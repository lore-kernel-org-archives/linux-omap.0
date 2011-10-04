From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: Please help with the OMAP static mapping mess
Date: Tue, 4 Oct 2011 11:48:40 +0530
Message-ID: <CAMQu2gxgRZzb6hh5pOVBgaPUZEizEqBr_e358MBuD_xHJOvX3Q@mail.gmail.com>
References: <alpine.LFD.2.02.1110031312480.9106@xanadu.home>
 <20111003205658.GJ6324@atomide.com> <alpine.LFD.2.02.1110031744100.9106@xanadu.home>
 <alpine.LFD.2.02.1110031827440.9106@xanadu.home> <20111003225908.GL6324@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:44612 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751563Ab1JDGTD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Oct 2011 02:19:03 -0400
Received: by ywa8 with SMTP id 8so168925ywa.29
        for <linux-omap@vger.kernel.org>; Mon, 03 Oct 2011 23:19:01 -0700 (PDT)
In-Reply-To: <20111003225908.GL6324@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>

On Tue, Oct 4, 2011 at 4:29 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Nicolas Pitre <nico@fluxnic.net> [111003 15:05]:
>> On Mon, 3 Oct 2011, Nicolas Pitre wrote:
>>
>> > On Mon, 3 Oct 2011, Tony Lindgren wrote:
>> >
>> > > * Nicolas Pitre <nico@fluxnic.net> [111003 11:26]:
>> > > >
>> > > > Furthermore... there is also a static mapping for physical add=
ress
>> > > > 0x4e000000 using virtual address 0xff100000 which is already r=
eserved
>> > > > for other purposes i.e. the consistent DMA area. =A0It is not =
immediately
>> > > > obvious where this comes from without being intimate with the =
OMAP code.
>> > > > Can this be fixed as well i.e. moved elsewhere please?
>> > >
>> > > This sounds like a bug somewhere. Which omap are you seeing this=
 on?
>> >
>> > OMAP4430 on a Panda board.
>> >
>> > Here are the static mappings I'm seeing:
>> >
>> > phys =3D 0x44000000 virt =3D 0xf8000000 size =3D 0x100000
>> > phys =3D 0x4a000000 virt =3D 0xfc000000 size =3D 0x400000
>> > phys =3D 0x50000000 virt =3D 0xf9000000 size =3D 0x100000
>> > phys =3D 0x4c000000 virt =3D 0xfd100000 size =3D 0x100000
>> > phys =3D 0x4d000000 virt =3D 0xfe100000 size =3D 0x100000
>> > phys =3D 0x4e000000 virt =3D 0xff100000 size =3D 0x100000 <---
>> > phys =3D 0x48000000 virt =3D 0xfa000000 size =3D 0x400000
>> > phys =3D 0x54000000 virt =3D 0xfe800000 size =3D 0x800000
>>
>> It looks like this comes from OMAP44XX_DMM_VIRT.
>>
>> #define OMAP44XX_DMM_PHYS =A0 =A0 =A0 OMAP44XX_DMM_BASE
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 /* 0x4e000000 --> 0xfd300000 */
>> #define OMAP44XX_DMM_VIRT =A0 =A0 =A0 (OMAP44XX_DMM_PHYS + OMAP4_L3_=
PER_IO_OFFSET)
>> #define OMAP44XX_DMM_SIZE =A0 =A0 =A0 SZ_1M
>>
>> The comment suggesting a mapping correspondance is obviously wrong. =
We have:
>>
>> #define OMAP44XX_DMM_BASE =A0 =A0 =A0 0x4e000000
>> #define OMAP4_L3_PER_IO_OFFSET =A00xb1100000
>>
>> Hence 0x4e000000 + 0xb1100000 =3D 0xff100000.
>
> Seem like it might cause some random patterns in tiler :)
> Santosh, can youp please check it?
>
This is already fixed Tony. You have pulled that patch.
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg55258.html

Regards
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
