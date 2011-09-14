From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv6 01/11] omap: prcm: switch to a chained IRQ handler
 mechanism
Date: Wed, 14 Sep 2011 06:10:28 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1109140607560.27954@utopia.booyaka.com>
References: <1311611771-15093-1-git-send-email-t-kristo@ti.com> <1311611771-15093-2-git-send-email-t-kristo@ti.com> <alpine.DEB.2.00.1108260257410.9743@utopia.booyaka.com> <1314885600.24105.11.camel@sokoban> <alpine.DEB.2.00.1109020311050.8762@utopia.booyaka.com>
 <1314965712.3035.5.camel@sokoban>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38961 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756484Ab1INMK3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Sep 2011 08:10:29 -0400
In-Reply-To: <1314965712.3035.5.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Mahadeva, Avinash" <avinashhm@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, "R, Govindraj" <govindraj.raja@ti.com>, "Balbi, Felipe" <balbi@ti.com>

Hello Tero,

On Fri, 2 Sep 2011, Tero Kristo wrote:

> On Fri, 2011-09-02 at 11:20 +0200, Paul Walmsley wrote:
>
> > If it would help, I'd be happy to do a first draft of the OMAP3430 PRM 
> > hwmod data.
> 
> If you can do this it would help, as you have much better understanding
> of the hwmod data than I do. It will probably drop a couple of review
> rounds away as the hwmod data would be close to what it should be from
> beginning.
> 
> If you are busy with other things, I can see what I can craft myself.

Not sure if you're still waiting on this, but here's a draft of a PRM 
hwmod for OMAP34xx for testing purposes.  It needs a little more review 
and thought before being ready for merging, but I think it will work for 
your purposes.  The OMAP2430 version should be quite similar.  Comments 
welcome,


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Sun, 4 Sep 2011 18:26:58 -0600
Subject: [PATCH] OMAP3xxx: hwmod data: add PRM hwmod

*** DRAFT ***
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   63 ++++++++++++++++++++++++++++
 1 files changed, 63 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 25bf43b..4b3640e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -161,6 +161,7 @@ static struct omap_hwmod omap3xxx_l3_main_hwmod = {
 };
 
 static struct omap_hwmod omap3xxx_l4_wkup_hwmod;
+static struct omap_hwmod omap3xxx_prm_hwmod;
 static struct omap_hwmod omap3xxx_uart1_hwmod;
 static struct omap_hwmod omap3xxx_uart2_hwmod;
 static struct omap_hwmod omap3xxx_uart3_hwmod;
@@ -478,6 +479,29 @@ static struct omap_hwmod omap3xxx_l4_per_hwmod = {
 	.flags		= HWMOD_NO_IDLEST,
 };
 
+static struct omap_hwmod_addr_space omap3xxx_prm_addrs[] = {
+	{
+		.pa_start	= 0x48306000,
+		.pa_end		= 0x48306000 + SZ_8K + SZ_4K - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+/* L4_WKUP -> PRM interface */
+static struct omap_hwmod_ocp_if omap3xxx_l4_wkup__prm = {
+	.master		= &omap3xxx_l4_wkup_hwmod,
+	.slave		= &omap3xxx_prm_hwmod,
+	.clk		= "wkup_l4_ick",
+	.addr		= omap3xxx_prm_addrs,
+	.user		= OCP_USER_MPU,
+};
+
+/* Master interfaces on the L4_WKUP interconnect */
+static struct omap_hwmod_ocp_if *omap3xxx_l4_wkup_masters[] = {
+	&omap3xxx_l4_wkup__prm,
+};
+
 /* Slave interfaces on the L4_WKUP interconnect */
 static struct omap_hwmod_ocp_if *omap3xxx_l4_wkup_slaves[] = {
 	&omap3xxx_l4_core__l4_wkup,
@@ -487,12 +511,48 @@ static struct omap_hwmod_ocp_if *omap3xxx_l4_wkup_slaves[] = {
 static struct omap_hwmod omap3xxx_l4_wkup_hwmod = {
 	.name		= "l4_wkup",
 	.class		= &l4_hwmod_class,
+	.masters	= omap3xxx_l4_wkup_masters,
+	.masters_cnt	= ARRAY_SIZE(omap3xxx_l4_wkup_masters),
 	.slaves		= omap3xxx_l4_wkup_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap3xxx_l4_wkup_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 	.flags		= HWMOD_NO_IDLEST,
 };
 
+/* Slave interfaces on the L4_WKUP interconnect */
+static struct omap_hwmod_ocp_if *omap3xxx_prm_slaves[] = {
+	&omap3xxx_l4_wkup__prm,
+};
+
+static struct omap_hwmod_class_sysconfig omap3xxx_prm_sysc = {
+	.rev_offs	= 0x0804,
+	.sysc_offs	= 0x0814,
+	.sysc_flags	= SYSC_HAS_AUTOIDLE,
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap3xxx_prm_hwmod_class = {
+	.name		= "prm",
+	.sysc		= &omap3xxx_prm_sysc,
+};
+
+static struct omap_hwmod_irq_info omap3xxx_prm_irqs[] = {
+	{ .irq = 11 },
+	{ .irq = -1 }
+};
+
+/* PRM */
+static struct omap_hwmod omap3xxx_prm_hwmod = {
+	.name		= "prm",
+	.mpu_irqs	= omap3xxx_prm_irqs,
+	.class		= &omap3xxx_prm_hwmod_class,
+	.main_clk	= "wkup_32k_fck",
+	.slaves		= omap3xxx_prm_slaves,
+	.slaves_cnt	= ARRAY_SIZE(omap3xxx_prm_slaves),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.flags		= HWMOD_NO_IDLEST,
+};
+
 /* Master interfaces on the MPU device */
 static struct omap_hwmod_ocp_if *omap3xxx_mpu_masters[] = {
 	&omap3xxx_mpu__l3_main,
@@ -3201,6 +3261,9 @@ static __initdata struct omap_hwmod *omap3xxx_hwmods[] = {
 	&omap3xxx_l4_core_hwmod,
 	&omap3xxx_l4_per_hwmod,
 	&omap3xxx_l4_wkup_hwmod,
+
+	&omap3xxx_prm_hwmod,
+
 	&omap3xxx_mmc1_hwmod,
 	&omap3xxx_mmc2_hwmod,
 	&omap3xxx_mmc3_hwmod,
-- 
1.7.5.4

