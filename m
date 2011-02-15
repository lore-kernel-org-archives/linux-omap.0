From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCHv2] omap2/3: dmtimer: Enable autoidle
Date: Tue, 15 Feb 2011 21:55:25 +0530
Message-ID: <56b8f6de37c57ffb77efdb349985d8e0@mail.gmail.com>
References: <1297787428-5717-1-git-send-email-tero.kristo@nokia.com><6038d98e9a2eb2129200f5e08560cf7e@mail.gmail.com>
 <878vxhuv6w.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:55166 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754166Ab1BOQZe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Feb 2011 11:25:34 -0500
Received: by mail-gy0-f174.google.com with SMTP id 11so158505gyb.33
        for <linux-omap@vger.kernel.org>; Tue, 15 Feb 2011 08:25:33 -0800 (PST)
In-Reply-To: <878vxhuv6w.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tero Kristo <tero.kristo@nokia.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@ti.com]
> Sent: Tuesday, February 15, 2011 9:50 PM
> To: Santosh Shilimkar
> Cc: Tero Kristo; linux-omap@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCHv2] omap2/3: dmtimer: Enable autoidle
>
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
> >> -----Original Message-----
> >> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> >> owner@vger.kernel.org] On Behalf Of Tero Kristo
> >> Sent: Tuesday, February 15, 2011 10:00 PM
> >> To: linux-omap@vger.kernel.org
> >> Cc: linux-arm-kernel@lists.infradead.org
> >> Subject: [PATCHv2] omap2/3: dmtimer: Enable autoidle
> >>
> >> This saves some power. OMAP4 version should check for GPT module
> ID,
> >> as
> >> autoidle is only supported on a subset of these.
> >>
> >> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> >> ---
> >>  arch/arm/plat-omap/dmtimer.c |    4 ++++
> >>  1 files changed, 4 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-
> >> omap/dmtimer.c
> >> index 1d706cf..ee9f6eb 100644
> >> --- a/arch/arm/plat-omap/dmtimer.c
> >> +++ b/arch/arm/plat-omap/dmtimer.c
> >> @@ -342,6 +342,10 @@ static void omap_dm_timer_reset(struct
> >> omap_dm_timer *timer)
> >>  	l |= 0x02 << 3;  /* Set to smart-idle mode */
> >>  	l |= 0x2 << 8;   /* Set clock activity to perserve f-clock on
> >> idle */
> >>
> >> +	/* Enable autoidle on OMAP2 / OMAP3 */
> >> +	if (cpu_is_omap24xx() || cpu_is_omap34xx())
> >> +		l |= 0x1 << 0;
> >> +
> > We should get rid of this CPU checks. How about adding a flag
> > and populating it on init for the architectures it supports.
> >
>
> Instead, this should be implemented on top of Tarun's hwmod
> conversion
> which knows that different timers have different capabilities (e.g.
> 1ms)
> and autoidle can be set based on capabilities.
>
You are right. Looking at patches it's seems to be already
implemented.

So this patch isn't needed really.

Regards,
Santosh
