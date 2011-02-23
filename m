From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: Linux-next as of 20110222 broken on OMAP4
Date: Wed, 23 Feb 2011 10:20:39 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037A0952FD@dbde02.ent.ti.com>
References: <b858222d69a83460e469b80ee13cfbe8@mail.gmail.com>
 <4D63B160.3010103@ti.com> <20110222191343.GP15225@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54328 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753462Ab1BWEur convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Feb 2011 23:50:47 -0500
In-Reply-To: <20110222191343.GP15225@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Gadiyar, Anand" <gadiyar@ti.com>, linux-omap <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Wednesday, February 23, 2011 12:44 AM
> To: Cousson, Benoit
> Cc: Gadiyar, Anand; linux-omap
> Subject: Re: Linux-next as of 20110222 broken on OMAP4
> 
> * Cousson, Benoit <b-cousson@ti.com> [110222 04:50]:
> > Hi Anand,
> >
> > On 2/22/2011 10:49 AM, Gadiyar, Anand wrote:
> > > Looks like linux-next as of today is broken on at least OMAP4.
> > >
> > > Turning on earlyprintk, I get a crash in omap_init_mcspi. Disabling
> > > CONFIG_SPI_OMAP24XX gets me as far as the following lines from my
> > > bootup log, but I haven't attempted to debug further.
> > >
> > > If there are any patches out there to fix this, let me know.
> > > Else I will debug this sometime tomorrow.
> >
> > Yes, it was discussed with Tony and temporarily fixed yesterday.
> >
> > The SPI fix is is already in omap-for-linus, and the timer1 temp fix is
> below.
> > We need to find a better way to handle timer now that they are
> initialized pretty soon.
> 
> I applied the fix below with Paul's ack from the other thread.
> So linux-next should be working again on omap4 when it gets rebuilt.
I have tested on OMAP4 and OMAP3. BTW, it doesn't work on OMAP24xx.
--
Tarun
> 
> > ---
> > From 9a8dc4fdab03d00d556d05ad8b64c547493ad84d Mon Sep 17 00:00:00 2001
> > From: Benoit Cousson <b-cousson@ti.com>
> > Date: Tue, 22 Feb 2011 10:36:27 +0100
> > Subject: [PATCH] OMAP4: hwmod data: Prevent timer1 to be reset and idle
> during init
> >
> > Since the timer1 is now started before the hwmod_init, we cannot
> > reset it and idle it anymore.
> >
> > Add the appropriate flags to prevent the hwmod framework to do that.
> >
> > Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > ---
> >  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-
> omap2/omap_hwmod_44xx_data.c
> > index 182aa79..79a8601 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > @@ -3989,6 +3989,7 @@ static struct omap_hwmod_ocp_if
> *omap44xx_timer1_slaves[] = {
> >  static struct omap_hwmod omap44xx_timer1_hwmod = {
> >  	.name		= "timer1",
> >  	.class		= &omap44xx_timer_1ms_hwmod_class,
> > +	.flags		= HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET,
> >  	.mpu_irqs	= omap44xx_timer1_irqs,
> >  	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_timer1_irqs),
> >  	.main_clk	= "timer1_fck",
> > --
> > 1.7.0.4
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
