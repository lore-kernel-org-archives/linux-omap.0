From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v13 10/11] OMAP: dmtimer: mark clocksource and
 clockevent timers reserved
Date: Mon, 18 Apr 2011 11:20:22 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037AC12CCF@dbde02.ent.ti.com>
References: <1302969063-8231-1-git-send-email-tarun.kanti@ti.com>
 <1302969063-8231-11-git-send-email-tarun.kanti@ti.com>
 <4DAA84C3.3080705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49678 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751355Ab1DRFus convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Apr 2011 01:50:48 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p3I5oiMd016692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 18 Apr 2011 00:50:47 -0500
In-Reply-To: <4DAA84C3.3080705@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Shilimkar, Santosh
> Sent: Sunday, April 17, 2011 11:42 AM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH v13 10/11] OMAP: dmtimer: mark clocksource and
> clockevent timers reserved
> 
> On 4/16/2011 9:21 PM, Tarun Kanti DebBarma wrote:
> > In driver probe use sys_timer_reserved to identify which all timers
> > have already been used for clocksource and clockevent. Mark all those
> > timers as reserved so that no one else can use them.
> >
> > Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> > ---
> >   arch/arm/plat-omap/dmtimer.c |    8 +++++++-
> >   1 files changed, 7 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
> > index e15b3a8..8b6fd22 100644
> > --- a/arch/arm/plat-omap/dmtimer.c
> > +++ b/arch/arm/plat-omap/dmtimer.c
> > @@ -554,7 +554,13 @@ static int __devinit omap_dm_timer_probe(struct
> platform_device *pdev)
> >   	timer->id = pdev->id;
> >   	timer->irq = irq->start;
> >   	timer->pdev = pdev;
> > -	timer->reserved = 0;
> > +#if defined(CONFIG_ARCH_OMAP2)
> 
> Do you mean CONFIG_ARCH_OMAP2PLUS here ?
Yes, I will correct. Thanks.
--
Tarun
> 
> > +	/* Mark clocksource and clockevent timers as reserved */
> > +	if ((sys_timer_reserved>>  (pdev->id - 1))&  0x1)
> > +		timer->reserved = 1;
> > +	else
> > +#endif
> > +		timer->reserved = 0;
> >
> >   	 /* Skip pm_runtime_enable for OMAP1 */
> >   	if (!pdata->needs_manual_reset)

