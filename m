From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH] ARM: dts: omap3-igep00x0: Fix nand ECC to maintain
 backward compatibility.
Date: Mon, 2 Dec 2013 17:05:58 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA50AA4@DBDE04.ent.ti.com>
References: <1385896995-16803-1-git-send-email-eballetbo@gmail.com>
	<CABxcv=mkSE2A9TLsp7pXWK=dyu6wjN0t6K2ke6NfP3G2rxaXug@mail.gmail.com>
	<20131202115422.1f8c73f6@skate>
	<CAFqH_53V5rOsCOLzTzm=9m1zvJpqN_ofh1jjzKAMmKqwHe28rQ@mail.gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73EA5094C@DBDE04.ent.ti.com>
	<20131202160219.40286dc9@skate>
	<20980858CB6D3A4BAE95CA194937D5E73EA5099E@DBDE04.ent.ti.com>
	<CAFqH_52ARf44fWOP9HBwfS=AjoNm2MfEMyBBAJ7KDJO+xLPGfw@mail.gmail.com>
	<20131202165103.726314d9@skate>	<529CAEA3.2080808@ti.com>
	<20131202170606.2191fd89@skate>
	<20980858CB6D3A4BAE95CA194937D5E73EA50A23@DBDE04.ent.ti.com>
 <20131202171907.56c9300a@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45900 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752729Ab3LBRGL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Dec 2013 12:06:11 -0500
In-Reply-To: <20131202171907.56c9300a@skate>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: "Rini, Tom" <trini@ti.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Javier Martinez Canillas <javier@dowhile0.org>, =?iso-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, "Scott Wood (scottwood@freescale.com)" <scottwood@freescale.com>

>From: Thomas Petazzoni [mailto:thomas.petazzoni@free-electrons.com]
>Dear Gupta, Pekon,
>
>On Mon, 2 Dec 2013 16:13:56 +0000, Gupta, Pekon wrote:
>
>> Yes, at-least OMAP3 arch u-boot should still supports 'nandecc'.
>> The infrastructure is still in place, however the command 'nandecc' is
>> deprecated in newer versions.
>> References in mainline u-boot:
>> arch/arm/cpu/armv7/omap3/board.c  @@do_switch_ecc()
>> driver/mtd/nand/omap_gpmc.c @@omap_nand_switch_ecc()
>>
>> So with minor hacks, you should be able to bring-back 'nandecc'.
>
>So in short, what it means is that indeed the fact of switching to BCH8
>on the kernel side is really breaking things, because U-Boot users now
>have the choice between:
>
> * Configuring U-Boot to use Hamming ECC, and be able to reflash their
>   SPL, but not their filesystem images.
>
> * Configuring U-Boot to use BCH8, and be able to reflash their
>   filesystem images, but not their SPL.
>
>Seems a little bit annoying for users, no?
>
Yes, agree ..
But this is only because we have mis-match in ecc-scheme between
ROM-code (while reading SPL) v/s  rest of system.
However, if you continue using 'HAM1' for *both* u-boot and kernel
you should not face any issue. And with latest patch on u-boot
your board file should also remain unchanged.

[...]

>> But for all these, images need to be flashed from u-boot. As kernel
>> cannot switch ecc-schemes on-the-fly.
>
>Which as I was saying, is a bit of shame. There is technically nothing
>that makes the ECC scheme something that needs to be applied globally
>on the entire flash.

No, I don't think that kernel needs to ever dynamically switch ecc-schemes.
This feature should be limited only to u-boot (or bootloaders) because:

(1) Adding support for dynamic switching of ecc-schemes will require all
  code to be compiled in driver which increases the kernel  driver footprint.
  (example adding BCH8_SW means you need to compile in lib/bch.c)

(2) Also selection of ecc-scheme mainly depends on NAND device parameter
     (like density, page-size, oobsize) which remain constant for a device
    (all NAND partitions). Thus all partitions should use *same* ecc-scheme
    preferable highest possible available with NAND device & kernel.

(3) Kernel uses same driver instance to handle all MTD partitions, so if one
   partition uses HAM1 while other uses BCH8, and both are simultaneously
   mounted, then it would be difficult for driver to switch ecc-schemes while
  doing interleaved Read/Write between the partitions.
  (though it can be added in framework, but then it's too much over-head).

In my opinion, kernel driver should be free from all over-heads, And should
be *as lite as possible, while continuing to be strong in catching bit-flips.*
Because there are lot of file-system layers over it, to handle more severe
failures. 
Example: even if you use HAM1 and report un-correctable errors, still
UBIFS has too much redundancy of critical metadata, that it can still
recover your volume.
Therefore, I preferred having ecc-scheme selectable via DT (static) for
kernel. However these are purely my opinions based on my assessments.


> And we see real practical cases where being able
>to specify a different ECC scheme per partition would make sense: when
>the ROM code uses a weaker ECC scheme than the one used for most other
>partitions.
>
This constrain of changing ecc-scheme has come because ROM code
ecc-scheme is hardened to select HAM1. And so u-boot (bootloaders)
is used to between bridge gaps between ROM code and kernel.
- This could have been avoided, if u-boot still supported 'nandecc'  OR
- ROM code had mechanism to change its ecc-scheme based on some
   Boot-mode setting (sysboot pins on board).


So coming back to the specific problem here.
I think we need 'nandecc' back in u-boot till atleast all systems have
migrated to BCH16 or whatever highest ecc-scheme which can be
supported on OMAP devices.


with regards, pekon
