From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: AM335x: Beaglebone stops to boot with current git kernel
Date: Fri, 23 Nov 2012 06:04:03 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EB7FB16@DBDE01.ent.ti.com>
References: <k80da6$61d$1@ger.gmane.org>
	<CAORVsuV7y_A4m+pHPoQ9a=Q7b4j-fCutJAFA1L+bqp4BV3kmFg@mail.gmail.com>
	<20121121183809.GZ18567@atomide.com>
	<CAK0ocyD25pRcQthN90inWy-95Yaa-B94rw724_uS5Y7FRA4qjQ@mail.gmail.com>
	<50ADBB5B.7090401@ti.com>
	<CAK0ocyCe3oJ8ynpNWpzcCFHtG3J4u7NBeNPTJK0GikFHaPAXOA@mail.gmail.com>
	<79CD15C6BA57404B839C016229A409A83EB7F222@DBDE01.ent.ti.com>
	<CAK0ocyD7fGzj1GuFP7EhFYqmLv66A0phNrxV6rAL9b9ejPYfvg@mail.gmail.com>
 <CAD=GYparyZ8kB+pX+SptSaNPHD-Ey9vBC1Q4nDcTKJLenpNK=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38500 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751761Ab2KWGEJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Nov 2012 01:04:09 -0500
In-Reply-To: <CAD=GYparyZ8kB+pX+SptSaNPHD-Ey9vBC1Q4nDcTKJLenpNK=w@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joel A Fernandes <agnel.joel@gmail.com>, Igor Mazanov <i.mazanov@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Jean Pihet <jean.pihet@newoldbits.com>, "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Nov 23, 2012 at 02:26:40, Joel A Fernandes wrote:
> Hi Vaibhav, Igor,
> 
> On and off due to vacation time too,..
> 
> Not sure but I missed the below patch from Vaibhav as it probably
> wasn't copied to linux-omap so I got confused which patch was Igor
> testing, whether it was the one in which we set ENABLE_ON_INIT or the
> one in which hwmod data is changed.
> 
> I think Igor tried the latter and it works. In that case, I guess we
> can drop the ENABLE_ON_INIT patch if this is a better fix. I had some
> comments though...
> 


Let try to explain why we should go with hwmod patches,

When I submitted clock tree patch, we decided to remove all leaf-nodes from 
the data, but since modules like debugs were not enabled in hwmod (as done 
for omap) I had explicitly keep these nodes in clock-tree to disable them 
with RESET_CLOCKS flag.
Please refer to the comment in file clock33xx_data.c


567 /*
568  * Modules clock nodes
569  *
570  * The following clock leaf nodes are added for the moment because:
571  *
572  *  - hwmod data is not present for these modules, either hwmod
573  *    control is not required or its not populated.
574  *  - Driver code is not yet migrated to use hwmod/runtime pm
575  *  - Modules outside kernel access (to disable them by default)
576  *
577  *     - debugss
578  *     - mmu (gfx domain)
579  *     - cefuse
580  *     - usbotg_fck (its additional clock and not really a modulemode)
581  *     - ieee5000
582  */



Ideally (and to keep consistency with existing implementation), we should 
enable hwmod node and remove clock-tree node.


> On Thu, Nov 22, 2012 at 10:40 AM, Igor Mazanov <i.mazanov@gmail.com> wrote:
> > On Thu, Nov 22, 2012 at 6:49 PM, Hiremath, Vaibhav <hvaibhav@ti.com> wrote:
> [..]
> >>> I have quickly created patch for you, can you try below patch and let me
> >>> know?
> >>>
> >>>
> >>>
> >>> diff --git a/arch/arm/mach-omap2/cclock33xx_data.c b/arch/arm/mach-omap2/cclock33xx_data.c
> >>> index ea64ad6..c9af78c 100644
> >>> --- a/arch/arm/mach-omap2/cclock33xx_data.c
> >>> +++ b/arch/arm/mach-omap2/cclock33xx_data.c
> >>> @@ -920,6 +920,7 @@ static const char *enable_init_clks[] = {
> >>>         "l4hs_gclk",
> >>>         "l4fw_gclk",
> >>>         "l4ls_gclk",
> >>> +       "debugss_ick",
> >>>  };
> >>>
> >>>  int __init am33xx_clk_init(void)
> >>> diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> >>> index ad8d43b..750b897 100644
> >>> --- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> >>> +++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
> >>> @@ -460,27 +460,6 @@ static struct omap_hwmod am33xx_clkdiv32k_hwmod = {
> >>>         },
> >>>  };
> >>>
> >>> -/*
> >>> - * 'debugss' class
> >>> - * debug sub system
> >>> - */
> >>> -static struct omap_hwmod_class am33xx_debugss_hwmod_class = {
> >>> -       .name           = "debugss",
> >>> -};
> >>> -
> >>> -static struct omap_hwmod am33xx_debugss_hwmod = {
> >>> -       .name           = "debugss",
> >>> -       .class          = &am33xx_debugss_hwmod_class,
> >>> -       .clkdm_name     = "l3_aon_clkdm",
> >>> -       .main_clk       = "debugss_ick",
> >>> -       .prcm           = {
> >>> -               .omap4  = {
> >>> -                       .clkctrl_offs   = AM33XX_CM_WKUP_DEBUGSS_CLKCTRL_OFFSET,
> >>> -                       .modulemode     = MODULEMODE_SWCTRL,
> >>> -               },
> >>> -       },
> >>> -};
> >>> -
> >>> /* ocmcram */
> >>>  static struct omap_hwmod_class am33xx_ocmcram_hwmod_class = {
> >>>         .name = "ocmcram",
> >>> @@ -570,6 +549,28 @@ static struct omap_hwmod am33xx_sha0_hwmod = {
> >>>
> >>>  #endif
> >>>
> >>> +/*
> >>> + * 'debugss' class
> >>> + * debug sub system
> >>> + */
> >>> +static struct omap_hwmod_class am33xx_debugss_hwmod_class = {
> >>> +       .name           = "debugss",
> >>> +};
> >>> +
> >>> +static struct omap_hwmod am33xx_debugss_hwmod = {
> >>> +       .name           = "debugss",
> >>> +       .class          = &am33xx_debugss_hwmod_class,
> >>> +       .clkdm_name     = "l3_aon_clkdm",
> >>> +       .main_clk       = "debugss_ick",
> >>> +       .flags          =  (HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET),
> 
> Setting these flags would still leave the problem where JTAG clocks
> are on when its not required no? In that case, what is the advantage
> of this patch?
> 

I missed to wrap it around #ifdef CONFIG_DEBUG_KERNEL. I will submit the 
formal patch shortly.

Thanks,
Vaibhav

