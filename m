From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH] ARM: dts: omap3-igep00x0: Fix nand ECC to maintain
 backward compatibility.
Date: Mon, 2 Dec 2013 16:51:03 +0100
Message-ID: <20131202165103.726314d9@skate>
References: <1385896995-16803-1-git-send-email-eballetbo@gmail.com>
	<CABxcv=mkSE2A9TLsp7pXWK=dyu6wjN0t6K2ke6NfP3G2rxaXug@mail.gmail.com>
	<20131202115422.1f8c73f6@skate>
	<CAFqH_53V5rOsCOLzTzm=9m1zvJpqN_ofh1jjzKAMmKqwHe28rQ@mail.gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73EA5094C@DBDE04.ent.ti.com>
	<20131202160219.40286dc9@skate>
	<20980858CB6D3A4BAE95CA194937D5E73EA5099E@DBDE04.ent.ti.com>
	<CAFqH_52ARf44fWOP9HBwfS=AjoNm2MfEMyBBAJ7KDJO+xLPGfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:52910 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752221Ab3LBPvJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Dec 2013 10:51:09 -0500
In-Reply-To: <CAFqH_52ARf44fWOP9HBwfS=AjoNm2MfEMyBBAJ7KDJO+xLPGfw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: "Gupta, Pekon" <pekon@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>, =?UTF-8?B?QmVub8OudA==?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, "Rini, Tom" <trini@ti.com>, "Scott Wood (scottwood@freescale.com)" <scottwood@freescale.com>

Dear Enric Balletbo Serra,

On Mon, 2 Dec 2013 16:39:09 +0100, Enric Balletbo Serra wrote:

> Thanks for the explanations to all.
> 
> Although the new ECC schema breaks the compatibility between the board
> files and new DT based kernel, I think we should use BCH8 scheme.
> Sorry, because I had not realized that this was configurable in
> u-boot, so I think, if Thomas is also agree, the better fix in that
> case is change CONFIG_NAND_OMAP_ECCSCHEME to
> OMAP_ECC_BCH8_CODE_HW_DETECTION_SW in u-boot. If this works we can
> discard this patch.

I theoretically don't have anything against that, but if I do this
change in U-Boot, and then use U-Boot to reflash to NAND the SPL and
U-Boot itself, will the OMAP ROM code still be able to read the SPL
from NAND ? I'm not sure which ECC scheme does the OMAP ROM code
support, and how it detects (or not) which ECC scheme to use to read
the SPL.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
