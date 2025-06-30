**Personal Troubles**

1. DigitalOcean didn’t grant me free-tier credits, and even after registering the IP from my other account I still received no credits.
2. On AWS I picked an underpowered instance, which caused everything to fail. I first set `maxPodsPerNode: 30` on a **t3.small** with no success—everything kept crashing. Swapping to **t3.medium** fixed the issue.
3. I spent a long time wrestling with the database, so I decided to create it via Terraform directly on AWS since it’s more cost-effective.
4. I couldn’t test Docker locally on port **8080** because Jenkins was already bound to that port.
5. Not everything is working yet—my health check keeps failing. This is my first time working with Kubernetes, and I’ve found it pretty challenging.

- Automatic Scaling & Cost Efficiency
Kubernetes can scale your Django pods up or down based on demand, ensuring you only pay for the resources you actually use 


- Self-Healing & High Availability
If a pod crashes, Kubernetes restarts it automatically and distributes workload across healthy nodes, minimizing downtime 

- Declarative, Git-Ops-Friendly Deployments
You declare the desired state (e.g. “2 replicas,” “port 8080”) in YAML, and Kubernetes continuously reconciles to match it—simplifying rollouts and rollbacks 


- Templated Packaging with Helm
Helm bundles all your Kubernetes manifests into a versioned “chart,” so you can install or upgrade your entire Django stack with one command 


- Built-In Versioning & Rollbacks
Every Helm release is tracked; if an upgrade misbehaves, you can instantly roll back to the previous working version