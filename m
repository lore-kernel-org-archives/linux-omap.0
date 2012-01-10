From: "Bedia, Vaibhav" <vaibhav.bedia@ti.com>
Subject: RE: [PATCHv12 0/9] OMAP3+: PRCM chain handler
Date: Tue, 10 Jan 2012 11:41:08 +0000
Message-ID: <B5906170F1614E41A8A28DE3B8D1214304EDAC@DBDE01.ent.ti.com>
References: <20111215213358.26632.44165.stgit@dusk>
	<B5906170F1614E41A8A28DE3B8D1214304DF4E@DBDE01.ent.ti.com>
 <87obucuzev.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56578 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755321Ab2AJLlS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Jan 2012 06:41:18 -0500
In-Reply-To: <87obucuzev.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Kevin,

On Tue, Jan 10, 2012 at 06:49:52, Hilman, Kevin wrote:
[...]
> >
> > 1. IO and wakeup events are not supported on AM33XX. Since cpu_is_34xx()
> > holds true for AM33XX I ended up adding a !cpu_is_am33xx() check in 
> > omap3xxx_prcm_init() to bypass the chain handler registration.
> 
> > Without such a check we were seeing a crash in USB since USB_CLKCTRL on 
> > AM33XX just happens to be at the IRQENABLE_MPU_OFFSET of OMAP3.
> > Hope such cpu_is_*() checks are acceptable.
> 
> We try to avoid them, especially when we already have existing feature
> flag for IO wakeups.
> 
> Does something like (completely untested) patch below work for you?
> 
> Of course, that implies that that feature flag is initialized correctly
> for AM33xx.
> 
> Kevin
> 
> 
> 
> diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
> index c1c4d86..87451d9 100644
> --- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
> +++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
> @@ -302,7 +302,7 @@ void omap3xxx_prm_restore_irqen(u32 *saved_mask)
>  
>  static int __init omap3xxx_prcm_init(void)
>  {
> -	if (cpu_is_omap34xx())
> +	if (cpu_is_omap34xx() && omap3_has_io_wakeup())
>  		return omap_prcm_register_chain_handler(&omap3_prcm_irq_setup);
>  	return 0;
>  }
> 

I'll try this out once we have feature flag initialized on AM33xx.
Can the cpu_is_omap34xx() check be completely dropped in that case?
Or is there some other reason for retaining it?

I guess we'll still need a way to avoid the error message from mux.c

Regards,
Vaibhav
