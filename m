From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH v3 17/20] GPIO: OMAP: Fix bankwidth for OMAP7xx MPUIO
Date: Fri, 1 Jul 2011 15:17:11 +0530
Message-ID: <1309513634-20971-18-git-send-email-tarun.kanti@ti.com>
References: <1309513634-20971-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59320 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755885Ab1GAJrv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Jul 2011 05:47:51 -0400
In-Reply-To: <1309513634-20971-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, Charulatha V <charu@ti.com>

From: Charulatha V <charu@ti.com>

In all OMAP1 SoCs, the MPUIO bank width is 16 bits. But, in OMAP7xx,
it is wrongly initialised to 32. Fix this.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap1/gpio7xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpio7xx.c
index 91a7691..65949c8 100644
--- a/arch/arm/mach-omap1/gpio7xx.c
+++ b/arch/arm/mach-omap1/gpio7xx.c
@@ -52,8 +52,8 @@ static struct omap_gpio_reg_offs omap7xx_mpuio_regs = {
 
 static struct __initdata omap_gpio_platform_data omap7xx_mpu_gpio_config = {
 	.virtual_irq_start	= IH_MPUIO_BASE,
-	.bank_width		= 32,
 	.is_mpuio		= true,
+	.bank_width		= 16,
 	.bank_stride		= 2,
 	.regs                   = &omap7xx_mpuio_regs,
 };
-- 
1.6.0.4

