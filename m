From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 1/8] OMAP4: hwmod data: Add hwspinlock
Date: Thu, 17 Feb 2011 11:24:42 +0100
Message-ID: <1297938289-8678-2-git-send-email-b-cousson@ti.com>
References: <1297938289-8678-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37571 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751993Ab1BQKZO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 05:25:14 -0500
In-Reply-To: <1297938289-8678-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, khilman@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Hari Kanigeri <h-kanigeri2@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

Add hwspinlock hwmod data for OMAP4 chip

Signed-off-by: Cousson, Benoit <b-cousson@ti.com>
Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Paul Walmsley <paul@pwsan.com>
[b-cousson@ti.com: Move the data to keep the original
order and add missing SIDLE_SMART_WKUP flag]
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   65 +++++++++++++++++++++++++++-
 1 files changed, 64 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index c2806bd..46da576 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -555,7 +555,6 @@ static struct omap_hwmod omap44xx_mpu_private_hwmod = {
  *  sl2if
  *  slimbus1
  *  slimbus2
- *  spinlock
  *  timer1
  *  timer10
  *  timer11
@@ -1639,6 +1638,67 @@ static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod = {
 };
 
 /*
+ * 'spinlock' class
+ * spinlock provides hardware assistance for synchronizing the processes
+ * running on multiple processors
+ */
+
+static struct omap_hwmod_class_sysconfig omap44xx_spinlock_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_CLOCKACTIVITY |
+			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   SIDLE_SMART_WKUP),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap44xx_spinlock_hwmod_class = {
+	.name	= "spinlock",
+	.sysc	= &omap44xx_spinlock_sysc,
+};
+
+/* spinlock */
+static struct omap_hwmod omap44xx_spinlock_hwmod;
+static struct omap_hwmod_addr_space omap44xx_spinlock_addrs[] = {
+	{
+		.pa_start	= 0x4a0f6000,
+		.pa_end		= 0x4a0f6fff,
+		.flags		= ADDR_TYPE_RT
+	},
+};
+
+/* l4_cfg -> spinlock */
+static struct omap_hwmod_ocp_if omap44xx_l4_cfg__spinlock = {
+	.master		= &omap44xx_l4_cfg_hwmod,
+	.slave		= &omap44xx_spinlock_hwmod,
+	.clk		= "l4_div_ck",
+	.addr		= omap44xx_spinlock_addrs,
+	.addr_cnt	= ARRAY_SIZE(omap44xx_spinlock_addrs),
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/* spinlock slave ports */
+static struct omap_hwmod_ocp_if *omap44xx_spinlock_slaves[] = {
+	&omap44xx_l4_cfg__spinlock,
+};
+
+static struct omap_hwmod omap44xx_spinlock_hwmod = {
+	.name		= "spinlock",
+	.class		= &omap44xx_spinlock_hwmod_class,
+	.prcm = {
+		.omap4 = {
+			.clkctrl_reg = OMAP4430_CM_L4CFG_HW_SEM_CLKCTRL,
+		},
+	},
+	.slaves		= omap44xx_spinlock_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap44xx_spinlock_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
+};
+
+/*
  * 'uart' class
  * universal asynchronous receiver/transmitter (uart)
  */
@@ -2058,6 +2118,9 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_smartreflex_iva_hwmod,
 	&omap44xx_smartreflex_mpu_hwmod,
 
+	/* spinlock class */
+	&omap44xx_spinlock_hwmod,
+
 	/* uart class */
 	&omap44xx_uart1_hwmod,
 	&omap44xx_uart2_hwmod,
-- 
1.7.0.4

