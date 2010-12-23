From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v7 12/12] OMAP2: dmtimer: set wakeup enable explicitly
 in plat
Date: Thu, 23 Dec 2010 16:22:09 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0373BA1C5D@dbde02.ent.ti.com>
References: <1292882719-30255-1-git-send-email-tarun.kanti@ti.com>
 <1292882719-30255-13-git-send-email-tarun.kanti@ti.com>
 <4D0FE2A7.2000506@ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0373A94395@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60567 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752455Ab0LWKwO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Dec 2010 05:52:14 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id oBNAqBN9029513
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 23 Dec 2010 04:52:13 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id oBNAqB9L014077
	for <linux-omap@vger.kernel.org>; Thu, 23 Dec 2010 16:22:11 +0530 (IST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0373A94395@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Benoit,
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of DebBarma, Tarun Kanti
> Sent: Wednesday, December 22, 2010 5:02 PM
> To: Cousson, Benoit
> Cc: linux-omap@vger.kernel.org
> Subject: RE: [PATCH v7 12/12] OMAP2: dmtimer: set wakeup enable explicitly
> in plat
> 
> Hello Benoit,
> > -----Original Message-----
> > From: Cousson, Benoit
> > Sent: Tuesday, December 21, 2010 4:42 AM
> > To: DebBarma, Tarun Kanti
> > Cc: linux-omap@vger.kernel.org
> > Subject: Re: [PATCH v7 12/12] OMAP2: dmtimer: set wakeup enable
> explicitly
> > in plat
> >
> > Hi Tarun,
> >
> > On 12/20/2010 11:05 PM, DebBarma, Tarun Kanti wrote:
> > > For some reason the wakeup enable bit is not getting set on OMAP2430,
> > > OMAP2420. This is inspite of the fact that SYSC_HAS_ENAWAKEUP flag is
> > > present in the hwmod database.
> >
> > This is indeed strange. Did you observe that on OMAP3 & 4?
> I am NOT seeing this on OMAP3 and OMAP4.
> 
> > Did you use the patch that Kevin did recently to fix an issue with the
> > ENAWAKEUP bit?
> > http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-
> > pm.git;a=commit;h=d15ae13fc7428a95b02c1935ebf92324fcb80a5f
> >
> No, I have tested on mainline. Right now I am testing on Kevin's
> PM branch and will see the result.
> 
> > The point is that this fix is not really acceptable for my point of
> view:-
> > (
> > You really have to check what is going on in the hwmod _enable_wakeup
> > function.
> Yes, I understand.  Let's check if this problem goes away in Kevin's
> setup.
I am seeing the problem with Kevin's setup as well.

--
Tarun

> >
> > >
> > > I am not sure if there is already a patch to fix this problem. Until
> the
> > > reason is found we need this patch to boot on the above platforms.
> > >
> > > Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> > > ---
> > >   arch/arm/plat-omap/dmtimer.c |   13 +++++++++++++
> > >   1 files changed, 13 insertions(+), 0 deletions(-)
> > >
> > > diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-
> omap/dmtimer.c
> > > index f4aa4a1..007b754 100644
> > > --- a/arch/arm/plat-omap/dmtimer.c
> > > +++ b/arch/arm/plat-omap/dmtimer.c
> > > @@ -227,6 +227,7 @@ static void omap_dm_timer_write_reg(struct
> > omap_dm_timer *timer, u32 reg,
> > >
> > >   static void omap_dm_timer_prepare(struct omap_dm_timer *timer)
> > >   {
> > > +	u32 l;
> > >   	struct dmtimer_platform_data *pdata = timer->pdev-
> >dev.platform_data;
> > >
> > >   	if (!pdata->is_omap16xx) {
> > > @@ -243,6 +244,18 @@ static void omap_dm_timer_prepare(struct
> > omap_dm_timer *timer)
> > >   	if (pdata->dm_timer_reset)
> > >   		pdata->dm_timer_reset(timer);
> > >
> > > +	/*
> > > +	 * Enable wake-up on OMAP2420, OMAP2430 CPUs.
> > > +	 * FIXME: SYSC_HAS_ENAWAKEUP flag is already set in hwmod
> database.
> > > +	 * But the setting does not seem to work. Need to investigate
> why
> > > +	 * this is happening.
> > > +	 */
> > > +	if (cpu_is_omap2430() || cpu_is_omap2420()) {
> > > +		l = omap_dm_timer_read_reg(timer, OMAP_TIMER_OCP_CFG_REG);
> > > +		l |= 1<<  2;
> > > +		omap_dm_timer_write_reg(timer, OMAP_TIMER_OCP_CFG_REG, l);
> > > +	}
> > > +
> > >   	omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
> > >
> > >   	/* Match hardware reset default of posted mode */
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
