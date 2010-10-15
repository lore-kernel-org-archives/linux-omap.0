From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: DSS2 broken with 36-rc1
Date: Fri, 15 Oct 2010 15:44:11 +0300
Message-ID: <AANLkTik_6byuzkZ+mKunTi6HJTHu49C4XGebfTjCaEeE@mail.gmail.com>
References: <1281962906.1888.25.camel@chotu>
	<4C72192A.9050801@compulab.co.il>
	<1282547709.2202.1.camel@tubuntu.research.nokia.com>
	<4C722115.50401@compulab.co.il>
	<1282548930.2202.16.camel@tubuntu.research.nokia.com>
	<4C7236A2.7080701@compulab.co.il>
	<1282723768.9299.90.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44889 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044Ab0JPARk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Oct 2010 20:17:40 -0400
Received: by bwz15 with SMTP id 15so1298116bwz.19
        for <linux-omap@vger.kernel.org>; Fri, 15 Oct 2010 17:17:36 -0700 (PDT)
In-Reply-To: <1282723768.9299.90.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: ext Mike Rapoport <mike@compulab.co.il>, "Palande Ameya (Nokia-MS/Helsinki)" <ameya.palande@nokia.com>, linux-omap <linux-omap@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

On Wed, Aug 25, 2010 at 11:09 AM, Tomi Valkeinen
<tomi.valkeinen@nokia.com> wrote:
> On Mon, 2010-08-23 at 10:51 +0200, ext Mike Rapoport wrote:
>> Tomi Valkeinen wrote:
>> > On Mon, 2010-08-23 at 09:19 +0200, ext Mike Rapoport wrote:
>> >> Tomi Valkeinen wrote:
>> >>> I tested 36-rc1 briefly with OMAP 3430SDP board. I wonder why th=
at
>> >>> works, but not N900...
>> >> May it be that 3430SDP uses SRAM for the framebuffer? Or reserves=
 framebuffer
>> >> memory from the RAM that is not managed by the kernel, e.g with s=
omething like
>> >> mem=3D<RAM size - fb size> vram=3D<fb size>,0x8...... ?
>> >
>> > No, SRAM cannot be used on OMAP3s, as SRAM is too small to hold a
>> > framebuffer. And no, I don't think it's reserving it from RAM not
>> > managed by the kernel.
>>
>> The N900 only sets omap_vram_sdram_{start,size} in rx51_video_mem_in=
it.
>> I think that it should also call omap_vram_reserve_sdram_memblock():
>>
>> diff --git a/arch/arm/mach-omap2/board-rx51-video.c b/arch/arm/mach-=
omap2/board-rx51-video.c
>> index 5a1005b..fdfe844 100644
>> --- a/arch/arm/mach-omap2/board-rx51-video.c
>> +++ b/arch/arm/mach-omap2/board-rx51-video.c
>> @@ -101,6 +101,7 @@ void __init rx51_video_mem_init(void)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_vram_set_sdram_vram(PAGE_ALIG=
N(864 * 480 * 4) +
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A02 * PAGE_ALIGN(1280 * 720 * 4 * 2), 0);
>> + =C2=A0 =C2=A0 =C2=A0 omap_vram_reserve_sdram_memblock();
>> =C2=A0 }
>
> But omap_vram_reserve_sdram_memblock() is called automatically from
> arch/arm/plat-omap/common.c. rx51_video_mem_init() should have been
> called before that happens. Has the call order changed, so that
> omap_vram_reserve_sdram_memblock() is called first, and
> rx51_video_mem_init() only after that?

That is indeed the case, ->reserve() is now called way earlier in the
boot process, before early param, and before ->map_io(), which is a
good thing, because now ->reserve() can take away the memory from the
kernel.

I'm sending the patches that fix this for me, you would also need:
http://article.gmane.org/gmane.linux.kernel/1047146

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
