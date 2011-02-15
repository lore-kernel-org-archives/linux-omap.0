From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH] omap: dmtimer: Enable autoidle
Date: Tue, 15 Feb 2011 14:50:02 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03745CA4C6@dbde02.ent.ti.com>
References: <1297704375-25873-1-git-send-email-tero.kristo@nokia.com>
 <87oc6exkjr.fsf@ti.com>
 <854C6400F5AA6644BA6FE7953F3E769B037E9BDD@008-AM1MPN1-014.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57490 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753787Ab1BOJUR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Feb 2011 04:20:17 -0500
In-Reply-To: <854C6400F5AA6644BA6FE7953F3E769B037E9BDD@008-AM1MPN1-014.mgdnok.nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Tero.Kristo@nokia.com" <Tero.Kristo@nokia.com>, "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Tero.Kristo@nokia.com
> Sent: Tuesday, February 15, 2011 1:47 PM
> To: Hilman, Kevin
> Cc: linux-omap@vger.kernel.org
> Subject: RE: [PATCH] omap: dmtimer: Enable autoidle
> 
> 
> 
> >-----Original Message-----
> >From: ext Kevin Hilman [mailto:khilman@ti.com]
> >Sent: 15 February, 2011 01:29
> >To: Kristo Tero (Nokia-MS/Tampere)
> >Cc: linux-omap@vger.kernel.org
> >Subject: Re: [PATCH] omap: dmtimer: Enable autoidle
> >
> >Tero Kristo <tero.kristo@nokia.com> writes:
> >
> >> This will save some power.
> >>
> >> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> >
> >Please report which platforms this was tested with.
> 
> Tested only on OMAP3.
> 
> Should this be changed to apply only on that one? I don't know about
> OMAP4, but I think this should work on OMAP2 at least based on spec.
It works on OMAP2 and OMAP4.
--
Tarun

> 
> 
> >
> >Also, please Cc linux-arm-kernel.
> >
> >Thanks,
> >
> >Kevin
> >
> >> ---
> >>  arch/arm/plat-omap/dmtimer.c |    1 +
> >>  1 files changed, 1 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-
> >omap/dmtimer.c
> >> index 1d706cf..949becc 100644
> >> --- a/arch/arm/plat-omap/dmtimer.c
> >> +++ b/arch/arm/plat-omap/dmtimer.c
> >> @@ -341,6 +341,7 @@ static void omap_dm_timer_reset(struct
> >omap_dm_timer *timer)
> >>  	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_OCP_CFG_REG);
> >>  	l |= 0x02 << 3;  /* Set to smart-idle mode */
> >>  	l |= 0x2 << 8;   /* Set clock activity to perserve f-clock on idle
> >*/
> >> +	l |= 0x1 << 0;   /* Set autoidle */
> >>
> >>  	/*
> >>  	 * Enable wake-up on OMAP2 CPUs.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
