From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH] ARM: dts: omap3-igep00x0: Fix nand ECC to maintain
 backward compatibility.
Date: Mon, 2 Dec 2013 16:02:19 +0100
Message-ID: <20131202160219.40286dc9@skate>
References: <1385896995-16803-1-git-send-email-eballetbo@gmail.com>
	<CABxcv=mkSE2A9TLsp7pXWK=dyu6wjN0t6K2ke6NfP3G2rxaXug@mail.gmail.com>
	<20131202115422.1f8c73f6@skate>
	<CAFqH_53V5rOsCOLzTzm=9m1zvJpqN_ofh1jjzKAMmKqwHe28rQ@mail.gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73EA5094C@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:52648 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751579Ab3LBPCc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Dec 2013 10:02:32 -0500
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA5094C@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: Enric Balletbo Serra <eballetbo@gmail.com>, Javier Martinez Canillas <javier@dowhile0.org>, =?UTF-8?B?QmVub8OudA==?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Dear Gupta, Pekon,

On Mon, 2 Dec 2013 14:56:09 +0000, Gupta, Pekon wrote:

> A query Why are you going backward from BCH8 to HAM1 ?
> 
> HAM1 is just kept for legacy reasons, it's not at all recommended for new
> development. As some field results have shown that devices with
> HAM1 become un-usable very soon and start reporting uncorrectable errors
> because HAM1 can only handle single bit-flip, which is inadequate in field
> conditions and large page device wears-n-tears. (especially considering
> your device density is of order of 4Gb - mt29c4g96maz).
> 
> Also, just to inform that BCH8_SW ecc-scheme is implemented in such
> a way that *only* error correction is handled using s/w library (lib/bch.c).
> Rest all ECC calculation is handled using GPMC hardware.
> So, the CPU penalty will be seen only when there are bit-flips found
> during Read access, which are of rare conditions, occurring only few times
> in multi-megabit transfers.
> 
> Also, On top of that ecc-schemes implementations have been optimized.
> And the patch-series is under review on mainline kernel.
> http://lists.infradead.org/pipermail/linux-mtd/2013-November/thread.html
> 
> (Apologies for long suggestion, but in summary please don't use HAM1
> for any new development. And with BCH8_SW you should see better
> bit-flip handling (longer device life) with no hit in performance).

The crucial point here is that the interaction between the bootloader
and the kernel. The use case I have is that I'm flashing a filesystem
image from the bootloader, and mounting it from the kernel.

Using a mainline 2013.10 U-Boot for IGEPv2 + the mainline kernel booted
in legacy mode (no Device Tree) works fine. Using the same 2013.10
U-Boot for IGEPv2 + the mainline kernel booted in DT no longer works,
because the kernel disagrees with the bootloader on the ECC scheme to
use.

So I'm not saying that Hamming is better than BCH, certainly not. I'm
just saying that changing ECC scheme in the kernel without looking at
the more global picture of what support the bootloaders are offering is
not nice. At least, the bootloader should provide a command, or option,
to be able to use an ECC scheme that is compatible with what the kernel
expects.

The current result is that booting a mainline kernel with DT on
existing bootloaders simply breaks existing configurations.

> >Pekon, the old ti,nand-ecc-opt = "sw" should be replaced by
> >ti,nand-ecc-opt = "ham1" ? Should be the same ? In that case, why this
> >different behavior ?
> >
> In addition, please use "HAM1" ecc-scheme on mainline u-boot also to flash.
> (following patches were accepted by domain maintainer 'Scott Woods').
> http://lists.denx.de/pipermail/u-boot/2013-November/167548.html
> So, Kernel "ham1" and u-boot "ham1" should be in sync..
> 
> Once above is clean, you may like to pull another set of patches below
> (these are kernel equivalent of driver optimization for u-boot driver)
>  http://lists.denx.de/pipermail/u-boot/2013-November/167445.html
> 
> Also, for JFFS2, please erase the flash using -j option.
> '-j' option adds a clean marker to erased blocks.

As said, I'm erasing/flashing from U-Boot, so flash_eraseall options
are not really useful here :)

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
