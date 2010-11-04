From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH RESEND v5 4/5] omap: nand: ecc layout select from board file
Date: Thu, 4 Nov 2010 13:32:57 +0200
Message-ID: <AANLkTinfO5e9JewdTDxasTRrUAXhGaQs=n6=HnqOQP7S@mail.gmail.com>
References: <1285596710-25658-1-git-send-email-s-ghorai@ti.com>
	<1285596710-25658-5-git-send-email-s-ghorai@ti.com>
	<AANLkTikKMnzHR5DZqzGdJJbnCXhCpxKA7K2C2ZtPhNke@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B0356BABFAE@dbde02.ent.ti.com>
	<AANLkTinOhBNUt+gvNb0MWiyHD8ZYgLDJPz8tc=p+CsVW@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B0356BAC2B6@dbde02.ent.ti.com>
	<AANLkTinNrZNuZnFfJKGLF9J3zsHsOTK0+VmUmYH88+c3@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B0356BAC323@dbde02.ent.ti.com>
	<AANLkTik3gO1Rm2U8-Rm2t2M83sdCjz_Oktpve_gDrbNM@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B0356BAC331@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:45987 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751154Ab0KDLc6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Nov 2010 07:32:58 -0400
Received: by qwf7 with SMTP id 7so1172951qwf.19
        for <linux-omap@vger.kernel.org>; Thu, 04 Nov 2010 04:32:57 -0700 (PDT)
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B0356BAC331@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Artem.Bityutskiy@nokia.com" <Artem.Bityutskiy@nokia.com>, Vimal Singh <vimal.newwork@gmail.com>, Tony Lindgren <tony@atomide.com>

On Thu, Nov 4, 2010 at 1:15 PM, Ghorai, Sukumar <s-ghorai@ti.com> wrote:
>
>
>> -----Original Message-----
>> From: Grazvydas Ignotas [mailto:notasas@gmail.com]
>> Sent: Thursday, November 04, 2010 4:42 PM
>> To: Ghorai, Sukumar
>> Cc: linux-omap@vger.kernel.org; linux-mtd@lists.infradead.org; linux-arm-
>> kernel@lists.infradead.org; Artem.Bityutskiy@nokia.com; Vimal Singh; Tony
>> Lindgren
>> Subject: Re: [PATCH RESEND v5 4/5] omap: nand: ecc layout select from
>> board file
>>
>> > [Ghorai] In 2.6.36, it's a s/w ecc by default and working in all
>> platforms like - omap3430 SDP, zoom2, 3630SDP, ZOOM3.
>> > So please explain more when you found that - sw ecc is broken on both
>> 2.6.36
>>
>> It doesn't for me, see
>> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-
>> 2.6.git;a=blob;f=drivers/mtd/nand/omap2.c;h=513e0a76a4a73866d52bba8151e435
>> 56a3b30a54;hb=f6f94e2ab1b33f0082ac22d71f66385a60d8157f
>>
>> This is omap NAND driver at v2.6.36 tag, and it has
>> CONFIG_MTD_NAND_OMAP_HWECC forced.
>
> [Ghorai] This is the same old code since log. And this portion of code not touched for 2.6.36.
> And please let me know what kind of problem you are facing when you using 2.6.36; also let me know how to reproduce, I can check in my platform too.

It has changed in 2.5.36, take a look how it was in 2.6.35, when it
worked for me:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=drivers/mtd/nand/omap2.c;h=ee87325c7712a8eeee4bbc683f93014c9901f337;hb=9fe6206f400646a2322096b56c59891d530e8d51

notice how 2.5.36 has CONFIG_MTD_NAND_OMAP_HWECC defined and 2.6.35 doesn't.

The test case is simple:
format and use NAND on 2.6.35 or earlier, works fine.
upgrade to 2.6.36 or 2.6.37-rc1 and try to mount the same NAND
partition - lots of ECC errors.
