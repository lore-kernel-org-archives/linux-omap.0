From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v9 0/9] mtd:nand:omap2: clean-up of supported ECC schemes
Date: Wed, 16 Oct 2013 18:48:36 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA277C8@DBDE04.ent.ti.com>
References: <1381816197-20477-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44743 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759631Ab3JPSt3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Oct 2013 14:49:29 -0400
In-Reply-To: <1381816197-20477-1-git-send-email-pekon@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "computersforpeace@gmail.com" <computersforpeace@gmail.com>
Cc: "robherring2@gmail.com" <robherring2@gmail.com>, "Pawel.Moll@arm.com" <Pawel.Moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "dwmw2@infradead.org" <dwmw2@infradead.org>, "arnd@arndb.de" <arnd@arndb.de>, "avinashphilipk@gmail.com" <avinashphilipk@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "olof@lixom.net" <olof@lixom.net>, "dedekind1@gmail.com" <dedekind1@gmail.com>, "tony@atomide.com" <tony@atomide.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>

Hi Brian,

> 
> *changes v8 -> v9*
> [PATCH 1/9] <no update from [PATCH v8 1/6]>
> [PATCH 2/9] <only commit log updated from [PATCH v8 2/6]>
>  As per feedbacks from Brian Norris <computersforpeace@gmail.com>
> previous
>  revision [PATCH v8 3/6] and [PATCH 4/6] are split into following sub-patches:
> - [PATCH 3/9] <new> replaces local reference with generic names (mtd,
> nand_chip)
> - [PATCH 4/9] <new> enables auto-detection of bus-width
> - [PATCH 5/9] <new> removes omap3_init_bch: populates ecc-scheme data
> - [PATCH 6/9] <new> removes omap3_init_bch_tail: populates ecc-layout
> - [PATCH 7/9] <new> replaces lib/bch.c with nand_bch.c wrapper
> [PATCH 8/9] <no update same as [PATCH v8 5/6]
> [PATCH 9/9] removed devm_free_xx functions
> 

Request you to have a look at v9.
If this is acceptable, then I would work to rebase the other pending
series on top of this one.


with regards, pekon
