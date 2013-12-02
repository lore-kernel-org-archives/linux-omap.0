From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH] ARM: dts: omap3-igep00x0: Fix nand ECC to maintain
 backward compatibility.
Date: Mon, 2 Dec 2013 15:16:28 +0100
Message-ID: <CAFqH_53V5rOsCOLzTzm=9m1zvJpqN_ofh1jjzKAMmKqwHe28rQ@mail.gmail.com>
References: <1385896995-16803-1-git-send-email-eballetbo@gmail.com>
	<CABxcv=mkSE2A9TLsp7pXWK=dyu6wjN0t6K2ke6NfP3G2rxaXug@mail.gmail.com>
	<20131202115422.1f8c73f6@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:40460 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515Ab3LBOQ3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Dec 2013 09:16:29 -0500
Received: by mail-we0-f179.google.com with SMTP id q59so11837588wes.38
        for <linux-omap@vger.kernel.org>; Mon, 02 Dec 2013 06:16:28 -0800 (PST)
In-Reply-To: <20131202115422.1f8c73f6@skate>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, pekon@ti.com

Hi,

CCing Pekon Gupta <pekon@ti.com>

2013/12/2 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>:
> Dear Javier Martinez Canillas,
>
> On Sun, 1 Dec 2013 13:27:25 +0100, Javier Martinez Canillas wrote:
>
>> > diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/omap3-igep0020.dts
>> > index d5cc792..4229e94 100644
>> > --- a/arch/arm/boot/dts/omap3-igep0020.dts
>> > +++ b/arch/arm/boot/dts/omap3-igep0020.dts
>> > @@ -116,7 +116,7 @@
>> >                 linux,mtd-name= "micron,mt29c4g96maz";
>> >                 reg = <0 0 0>;
>> >                 nand-bus-width = <16>;
>> > -               ti,nand-ecc-opt = "bch8";
>> > +               ti,nand-ecc-opt = "ham1";
>> >
>> >                 gpmc,sync-clk-ps = <0>;
>> >                 gpmc,cs-on-ns = <0>;
>> > diff --git a/arch/arm/boot/dts/omap3-igep0030.dts b/arch/arm/boot/dts/omap3-igep0030.dts
>> > index 525e6d9..9043e97 100644
>> > --- a/arch/arm/boot/dts/omap3-igep0030.dts
>> > +++ b/arch/arm/boot/dts/omap3-igep0030.dts
>> > @@ -59,7 +59,7 @@
>> >                 linux,mtd-name= "micron,mt29c4g96maz";
>> >                 reg = <0 0 0>;
>> >                 nand-bus-width = <16>;
>> > -               ti,nand-ecc-opt = "bch8";
>> > +               ti,nand-ecc-opt = "ham1";
>
> Tested this with 3.13-rc1, and it somewhat works, but causes some ECC
> error messages:
>
> # mount -t jffs2 /dev/mtdblock3 /mnt/
> [   10.423736] jffs2: CLEANMARKER node found at 0x00000000 has totlen 0xc != normal 0x0
> [   10.444671] jffs2: CLEANMARKER node found at 0x00020000 has totlen 0xc != normal 0x0
> [   10.472290] jffs2: mtd->read(0x100 bytes from 0x40000) returned ECC error
> [   10.480743] jffs2: mtd->read(0x100 bytes from 0x60000) returned ECC error
> [   10.489013] jffs2: mtd->read(0x100 bytes from 0x80000) returned ECC error
> [   10.497283] jffs2: mtd->read(0x100 bytes from 0xa0000) returned ECC error
> [   10.505126] jffs2: mtd->read(0x100 bytes from 0xc0000) returned ECC error
> [   10.513458] jffs2: mtd->read(0x100 bytes from 0xe0000) returned ECC error
> [   10.521667] jffs2: mtd->read(0x100 bytes from 0x100000) returned ECC error
> [   10.529968] jffs2: mtd->read(0x100 bytes from 0x120000) returned ECC error
> [   10.538269] jffs2: mtd->read(0x100 bytes from 0x140000) returned ECC error
> [   10.546295] jffs2: mtd->read(0x100 bytes from 0x160000) returned ECC error
> [   10.554534] jffs2: mtd->read(0x100 bytes from 0x180000) returned ECC error
> [   10.563323] jffs2: mtd->read(0x100 bytes from 0x1a0000) returned ECC error
> [   10.571685] jffs2: mtd->read(0x100 bytes from 0x1c0000) returned ECC error
> [   10.579986] jffs2: mtd->read(0x100 bytes from 0x1e0000) returned ECC error
> [   10.588287] jffs2: mtd->read(0x100 bytes from 0x200000) returned ECC error
> [   10.596313] jffs2: mtd->read(0x100 bytes from 0x220000) returned ECC error
> [   10.604522] jffs2: mtd->read(0x100 bytes from 0x240000) returned ECC error
> [   10.613037] jffs2: mtd->read(0x100 bytes from 0x260000) returned ECC error
> [   10.621307] jffs2: mtd->read(0x100 bytes from 0x280000) returned ECC error
> [   10.629608] jffs2: mtd->read(0x100 bytes from 0x2a0000) returned ECC error
> [   10.637908] jffs2: mtd->read(0x100 bytes from 0x2c0000) returned ECC error
> [   10.645843] jffs2: mtd->read(0x100 bytes from 0x2e0000) returned ECC error
> [   10.654113] jffs2: notice: (851) jffs2_build_xattr_subsystem: complete building xattr subsystem, 0 of xdatum (0 unchecked, 0 orphan) and 0 of xref (0 dead, 0 orphan) found.
> #
> #
> # cd /mnt/
> # ls
> MD5SUMS  foo10    foo3     foo5     foo7     foo9
> foo1     foo2     foo4     foo6     foo8
> # md5sum -c MD5SUMS
> foo1: OK
> foo10: OK
> foo2: OK
> foo3: OK
> foo4: OK
> foo5: OK
> foo6: OK
> foo7: OK
> foo8: OK
> foo9: OK
>
> This is with a JFFS2 image flashed after doing "nandecc sw" in U-Boot.
>
>> Just a note that this binding property got renamed for v3.13 on
>>
>> commit c66d039197e42af8867e5d0d9b904daf0fb9e6bc
>> Author: Pekon Gupta <pekon@ti.com>
>> Date:   Thu Oct 24 18:20:18 2013 +0530
>>
>>     mtd: nand: omap: combine different flavours of 1-bit hamming ecc schemes
>>
>> so users using current v3.12 kernel or older should use
>>
>> ti,nand-ecc-opt = "sw";
>>
>> instead.
>
> However, this works perfectly fine, with the same JFFS2 image, flashed
> in the same way in U-Boot:
>

Pekon, the old ti,nand-ecc-opt = "sw" should be replaced by
ti,nand-ecc-opt = "ham1" ? Should be the same ? In that case, why this
different behavior ?


> # mount -t jffs2 /dev/mtdblock3 /mnt/
> [   19.789306] jffs2: CLEANMARKER node found at 0x00000000 has totlen 0xc != normal 0x0
> [   19.810455] jffs2: CLEANMARKER node found at 0x00020000 has totlen 0xc != normal 0x0
> [   19.850860] jffs2: notice: (802) jffs2_build_xattr_subsystem: complete building xattr subsystem, 0 of xdatum (0 unchecked, 0 orphan) and 0 of xref (0 dead, 0 orphan) found.
> # cd /mnt/
> # ls
> MD5SUMS  foo10    foo3     foo5     foo7     foo9
> foo1     foo2     foo4     foo6     foo8
> # md5sum -c MD5SUMS
> foo1: OK
> foo10: OK
> foo2: OK
> foo3: OK
> foo4: OK
> foo5: OK
> foo6: OK
> foo7: OK
> foo8: OK
> foo9: OK
>
> Best regards,
>
> Thomas
> --
> Thomas Petazzoni, CTO, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
