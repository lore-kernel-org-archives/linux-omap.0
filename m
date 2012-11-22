From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: AM335x: Beaglebone stops to boot with current git kernel
Date: Thu, 22 Nov 2012 14:47:28 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EB7F1E3@DBDE01.ent.ti.com>
References: <k80da6$61d$1@ger.gmane.org>
	<CAORVsuV7y_A4m+pHPoQ9a=Q7b4j-fCutJAFA1L+bqp4BV3kmFg@mail.gmail.com>
	<20121121183809.GZ18567@atomide.com>
	<CAK0ocyD25pRcQthN90inWy-95Yaa-B94rw724_uS5Y7FRA4qjQ@mail.gmail.com>
	<50ADBB5B.7090401@ti.com>
 <CAK0ocyCe3oJ8ynpNWpzcCFHtG3J4u7NBeNPTJK0GikFHaPAXOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55628 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752980Ab2KVSmR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Nov 2012 13:42:17 -0500
In-Reply-To: <CAK0ocyCe3oJ8ynpNWpzcCFHtG3J4u7NBeNPTJK0GikFHaPAXOA@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Mazanov <i.mazanov@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Jean Pihet <jean.pihet@newoldbits.com>, "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thu, Nov 22, 2012 at 17:46:50, Igor Mazanov wrote:
> On Thu, Nov 22, 2012 at 9:42 AM, Vaibhav Hiremath <hvaibhav@ti.com> wrote:
> >
> >
> > On 11/22/2012 1:30 AM, Igor Mazanov wrote:
> >> On Wed, Nov 21, 2012 at 9:38 PM, Tony Lindgren <tony@atomide.com> wrote:
> >>> * Jean Pihet <jean.pihet@newoldbits.com> [121114 08:43]:
> >>>> On Wed, Nov 14, 2012 at 4:28 PM, Igor Mazanov <i.mazanov@gmail.com> wrote:
> >>>>>
> >>>>> Beaglebone boot process is broken with the current git kernel. I use
> >>>>> omap2plus_defconfig for tests.
> >>>>>
> >>>>> It looks like the boot process stops due to the last changes in the AM33xx
> >>>>> clock sysbsystem. A following patch resolves this issue:
> >>> ...
> >>>
> >>>> The patch should change the name of the hwmod entry as well, can you
> >>>> fold this change in the current patch?
> >>>
> >>> Any news on updating this?
> >>
> >> The current kernel boots, but after a switching to CCF doesn't work
> >> the debugss - it's just disabled in the current hwmod code. So, it
> >> looks like we can't  use JTAG to connect to the running kernel.
> >>
> >
> > just resumed from vacation...
> >
> > JTAG clock will get disabled because, CONFIG_OMAP_RESET_CLOCKS will
> > disable unused clocks, so as debugss clock.
> >
> > There is another thread started by Joel on the similar issue,
> >
> > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg80863.html
> >
> > Something below should be done for debugss on AM33xx,
> >
> > diff --git a/arch/arm/mach-omap2/clock33xx_data.c
> > b/arch/arm/mach-omap2/clock33xx_data.c
> > index 17e3de5..60e0b53 100644
> > --- a/arch/arm/mach-omap2/clock33xx_data.c
> > +++ b/arch/arm/mach-omap2/clock33xx_data.c
> > @@ -584,6 +584,9 @@ static struct clk debugss_ick = {
> >         .clkdm_name     = "l3_aon_clkdm",
> >         .parent         = &dpll_core_m4_ck,
> >         .ops            = &clkops_omap2_dflt,
> > +#ifdef CONFIG_DEBUG_KERNEL
> > +       .flags          = ENABLE_ON_INIT,
> > +#endif
> >         .enable_reg     = AM33XX_CM_WKUP_DEBUGSS_CLKCTRL,
> >         .enable_bit     = AM33XX_MODULEMODE_SWCTRL,
> >         .recalc         = &followparent_recalc,
> 
> Yes, I noticed this thread. But now a clock subsystem in the current
> kernel is switched to Common Clock Framework and debugss (and several
> another modules) is disabled

Still this can be handled and enabled during init.


> (#if 0 .... #endif) in
> omap_hwmod_33xx_data.c.
> 
> From omap_hwmod_33xx_data.c:
> 
> /*
>  * Modules omap_hwmod structures
>  *
>  * The following IPs are excluded for the moment because:
>  * - They do not need an explicit SW control using omap_hwmod API.
>  * - They still need to be validated with the driver
>  *   properly adapted to omap_hwmod / omap_device
>  *
>  *    - cEFUSE (doesn't fall under any ocp_if)
>  *    - clkdiv32k
>  *    - debugss
>  *    - ocmc ram
>  *    - ocp watch point
>  *    - aes0
>  *    - sha0
>  */
> 
> I uncommented the debugss entry in the omap_hwmod settings, but only
> got a warning like:
> 
>  CC      arch/arm/mach-omap2/omap_hwmod_33xx_data.o
> arch/arm/mach-omap2/omap_hwmod_33xx_data.c:472:26: warning:
> 'am33xx_debugss_hwmod' defined but not used [-Wunused-variable]
> 
> By the way, I need to use JTAG to trace a problem described in this thread:
> 
> http://marc.info/?l=linux-omap&m=135307646415429&w=2
> 
> May be, it's the clocks related issue too...
> 


I have quickly created patch for you, can you try below patch and let me 
know?



diff --git a/arch/arm/mach-omap2/cclock33xx_data.c b/arch/arm/mach-omap2/cclock33xx_data.c
index ea64ad6..c9af78c 100644
--- a/arch/arm/mach-omap2/cclock33xx_data.c
+++ b/arch/arm/mach-omap2/cclock33xx_data.c
@@ -920,6 +920,7 @@ static const char *enable_init_clks[] = {
        "l4hs_gclk",
        "l4fw_gclk",
        "l4ls_gclk",
+       "debugss_ick",
 };

 int __init am33xx_clk_init(void)
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index ad8d43b..750b897 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -460,27 +460,6 @@ static struct omap_hwmod am33xx_clkdiv32k_hwmod = {
        },
 };

-/*
- * 'debugss' class
- * debug sub system
- */
-static struct omap_hwmod_class am33xx_debugss_hwmod_class = {
-       .name           = "debugss",
-};
-
-static struct omap_hwmod am33xx_debugss_hwmod = {
-       .name           = "debugss",
-       .class          = &am33xx_debugss_hwmod_class,
-       .clkdm_name     = "l3_aon_clkdm",
-       .main_clk       = "debugss_ick",
-       .prcm           = {
-               .omap4  = {
-                       .clkctrl_offs   = AM33XX_CM_WKUP_DEBUGSS_CLKCTRL_OFFSET,
-                       .modulemode     = MODULEMODE_SWCTRL,
-               },
-       },
-};
-
/* ocmcram */
 static struct omap_hwmod_class am33xx_ocmcram_hwmod_class = {
        .name = "ocmcram",
@@ -570,6 +549,28 @@ static struct omap_hwmod am33xx_sha0_hwmod = {

 #endif

+/*
+ * 'debugss' class
+ * debug sub system
+ */
+static struct omap_hwmod_class am33xx_debugss_hwmod_class = {
+       .name           = "debugss",
+};
+
+static struct omap_hwmod am33xx_debugss_hwmod = {
+       .name           = "debugss",
+       .class          = &am33xx_debugss_hwmod_class,
+       .clkdm_name     = "l3_aon_clkdm",
+       .main_clk       = "debugss_ick",
+       .flags          =  (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
+       .prcm           = {
+               .omap4  = {
+                       .clkctrl_offs   = AM33XX_CM_WKUP_DEBUGSS_CLKCTRL_OFFSET,
+                       .modulemode     = MODULEMODE_SWCTRL,
+               },
+       },
+};
+
 /* 'smartreflex' class */
 static struct omap_hwmod_class am33xx_smartreflex_hwmod_class = {
        .name           = "smartreflex",
@@ -2261,6 +2262,24 @@ static struct omap_hwmod_ocp_if am33xx_l3_main__gfx = {
        .user           = OCP_USER_MPU | OCP_USER_SDMA,
 };

+/* l3_main -> debugss */
+static struct omap_hwmod_addr_space am33xx_debugss_addrs[] = {
+       {
+               .pa_start       = 0x4b000000,
+               .pa_end         = 0x4b000000 + SZ_16M - 1,
+               .flags          = ADDR_TYPE_RT
+       },
+       { }
+};
+
+static struct omap_hwmod_ocp_if am33xx_l3_main__debugss = {
+       .master         = &am33xx_l3_main_hwmod,
+       .slave          = &am33xx_debugss_hwmod,
+       .clk            = "debugss_ick",
+       .addr           = am33xx_debugss_addrs,
+       .user           = OCP_USER_MPU,
+};
+
 /* l4 wkup -> smartreflex0 */
 static struct omap_hwmod_addr_space am33xx_smartreflex0_addrs[] = {
        {
@@ -3315,6 +3334,7 @@ static struct omap_hwmod_ocp_if *am33xx_hwmod_ocp_ifs[] __initdata = {
        &am33xx_pruss__l3_main,
        &am33xx_wkup_m3__l4_wkup,
        &am33xx_gfx__l3_main,
+       &am33xx_l3_main__debugss,
        &am33xx_l4_wkup__wkup_m3,
        &am33xx_l4_wkup__control,
        &am33xx_l4_wkup__smartreflex0,


Thanks,
Vaibhav
