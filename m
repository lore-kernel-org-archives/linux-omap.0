From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v7 12/12] OMAP2: dmtimer: set wakeup enable explicitly
 in plat
Date: Mon, 3 Jan 2011 13:01:49 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0373BA2B32@dbde02.ent.ti.com>
References: <1292882719-30255-1-git-send-email-tarun.kanti@ti.com>
 <1292882719-30255-13-git-send-email-tarun.kanti@ti.com>
 <4D0FE2A7.2000506@ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0373A94395@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44119 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751961Ab1ACHcC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Jan 2011 02:32:02 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p037VpNu014193
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 3 Jan 2011 01:31:58 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p037VoWK006623
	for <linux-omap@vger.kernel.org>; Mon, 3 Jan 2011 13:01:50 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Benoit, Kevin,

[snip]
...

> >
> > > The point is that this fix is not really acceptable for my point of
> > view:-
> > > (
> > > You really have to check what is going on in the hwmod _enable_wakeup
> > > function.
> > Yes, I understand.  Let's check if this problem goes away in Kevin's
> > setup.
> I am seeing the problem with Kevin's setup as well.

If I remove SYSC_HAS_AUTOIDLE flag the problem goes away.
BTW, I have traced _enable_wakeup() and is working fine.
--
Tarun

> > >
> > > >
> > > > I am not sure if there is already a patch to fix this problem. Until
> > the
> > > > reason is found we need this patch to boot on the above platforms.
> > > >
> > > > Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> > > > ---
> > > >   arch/arm/plat-omap/dmtimer.c |   13 +++++++++++++
> > > >   1 files changed, 13 insertions(+), 0 deletions(-)
> > > >
> > > > diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-
> > omap/dmtimer.c
> > > > index f4aa4a1..007b754 100644
> > > > --- a/arch/arm/plat-omap/dmtimer.c
> > > > +++ b/arch/arm/plat-omap/dmtimer.c
> > > > @@ -227,6 +227,7 @@ static void omap_dm_timer_write_reg(struct
> > > omap_dm_timer *timer, u32 reg,
> > > >
> > > >   static void omap_dm_timer_prepare(struct omap_dm_timer *timer)
> > > >   {
> > > > +	u32 l;
> > > >   	struct dmtimer_platform_data *pdata = timer->pdev-
> > >dev.platform_data;
> > > >
> > > >   	if (!pdata->is_omap16xx) {
> > > > @@ -243,6 +244,18 @@ static void omap_dm_timer_prepare(struct
> > > omap_dm_timer *timer)
> > > >   	if (pdata->dm_timer_reset)
> > > >   		pdata->dm_timer_reset(timer);
> > > >
> > > > +	/*
> > > > +	 * Enable wake-up on OMAP2420, OMAP2430 CPUs.
> > > > +	 * FIXME: SYSC_HAS_ENAWAKEUP flag is already set in hwmod
> > database.
> > > > +	 * But the setting does not seem to work. Need to investigate
> > why
> > > > +	 * this is happening.
> > > > +	 */
> > > > +	if (cpu_is_omap2430() || cpu_is_omap2420()) {
> > > > +		l = omap_dm_timer_read_reg(timer, OMAP_TIMER_OCP_CFG_REG);
> > > > +		l |= 1<<  2;
> > > > +		omap_dm_timer_write_reg(timer, OMAP_TIMER_OCP_CFG_REG, l);
> > > > +	}
> > > > +
> > > >   	omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
> > > >
> > > >   	/* Match hardware reset default of posted mode */
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
