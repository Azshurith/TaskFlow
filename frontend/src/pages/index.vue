<template>
  <div class="p-4">
    <h1 class="text-2xl font-bold mb-4">Nuxt Headless Task Viewer</h1>
    <ul v-if="tasks.length">
      <li v-for="task in tasks" :key="task.id" class="mb-3 border-b pb-2">
        <h2 class="text-xl font-semibold">{{ task.title }}</h2>
        <p class="text-gray-600">{{ task.description }}</p>
        <p>Status: <span :class="task.isCompleted ? 'text-green-600' : 'text-red-600'">{{ task.isCompleted ? 'Completed' : 'Pending' }}</span></p>
      </li>
    </ul>
    <p v-else>No tasks found.</p>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRuntimeConfig } from '#app'

const tasks = ref([])
const config = useRuntimeConfig()

onMounted(async () => {
  try {
    const res = await fetch(`http://localhost:${config.public.asp}/api/tasks?page=1&size=10`)
    if (!res.ok) throw new Error('Failed to fetch tasks')
    tasks.value = await res.json()
  } catch (err) {
    console.error(err)
  }
})
</script>
