From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH 4/4 v2] ARM: OMAP2+: updated ECC scheme attributes for
 omap2-nand DT
Date: Sat, 18 May 2013 11:05:26 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73E9C54B6@DBDE04.ent.ti.com>
References: <1368791418-14330-1-git-send-email-pekon@ti.com>
 <1368791418-14330-5-git-send-email-pekon@ti.com>
 <201305171446.06023.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51945 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752913Ab3ERLGI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 18 May 2013 07:06:08 -0400
In-Reply-To: <201305171446.06023.arnd@arndb.de>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Philip, Avinash" <avinashphilip@ti.com>, "tony@atomide.com" <tony@atomide.com>, "Balbi, Felipe" <balbi@ti.com>, "jp.francois@cynove.com" <jp.francois@cynove.com>


> On Friday 17 May 2013, Gupta, Pekon wrote:
> > From: "Gupta, Pekon" <pekon@ti.com>
> >
> > Updates ECC scheme selection string same to same as used in omap2-
> driver code.
> > This makes the DT configurations easy to understand and map to actual
> code.
> >
> > Signed-off-by: Gupta, Pekon <pekon@ti.com>
> 
> This moves the binding in the wrong direction. First of all, you should
> never
> make incompatible changes to a specification document.
> 
> > -	"bch8_hw_detection_sw" 	8-bit BCH with ECC calculation in
> hardware
> > -				and error detection in software
> > -				- requires Kconfig
> CONFIG_MTD_NAND_ECC_BCH
> 
> The binding before your change is already broken since it refers to
> Linux-specific Kconfig symbols, and you fail to fix that.
> 
[Pekon]: There are two constrains due to which I could not remove
Kconfig dependency
(1) Some BCHx ECC schemes are using generic lib/bch.h and nand_bch.h 
generic libraries, which further depend on 'CONFIG_MTD_NAND_ECC_BCH'.
So I have to include that dependency, so that incorrect ECC scheme 
selection In DT does not break linker.

(2) Other alternative could have been to always include lib/bch.h and 
nand_bch.h. But that would have bloated the omap2-driver footprint,
especially when 80% of the time these libraries were not getting used.

(3) I did not want to change things so drastically that it breaks on legacy
devices. Some users are now migrating to latest kernel from older 
versions. I din't want to make migration more tough :-)

However, I tried to fix some existing issues due to incorrect selection of
Kconfigs, and I tried making things simpler from user's point-of-view.

Like, if you don't select a correct Kconfig along with matching ECC scheme
Then your device_initialization would cleanly exit giving you msg:
pr_err("selected ECC scheme not supported or not enabled\n");


when running the linker.> > +
> 	"OMAP_ECC_BCH4_CODE_HW_DETECTION_SW"
> > +					4-bit BCH with ECC calculation in
> > +					hardware & error detection in
> software.
> > +					- requires
> CONFIG_MTD_NAND_ECC_BCH
> 
> Instead you make it worse by using /more/ Linux-isms in the binding.
> 
> 	Arnd

[Pekon]: The update binding attribute string is done for following reasons:
(1) make it more user-friendly. The string you put in the DT is same, 
You see while browsing thru the driver code.
My assessment was that most mainline user are much tech-savy 
they themselves try to dig into the code and analyze the issue.
Thus for them, reducing the gap between driver nomenclature and 
DT bindings was my way of thinking.

(2) prefix of 'OMAP_ECC_xx' was required because I wanted to 
Differentiate Some ECC schemes implementations from the ones 
already present in generic driver (nand_base.c)
Example: there are following favours of same BCH-ECC scheme now..
- NAND_ECC_SOFT_BCH:  purely S/W based ECC scheme
- OMAP_ECC_BCH4_HW_DETECTION_SW: partly S/w partly H/W based
- OMAP_ECC_BCH4_MODE_HW: fully H/W based ECC scheme.

Anyway these are just my way of thinking.. 
If you have some suggestions, in following a particular nomenclature
OR particular way of streamlining the driver, please elaborate..
Any feedbacks would help to improve..


With regards, pekon
