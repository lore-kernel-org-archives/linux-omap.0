From: Enric Balletbo Serra <eballetbo@gmail.com>
Subject: Re: [PATCH] ARM: dts: omap3-igep00x0: Fix nand ECC to maintain
 backward compatibility.
Date: Mon, 2 Dec 2013 16:39:09 +0100
Message-ID: <CAFqH_52ARf44fWOP9HBwfS=AjoNm2MfEMyBBAJ7KDJO+xLPGfw@mail.gmail.com>
References: <1385896995-16803-1-git-send-email-eballetbo@gmail.com>
	<CABxcv=mkSE2A9TLsp7pXWK=dyu6wjN0t6K2ke6NfP3G2rxaXug@mail.gmail.com>
	<20131202115422.1f8c73f6@skate>
	<CAFqH_53V5rOsCOLzTzm=9m1zvJpqN_ofh1jjzKAMmKqwHe28rQ@mail.gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73EA5094C@DBDE04.ent.ti.com>
	<20131202160219.40286dc9@skate>
	<20980858CB6D3A4BAE95CA194937D5E73EA5099E@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:58669 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807Ab3LBPjK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Dec 2013 10:39:10 -0500
Received: by mail-we0-f182.google.com with SMTP id q59so12343500wes.27
        for <linux-omap@vger.kernel.org>; Mon, 02 Dec 2013 07:39:09 -0800 (PST)
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA5099E@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Javier Martinez Canillas <javier@dowhile0.org>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, "Rini, Tom" <trini@ti.com>, "Scott Wood (scottwood@freescale.com)" <scottwood@freescale.com>

Hi all,

2013/12/2 Gupta, Pekon <pekon@ti.com>:
>>From: Thomas Petazzoni [mailto:thomas.petazzoni@free-electrons.com]
>>>On Mon, 2 Dec 2013 14:56:09 +0000, Gupta, Pekon wrote:
>>
>>> A query Why are you going backward from BCH8 to HAM1 ?
>>>
>>> HAM1 is just kept for legacy reasons, it's not at all recommended for new
>>> development. As some field results have shown that devices with
>>> HAM1 become un-usable very soon and start reporting uncorrectable errors
>>> because HAM1 can only handle single bit-flip, which is inadequate in field
>>> conditions and large page device wears-n-tears. (especially considering
>>> your device density is of order of 4Gb - mt29c4g96maz).
>>>
>>> Also, just to inform that BCH8_SW ecc-scheme is implemented in such
>>> a way that *only* error correction is handled using s/w library (lib/bch.c).
>>> Rest all ECC calculation is handled using GPMC hardware.
>>> So, the CPU penalty will be seen only when there are bit-flips found
>>> during Read access, which are of rare conditions, occurring only few times
>>> in multi-megabit transfers.
>>>
>>> Also, On top of that ecc-schemes implementations have been optimized.
>>> And the patch-series is under review on mainline kernel.
>>> http://lists.infradead.org/pipermail/linux-mtd/2013-November/thread.html
>>>
>>> (Apologies for long suggestion, but in summary please don't use HAM1
>>> for any new development. And with BCH8_SW you should see better
>>> bit-flip handling (longer device life) with no hit in performance).
>>
>>The crucial point here is that the interaction between the bootloader
>>and the kernel. The use case I have is that I'm flashing a filesystem
>>image from the bootloader, and mounting it from the kernel.
>>
>>Using a mainline 2013.10 U-Boot for IGEPv2 + the mainline kernel booted
>>in legacy mode (no Device Tree) works fine. Using the same 2013.10
>>U-Boot for IGEPv2 + the mainline kernel booted in DT no longer works,
>>because the kernel disagrees with the bootloader on the ECC scheme to
>>use.
>>
>>So I'm not saying that Hamming is better than BCH, certainly not. I'm
>>just saying that changing ECC scheme in the kernel without looking at
>>the more global picture of what support the bootloaders are offering is
>>not nice. At least, the bootloader should provide a command, or option,
>>to be able to use an ECC scheme that is compatible with what the kernel
>>expects.
>>
> Yes, there is a way to change ecc-scheme in u-boot..
> Also, you can modify to any ecc-scheme in u-boot using
> "CONFIG_NAND_OMAP_ECCSCHEME" as documented in doc/README.nand
>
> Also your board should boot seamlessly from mainline u-boot in sync
> with mainline kernel. As per my knowledge following patch is already
> in mainline u-boot. And touches your board as well. (omap3_igep00x0.h)
> http://lists.denx.de/pipermail/u-boot/2013-November/167550.html
>
> AFAIK these patches should be in u-boot mainline.
>
> Though I have taken at-most care that no existing board should break.
> But, I'm sorry if there is something broken in between the u-boot and
> Kernel builds. Let me know if I can help in fixing that somehow.
>
>
> with regards, pekon

Thanks for the explanations to all.

Although the new ECC schema breaks the compatibility between the board
files and new DT based kernel, I think we should use BCH8 scheme.
Sorry, because I had not realized that this was configurable in
u-boot, so I think, if Thomas is also agree, the better fix in that
case is change CONFIG_NAND_OMAP_ECCSCHEME to
OMAP_ECC_BCH8_CODE_HW_DETECTION_SW in u-boot. If this works we can
discard this patch.

Best regards,
   Enric
