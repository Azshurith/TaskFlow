<template>
    <main class="min-h-screen bg-gray-50 py-10 px-4">
      <section class="max-w-3xl mx-auto bg-white shadow-lg rounded-2xl p-8">
        <h1 class="text-4xl font-bold text-center text-blue-700 mb-10">📝 Task Manager</h1>
  
        <!-- ✍️ Task Form -->
        <div class="mb-10">
          <h2 class="text-2xl font-semibold text-gray-800 mb-4">
            {{ form.id ? '✏️ Edit Task' : '➕ Create New Task' }}
          </h2>
  
          <form @submit.prevent="handleSubmit" class="grid gap-5">
            <input
              v-model="form.title"
              type="text"
              placeholder="Title"
              class="p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
              required
            />
            <textarea
              v-model="form.description"
              placeholder="Description"
              rows="3"
              class="p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500"
            ></textarea>
  
            <label class="inline-flex items-center space-x-2">
              <input type="checkbox" v-model="form.isCompleted" />
              <span class="text-sm text-gray-600">Mark as Completed</span>
            </label>
  
            <div class="flex space-x-3">
              <button
                type="submit"
                class="bg-blue-600 hover:bg-blue-700 text-white font-medium px-5 py-2.5 rounded-lg transition"
              >
                {{ form.id ? 'Update' : 'Create' }}
              </button>
              <button
                v-if="form.id"
                @click.prevent="resetForm"
                class="text-sm text-gray-500 hover:text-gray-700 underline"
              >
                Cancel
              </button>
            </div>
          </form>
        </div>
  
        <!-- 📋 Task List -->
        <div class="space-y-5">
          <div
            v-for="task in tasks"
            :key="task.id"
            class="p-6 border border-gray-200 rounded-xl bg-gray-50 hover:shadow-md transition"
          >
            <div class="flex justify-between items-start">
              <div>
                <h3 class="text-lg font-bold text-gray-800">{{ task.title }}</h3>
                <p class="text-sm text-gray-600 mb-1">{{ task.description }}</p>
                <span
                  :class="task.isCompleted ? 'text-green-600' : 'text-yellow-500'"
                  class="text-sm font-semibold"
                >
                  {{ task.isCompleted ? '✔️ Completed' : '⏳ Pending' }}
                </span>
              </div>
              <div class="space-x-2 flex-shrink-0">
                <button
                  @click="editTask(task)"
                  class="text-sm text-blue-600 hover:text-blue-800 font-medium"
                >
                  Edit
                </button>
                <button
                  @click="deleteTask(task.id)"
                  class="text-sm text-red-600 hover:text-red-800 font-medium"
                >
                  Delete
                </button>
              </div>
            </div>
          </div>
          <p v-if="!tasks.length" class="text-center text-gray-400 italic">No tasks found.</p>
        </div>
      </section>
    </main>
  </template>
  
  <script setup>
  import { ref, onMounted } from 'vue'
  import { useRuntimeConfig } from '#app'
  
  const tasks = ref([])
  const form = ref({ id: null, title: '', description: '', isCompleted: false })
  const config = useRuntimeConfig()
  const apiBase = `http://localhost:${config.public.asp}/api/tasks`
  
  const loadTasks = async () => {
    const res = await fetch(`${apiBase}?page=1&size=10`)
    tasks.value = await res.json()
  }
  
  const handleSubmit = async () => {
    const method = form.value.id ? 'PUT' : 'POST'
    const url = form.value.id ? `${apiBase}/${form.value.id}` : apiBase
    const payload = { ...form.value }
    if (!form.value.id) delete payload.id
  
    await fetch(url, {
      method,
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(payload)
    })
  
    resetForm()
    await loadTasks()
  }
  
  const editTask = (task) => {
    form.value = { ...task }
  }
  
  const deleteTask = async (id) => {
    await fetch(`${apiBase}/${id}`, { method: 'DELETE' })
    await loadTasks()
  }
  
  const resetForm = () => {
    form.value = { id: null, title: '', description: '', isCompleted: false }
  }
  
  onMounted(loadTasks)
  </script>
  