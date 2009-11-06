From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH] Fix race condition in omap_request_dma()
Date: Fri, 6 Nov 2009 17:52:55 +0530
Message-ID: <618f0c910911060422p232c3e6apd870ab1253edf03c@mail.gmail.com>
References: <F12CE1A68F023D498A2691C7B539311503B17F61@ZMY16EXM66.ds.mot.com>
	 <618f0c910910301022m313cc0f3sb3f1f3439571d950@mail.gmail.com>
	 <F12CE1A68F023D498A2691C7B539311503B80E25@ZMY16EXM66.ds.mot.com>
	 <F12CE1A68F023D498A2691C7B539311503B816E8@ZMY16EXM66.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:56135 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752287AbZKFMWu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Nov 2009 07:22:50 -0500
Received: by pwj9 with SMTP id 9so607665pwj.21
        for <linux-omap@vger.kernel.org>; Fri, 06 Nov 2009 04:22:56 -0800 (PST)
In-Reply-To: <F12CE1A68F023D498A2691C7B539311503B816E8@ZMY16EXM66.ds.mot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: HU TAO-TGHK48 <taohu@motorola.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Yang Fei-AFY095 <fei.yang@motorola.com>, jon-hunter@ti.com, Zhou Ming-a17711 <a17711@motorola.com>, "Ye Yuan.Bo-A22116" <yuan-bo.ye@motorola.com>

On Fri, Nov 6, 2009 at 12:45 AM, HU TAO-TGHK48 <taohu@motorola.com> wro=
te:
>
> Any new comments?
>
> -Hu Tao
>
>
I am happy with this version.
Regards,

Venkatraman.

>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of HU TAO-TGHK48
>> Sent: Saturday, October 31, 2009 5:33 AM
>> To: Venkatraman S
>> Cc: linux-omap@vger.kernel.org; Tony Lindgren; Yang
>> Fei-AFY095; jon-hunter@ti.com; Zhou Ming-a17711; Ye Yuan.Bo-A22116
>> Subject: RE: [PATCH] Fix race condition in omap_request_dma()
>>
>> Hi, Venkatraman
>>
>> Agree with you. And just found omap_free_dma() need to be fixed too.
>> New patch attached.
>>
>> From 7aa22ece591365c2dcd73c799d93781497322ff1 Mon Sep 17 00:00:00 20=
01
>> From: Tao Hu <taohu@motorola.com>
>> Date: Fri, 30 Oct 2009 16:24:25 -0500
>> Subject: [PATCH] Fix race condition in omap dma driver
>>
>> The bug could cause irq enable bit of one DMA channel is
>> cleared/set unexpectedly when 2 (or more) drivers are calling
>> omap_request_dma()/omap_free_dma() simultaneously
>>
>> Signed-off-by: Fei Yang <AFY095@motorola.com>
>> Signed-off-by: Tao Hu =A0<taohu@motorola.com>
>> ---
>> =A0arch/arm/plat-omap/dma.c | =A0 =A06 ++++++
>> =A01 files changed, 6 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/dma.c
>> b/arch/arm/plat-omap/dma.c index cd53b28..5767899 100755
>> --- a/arch/arm/plat-omap/dma.c
>> +++ b/arch/arm/plat-omap/dma.c
>> @@ -673,13 +673,16 @@ static inline void disable_lnk(int lch)
>> =A0static inline void omap2_enable_irq_lch(int lch) =A0{
>> =A0 =A0 =A0 u32 val;
>> + =A0 =A0 unsigned long flags;
>>
>> =A0 =A0 =A0 if (!cpu_class_is_omap2())
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>
>> + =A0 =A0 spin_lock_irqsave(&dma_chan_lock, flags);
>> =A0 =A0 =A0 val =3D dma_read(IRQENABLE_L0);
>> =A0 =A0 =A0 val |=3D 1 << lch;
>> =A0 =A0 =A0 dma_write(val, IRQENABLE_L0);
>> + =A0 =A0 spin_unlock_irqrestore(&dma_chan_lock, flags);
>> =A0}
>>
>> =A0int omap_request_dma(int dev_id, const char *dev_name, @@
>> -788,10 +791,13 @@ void omap_free_dma(int lch)
>>
>> =A0 =A0 =A0 if (cpu_class_is_omap2()) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 val;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&dma_chan_lock, flags);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Disable interrupts */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D dma_read(IRQENABLE_L0);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 val &=3D ~(1 << lch);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_write(val, IRQENABLE_L0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&dma_chan_lock, fla=
gs);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Clear the CSR register and IRQ status=
 register */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR(=
lch));
>> --
>> 1.5.4.3
>>
>>
>>
>> > -----Original Message-----
>> > From: Venkatraman S [mailto:svenkatr@gmail.com]
>> > Sent: Saturday, October 31, 2009 1:22 AM
>> > To: HU TAO-TGHK48
>> > Cc: linux-omap@vger.kernel.org; Tony Lindgren; Yang Fei-AFY095;
>> > jon-hunter@ti.com; Zhou Ming-a17711; Ye Yuan.Bo-A22116
>> > Subject: Re: [PATCH] Fix race condition in omap_request_dma()
>> >
>> > On Fri, Oct 30, 2009 at 9:00 AM, HU TAO-TGHK48 <taohu@motorola.com=
>
>> > wrote:
>> > > From a36dac7ee6140ffa23f0adc024964aaf3e266e5f Mon Sep 17
>> > 00:00:00 2001
>> > > From: Tao Hu <taohu@motorola.com>
>> > > Date: Thu, 29 Oct 2009 17:17:21 -0500
>> > > Subject: [PATCH] Fix race condition in omap_request_dma()
>> > >
>> > > The bug could cause irq enable bit of one DMA channel is cleared
>> > > unexpectedly when 2 (or more) drivers are calling
>> > > omap_request_dma() simultaneously
>> > >
>> > > Signed-off-by: Fei Yang <AFY095@motorola.com>
>> > > Signed-off-by: Tao Hu =A0<taohu@motorola.com>
>> > > ---
>> > > =A0arch/arm/plat-omap/dma.c | =A0 =A02 ++
>> > > =A01 files changed, 2 insertions(+), 0 deletions(-)
>> > >
>> > > diff --git a/arch/arm/plat-omap/dma.c
>> > b/arch/arm/plat-omap/dma.c index
>> > > cd53b28..6895484 100755
>> > > --- a/arch/arm/plat-omap/dma.c
>> > > +++ b/arch/arm/plat-omap/dma.c
>> > > @@ -749,11 +749,13 @@ int omap_request_dma(int dev_id, const cha=
r
>> > > *dev_name,
>> > > =A0 =A0 =A0 =A0}
>> > >
>> > > =A0 =A0 =A0 =A0if (cpu_class_is_omap2()) {
>> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&dma_chan_lock, =
flags);
>> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap2_enable_irq_lch(free_ch);
>> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_enable_channel_irq(free_ch);
>> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Clear the CSR register and IRQ=
 status
>> register */
>> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_write(OMAP2_DMA_CSR_CLEAR_MAS=
K, CSR(free_ch));
>> > > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_write(1 << free_ch, IRQSTATUS=
_L0);
>> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&dma_chan_l=
ock, flags);
>> > > =A0 =A0 =A0 =A0}
>> >
>> > Nice catch. I think the lock needs to be applied only for
>> the global
>> > registers which are changed using the read - update - write method=
=2E
>> > The dma_write to per channel configuration registers need not be
>> > locked.
>> > Hence the lock is better placed "within" omap2_enable_irq_lch
>> > function. That way, if it's reused, the locking would also be in
>> > place.
>> > Thank you !
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe
>> linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
