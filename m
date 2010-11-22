From: Grant Erickson <marathon96@gmail.com>
Subject: Re: No more software ECC in omap2.c NAND driver. Why?
Date: Sun, 21 Nov 2010 22:39:10 -0800
Message-ID: <C90F500E.2033D%marathon96@gmail.com>
References: <2A3DCF3DA181AD40BDE86A3150B27B6B0369C42A32@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47418 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179Ab0KVGj0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 01:39:26 -0500
Received: by iwn34 with SMTP id 34so2494507iwn.19
        for <linux-omap@vger.kernel.org>; Sun, 21 Nov 2010 22:39:25 -0800 (PST)
In-Reply-To: <2A3DCF3DA181AD40BDE86A3150B27B6B0369C42A32@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ghorai, Sukumar" <s-ghorai@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Grazvydas Ignotas <notasas@gmail.com>, Charles Manning <manningc2@actrix.gen.nz>

On 11/21/10 10:27 PM, Ghorai, Sukumar wrote:
>> -----Original Message-----
>> From: Grant Erickson [mailto:marathon96@gmail.com]
>> Sent: Monday, November 22, 2010 11:39 AM
>> To: Charles Manning
>> Cc: linux-omap@vger.kernel.org; Grazvydas Ignotas; Ghorai, Sukumar
>> Subject: Re: No more software ECC in omap2.c NAND driver. Why?
>> 
>> On 11/21/10 1:01 PM, Charles Manning wrote:
>>> Just recompiling with the CONFIG_MTD_NAND_OMAP_HWECC define commented
>> out did
>>> not result in a working system. I suspect there is more tto the problem
>> than
>>> this.
>> 
>> FWIW, I had the exact same issues with my Mistral AM37x EVM board. I not
>> only had to remove/deassert CONFIG_MTD_NAND_OMAP_HWECC, but also had to
>> roll
>> back nand_base.c and nand_bbt.c back to their 2.6.32 versions (later ones
>> between .32 and .35 might have worked but I didn't bother trying) to be
>> able
>> to read, error-free and correctly, NAND that was erased and written with a
>> .32-era kernel.
>
> [Ghorai] are you trying again?
> How do you flush the FS (form u-boot or from kernel, nandwrite)? And let me
> know the test you are doing, to know the steps to reproduce in my platform -
> zoom/sdp.

The board (Mistral AM37x) NAND (Micron 256 MiB) was originally bootstrapped
over SD/MMC from u-boot using the following script:

    mmc init
    mw.b ${loadaddr} 0xff 0x40000
    nand erase 0 0x40000
    fatload mmc 0 ${loadaddr} mlo
    nandecc hw
    nand write.i ${loadaddr} 0 0x40000
    mw.b ${loadaddr} 0xff 0x180000
    nand erase 0x00040000 0x180000
    nand erase 0x001c0000 0x180000
    fatload mmc 0 ${loadaddr} u-boot.bin
    nandecc sw
    nand write.i ${loadaddr} 0x00040000 0x180000
    nand write.i ${loadaddr} 0x001c0000 0x180000
    mw.b ${loadaddr} 0xff 0x800000
    nand erase 0x00400000 0x800000
    nand erase 0x03a00000 0x800000
    fatload mmc 0 ${loadaddr} uImage
    nand write.i ${loadaddr} 0x00400000 0x800000
    nand write.i ${loadaddr} 0x03a00000 0x800000
    mw.b ${loadaddr} 0xff 0x2000000
    nand erase 0x00c00000 0x2000000
    nand erase 0x04200000 0x2000000
    fatload mmc 0 ${loadaddr} root.jff
    nand write.i ${loadaddr} 0x00c00000 0x2000000
    nand write.i ${loadaddr} 0x04200000 0x2000000

Following that, the board is updated, from Linux, using 'flash_eraseall -q'
and 'nandwrite -p -q' on all partitions, except that containing MLO.

Best,

Grant


