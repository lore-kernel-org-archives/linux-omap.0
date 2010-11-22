From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: No more software ECC in omap2.c NAND driver. Why?
Date: Mon, 22 Nov 2010 12:59:55 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B0369C42AB7@dbde02.ent.ti.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B0369C42A32@dbde02.ent.ti.com>
 <C90F500E.2033D%marathon96@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59592 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751940Ab0KVHaE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 02:30:04 -0500
In-Reply-To: <C90F500E.2033D%marathon96@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Erickson <marathon96@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Grazvydas Ignotas <notasas@gmail.com>, Charles Manning <manningc2@actrix.gen.nz>



[..snip..]
> 
> The board (Mistral AM37x) NAND (Micron 256 MiB) was originally
> bootstrapped
> over SD/MMC from u-boot using the following script:
[Ghorai] let me know the nand details - x8/x16, small/big page?

> 
[..snip..]
>     nandecc sw
[..snip..]
>     fatload mmc 0 ${loadaddr} root.jff
[Ghorai] How you create the root.jff
mkfs.jffs2 --output=root.jffs2 --root=.. --pagesize=?? --eraseblock=?? -n

>     nand write.i ${loadaddr} 0x00c00000 0x2000000
>     nand write.i ${loadaddr} 0x04200000 0x2000000
[Ghorai] why you writing in two places?

> 
> Following that, the board is updated, from Linux, using 'flash_eraseall -
> q'
> and 'nandwrite -p -q' on all partitions, except that containing MLO.
[Ghorai] 
1. can you send the exact comment you used to write in nand? Which partition?

2. What is the last kernel you used and was working perfectly? 

3. If possible revert the following patches and let me know the status?
f450d86790ebf72ac93c7ea5addd6fa278aae64c..2430f9df61e2ea47ea468dfe22b7e2db97111fb4
2c01946c6b9ebaa5a89710bc42ca224a7f52f227
948d38e799f0ab87cf8ed9113fcdaaee61acf321



