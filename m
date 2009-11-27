From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: [RFC] [PATCH] OMAP: DMA: move LCD DMA related code from plat-omap
	to mach-omap1 (Re: [PATCH] OMAP1: PM: Fix omapfb/lcd on Amstrad Delta broken
	when PM set)
Date: Fri, 27 Nov 2009 09:08:38 +0100
Message-ID: <e7c6a05e0911270008i328aef33qd4fa257b1d28cc25@mail.gmail.com>
References: <200910292339.48610.jkrzyszt@tis.icnet.pl>
	 <200911252357.10812.jkrzyszt@tis.icnet.pl>
	 <alpine.DEB.2.00.0911251905590.19371@utopia.booyaka.com>
	 <200911261530.45612.jkrzyszt@tis.icnet.pl>
	 <alpine.DEB.2.00.0911270000020.984@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f171.google.com ([209.85.223.171]:36755 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407AbZK0IIc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Nov 2009 03:08:32 -0500
Received: by iwn1 with SMTP id 1so825378iwn.33
        for <linux-omap@vger.kernel.org>; Fri, 27 Nov 2009 00:08:38 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.0911270000020.984@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Fri, Nov 27, 2009 at 8:01 AM, Paul Walmsley <paul@pwsan.com> wrote:
> On Thu, 26 Nov 2009, Janusz Krzysztofik wrote:
>
>> Thursday 26 November 2009 03:08:30 Paul Walmsley napisa=C5=82(a):
>> > On Wed, 25 Nov 2009, Janusz Krzysztofik wrote:
>> > > It turned out not that simple. Since arch/arm/mach-omap1/lcd_dma=
=2Ec
>> > > exports several functions that are called unconditionaly from
>> > > drivers/video/omap/lcdc.c AND the latter is linked into the omap=
fb
>> > > driver based on CONFIG_ARCH_OMAP1=3Dy, linking in the former can=
't be
>> > > limited to selected OMAP1 subarchs unless at least
>> > > drivers/video/omap/{Kconfig,Makefile}, if not drivers/video/omap=
/lcdc.c
>> > > itself either, are modified for that as well. Am I missing somet=
hing?
>> > >
>> > > If not, I can see two options:
>> > > 1. Keep arch/arm/mach-omap1/lcd_dma.c linked in for any OMAP1 su=
barch
>> > > unless CONFIG_FB_OMAP is not set. That can be cleaned up further=
 after
>> > > the drivers/video/omap/* stuff is ever modified.
>> > > 2. Include drivers/video/omap/* modifications into this series.
>> > >
>> > > What do you suggest?
>> >
>> > Let's take option 1 for right now. =C2=A0Maybe one of the htcwizar=
d people
>> > might take that project up after the LCD DMA split is merged.
>>
>> I probably missed a third option: conditionally replacing declaratio=
ns of
>> those functions required by lcdc.c with coresponding fake static inl=
ine
>> definitions inside an #ifdef block in lcd_dma.h. What do you think?
>
> Just took a quick look at that lcdc.c file; I think we'd better leave
> those functions in, since they are so tightly integrated to the code.
> Hopefully one of the OMAP730/750/850 people can tease them out, since
> they've got a platform to test on. =C2=A0Sound reasonable? =C2=A0Less=
 work for us,
> anyway :-)
I have htc wizard with omap850 I can test if patch will be finished :-)
>
> - Paul



Marek
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
