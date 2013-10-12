From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v8 0/6] mtd:nand:omap2: clean-up of supported ECC schemes
Date: Sat, 12 Oct 2013 22:26:17 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA2188A@DBDE04.ent.ti.com>
References: <1381498603-15715-1-git-send-email-pekon@ti.com>
 <20131011210924.GO23337@ld-irv-0074.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42799 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752774Ab3JLW1S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 12 Oct 2013 18:27:18 -0400
In-Reply-To: <20131011210924.GO23337@ld-irv-0074.broadcom.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "olof@lixom.net" <olof@lixom.net>, "dedekind1@gmail.com" <dedekind1@gmail.com>, "Pawel.Moll@arm.com" <Pawel.Moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "arnd@arndb.de" <arnd@arndb.de>, "tony@atomide.com" <tony@atomide.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "avinashphilipk@gmail.com" <avinashphilipk@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Brain,

> 
> Hi Pekon,
> 
> I will try to summarize the standing of your patch series.
> 
> Patches 1 and 2 look good and have addressed all of the DT maintainers'
> comments, AFAICT. They are ready to go in, except that the following
> patches are not ready; they should probably go in together.
> 
> You ignored most of my comments to patch 3, and it is insufficiently
> documented. Please take a look at my comments, both here (in v8) and in
> v6. It still should be split into more patches.
> 
I tried splitting the earlier [PATCH 3/6], therefore a new patch for merging
various Hamming ECC schemes was spawned. But, I could not clean more
because I would have broken the NAND functionality in between the
patches.
My apologies, I missed some of you other comments, so I'm preparing
next version by splitting [PATCH 3/6] into more sub-patches for ease of
review. 
Most #ifdef were put to suppress warning of un-used functions during
compile time. So those cannot be removed, otherwise this patch would
give compile warnings under randconfig.


> Patch 4 does too much without describing it. Why are you dropping the
> old omap3_correct_data_bch() code? Is this just refactoring? If so, you
> should say so. And this also suggests that you have two logical changes
> going on that should be separated into different patches; one to
> refactor the open-coded NAND/BCH library to replace it with the
> nand_bch.{c,h} support library and one for the new ECC modes.
> 
Agreed, I update commit log to be more explicit that here nand_bch.c
actually encapsulates lib/bch.c.
Here also I cannot remove #ifdef across nand_bch_free() because
it frees some bch control data, which would not be defined for all
ecc-schemes (it is specific to xx_SW  ecc schemes). Hence removing
#ifdef here would give null-pointer exception.


> Patch 5 is good but should wait until the other DT parts are acceptable
> and merged into MTD.
> 
> Patch 6 needs rewriting to use devm_* functions properly, but it was
> never integral to this patch series. You can improve it and resend with
> this series or just send it separately afterward.
> 
Yes I understood this, but I think it would be still good to explicitly
free the resources in case of "module_remove()", because that would
free all resources instantaneously without waiting for devm_ to 
iterate thru the list when it wakes-up (I guess).

I'm not knowledgeable of exact implementation of devm_ and how
often does it iterates the list and frees the resources for corresponding
un-registered devices. So trusting you I'll include your feedbacks here.


with regards, pekon
