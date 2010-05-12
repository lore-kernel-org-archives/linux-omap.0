From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v3] OMAP3: Registering sgx device and it's platform data
Date: Wed, 12 May 2010 12:03:34 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026F9F3CD0@dbde02.ent.ti.com>
References: <1273560899-4449-1-git-send-email-manjugk@ti.com>
 <87hbmeeban.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41264 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751044Ab0ELGdm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 May 2010 02:33:42 -0400
In-Reply-To: <87hbmeeban.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Agarwal, Preshit" <preshit.agarwal@ti.com>, Tony Lindgren <tony@atomide.com>, "Turquette, Mike" <mturquette@ti.com>, "V, Hemanth" <hemanthv@ti.com>

 

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Tuesday, May 11, 2010 8:27 PM
> To: G, Manjunath Kondaiah
> Cc: linux-omap@vger.kernel.org; Agarwal, Preshit; Tony 
> Lindgren; Turquette, Mike; V, Hemanth
> Subject: Re: [PATCH v3] OMAP3: Registering sgx device and 
> it's platform data
> 
> Manjunatha GK <manjugk@ti.com> writes:
> 
> > The SGX powervr_device is registered with it's platform specific
> > data to provide information about setting constraint through
> > omap_pm_set_min_bus_tput.
> >
> > Signed-off-by: Preshit Agarwal <preshit.agarwal@ti.com>
> > Signed-off-by: Manjunatha GK <manjugk@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > Cc: Mike Turquette <mturquette@ti.com>
> > Cc: Hemanth V <hemanthv@ti.com>
> > ---
> >  arch/arm/mach-omap2/devices.c                  |   26 
> ++++++++++++++++++++++-
> >  arch/arm/mach-omap2/include/mach/omap_sgxdef.h |   11 ++++++++++
> >  2 files changed, 35 insertions(+), 2 deletions(-)
> >  create mode 100644 arch/arm/mach-omap2/include/mach/omap_sgxdef.h
> >
> > diff --git a/arch/arm/mach-omap2/devices.c 
> b/arch/arm/mach-omap2/devices.c
> > index 20fa76e..aabbf7b 100644
> > --- a/arch/arm/mach-omap2/devices.c
> > +++ b/arch/arm/mach-omap2/devices.c
> > @@ -26,7 +26,7 @@
> >  #include <plat/mux.h>
> >  #include <mach/gpio.h>
> >  #include <plat/mmc.h>
> > -
> > +#include <mach/omap_sgxdef.h>
> >  #include "mux.h"
> >  
> >  #if defined(CONFIG_VIDEO_OMAP2) || 
> defined(CONFIG_VIDEO_OMAP2_MODULE)
> > @@ -791,6 +791,28 @@ static inline void omap_hdq_init(void)
> >  static inline void omap_hdq_init(void) {}
> >  #endif
> >  
> > +struct sgx_platform_data omap_sgx_data = {
> > +#ifdef CONFIG_PM
> > +	.set_min_bus_tput = omap_pm_set_min_bus_tput,
> > +#else
> > +	.set_min_bus_tput = NULL,
> > +#endif
> 
> Please explain why this should be dependent on CONFIG_PM?
> 
> I suspect you should be making these kinds of decisions in the driver
> itself, not in device init.

Not sure in which context the SGX driver uses this platform data.
But, as you mentioned, we can leave it to SGX driver for handling it in  
driver itself. I will make this as NULL in device init.

> 
> > +};
> > +
> > +static struct platform_device powervr_device = {
> > +	.name            = "pvrsrvkm",
> > +	.id              = -1,
> > +	.dev            = {
> > +	.platform_data = &omap_sgx_data,
> > +       }
> > +};
> > +
> > +static void omap_init_sgx(void)
> > +{
> > +       (void) platform_device_register(&powervr_device);
> > +}
> > +
> > +
> >  
> /*------------------------------------------------------------
> -------------*/
> >  
> >  static int __init omap2_init_devices(void)
> > @@ -805,7 +827,7 @@ static int __init omap2_init_devices(void)
> >  	omap_hdq_init();
> >  	omap_init_sti();
> >  	omap_init_sha1_md5();
> > -
> > +	omap_init_sgx();
> >  	return 0;
> >  }
> >  arch_initcall(omap2_init_devices);
> > diff --git a/arch/arm/mach-omap2/include/mach/omap_sgxdef.h 
> b/arch/arm/mach-omap2/include/mach/omap_sgxdef.h
> > new file mode 100644
> > index 0000000..5d90a6a
> > --- /dev/null
> > +++ b/arch/arm/mach-omap2/include/mach/omap_sgxdef.h
> > @@ -0,0 +1,11 @@
> > +#ifndef OMAP_SGXDEF_H
> > +#define OMAP_SGXDEF_H
> > +
> > +#include <plat/omap-pm.h>
> > +
> > +struct sgx_platform_data {
> > +	void(*set_min_bus_tput)(struct device *dev, u8 agent_id,
> 
> need a space after 'void' and before '('

Ok.

>            
> > +							
> unsigned long r);
> 
> minor nit: you could drop a tab of 3 for nicer looking alignment 
Ok. Thanks

-Manjunath
