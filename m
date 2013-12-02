From: Tom Rini <trini@ti.com>
Subject: Re: [PATCH] ARM: dts: omap3-igep00x0: Fix nand ECC to maintain backward
 compatibility.
Date: Mon, 2 Dec 2013 11:00:35 -0500
Message-ID: <529CAEA3.2080808@ti.com>
References: <1385896995-16803-1-git-send-email-eballetbo@gmail.com> <CABxcv=mkSE2A9TLsp7pXWK=dyu6wjN0t6K2ke6NfP3G2rxaXug@mail.gmail.com> <20131202115422.1f8c73f6@skate> <CAFqH_53V5rOsCOLzTzm=9m1zvJpqN_ofh1jjzKAMmKqwHe28rQ@mail.gmail.com> <20980858CB6D3A4BAE95CA194937D5E73EA5094C@DBDE04.ent.ti.com> <20131202160219.40286dc9@skate> <20980858CB6D3A4BAE95CA194937D5E73EA5099E@DBDE04.ent.ti.com> <CAFqH_52ARf44fWOP9HBwfS=AjoNm2MfEMyBBAJ7KDJO+xLPGfw@mail.gmail.com> <20131202165103.726314d9@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38166 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751965Ab3LBQA1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Dec 2013 11:00:27 -0500
In-Reply-To: <20131202165103.726314d9@skate>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Enric Balletbo Serra <eballetbo@gmail.com>, "Gupta, Pekon" <pekon@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>, =?ISO-8859-1?Q?Beno=EEt_?= =?ISO-8859-1?Q?Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, "Scott Wood (scottwood@freescale.com)" <scottwood@freescale.com>

On 12/02/2013 10:51 AM, Thomas Petazzoni wrote:
> Dear Enric Balletbo Serra,
> 
> On Mon, 2 Dec 2013 16:39:09 +0100, Enric Balletbo Serra wrote:
> 
>> Thanks for the explanations to all.
>>
>> Although the new ECC schema breaks the compatibility between the board
>> files and new DT based kernel, I think we should use BCH8 scheme.
>> Sorry, because I had not realized that this was configurable in
>> u-boot, so I think, if Thomas is also agree, the better fix in that
>> case is change CONFIG_NAND_OMAP_ECCSCHEME to
>> OMAP_ECC_BCH8_CODE_HW_DETECTION_SW in u-boot. If this works we can
>> discard this patch.
> 
> I theoretically don't have anything against that, but if I do this
> change in U-Boot, and then use U-Boot to reflash to NAND the SPL and
> U-Boot itself, will the OMAP ROM code still be able to read the SPL
> from NAND ? I'm not sure which ECC scheme does the OMAP ROM code
> support, and how it detects (or not) which ECC scheme to use to read
> the SPL.

Yes, this brings us back to one of the old and long-standing problems.
The ROM on these devices will generally speak one format and that means
using NAND chips that say for the first block (or N blocks or whatever)
you only need 1bit ECC but for the rest 4/8/16/whatever.  And then
informing the kernel (and anything else) that "partitions" N need this
format and the rest need that.

-- 
Tom
