From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH V3 1/8] ARM: OMAP3: Add debugss HWMOD data
Date: Thu, 20 Sep 2012 17:13:10 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209201653020.12583@utopia.booyaka.com>
References: <1347290626-21164-1-git-send-email-jon-hunter@ti.com> <1347290626-21164-2-git-send-email-jon-hunter@ti.com> <alpine.DEB.2.00.1209191731270.5264@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:59886 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752890Ab2ITRNL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Sep 2012 13:13:11 -0400
In-Reply-To: <alpine.DEB.2.00.1209191731270.5264@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Wed, 19 Sep 2012, Paul Walmsley wrote:

> On Mon, 10 Sep 2012, Jon Hunter wrote:
> 
> > To enable PMU with runtime PM support on OMAP3 devices we need to be able to
> > dynamically enable and disable the debug sub-system at runtime. By adding HWMOD
> > data for the debug sub-system for OMAP3, we can build the PMU device using the
> > debug sub-system HWMOD and control this power domain using runtime PM.
> > 
> > Reviewed-by: Benoit Cousson <b-cousson@ti.com>
> > Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> 
> Isn't this patch missing MPU address ranges?  Looking at the OMAP4 TRM 
> Table 2-2 "L3_EMU Memory Space Mapping" it should cover 
> 0x54000000-0x541fffff?

Looks like Jon is out of the office at the moment.  So this one has been 
updated locally to add the _OMAP3_ address space from the TRM (my earlier 
message referred incorrectly to the OMAP4 address space).  Updated patch 
below.


- Paul

From: Jon Hunter <jon-hunter@ti.com>
Date: Thu, 20 Sep 2012 01:59:37 -0600
Subject: [PATCH] ARM: OMAP3: hwmod data: Add debugss HWMOD data

To enable PMU with runtime PM support on OMAP3 devices we need to be able to
dynamically enable and disable the debug sub-system at runtime. By adding HWMOD
data for the debug sub-system for OMAP3, we can build the PMU device using the
debug sub-system HWMOD and control this power domain using runtime PM.

Reviewed-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
[paul@pwsan.com: updated to apply; added L4-EMU address space]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   36 ++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 4606351..fc64454 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -124,6 +124,24 @@ static struct omap_hwmod omap3xxx_iva_hwmod = {
 	},
 };
 
+/*
+ * 'debugss' class
+ * debug and emulation sub system
+ */
+
+static struct omap_hwmod_class omap3xxx_debugss_hwmod_class = {
+	.name	= "debugss",
+};
+
+/* debugss */
+static struct omap_hwmod omap3xxx_debugss_hwmod = {
+	.name		= "debugss",
+	.class		= &omap3xxx_debugss_hwmod_class,
+	.clkdm_name	= "emu_clkdm",
+	.main_clk	= "emu_src_ck",
+	.flags		= HWMOD_NO_IDLEST,
+};
+
 /* timer class */
 static struct omap_hwmod_class_sysconfig omap3xxx_timer_1ms_sysc = {
 	.rev_offs	= 0x0000,
@@ -2186,6 +2204,23 @@ static struct omap_hwmod_ocp_if omap3xxx_mpu__l3_main = {
 	.user	= OCP_USER_MPU,
 };
 
+static struct omap_hwmod_addr_space omap3xxx_l4_emu_addrs[] = {
+	{
+		.pa_start	= 0x54000000,
+		.pa_end		= 0x547fffff,
+		.flags		= ADDR_TYPE_RT,
+	},
+	{ }
+};
+
+/* l3 -> debugss */
+static struct omap_hwmod_ocp_if omap3xxx_l3_main__l4_debugss = {
+	.master		= &omap3xxx_l3_main_hwmod,
+	.slave		= &omap3xxx_debugss_hwmod,
+	.addr		= &omap3xxx_l4_emu_hwmod,
+	.user		= OCP_USER_MPU,
+};
+
 /* DSS -> l3 */
 static struct omap_hwmod_ocp_if omap3430es1_dss__l3 = {
 	.master		= &omap3430es1_dss_core_hwmod,
@@ -3506,6 +3541,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_hwmod_ocp_ifs[] __initdata = {
 	&omap3xxx_l3_main__l4_core,
 	&omap3xxx_l3_main__l4_per,
 	&omap3xxx_mpu__l3_main,
+	&omap3xxx_l3_main__l4_debugss,
 	&omap3xxx_l4_core__l4_wkup,
 	&omap3xxx_l4_core__mmc3,
 	&omap3_l4_core__uart1,
-- 
1.7.10.4

