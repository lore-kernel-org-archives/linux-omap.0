From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH] ARM: dts: omap3-igep00x0: Fix nand ECC to maintain
 backward compatibility.
Date: Mon, 2 Dec 2013 17:06:06 +0100
Message-ID: <20131202170606.2191fd89@skate>
References: <1385896995-16803-1-git-send-email-eballetbo@gmail.com>
	<CABxcv=mkSE2A9TLsp7pXWK=dyu6wjN0t6K2ke6NfP3G2rxaXug@mail.gmail.com>
	<20131202115422.1f8c73f6@skate>
	<CAFqH_53V5rOsCOLzTzm=9m1zvJpqN_ofh1jjzKAMmKqwHe28rQ@mail.gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73EA5094C@DBDE04.ent.ti.com>
	<20131202160219.40286dc9@skate>
	<20980858CB6D3A4BAE95CA194937D5E73EA5099E@DBDE04.ent.ti.com>
	<CAFqH_52ARf44fWOP9HBwfS=AjoNm2MfEMyBBAJ7KDJO+xLPGfw@mail.gmail.com>
	<20131202165103.726314d9@skate>
	<529CAEA3.2080808@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:52974 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751964Ab3LBQGO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Dec 2013 11:06:14 -0500
In-Reply-To: <529CAEA3.2080808@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tom Rini <trini@ti.com>
Cc: Enric Balletbo Serra <eballetbo@gmail.com>, "Gupta, Pekon" <pekon@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>, =?UTF-8?B?QmVub8OudA==?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, "Scott Wood (scottwood@freescale.com)" <scottwood@freescale.com>

Dear Tom Rini,

On Mon, 2 Dec 2013 11:00:35 -0500, Tom Rini wrote:

> >> Although the new ECC schema breaks the compatibility between the board
> >> files and new DT based kernel, I think we should use BCH8 scheme.
> >> Sorry, because I had not realized that this was configurable in
> >> u-boot, so I think, if Thomas is also agree, the better fix in that
> >> case is change CONFIG_NAND_OMAP_ECCSCHEME to
> >> OMAP_ECC_BCH8_CODE_HW_DETECTION_SW in u-boot. If this works we can
> >> discard this patch.
> > 
> > I theoretically don't have anything against that, but if I do this
> > change in U-Boot, and then use U-Boot to reflash to NAND the SPL and
> > U-Boot itself, will the OMAP ROM code still be able to read the SPL
> > from NAND ? I'm not sure which ECC scheme does the OMAP ROM code
> > support, and how it detects (or not) which ECC scheme to use to read
> > the SPL.
> 
> Yes, this brings us back to one of the old and long-standing problems.
> The ROM on these devices will generally speak one format and that means
> using NAND chips that say for the first block (or N blocks or whatever)
> you only need 1bit ECC but for the rest 4/8/16/whatever.  And then
> informing the kernel (and anything else) that "partitions" N need this
> format and the rest need that.

As long as U-Boot provides separate commands, or a "nandecc" command
that allows to switch between ECC scheme, and select the ECC scheme
expected by the ROM code when flashing the SPL, and then the ECC scheme
expected by the SPL and the kernel to flash U-Boot itself, the kernel
image, and the various filesystem images, then it's all fine, we can
leave with different ECC schemes used for different things on the NAND
flash.

Of course, ideally, we should also be able to tell the kernel about the
ECC scheme on a per-partition basis.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
