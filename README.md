**Personal Troubles**

1. DigitalOcean didn’t grant me free-tier credits, and even after registering the IP from my other account I still received no credits.
2. On AWS I picked an underpowered instance, which caused everything to fail. I first set `maxPodsPerNode: 30` on a **t3.small** with no success—everything kept crashing. Swapping to **t3.medium** fixed the issue.
3. I spent a long time wrestling with the database, so I decided to create it via Terraform directly on AWS since it’s more cost-effective.
4. I couldn’t test Docker locally on port **8080** because Jenkins was already bound to that port.
5. Not everything is working yet—my health check keeps failing. This is my first time working with Kubernetes, and I’ve found it pretty challenging.
