From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH v5 1/5] omap gpmc: enable irq mode in gpmc
Date: Wed, 29 Sep 2010 12:07:48 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B0356476436@dbde02.ent.ti.com>
References: <1285594634-19277-1-git-send-email-s-ghorai@ti.com>
 <1285594634-19277-2-git-send-email-s-ghorai@ti.com>
 <20100928222727.GS3117@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46113 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751829Ab0I2Gh4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Sep 2010 02:37:56 -0400
In-Reply-To: <20100928222727.GS3117@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>



> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Wednesday, September 29, 2010 3:57 AM
> To: Ghorai, Sukumar
> Cc: linux-omap@vger.kernel.org; linux-mtd@lists.infradead.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH v5 1/5] omap gpmc: enable irq mode in gpmc
> 
> * Sukumar Ghorai <s-ghorai@ti.com> [100927 06:30]:
> >   add support the irq mode in GPMC.
> >   gpmc_init() function move after omap_init_irq() as it has dependecy on
> irq.
> 
> > --- a/arch/arm/mach-omap2/board-2430sdp.c
> > +++ b/arch/arm/mach-omap2/board-2430sdp.c
> > @@ -144,6 +144,7 @@ static void __init omap_2430sdp_init_irq(void)
> >  	omap_board_config_size = ARRAY_SIZE(sdp2430_config);
> >  	omap2_init_common_hw(NULL, NULL);
> >  	omap_init_irq();
> > +	gpmc_init();
> >  	omap_gpio_init();
> >  }
> >
> > diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-
> omap2/board-3430sdp.c
> > index 67b95b5..549cd62 100644
> > --- a/arch/arm/mach-omap2/board-3430sdp.c
> > +++ b/arch/arm/mach-omap2/board-3430sdp.c
> > @@ -328,6 +328,7 @@ static void __init omap_3430sdp_init_irq(void)
> >  	omap3_pm_init_cpuidle(omap3_cpuidle_params_table);
> >  	omap2_init_common_hw(hyb18m512160af6_sdrc_params, NULL);
> >  	omap_init_irq();
> > +	gpmc_init();
> >  	omap_gpio_init();
> >  }
> ...
> 
> You can avoid adding gpmc_init() by making it a subsys_initcall().
> Just make sure you return early from it with if (!cpu_class_is_omap2()).
[Ghorai] will do
> 
> > --- a/arch/arm/mach-omap2/gpmc.c
> > +++ b/arch/arm/mach-omap2/gpmc.c
> > @@ -713,6 +721,31 @@ void __init gpmc_init(void)
> >  	l |= (0x02 << 3) | (1 << 0);
> >  	gpmc_write_reg(GPMC_SYSCONFIG, l);
> >  	gpmc_mem_init();
> > +
> > +	/* initalize the irq_chained */
> > +	irq = OMAP_GPMC_IRQ_BASE;
> > +	for (cs = 0; cs < GPMC_CS_NUM; cs++) {
> > +		set_irq_handler(irq, handle_simple_irq);
> > +		set_irq_flags(irq, IRQF_VALID);
> > +		irq++;
> > +	}
> > +
> > +	if (request_irq(20, gpmc_handle_irq, IRQF_SHARED, "gpmc",
> gpmc_base))
> > +		printk(KERN_ERR "gpmc: irq-%d could not claim: err %d\n",
> > +							INT_34XX_GPMC_IRQ, irq);
> > +}
> 
> Hmm, this does not look right.. Shouldn't you call
> set_irq_chained_handler()
> somewhere too? 
[Ghorai] its not use, as multi-lebel irq is not there.
>Also, are you sure the interrupt is 20 for all of mach-
> omap2?
> It should be added to the irqs.h files.
[Ghorai] it's added in irqs.h, and will remove the hard coded value. Last minute mistake.

> 
> > +static irqreturn_t gpmc_handle_irq(int irq, void *dev)
> > +{
> > +	u8 cs;
> > +
> > +	if (irq != INT_34XX_GPMC_IRQ)
> > +		return IRQ_HANDLED;
> > +	/* check cs to invoke the irq */
> > +	cs = ((gpmc_read_reg(GPMC_PREFETCH_CONFIG1)) >> CS_NUM_SHIFT) & 0x7;
> > +	generic_handle_irq(OMAP_GPMC_IRQ_BASE+cs);
> > +
> > +	return IRQ_HANDLED;
> >  }
> 
> Doesn't doing OMAP_GPMC_IRQ_BASE + cs overlap with some other irq?
[Ghorai] will check the boundary condition too -
if(OMAP_GPMC_IRQ_BASE + cs <= OMAP_GPMC_IRQ_END)

And will re-submit.

> 
> Regards,
> 
> Tony
