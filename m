From: Grant Erickson <marathon96@gmail.com>
Subject: Re: No more software ECC in omap2.c NAND driver. Why?
Date: Mon, 22 Nov 2010 11:03:56 -0800
Message-ID: <C90FFE9C.203C0%marathon96@gmail.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B0369C42AB7@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:34332 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795Ab0KVTEK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 14:04:10 -0500
Received: by ewy5 with SMTP id 5so1886386ewy.19
        for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 11:04:08 -0800 (PST)
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B0369C42AB7@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Grazvydas Ignotas <notasas@gmail.com>, Charles Manning <manningc2@actrix.gen.nz>

On 11/21/10 11:29 PM, Ghorai, Sukumar wrote:
>> The board (Mistral AM37x) NAND (Micron 256 MiB) was originally
>> bootstrapped
>> over SD/MMC from u-boot using the following script:
>
> [Ghorai] let me know the nand details - x8/x16, small/big page?

It's the Micron 256 MiB x16 2 KiB page size, 128 KiB erase block size device
on the Mistral AM37x board.

>>     fatload mmc 0 ${loadaddr} root.jff
>
> [Ghorai] How you create the root.jff
> mkfs.jffs2 --output=root.jffs2 --root=.. --pagesize=?? --eraseblock=?? -n

% mkfs.jffs2 --little-endian --no-cleanmarkers --pad 2048 --pagesize 2048
--eraseblock 131072 -d /tmp/tmp.h9dKGpcNFw -D root.devices -o root.jffs2

>>     nand write.i ${loadaddr} 0x00c00000 0x2000000
>>     nand write.i ${loadaddr} 0x04200000 0x2000000
>
> [Ghorai] why you writing in two places?

Redundant images.

>> Following that, the board is updated, from Linux, using 'flash_eraseall -
>> q'
>> and 'nandwrite -p -q' on all partitions, except that containing MLO.
> [Ghorai] 
>
> 1. can you send the exact comment you used to write in nand? Which partition?

    flash_eraseall -q /dev/mtd7
    nandwrite -p -q /dev/mtd7 root.jffs2
    flash_eraseal -q /dev/mtd9
    nandwrite -p -q /dev/mtd9 root.jffs2

> 2. What is the last kernel you used and was working perfectly?

v2.6.32_OMAPPSP_03.00.01.06.patch1

Best,

Grant


