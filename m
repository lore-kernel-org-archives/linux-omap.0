From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] video: omap: vram: remove from normal memory
Date: Mon, 8 Nov 2010 00:49:48 +0200
Message-ID: <AANLkTin+0B1GbiJkf9X88-08Yc6LROSorPyCyydvCtkK@mail.gmail.com>
References: <AANLkTik_6byuzkZ+mKunTi6HJTHu49C4XGebfTjCaEeE@mail.gmail.com>
	<1287146784-5517-1-git-send-email-felipe.contreras@gmail.com>
	<1287407452.6781.64.camel@tubuntu>
	<1287410618.6781.110.camel@tubuntu>
	<20101018225534.GH13341@atomide.com>
	<1287489785.2216.10.camel@tubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:56461 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439Ab0KGWtv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 7 Nov 2010 17:49:51 -0500
Received: by bwz11 with SMTP id 11so4284056bwz.19
        for <linux-omap@vger.kernel.org>; Sun, 07 Nov 2010 14:49:50 -0800 (PST)
In-Reply-To: <1287489785.2216.10.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: ext Tony Lindgren <tony@atomide.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, "Palande Ameya (Nokia-MS/Helsinki)" <ameya.palande@nokia.com>, Russell King <linux@arm.linux.org.uk>, "mike@compulab.co.il" <mike@compulab.co.il>

On Tue, Oct 19, 2010 at 3:03 PM, Tomi Valkeinen
<tomi.valkeinen@nokia.com> wrote:
> On Tue, 2010-10-19 at 00:55 +0200, ext Tony Lindgren wrote:
>> * Tomi Valkeinen <tomi.valkeinen@nokia.com> [101018 06:55]:
>> > On Mon, 2010-10-18 at 16:10 +0300, Tomi Valkeinen wrote:
>> > > Hi,
>> > >
>> > > On Fri, 2010-10-15 at 14:46 +0200, ext Felipe Contreras wrote:
>> > > > So that we can ioremap happily.
>> > > >
>> > > > Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>
>> > > > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> > > > ---
>> > > > =C2=A0drivers/video/omap2/vram.c | =C2=A0 =C2=A02 ++
>> > > > =C2=A01 files changed, 2 insertions(+), 0 deletions(-)
>> > > >
>> > > > diff --git a/drivers/video/omap2/vram.c b/drivers/video/omap2/=
vram.c
>> > > > index f6fdc20..1a99777 100644
>> > > > --- a/drivers/video/omap2/vram.c
>> > > > +++ b/drivers/video/omap2/vram.c
>> > > > @@ -575,6 +575,8 @@ void __init omap_vram_reserve_sdram_memblo=
ck(void)
>> > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>> > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 paddr =
=3D memblock_alloc_base(size, PAGE_SIZE, MEMBLOCK_REAL_LIMIT);
>> > > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memblock_fr=
ee(paddr, size);
>> > > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memblock_re=
move(paddr, size);
>> > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> > > >
>> > > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 omap_vram_add_region(paddr, size);
>> > >
>> > > I tested this on OMAP3 SDP board, on top of my DSS2 tree. I can =
boot up
>> > > fine, but my test program crashes the kernel (dump below).
>> > >
>> > > This crash doesn't happen if I have the "HACK: OMAP: DSS2: OMAPF=
B: use
>> > > phys_to_virt for RAM mappings" patch in (I removed that during t=
esting
>> > > this patch).
>> > >
>> > > I don't know yet what is crashing the kernel, but I'd guess it's=
 the
>> > > fact that my test program reallocates the framebuffer memory wit=
h
>> > > OMAPFB_SETUP_MEM ioctl.
>> >
>> > Ah, sorry, I was missing the patch from Russel which you mentioned=
 in
>> > another mail (http://article.gmane.org/gmane.linux.kernel/1047146)=
=2E With
>> > that patch included things seem to work.
>>
>> Tomi, I assume you're queuing these? If so, for both:
>>
>> Acked-by: Tony Lindgren <tony@atomide.com>
>
> Yes, I can queue them (when the required memblock stuff is in).

Now it's in :) (v2.6.37-rc1)

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
