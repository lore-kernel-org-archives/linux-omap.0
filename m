From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] video: omap: vram: remove from normal memory
Date: Tue, 19 Oct 2010 10:27:12 +0300
Message-ID: <AANLkTi=1tPHVY6jkg6Ne5MY=2CPWJj9qii+PSRZjj950@mail.gmail.com>
References: <AANLkTik_6byuzkZ+mKunTi6HJTHu49C4XGebfTjCaEeE@mail.gmail.com>
	<1287146784-5517-1-git-send-email-felipe.contreras@gmail.com>
	<1287407452.6781.64.camel@tubuntu>
	<1287410618.6781.110.camel@tubuntu>
	<20101018225534.GH13341@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53248 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752133Ab0JSH1P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Oct 2010 03:27:15 -0400
Received: by fxm4 with SMTP id 4so1355598fxm.19
        for <linux-omap@vger.kernel.org>; Tue, 19 Oct 2010 00:27:14 -0700 (PDT)
In-Reply-To: <20101018225534.GH13341@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-omap <linux-omap@vger.kernel.org>, "Palande Ameya (Nokia-MS/Helsinki)" <ameya.palande@nokia.com>, Russell King <linux@arm.linux.org.uk>, "mike@compulab.co.il" <mike@compulab.co.il>

On Tue, Oct 19, 2010 at 1:55 AM, Tony Lindgren <tony@atomide.com> wrote=
:
> * Tomi Valkeinen <tomi.valkeinen@nokia.com> [101018 06:55]:
>> On Mon, 2010-10-18 at 16:10 +0300, Tomi Valkeinen wrote:
>> > Hi,
>> >
>> > On Fri, 2010-10-15 at 14:46 +0200, ext Felipe Contreras wrote:
>> > > So that we can ioremap happily.
>> > >
>> > > Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>
>> > > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> > > ---
>> > > =C2=A0drivers/video/omap2/vram.c | =C2=A0 =C2=A02 ++
>> > > =C2=A01 files changed, 2 insertions(+), 0 deletions(-)
>> > >
>> > > diff --git a/drivers/video/omap2/vram.c b/drivers/video/omap2/vr=
am.c
>> > > index f6fdc20..1a99777 100644
>> > > --- a/drivers/video/omap2/vram.c
>> > > +++ b/drivers/video/omap2/vram.c
>> > > @@ -575,6 +575,8 @@ void __init omap_vram_reserve_sdram_memblock=
(void)
>> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> > > =C2=A0 } else {
>> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 paddr =3D memblock_alloc_base=
(size, PAGE_SIZE, MEMBLOCK_REAL_LIMIT);
>> > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 memblock_free(paddr, size);
>> > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 memblock_remove(paddr, size);
>> > > =C2=A0 }
>> > >
>> > > =C2=A0 omap_vram_add_region(paddr, size);
>> >
>> > I tested this on OMAP3 SDP board, on top of my DSS2 tree. I can bo=
ot up
>> > fine, but my test program crashes the kernel (dump below).
>> >
>> > This crash doesn't happen if I have the "HACK: OMAP: DSS2: OMAPFB:=
 use
>> > phys_to_virt for RAM mappings" patch in (I removed that during tes=
ting
>> > this patch).
>> >
>> > I don't know yet what is crashing the kernel, but I'd guess it's t=
he
>> > fact that my test program reallocates the framebuffer memory with
>> > OMAPFB_SETUP_MEM ioctl.
>>
>> Ah, sorry, I was missing the patch from Russel which you mentioned i=
n
>> another mail (http://article.gmane.org/gmane.linux.kernel/1047146). =
With
>> that patch included things seem to work.
>
> Tomi, I assume you're queuing these? If so, for both:
>
> Acked-by: Tony Lindgren <tony@atomide.com>

Note that this depends on a patch by Russell that is not clear if it
will be merged on .37.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
