From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] OMAP: Should cs be positive in gpmc_cs_free()?
Date: Sun, 01 Nov 2009 14:18:16 +0100
Message-ID: <4AED8A98.6040205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752333AbZKANHL@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Tony Lindgren <tony@atomide.com>" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

The index `cs' is signed, test whether it is negative before
we release gpmc_cs_mem[cs].

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Found by code analysis, is it required?

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 1587682..c892a54 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -378,7 +378,7 @@ EXPORT_SYMBOL(gpmc_cs_request);
 void gpmc_cs_free(int cs)
 {
 	spin_lock(&gpmc_mem_lock);
-	if (cs >= GPMC_CS_NUM || !gpmc_cs_reserved(cs)) {
+	if (cs >= GPMC_CS_NUM || cs < 0 || !gpmc_cs_reserved(cs)) {
 		printk(KERN_ERR "Trying to free non-reserved GPMC CS%d\n", cs);
 		BUG();
 		spin_unlock(&gpmc_mem_lock);
