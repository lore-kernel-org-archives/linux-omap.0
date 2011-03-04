From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: Integration branch base switchover to Tony's omap-for-linus branch
Date: Fri, 4 Mar 2011 20:31:59 +0530
Message-ID: <4837f9c890c8a6c38d346cac73d9cec6@mail.gmail.com>
References: <alpine.DEB.2.00.1102251722450.6198@utopia.booyaka.com>
 <3f332cbd75f835ca119bdeccd72c4bb2@mail.gmail.com> <alpine.DEB.2.00.1103011431240.16349@utopia.booyaka.com>
 <4D6F89FB.7080201@ti.com> <4D70F25C.4040206@ti.com> <4D70FE4A.8060600@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:48622 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752435Ab1CDPCI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 10:02:08 -0500
Received: by mail-gw0-f51.google.com with SMTP id 15so1209791gwb.10
        for <linux-omap@vger.kernel.org>; Fri, 04 Mar 2011 07:02:06 -0800 (PST)
In-reply-to: <4D70FE4A.8060600@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org

> -----Original Message-----
> From: Cousson, Benoit [mailto:b-cousson@ti.com]
> Sent: Friday, March 04, 2011 8:29 PM
> To: Nayak, Rajendra
> Cc: Paul Walmsley; Shilimkar, Santosh; linux-omap@vger.kernel.org
> Subject: Re: Integration branch base switchover to Tony's omap-for-
> linus branch
>
> Hi Rajendra,
>
> On 3/4/2011 3:08 PM, Nayak, Rajendra wrote:
> > Hi Paul,
>
> [...]
>
> > This however is still not rootcaused and is not the same as the
> issue
> > seen with i2c as the WE for GPT1 is already programmed for
> enabling
> > wakeup.
> >
> > The one way to fix this for now is to put GPT1 block in software
> > controlled idle as was done by your test patch for i2c.
> >
> > ---
> >   From fde94c22bb2db233b0b0cc4c2024d6f4e9f95257 Mon Sep 17
> 00:00:00 2001
> > From: Rajendra Nayak<rnayak@ti.com>
> > Date: Fri, 4 Mar 2011 19:33:45 +0530
> > Subject: [PATCH] OMAP4: hwmod: Disable hardware-controlled idle
> for GPT1
>
> Maybe we should emphasis the temporary need for this commit to avoid
> forgetting it?
>
> > Some issues seen (which cause lockups in suspend) with GPT1
> > after the MPU<->L4_WKUP static dependency was cleared can be
> > Worked-around for now by forcing GPT1 in software
> > controlled idle.
> >
> > Signed-off-by: Rajendra Nayak<rnayak@ti.com>
> > ---
> >    arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 +-
> >    1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > index 2c58827..9317a05 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > @@ -3989,7 +3989,7 @@ static struct omap_hwmod_ocp_if
> > *omap44xx_timer1_slaves[] = {
> >    static struct omap_hwmod omap44xx_timer1_hwmod = {
> >           .name           = "timer1",
> >           .class          =&omap44xx_timer_1ms_hwmod_class,
> > -       .flags          = HWMOD_INIT_NO_IDLE |
> HWMOD_INIT_NO_RESET,
> > +       .flags          = HWMOD_INIT_NO_IDLE | HWMOD_INIT_NO_RESET
> |
> > HWMOD_SWSUP_SIDLE,
>
> I was wondering why the previous flags were still there, but it
> looks
> like the revert was not done.
>
> I'll push it with the revert for the flags.
>
> Where is the Santosh's branch that should be rebased on top of that
> one?
>
I am trying to rebase it on Kevin's pm-core branch. Will cherry pick
these patches
