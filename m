From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v4] OMAP3: Registering sgx device and it's platform data
Date: Thu, 20 May 2010 19:32:23 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026FB23291@dbde02.ent.ti.com>
References: <1273727200-4811-1-git-send-email-manjugk@ti.com>
 <4BEC1B71.3070204@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54486 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753441Ab0ETOCb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 May 2010 10:02:31 -0400
In-Reply-To: <4BEC1B71.3070204@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Agarwal, Preshit" <preshit.agarwal@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Turquette, Mike" <mturquette@ti.com>, "V, Hemanth" <hemanthv@ti.com>

 

> -----Original Message-----
> From: Menon, Nishanth 
> Sent: Thursday, May 13, 2010 9:02 PM
> To: G, Manjunath Kondaiah
> Cc: linux-omap@vger.kernel.org; Agarwal, Preshit; Tony 
> Lindgren; Kevin Hilman; Turquette, Mike; V, Hemanth
> Subject: Re: [PATCH v4] OMAP3: Registering sgx device and 
> it's platform data
> 
> G, Manjunath Kondaiah had written, on 05/13/2010 12:06 AM, 
> the following:
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
> >  arch/arm/mach-omap2/devices.c                  |   21 
> +++++++++++++++++++--
> >  arch/arm/mach-omap2/include/mach/omap_sgxdef.h |   11 +++++++++++
> >  2 files changed, 30 insertions(+), 2 deletions(-)
> >  create mode 100644 arch/arm/mach-omap2/include/mach/omap_sgxdef.h
> > 
> > diff --git a/arch/arm/mach-omap2/devices.c 
> b/arch/arm/mach-omap2/devices.c
> > index 2271b9b..6349ee5 100644
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
> > @@ -786,6 +786,23 @@ static inline void omap_hdq_init(void)
> >  static inline void omap_hdq_init(void) {}
> >  #endif
> >  
> > +struct sgx_platform_data omap_sgx_data = {
> > +	.set_min_bus_tput = NULL,
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
> >  
> /*------------------------------------------------------------
> -------------*/
> >  
> >  static int __init omap2_init_devices(void)
> > @@ -800,7 +817,7 @@ static int __init omap2_init_devices(void)
> >  	omap_hdq_init();
> >  	omap_init_sti();
> >  	omap_init_sha1_md5();
> > -
> > +	omap_init_sgx();
> should'nt we depend on has_sgx_feature?

I will change it to: "if (omap3_has_sgx) omap_init_sgx();"

-Manjunath