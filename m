From: "HU TAO-TGHK48" <taohu@motorola.com>
Subject: RE: [PATCH] Fix race condition in omap_request_dma()
Date: Sat, 7 Nov 2009 00:45:24 +0800
Message-ID: <F12CE1A68F023D498A2691C7B539311503B81862@ZMY16EXM66.ds.mot.com>
References: <F12CE1A68F023D498A2691C7B539311503B17F61@ZMY16EXM66.ds.mot.com> <618f0c910910301022m313cc0f3sb3f1f3439571d950@mail.gmail.com> <F12CE1A68F023D498A2691C7B539311503B80E25@ZMY16EXM66.ds.mot.com> <F12CE1A68F023D498A2691C7B539311503B816E8@ZMY16EXM66.ds.mot.com> <618f0c910911060422p232c3e6apd870ab1253edf03c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail153.messagelabs.com ([216.82.253.51]:37156 "EHLO
	mail153.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759490AbZKFQpp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Nov 2009 11:45:45 -0500
Received: from il06exr03.mot.com (il06exr03.mot.com [129.188.137.133])
	by motgate8.mot.com (8.14.3/8.14.3) with ESMTP id nA6Gjonp010759
	for <linux-omap@vger.kernel.org>; Fri, 6 Nov 2009 09:45:50 -0700 (MST)
Received: from il06vts04.mot.com (il06vts04.mot.com [129.188.137.144])
	by il06exr03.mot.com (8.13.1/Vontu) with SMTP id nA6Gjn9D028432
	for <linux-omap@vger.kernel.org>; Fri, 6 Nov 2009 10:45:49 -0600 (CST)
Received: from ZMY16EXM66.ds.mot.com (zmy16exm66.ap.mot.com [10.179.4.26])
	by il06exr03.mot.com (8.13.1/8.13.0) with ESMTP id nA6Gjm4Q028424
	for <linux-omap@vger.kernel.org>; Fri, 6 Nov 2009 10:45:49 -0600 (CST)
Content-class: urn:content-classes:message
In-Reply-To: <618f0c910911060422p232c3e6apd870ab1253edf03c@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Yang Fei-AFY095 <fei.yang@motorola.com>, jon-hunter@ti.com, Zhou Ming-a17711 <a17711@motorola.com>, "Ye Yuan.Bo-A22116" <yuan-bo.ye@motorola.com>, Venkatraman S <svenkatr@ti.com>

Hi, Tony

Can we merge this patch in?
Thanks.
=20
-Hu Tao

> -----Original Message-----
> From: svenkatr@gmail.com [mailto:svenkatr@gmail.com] On=20
> Behalf Of Venkatraman S
> Sent: Friday, November 06, 2009 8:23 PM
> To: HU TAO-TGHK48
> Cc: linux-omap@vger.kernel.org; Tony Lindgren; Yang=20
> Fei-AFY095; jon-hunter@ti.com; Zhou Ming-a17711; Ye Yuan.Bo-A22116
> Subject: Re: [PATCH] Fix race condition in omap_request_dma()
>=20
> On Fri, Nov 6, 2009 at 12:45 AM, HU TAO-TGHK48=20
> <taohu@motorola.com> wrote:
> >
> > Any new comments?
> >
> > -Hu Tao
> >
> >
> I am happy with this version.
> Regards,
>=20
> Venkatraman.
>=20
> >
> >> -----Original Message-----
> >> From: linux-omap-owner@vger.kernel.org=20
> >> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of HU=20
> TAO-TGHK48
> >> Sent: Saturday, October 31, 2009 5:33 AM
> >> To: Venkatraman S
> >> Cc: linux-omap@vger.kernel.org; Tony Lindgren; Yang Fei-AFY095;=20
> >> jon-hunter@ti.com; Zhou Ming-a17711; Ye Yuan.Bo-A22116
> >> Subject: RE: [PATCH] Fix race condition in omap_request_dma()
> >>
> >> Hi, Venkatraman
> >>
> >> Agree with you. And just found omap_free_dma() need to be=20
> fixed too.
> >> New patch attached.
> >>
> >> From 7aa22ece591365c2dcd73c799d93781497322ff1 Mon Sep 17 00:00:00=20
> >> 2001
> >> From: Tao Hu <taohu@motorola.com>
> >> Date: Fri, 30 Oct 2009 16:24:25 -0500
> >> Subject: [PATCH] Fix race condition in omap dma driver
> >>
> >> The bug could cause irq enable bit of one DMA channel is=20
> cleared/set=20
> >> unexpectedly when 2 (or more) drivers are calling
> >> omap_request_dma()/omap_free_dma() simultaneously
> >>
> >> Signed-off-by: Fei Yang <AFY095@motorola.com>
> >> Signed-off-by: Tao Hu =A0<taohu@motorola.com>
> >> ---
> >> =A0arch/arm/plat-omap/dma.c | =A0 =A06 ++++++
> >> =A01 files changed, 6 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c=20
> >> index cd53b28..5767899 100755
> >> --- a/arch/arm/plat-omap/dma.c
> >> +++ b/arch/arm/plat-omap/dma.c
> >> @@ -673,13 +673,16 @@ static inline void disable_lnk(int lch)
> >> =A0static inline void omap2_enable_irq_lch(int lch) =A0{
> >> =A0 =A0 =A0 u32 val;
> >> + =A0 =A0 unsigned long flags;
> >>
> >> =A0 =A0 =A0 if (!cpu_class_is_omap2())
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> >>
> >> + =A0 =A0 spin_lock_irqsave(&dma_chan_lock, flags);
> >> =A0 =A0 =A0 val =3D dma_read(IRQENABLE_L0);
> >> =A0 =A0 =A0 val |=3D 1 << lch;
> >> =A0 =A0 =A0 dma_write(val, IRQENABLE_L0);
> >> + =A0 =A0 spin_unlock_irqrestore(&dma_chan_lock, flags);
> >> =A0}
> >>
> >> =A0int omap_request_dma(int dev_id, const char *dev_name, @@ -788,=
10=20
> >> +791,13 @@ void omap_free_dma(int lch)
> >>
> >> =A0 =A0 =A0 if (cpu_class_is_omap2()) {
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 val;
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&dma_chan_lock, flags)=
;
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Disable interrupts */
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D dma_read(IRQENABLE_L0);
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 val &=3D ~(1 << lch);
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_write(val, IRQENABLE_L0);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&dma_chan_lock, f=
lags);
> >>
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Clear the CSR register and IRQ stat=
us register */
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CS=
R(lch));
> >> --
> >> 1.5.4.3
> >>
> >>
> >>
> >> > -----Original Message-----
> >> > From: Venkatraman S [mailto:svenkatr@gmail.com]
> >> > Sent: Saturday, October 31, 2009 1:22 AM
> >> > To: HU TAO-TGHK48
> >> > Cc: linux-omap@vger.kernel.org; Tony Lindgren; Yang Fei-AFY095;=20
> >> > jon-hunter@ti.com; Zhou Ming-a17711; Ye Yuan.Bo-A22116
> >> > Subject: Re: [PATCH] Fix race condition in omap_request_dma()
> >> >
> >> > On Fri, Oct 30, 2009 at 9:00 AM, HU TAO-TGHK48=20
> <taohu@motorola.com>
> >> > wrote:
> >> > > From a36dac7ee6140ffa23f0adc024964aaf3e266e5f Mon Sep 17
> >> > 00:00:00 2001
> >> > > From: Tao Hu <taohu@motorola.com>
> >> > > Date: Thu, 29 Oct 2009 17:17:21 -0500
> >> > > Subject: [PATCH] Fix race condition in omap_request_dma()
> >> > >
> >> > > The bug could cause irq enable bit of one DMA channel=20
> is cleared=20
> >> > > unexpectedly when 2 (or more) drivers are calling
> >> > > omap_request_dma() simultaneously
> >> > >
> >> > > Signed-off-by: Fei Yang <AFY095@motorola.com>
> >> > > Signed-off-by: Tao Hu =A0<taohu@motorola.com>
> >> > > ---
> >> > > =A0arch/arm/plat-omap/dma.c | =A0 =A02 ++
> >> > > =A01 files changed, 2 insertions(+), 0 deletions(-)
> >> > >
> >> > > diff --git a/arch/arm/plat-omap/dma.c
> >> > b/arch/arm/plat-omap/dma.c index
> >> > > cd53b28..6895484 100755
> >> > > --- a/arch/arm/plat-omap/dma.c
> >> > > +++ b/arch/arm/plat-omap/dma.c
> >> > > @@ -749,11 +749,13 @@ int omap_request_dma(int dev_id,=20
> const char=20
> >> > > *dev_name,
> >> > > =A0 =A0 =A0 =A0}
> >> > >
> >> > > =A0 =A0 =A0 =A0if (cpu_class_is_omap2()) {
> >> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&dma_chan_lock=
, flags);
> >> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap2_enable_irq_lch(free_ch);
> >> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_enable_channel_irq(free_ch=
);
> >> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Clear the CSR register and I=
RQ status
> >> register */
> >> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_write(OMAP2_DMA_CSR_CLEAR_M=
ASK,=20
> CSR(free_ch));
> >> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_write(1 << free_ch, IRQSTAT=
US_L0);
> >> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&dma_chan=
_lock, flags);
> >> > > =A0 =A0 =A0 =A0}
> >> >
> >> > Nice catch. I think the lock needs to be applied only for
> >> the global
> >> > registers which are changed using the read - update -=20
> write method.
> >> > The dma_write to per channel configuration registers need not be=
=20
> >> > locked.
> >> > Hence the lock is better placed "within" omap2_enable_irq_lch=20
> >> > function. That way, if it's reused, the locking would also be in=
=20
> >> > place.
> >> > Thank you !
> >> >
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe=20
> linux-omap"=20
> >> in the body of a message to majordomo@vger.kernel.org More=20
> majordomo=20
> >> info at =A0http://vger.kernel.org/majordomo-info.html
> >>
> >
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
