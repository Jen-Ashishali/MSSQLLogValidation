# SQL Server Transaction Log Validation & Shrink Scripts

Welcome, fellow DBAs, developers, and chaos managers 😎.  

Ever had your transaction logs fill up, apps stop, and SQL Agent insist everything is green? Yeah… me too. This repo is the culmination of **months of real-world troubleshooting** in high-availability SQL Server environments.

## 🧩 Features

- Validate log usage across all databases
- Flag databases exceeding thresholds (size & utilization)
- Force job failure on violations to prevent silent disasters
- Backup automation (transaction log + cleanup)
- Optional shrink step (emergency use only — read my Medium article!)

## 🚀 How to Use

1. Clone this repo
2. Customize the database list & thresholds
3. Run scripts in a test/dev environment first!
4. Schedule in SQL Agent for nightly inspection
5. Check job history for validation summary

## ⚠️ Notes / Best Practices

- Shrinking logs is **not routine maintenance** — emergency only
- Regular log backups + proper sizing are critical
- Works with Availability Groups, but be mindful of redo lag

## 📖 More Context

For the full story behind these scripts — including the outage, the job that lied to me, and the Thanos moment — check out my Medium article: [Link here]

---

Made with ❤️ by a Nigerian DBA trying to keep chaos at bay.

