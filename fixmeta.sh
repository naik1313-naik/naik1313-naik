#!/bin/bash
# Add accurate descriptions + topics to public repos. Additive only — no renames, no deletes.
set -u
OWNER="naik1313-naik"

set_repo() {
  local repo="$1" desc="$2" topics="$3"
  local out
  out=$(gh api --method PATCH "repos/$OWNER/$repo" -f description="$desc" --jq '.description[0:45]' 2>&1)
  out=$(printf '%s\n' "$out" | head -1)
  local tcount
  tcount=$(printf '{"names":[%s]}' "$(printf '%s' "$topics" | sed 's/[^,]*/"&"/g')" | gh api --method PUT "repos/$OWNER/$repo/topics" -H "Accept: application/vnd.github+json" --input - --jq '.names|length' 2>&1 | head -1)
  printf '%-28s desc:%s  topics:%s\n' "$repo" "$out" "$tcount"
}

echo "--- flagship ---"
set_repo rathod-brothers \
  "Full-stack platform for a heavy-machinery business: React + TypeScript storefront, Express + MySQL enquiry pipeline with JWT auth, and an admin dashboard. Vitest-tested monorepo deployed on Railway." \
  "fullstack,react,typescript,express,mysql,jwt,zod,tailwindcss,vite,vitest,monorepo,railway"

set_repo gvplumbing \
  "Premium showroom website for a plumbing & hardware business. Next.js 14 App Router, TypeScript, Tailwind v4, Framer Motion; Supabase auth, cart, checkout and admin dashboard." \
  "nextjs,react,typescript,tailwindcss,framer-motion,supabase,resend,zod,ecommerce,fullstack"

set_repo college-management-system \
  "College management platform with JWT role-based access for Admin, Teacher and Student. Express + PostgreSQL backend, React frontend, Razorpay fee payments, shared API ready for React Native." \
  "fullstack,jwt,role-based-access,postgresql,express,react,razorpay,nodejs,education"

echo "--- portfolio / creative ---"
set_repo portfolio \
  "Personal portfolio with a scroll-driven 3D hero built on React 19, TypeScript, Three.js, GSAP and Lenis." \
  "portfolio,react,typescript,threejs,react-three-fiber,gsap,lenis,tailwindcss,vite"

set_repo portfolio.2 \
  "Creative portfolio with a React Three Fiber hero, GSAP motion timelines and Lenis smooth scrolling. Deployed on GitHub Pages." \
  "portfolio,react,typescript,threejs,react-three-fiber,gsap,lenis,tailwindcss,vite,frontend"

set_repo linways \
  "3D portfolio experience built with Astro and React — full-screen hero with an animated object and a scroll-reactive Three.js camera." \
  "portfolio,astro,react,threejs,gsap,tailwindcss,frontend,animation"

echo "--- python / backend ---"
set_repo ecommerce-website \
  "SwadeshiMart — full-stack ecommerce store: FastAPI + SQLAlchemy + SQLite backend, server-side sessions, React storefront, admin CRUD panel." \
  "fastapi,python,sqlalchemy,sqlite,ecommerce,fullstack,backend,react"

set_repo ttt \
  "SmartSpend — personal finance tracker with income/expense transactions, budgets, category analytics and a live WebSocket feed. FastAPI + MySQL backend, React + Recharts frontend." \
  "fastapi,python,mysql,react,recharts,websockets,finance,fullstack,backend"

set_repo COURSE-REGISTRATION \
  "NexGen Learning — course marketplace with student enrolment, Stripe checkout and admin analytics. React + Node/Express + MySQL in a Docker Compose monorepo." \
  "react,nodejs,express,mysql,stripe,docker,jwt,fullstack,education"

set_repo big-biceps \
  "Static brochure site for a real gym — weekly timings, membership rules, clean-shoe policy. Deployed on Vercel." \
  "html,css,vanilla-js,static-site,frontend"

set_repo mental-health \
  "MindWatch — mood, sleep and journal check-in tracker that scores wellbeing and surfaces risk, with a counselor dashboard. Express + Azure Cosmos DB + Chart.js." \
  "nodejs,express,azure,cosmosdb,chartjs,health,fullstack,backend"

echo "--- done ---"