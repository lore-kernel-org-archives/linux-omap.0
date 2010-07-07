From: =?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?= <eballetbo@gmail.com>
Subject: mtd_pagetest fails with omap2 OneNAND driver
Date: Wed, 7 Jul 2010 16:55:17 +0200
Message-ID: <AANLkTinrUQKhq9DZ5U8ErJ8PUAEspuDwcNRAPcrv7GCu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42466 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996Ab0GGOzS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jul 2010 10:55:18 -0400
Received: by pwi5 with SMTP id 5so2484999pwi.19
        for <linux-omap@vger.kernel.org>; Wed, 07 Jul 2010 07:55:17 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org

Hello,

I need some help to understand what is wrong, maybe someone can help me.

I'm running an OMAP3-based board with a OneNAND from Numonyx, the
problem is some mtd tests fails. An example is the mtd_pagetest, the
erase test fails.

[  937.885925] mtd_pagetest: erasetest
[  937.889434] mtd_pagetest: erasing block 0
[  937.895721] mtd_pagetest: writing 1st page of block 0
[  937.901550] mtd_pagetest: erasing block 0
[  937.907623] mtd_pagetest: reading 1st page of block 0
[  937.912994] mtd_pagetest: verifying 1st page of block 0 is all 0xff
[  937.919342] mtd_pagetest: verifying all 0xff failed at 0
[  937.924713] mtd_pagetest: finished with 1 errors

If I read the mtd contents

# mtd_debug read /dev/mtd4 0 1024 output.log
# hexdump output.log
0000000 1caf ecfa 976b aa81 700a 9ce1 5427 32eb

looks like the mtd partition it's not erased, but If I use the
flash_eraseall tool erases the flash completely without problem

# flash_eraseall /dev/mtd4
Erasing 256 Kibyte @ fa80000 -- 100 % complete.
# mtd_debug read /dev/mtd4 0 1024 output.log
Copied 1024 bytes from address 0x00000000 in flash to file.log
# hexdump output.log
0000000 ffff ffff ffff ffff ffff ffff ffff ffff
*
0000400

So I don't understand why this test fails. Any idea what might be wrong ?

Here the full log

[  775.590270] =================================================
[  775.596160] mtd_pagetest: MTD device: 4
[  775.603851] mtd_pagetest: MTD device size 262668288, eraseblock
size 262144, page size 4096, count of eraseblocks 1002, pages per
eraseblock 64, OOB size 64
[  775.618408] mtd_pagetest: scanning for bad eraseblocks
[  775.624420] mtd_pagetest: scanned 1002 eraseblocks, 0 are bad
[  775.630218] mtd_pagetest: erasing whole device
[  777.486846] mtd_pagetest: erased 1002 eraseblocks
[  777.491638] mtd_pagetest: writing whole device
[  777.531585] mtd_pagetest: written up to eraseblock 0
[  786.519378] mtd_pagetest: written up to eraseblock 256
[  795.505706] mtd_pagetest: written up to eraseblock 512
[  804.488769] mtd_pagetest: written up to eraseblock 768
[  812.668182] mtd_pagetest: written 1002 eraseblocks
[  812.673126] mtd_pagetest: verifying all eraseblocks
[  812.803375] mtd_pagetest: verified up to eraseblock 0
[  844.772460] mtd_pagetest: verified up to eraseblock 256
[  876.734741] mtd_pagetest: verified up to eraseblock 512
[  908.696838] mtd_pagetest: verified up to eraseblock 768
[  937.791229] mtd_pagetest: verified 1002 eraseblocks
[  937.796234] mtd_pagetest: crosstest
[  937.800903] mtd_pagetest: reading page at 0x0
[  937.805877] mtd_pagetest: reading page at 0xfa7f000
[  937.811096] mtd_pagetest: reading page at 0x0
[  937.816070] mtd_pagetest: verifying pages read at 0x0 match
[  937.821838] mtd_pagetest: crosstest ok
[  937.825622] mtd_pagetest: erasecrosstest
[  937.829589] mtd_pagetest: erasing block 0
[  937.835906] mtd_pagetest: writing 1st page of block 0
[  937.841552] mtd_pagetest: reading 1st page of block 0
[  937.847198] mtd_pagetest: verifying 1st page of block 0
[  937.852600] mtd_pagetest: erasing block 0
[  937.858734] mtd_pagetest: writing 1st page of block 0
[  937.864379] mtd_pagetest: erasing block 1001
[  937.870788] mtd_pagetest: reading 1st page of block 0
[  937.876342] mtd_pagetest: verifying 1st page of block 0
[  937.881652] mtd_pagetest: erasecrosstest ok
[  937.885925] mtd_pagetest: erasetest
[  937.889434] mtd_pagetest: erasing block 0
[  937.895721] mtd_pagetest: writing 1st page of block 0
[  937.901550] mtd_pagetest: erasing block 0
[  937.907623] mtd_pagetest: reading 1st page of block 0
[  937.912994] mtd_pagetest: verifying 1st page of block 0 is all 0xff
[  937.919342] mtd_pagetest: verifying all 0xff failed at 0
[  937.924713] mtd_pagetest: finished with 1 errors
[  937.929870] =================================================

Thanks in advance,

Enric
