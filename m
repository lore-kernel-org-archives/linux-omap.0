From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH RESEND v5 4/5] omap: nand: ecc layout select from board file
Date: Thu, 4 Nov 2010 17:54:00 +0200
Message-ID: <AANLkTikbcHM4MpWm9ar-hLZBh3g5PkD3PK6FxY_bGd8u@mail.gmail.com>
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
	<AANLkTinfO5e9JewdTDxasTRrUAXhGaQs=n6=HnqOQP7S@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B0356BAC3BB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:38122 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494Ab0KDPyB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Nov 2010 11:54:01 -0400
Received: by qyk10 with SMTP id 10so1523018qyk.19
        for <linux-omap@vger.kernel.org>; Thu, 04 Nov 2010 08:54:01 -0700 (PDT)
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B0356BAC3BB@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Artem.Bityutskiy@nokia.com" <Artem.Bityutskiy@nokia.com>, Vimal Singh <vimal.newwork@gmail.com>, Tony Lindgren <tony@atomide.com>

On Thu, Nov 4, 2010 at 2:52 PM, Ghorai, Sukumar <s-ghorai@ti.com> wrote:
>> -----Original Message-----
>> It has changed in 2.5.36, take a look how it was in 2.6.35, when it
>> worked for me:
>> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-
>> 2.6.git;a=blob;f=drivers/mtd/nand/omap2.c;h=ee87325c7712a8eeee4bbc683f9301
>> 4c9901f337;hb=9fe6206f400646a2322096b56c59891d530e8d51
>>
>> notice how 2.5.36 has CONFIG_MTD_NAND_OMAP_HWECC defined and 2.6.35
>> doesn't.
>>
>> The test case is simple:
>> format and use NAND on 2.6.35 or earlier, works fine.
>> upgrade to 2.6.36 or 2.6.37-rc1 and try to mount the same NAND
>> partition - lots of ECC errors.
>
> [Ghorai] I tested this and working fine in zoom3.
>
> And as you mentioned there may be an issue we need to identify,
> So remove this #define form 2.6.36 and let me know the test result.

After removing #define it works, but only without
CONFIG_MTD_NAND_OMAP_PREFETCH. With prefetch enabled, sub-page reads
return ECC errors, for example:

nanddump -p -l 1024 -s 512 /dev/mtd3
ECC: 3 uncorrectable bitflip(s) at offset 0x00000200

nanddump -p -l 1024 -s 0 /dev/mtd3
nanddump -p -l 1024 -s 1024 /dev/mtd3
works ok.

Sub-pages need to be working for UBI, my NAND partitions are formatted
with UBIFS.
