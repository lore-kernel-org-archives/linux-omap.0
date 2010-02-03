From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/9] OMAP2/3: GPMC: ensure valid clock pointer
Date: Tue, 02 Feb 2010 18:26:09 -0800
Message-ID: <20100203022609.26347.33153.stgit@baageli.muru.com>
References: <20100203022318.26347.34734.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59361 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932331Ab0BCCZl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Feb 2010 21:25:41 -0500
In-Reply-To: <20100203022318.26347.34734.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

From: Kevin Hilman <khilman@deeprootsystems.com>

Ensure valid clock pointer during GPMC init.  Fixes compiler
warning about potential use of uninitialized variable.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/gpmc.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 3f1334f..7027cdc 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -505,7 +505,7 @@ static void __init gpmc_mem_init(void)
 void __init gpmc_init(void)
 {
 	u32 l;
-	char *ck;
+	char *ck = NULL;
 
 	if (cpu_is_omap24xx()) {
 		ck = "core_l3_ck";
@@ -521,6 +521,9 @@ void __init gpmc_init(void)
 		l = OMAP44XX_GPMC_BASE;
 	}
 
+	if (WARN_ON(!ck))
+		return;
+
 	gpmc_l3_clk = clk_get(NULL, ck);
 	if (IS_ERR(gpmc_l3_clk)) {
 		printk(KERN_ERR "Could not get GPMC clock %s\n", ck);

