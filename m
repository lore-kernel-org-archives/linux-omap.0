From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: RE: [PATCH 6/6 v2] OMAP2PLUS: WDT: Conversion to runtime PM
Date: Thu, 12 Aug 2010 10:10:26 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C65D771E@dbde02.ent.ti.com>
References: <1281521471-15802-1-git-send-email-charu@ti.com>
	<1281521471-15802-2-git-send-email-charu@ti.com>
	<1281521471-15802-3-git-send-email-charu@ti.com>
	<1281521471-15802-4-git-send-email-charu@ti.com>
	<1281521471-15802-5-git-send-email-charu@ti.com>
	<1281521471-15802-6-git-send-email-charu@ti.com>
	<1281521471-15802-7-git-send-email-charu@ti.com>
 <87lj8d0z0e.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57006 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751036Ab0HLEkj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Aug 2010 00:40:39 -0400
In-Reply-To: <87lj8d0z0e.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "wim@iguana.be" <wim@iguana.be>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Basak, Partha" <p-basak2@ti.com>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Thursday, August 12, 2010 12:15 AM
> To: Varadarajan, Charulatha
> Cc: linux-omap@vger.kernel.org; wim@iguana.be; paul@pwsan.com; Cousson,
> Benoit; Nayak, Rajendra; Basak, Partha
> Subject: Re: [PATCH 6/6 v2] OMAP2PLUS: WDT: Conversion to runtime PM
> 
> Charulatha V <charu@ti.com> writes:
> 
> > This patch converts the OMAP Watchdog timer driver to
> > get adapted to HWMOD FW and to use the runtime PM APIs.
> >
> > Signed-off-by: Charulatha V <charu@ti.com>
> > Signed-off-by: Basak, Partha <p-basak2@ti.com>
> 
> This series looks good.  One minor comment below...
> 
> > ---
> >  arch/arm/plat-omap/devices.c |   52 ++++++++++++++++++++++++++++++-----
> ------
> >  drivers/watchdog/omap_wdt.c  |   43 ++++++----------------------------
> >  2 files changed, 46 insertions(+), 49 deletions(-)
> >
> > diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
> > index d1920be..efe2aff 100644
> > --- a/arch/arm/plat-omap/devices.c
> > +++ b/arch/arm/plat-omap/devices.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/io.h>
> >  #include <linux/slab.h>
> > +#include <linux/err.h>
> >
> >  #include <mach/hardware.h>
> >  #include <asm/mach-types.h>
> > @@ -28,6 +29,8 @@
> >  #include <plat/menelaus.h>
> >  #include <plat/mcbsp.h>
> >  #include <plat/omap44xx.h>
> > +#include <plat/omap_hwmod.h>
> > +#include <plat/omap_device.h>
> >
> >  /*---------------------------------------------------------------------
> ----*/
> >
> > @@ -238,6 +241,8 @@ static inline void omap_init_uwire(void) {}
> >
> >  static struct resource wdt_resources[] = {
> >  	{
> > +		.start		= 0xfffeb000,
> > +		.end		= 0xfffeb07F,
> >  		.flags		= IORESOURCE_MEM,
> >  	},
> >  };
> 
> This struct should probably be renamed with an omap1_ prefix.
> 
> > @@ -249,24 +254,43 @@ static struct platform_device omap_wdt_device = {
> >  	.resource	= wdt_resources,
> >  };
> 
> ditto
> 

Okay

> and they should be moved down just above omap_init_wdt()

Okay. Will send you the updated patch series soon.

> 
> > -static void omap_init_wdt(void)
> > +struct omap_device_pm_latency omap_wdt_latency[] = {
> > +	[0] = {
> > +		.deactivate_func = omap_device_idle_hwmods,
> > +		.activate_func   = omap_device_enable_hwmods,
> > +		.flags		 = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
> > +	},
> > +};
> > +
> > +static void omap2_init_wdt()
> >  {
> > -	if (cpu_is_omap16xx())
> > -		wdt_resources[0].start = 0xfffeb000;
> > -	else if (cpu_is_omap2420())
> > -		wdt_resources[0].start = 0x48022000; /* WDT2 */
> > -	else if (cpu_is_omap2430())
> > -		wdt_resources[0].start = 0x49016000; /* WDT2 */
> > -	else if (cpu_is_omap343x())
> > -		wdt_resources[0].start = 0x48314000; /* WDT2 */
> > -	else if (cpu_is_omap44xx())
> > -		wdt_resources[0].start = 0x4a314000;
> > -	else
> > +	int id = -1;
> > +	struct omap_device *od;
> > +	struct omap_hwmod *oh;
> > +	char *oh_name = "wd_timer2";
> > +	char *name = "omap_wdt";
> > +
> > +	oh = omap_hwmod_lookup(oh_name);
> > +	if (!oh) {
> > +		pr_err("Could not look up %s\n", oh_name);
> >  		return;
> > +	}
> 
> Kevin
