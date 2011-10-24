From: ming.lei@canonical.com
Subject: [PATCH v5 4/7] arm: omap4: hwmod: introduce emu hwmod
Date: Mon, 24 Oct 2011 22:45:56 +0800
Message-ID: <1319467559-5518-5-git-send-email-ming.lei@canonical.com>
References: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40855 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932642Ab1JXOrt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Oct 2011 10:47:49 -0400
Received: by iaby12 with SMTP id y12so1404735iab.19
        for <linux-omap@vger.kernel.org>; Mon, 24 Oct 2011 07:47:49 -0700 (PDT)
In-Reply-To: <1319467559-5518-1-git-send-email-ming.lei@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk, will.deacon@arm.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, khilman@deeprootsystems.com, paul@pwsan.com, Ming Lei <ming.lei@canonical.com>

From: Ming Lei <ming.lei@canonical.com>

So that access to cross trigger interface can be allowed, which
will be introduce in later patches.

Signed-off-by: Ming Lei <ming.lei@canonical.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 393afac..c7289a8 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -5276,6 +5276,30 @@ static struct omap_hwmod omap44xx_wd_timer3_hwmod = {
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_wd_timer3_slaves),
 };
 
+static struct omap_hwmod_class omap44xx_emu_hwmod_class = {
+	.name	= "emu",
+};
+
+static struct omap_hwmod_irq_info omap44xx_emu_irqs[] = {
+	{ .name = "cti0", .irq = 1 + OMAP44XX_IRQ_GIC_START },
+	{ .name = "cti1", .irq = 2 + OMAP44XX_IRQ_GIC_START },
+	{ .irq = -1 }
+};
+
+/*emu hwmod*/
+static struct omap_hwmod omap44xx_emu_hwmod = {
+	.name		= "emu",
+	.class		= &omap44xx_emu_hwmod_class,
+	.clkdm_name	= "emu_sys_clkdm",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = OMAP4_CM_EMU_CLKSTCTRL_OFFSET,
+			.modulemode   = MODULEMODE_HWCTRL,
+		},
+	},
+	.mpu_irqs	= omap44xx_emu_irqs,
+};
+
 static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 
 	/* dmm class */
@@ -5422,6 +5446,8 @@ static __initdata struct omap_hwmod *omap44xx_hwmods[] = {
 	&omap44xx_wd_timer2_hwmod,
 	&omap44xx_wd_timer3_hwmod,
 
+	/*emu class*/
+	&omap44xx_emu_hwmod,
 	NULL,
 };
 
-- 
1.7.5.4

