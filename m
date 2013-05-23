From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [BISECTED] 3.10-rc1 OMAP1 GPIO IRQ regression
Date: Thu, 23 May 2013 23:13:58 +0300
Message-ID: <20130523201358.GI31836@blackmetal.musicnaut.iki.fi>
References: <20130513205302.GA3157@blackmetal.musicnaut.iki.fi>
 <20130516180933.GG5600@atomide.com>
 <20130516210006.GA31836@blackmetal.musicnaut.iki.fi>
 <20130516214430.GN5600@atomide.com>
 <20130520174621.GI10378@atomide.com>
 <20130521173936.GE31836@blackmetal.musicnaut.iki.fi>
 <519BCCEC.8010303@gmail.com>
 <20130522212054.GG31836@blackmetal.musicnaut.iki.fi>
 <519E67AD.6070702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:55351 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758293Ab3EWUOH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 May 2013 16:14:07 -0400
Content-Disposition: inline
In-Reply-To: <519E67AD.6070702@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jgchunter@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, linux-omap@vger.kernel.org, Jon Hunter <jon-hunter@ti.com>, linux-arm-kernel@lists.infradead.org

On Thu, May 23, 2013 at 08:02:05PM +0100, Jon Hunter wrote:
> On 22/05/13 22:20, Aaro Koskinen wrote:
> > On Tue, May 21, 2013 at 08:37:16PM +0100, Jon Hunter wrote:
> >> On 21/05/13 18:39, Aaro Koskinen wrote:
> >>> On Mon, May 20, 2013 at 10:46:21AM -0700, Tony Lindgren wrote:
> >>>> * Tony Lindgren <tony@atomide.com> [130516 14:50]:
> >>>>> * Aaro Koskinen <aaro.koskinen@iki.fi> [130516 14:05]:
> >>>>>> On Thu, May 16, 2013 at 11:09:34AM -0700, Tony Lindgren wrote:
> >>>>>>> * Aaro Koskinen <aaro.koskinen@iki.fi> [130513 13:58]:
> >>>>>>>> I tested 3.10-rc1 on OMAP1 / Nokia 770, and Retu MFD probe is broken:
> >>>>>>>>
> >>>>>>>> [    2.264221] retu-mfd 2-0001: Retu v3.2 found
> >>>>>>>> [    2.281951] retu-mfd 2-0001: Failed to allocate IRQs: -12
> >>>>>>>> [    2.300140] retu-mfd: probe of 2-0001 failed with error -12
> >>>>>>>>
> >>>>>>>> The error is coming from regmap code. According to git bisect, it is
> >>>>>>>> caused by:
> >>>>>>>>
> >>>>>>>> 	commit ede4d7a5b9835510fd1f724367f68d2fa4128453
> >>>>>>>> 	Author: Jon Hunter <jon-hunter@ti.com>
> >>>>>>>> 	Date:   Fri Mar 1 11:22:47 2013 -0600
> >>>>>>>>
> >>>>>>>> 	    gpio/omap: convert gpio irq domain to linear mapping
> >>>>>>>>
> >>>>>>>> The commit does not anymore revert cleanly, and I haven't yet tried
> >>>>>>>> crafting a manual revert, so any fix proposals/ideas are welcome...
> >>>>>>>
> >>>>>>> Hmm this might be a bit trickier to fix. Obviously the real solution
> >>>>>>> is to convert omap1 to SPARSE_IRQ like we did for omap2+.
> >>>>>>>
> >>>>>>> For the -rc cycle, it might be possible to fix this by adding a
> >>>>>>> different irq_to_gpio() and gpio_to_irq() functions for omap1.
> >>>>>>
> >>>>>> The commit reverts cleanly if we also revert
> >>>>>> 3513cdeccc647d41c4a9ff923af17deaaac04a66 (gpio/omap: optimise interrupt
> >>>>>> service routine), which seems to be just some minor optimization. The
> >>>>>> result is below, and with it 770 works again.
> >>>>>
> >>>>> Hmm in this case it seems that we should just fix it rather than go back
> >>>>> to the old code, so let's take a look at that first.
> >>>>
> >>>> Does the following fix it for you or do we need to fix something else
> >>>> there too?
> >>>
> >>> Thanks, that fixes Retu probe on 770.
> >>
> >> Sorry for not responding sooner, but I have been moving. 
> >>
> >> From looking at the code it appears that the regmap_add_irq_chip()
> >> is failing in the retu driver. I am not sure if this will work, 
> >> but have you tried making the following change to the retu driver 
> >> so that it also uses irq_domain_add_linear() as well? Just a thought ...
> > 
> > This will trigger WARNING: at drivers/base/regmap/regmap-irq.c:514.
> 
> Sorry, there is another change needed. Can you try ...

I will try this. However, I would also like to point out that Retu works
fine on N800/N810 (OMAP2). If the problem is in Retu, why only OMAP1
is affected?

A.

> diff --git a/drivers/mfd/retu-mfd.c b/drivers/mfd/retu-mfd.c
> index a183098..9080cd6 100644
> --- a/drivers/mfd/retu-mfd.c
> +++ b/drivers/mfd/retu-mfd.c
> @@ -267,14 +267,13 @@ static int retu_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
>         if (ret < 0)
>                 return ret;
>  
> -       ret = regmap_add_irq_chip(rdev->regmap, i2c->irq, IRQF_ONESHOT, -1,
> +       ret = regmap_add_irq_chip(rdev->regmap, i2c->irq, IRQF_ONESHOT, 0,
>                                   rdat->irq_chip, &rdev->irq_data);
>         if (ret < 0)
>                 return ret;
>  
>         ret = mfd_add_devices(rdev->dev, -1, rdat->children, rdat->nchildren,
> -                             NULL, regmap_irq_chip_get_base(rdev->irq_data),
> -                             NULL);
> +                             NULL, 0, regmap_irq_get_domain(rdev->irq_data));
>         if (ret < 0) {
>                 regmap_del_irq_chip(i2c->irq, rdev->irq_data);
>                 return ret;
>  
> > Also other drivers report GPIO IRQ issues later in the boot, e.g.
> > 
> > [    3.907928] genirq: Flags mismatch irq 0. 00000001 (serial wakeup) vs. 00002000 (RETU)
> > [    3.923706] No interrupt for UART wake GPIO: 37
> 
> Looks like the gpio is just conflicting with the RETU driver.
>  
> > With Tony's patch (without any Retu modifications), the boot is clean. So
> > I guess gpio-omap fix is needed.
> 
> Ideally it would be good if the RETU can use linear domains and then may be this
> can be avoided.
> 
> Cheers
> Jon
