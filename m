From: "Luca Ceresoli" <luca@lucaceresoli.net>
Subject: Re: UbiFS + HWECC(?) + BeagleBoard = fail
Date: Mon,  6 Dec 2010 18:51:33 +0100
Message-ID: <LD0PLX$838F65AFC2A2E66E0112F637AD4376B8@aruba.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtpa1.aruba.it ([62.149.128.210]:36686 "HELO smtpw2.aruba.it"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752806Ab0LFR6R convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 12:58:17 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Grazvydas Ignotas <notasas@gmail.com>

On Mon, 8 Nov 2010 13:08:44 +0200, Grazvydas Ignotas wrote:
>On Sun, Nov 7, 2010 at 9:40 AM, [AvataR] <public.avatar@xxxxxxxxx> wrote:
>> Hi. After moving to upstream 2.6.3{5,6,7} kernels, i forced to use jffs2
>> instead of ubifs, because of lot CRC errors. If i use prefetch/dma, i
>> can attach to ubi, make volume, write data, reboot - and got lots of CRC
>> errors. Without prefetch i just couldn't do anything to ubi.
>>
>> Looks like hw/sw bug in ubi
>
>Looks like Sukumar's recent changes broke subpage reads that are
>needed for UBI to operate. You can try commenting out #define
>CONFIG_MTD_NAND_OMAP_HWECC in drivers/mtd/nand/omap2.c and disabling
>MTD_NAND_OMAP_PREFETCH, with that it mostly works for me but sometimes
>spits out ECC error or two.

I think this is the same bug reported back in august in
http://www.spinics.net/lists/linux-omap/msg34452.html, right?

I've been hit by this as well, and it seems to be still there, at least in

commit afd2d11e00520b7440003987be2ee4aab7c32901
Merge: 7fd1cff 734b4c7
Author: Tony Lindgren <tony@atomide.com>
Date:   Wed Dec 1 13:56:37 2010 -0800

    Merge branch 'devel-gpio'

While I thank you for you proposed solution, I see it does not work here.
In fact I commented the #define CONFIG_MTD_NAND_OMAP_HWECC and left
MTD_NAND_OMAP_PREFETCH disabled as it previously was, and got compilation
errors:

drivers/mtd/nand/omap2.c:1: warning: data definition has no type or storage class
drivers/mtd/nand/omap2.c:1: warning: type defaults to 'int' in declaration of 'B1'
drivers/mtd/nand/omap2.c:1: error: expected identifier or '(' before numeric constant
drivers/mtd/nand/omap2.c:1:9: error: invalid suffix "c" on integer constant
drivers/mtd/nand/omap2.c:1: error: expected identifier or '(' before numeric constant

As it looks to me like a very serious and very ancient bug, I wonder if I
missed something.

Or is any patch around to fix this?

Any pointer would be greatly appreciated.

Thanks,
Luca Ceresoli



