From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [RFC 5/6] ARM: OMAP3: hwmod data: add sad2d hwmod
Date: Sun, 15 Jul 2012 19:28:29 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207151924591.28834@utopia.booyaka.com>
References: <1342197459-7920-1-git-send-email-t-kristo@ti.com> <1342197459-7920-6-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49383 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748Ab2GPB2a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 15 Jul 2012 21:28:30 -0400
In-Reply-To: <1342197459-7920-6-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

Hi

One comment

On Fri, 13 Jul 2012, Tero Kristo wrote:

> @@ -3203,6 +3239,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_hwmod_ocp_ifs[] __initdata = {
>  	&omap34xx_l4_core__mcspi3,
>  	&omap34xx_l4_core__mcspi4,
>  	&omap3xxx_l4_wkup__counter_32k,
> +	&omap3xxx_sad2d__l3,
>  	NULL,

This part of the patch doesn't seem right.  As far as I know, AM35xx 
doesn't support the D2D interface.  So it wouldn't make sense to add this 
to the OMAP3-common list.  So instead the patch has been updated here to 
add this to the OMAP34xx and OMAP36xx lists.

Updated patch below.


- Paul

From: Tero Kristo <t-kristo@ti.com>
Date: Fri, 13 Jul 2012 19:37:38 +0300
Subject: [PATCH] ARM: OMAP3: hwmod data: add sad2d hwmod

SAD2D stands for the die to die interface, and is used for communicating
with the optional stacked modem. This hwmod is added in preparation for
the d2d_idle move from pm34xx.c to hwmod data.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
[paul@pwsan.com: SAD2D presumably doesn't exist on non-OMAP34xx/OMAP36xx,
 so only add it to the OMAP34xx/OMAP36xx lists]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/cm-regbits-34xx.h      |    2 ++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   37 ++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index 975f6bd..59598ff 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -218,6 +218,8 @@
 #define OMAP3430_ST_MAILBOXES_MASK			(1 << 7)
 #define OMAP3430_ST_OMAPCTRL_SHIFT			6
 #define OMAP3430_ST_OMAPCTRL_MASK			(1 << 6)
+#define OMAP3430_ST_SAD2D_SHIFT				3
+#define OMAP3430_ST_SAD2D_MASK				(1 << 3)
 #define OMAP3430_ST_SDMA_SHIFT				2
 #define OMAP3430_ST_SDMA_MASK				(1 << 2)
 #define OMAP3430_ST_SDRC_SHIFT				1
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index ce7e606..0dce77e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -2033,6 +2033,33 @@ static struct omap_hwmod omap3xxx_hdq1w_hwmod = {
 	.class		= &omap2_hdq1w_class,
 };
 
+/* SAD2D */
+static struct omap_hwmod_rst_info omap3xxx_sad2d_resets[] = {
+	{ .name = "rst_modem_pwron_sw", .rst_shift = 0 },
+	{ .name = "rst_modem_sw", .rst_shift = 1 },
+};
+
+static struct omap_hwmod_class omap3xxx_sad2d_class = {
+	.name			= "sad2d",
+};
+
+static struct omap_hwmod omap3xxx_sad2d_hwmod = {
+	.name		= "sad2d",
+	.rst_lines	= omap3xxx_sad2d_resets,
+	.rst_lines_cnt	= ARRAY_SIZE(omap3xxx_sad2d_resets),
+	.main_clk	= "sad2d_ick",
+	.prcm		= {
+		.omap2 = {
+			.module_offs = CORE_MOD,
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_SAD2D_SHIFT,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_ST_SAD2D_SHIFT,
+		},
+	},
+	.class		= &omap3xxx_sad2d_class,
+};
+
 /*
  * '32K sync counter' class
  * 32-bit ordinary counter, clocked by the falling edge of the 32 khz clock
@@ -2137,6 +2164,14 @@ static struct omap_hwmod_ocp_if am35xx_usbhsotg__l3 = {
 	.user		= OCP_USER_MPU,
 };
 
+/* l3_core -> sad2d interface */
+static struct omap_hwmod_ocp_if omap3xxx_sad2d__l3 = {
+	.master		= &omap3xxx_sad2d_hwmod,
+	.slave		= &omap3xxx_l3_main_hwmod,
+	.clk		= "core_l3_ick",
+	.user		= OCP_USER_MPU,
+};
+
 /* L4_CORE -> L4_WKUP interface */
 static struct omap_hwmod_ocp_if omap3xxx_l4_core__l4_wkup = {
 	.master	= &omap3xxx_l4_core_hwmod,
@@ -3371,6 +3406,7 @@ static struct omap_hwmod_ocp_if *omap34xx_hwmod_ocp_ifs[] __initdata = {
 	&omap34xx_l4_core__sr2,
 	&omap3xxx_l4_core__mailbox,
 	&omap3xxx_l4_core__hdq1w,
+	&omap3xxx_sad2d__l3,
 	NULL
 };
 
@@ -3391,6 +3427,7 @@ static struct omap_hwmod_ocp_if *omap36xx_hwmod_ocp_ifs[] __initdata = {
 	&omap3xxx_l4_core__es3plus_mmc1,
 	&omap3xxx_l4_core__es3plus_mmc2,
 	&omap3xxx_l4_core__hdq1w,
+	&omap3xxx_sad2d__l3,
 	NULL
 };
 
-- 
1.7.10.4

