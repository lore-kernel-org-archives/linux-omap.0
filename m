From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v4] OMAP3: Registering sgx device and it's platform data
Date: Thu, 20 May 2010 19:50:41 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94026FB232B2@dbde02.ent.ti.com>
References: <1273727200-4811-1-git-send-email-manjugk@ti.com>
 <87vdaqmo7m.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39168 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751934Ab0ETOUt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 May 2010 10:20:49 -0400
In-Reply-To: <87vdaqmo7m.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Agarwal, Preshit" <preshit.agarwal@ti.com>, Tony Lindgren <tony@atomide.com>, "Turquette, Mike" <mturquette@ti.com>, "V, Hemanth" <hemanthv@ti.com>



> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
> Sent: Friday, May 14, 2010 10:10 PM
> To: G, Manjunath Kondaiah
> Cc: linux-omap@vger.kernel.org; Agarwal, Preshit; Tony 
> Lindgren; Turquette, Mike; V, Hemanth
> Subject: Re: [PATCH v4] OMAP3: Registering sgx device and 
> it's platform data
> 
> Manjunatha GK <manjugk@ti.com> writes:
> 
> > The SGX powervr_device is registered with it's platform specific
> > data to provide information about setting constraint through
> > omap_pm_set_min_bus_tput.
> 
> Now the patch content doesn't match the description as you no
> longer call omap_pm_set_min_bus_tput()...
> 
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
> 
> When I suggested you remove the #ifdef CONFIG_PM, I was expecting
> you to leave the omap_pm_set_min_bus_tput() part.
> 
> The point was that the driver itself should choose whether or 
> not to call
> pdata->set_min_bus_tput() using #ifdef or other runtime decisions.

I agree with your point. I will have only:
.set_min_bus_tput = omap_pm_set_min_bus_tput,

Let driver decide calling this using #ifdef or other runtime decisions.

-Manjunath