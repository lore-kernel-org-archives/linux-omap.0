From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH v2] dma: fix scope of errata i88 upto 3430ES1.0
Date: Mon, 26 Apr 2010 20:21:25 +0530
Message-ID: <g2q618f0c911004260751kae29a2fq6b90db2f221e15ca@mail.gmail.com>
References: <w2g618f0c911004020435qd281c5deoc3e0ade84cc2d0b1@mail.gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02C4C33347@dbde02.ent.ti.com>
	 <p2i618f0c911004050819u9af37b57ob399a52006f40017@mail.gmail.com>
	 <o2h618f0c911004050836ge9222b05i6520c8c7de9336ed@mail.gmail.com>
	 <v2g618f0c911004190351h438b8d14o83a57d631eef3a2c@mail.gmail.com>
	 <20100421211413.GJ18272@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f202.google.com ([209.85.223.202]:33238 "EHLO
	mail-iw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790Ab0DZOv0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Apr 2010 10:51:26 -0400
Received: by iwn40 with SMTP id 40so3241502iwn.1
        for <linux-omap@vger.kernel.org>; Mon, 26 Apr 2010 07:51:25 -0700 (PDT)
In-Reply-To: <20100421211413.GJ18272@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org

Tony Lindgren <tony@atomide.com> wrote:
> * Venkatraman S <svenkatr@ti.com> [100419 03:47]:
>> Hi Tony,
>> > Venkatraman S <svenkatr@ti.com> wrote:
>> > From 2799506180649cbb61d24cf2b4171425b2e1fa80 Mon Sep 17 00:00:00 =
2001
>> > From: Venkatraman S <svenkatr@ti.com>
>> > Date: Mon, 5 Apr 2010 20:56:27 +0530
>> > Subject: [PATCH] dma: fix scope of errata i88 upto 3430ES1.0
>> >
>> > DMA errata for special end of block programming is applicable
>> > only for OMAP2430 & OMAP3430 ES1.0.
>> > This patch does the necessary checks before the workaround
>> > is applied. Tested on 3430 SDP
>> >
>> > Signed-off-by: Thara Gopinath <thara@ti.com>
>> > Signed-off-by: Venkatraman S <svenkatr@ti.com>
>> > Reviewed-by: Shilimkar Santosh <santosh.shilimkar@ti.com>
>> > ---
>> > From v1, removed the redundant omap3430() check
>> >
>> > =A0arch/arm/plat-omap/dma.c | =A0 20 ++++++++++++--------
>> > =A01 files changed, 12 insertions(+), 8 deletions(-)
>> >
>> > diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
>> > index 2ab224c..a9b480a 100644
>> > --- a/arch/arm/plat-omap/dma.c
>> > +++ b/arch/arm/plat-omap/dma.c
>> > @@ -1663,14 +1663,17 @@ int omap_stop_dma_chain_transfers(int chai=
n_id)
>> > =A0 =A0 =A0 =A0channels =3D dma_linked_lch[chain_id].linked_dmach_=
q;
>> >
>> > =A0 =A0 =A0 =A0/*
>> > - =A0 =A0 =A0 =A0* DMA Errata:
>> > - =A0 =A0 =A0 =A0* Special programming model needed to disable DMA=
 before end of block
>> > + =A0 =A0 =A0 =A0* DMA Errata: i88
>> > + =A0 =A0 =A0 =A0* Special programming model needed
>> > + =A0 =A0 =A0 =A0* to disable DMA before end of block
>> > =A0 =A0 =A0 =A0 */
>> > =A0 =A0 =A0 =A0sys_cf =3D dma_read(OCP_SYSCONFIG);
>> > - =A0 =A0 =A0 l =3D sys_cf;
>> > - =A0 =A0 =A0 /* Middle mode reg set no Standby */
>> > - =A0 =A0 =A0 l &=3D ~((1 << 12)|(1 << 13));
>> > - =A0 =A0 =A0 dma_write(l, OCP_SYSCONFIG);
>> > + =A0 =A0 =A0 if (cpu_is_omap2430() || (omap_rev() =3D=3D OMAP3430=
_REV_ES1_0)) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l =3D sys_cf;
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Middle mode reg set no Standby */
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 l &=3D ~((1 << 12)|(1 << 13));
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_write(l, OCP_SYSCONFIG);
>> > + =A0 =A0 =A0 }
>> >
>> > =A0 =A0 =A0 =A0for (i =3D 0; i < dma_linked_lch[chain_id].no_of_lc=
hs_linked; i++) {
>> >
>
> What about other omaps? It seems that we're currently doing the worka=
round
> for all omaps. Seems like "Tested on 3430 SDP" is not quite safe enou=
gh
> for making change that might affect other omaps.
>
> Tony

     The Errata document specifically mentions that the workaround is
needed only for
3430 ES1.0 or earlier. I had actually tested on the ES2.0. [Now that
you have mentioned it,
I tested on 3630 and 4430 as well]
Let me know if you need more test results or information.
Thanks,

Venkat.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
