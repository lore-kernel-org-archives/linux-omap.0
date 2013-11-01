From: "Gupta, Pekon" <pekon@ti.com>
Subject: RE: [PATCH v11 00/10] [PATCH v10 00/10] mtd:nand:omap2: clean-up of
 supported ECC schemes
Date: Fri, 1 Nov 2013 20:10:55 +0000
Message-ID: <20980858CB6D3A4BAE95CA194937D5E73EA2DAD3@DBDE04.ent.ti.com>
References: <1382619026-4182-1-git-send-email-pekon@ti.com>
 <20131024135258.GC9958@localhost>
 <CAN8TOE_KQxW4-6KgjQDczyB31wmYB_y9Tirxa34GWQGgY39sNQ@mail.gmail.com>
 <20131031212348.GK15154@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60909 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751785Ab3KAUMH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Nov 2013 16:12:07 -0400
In-Reply-To: <20131031212348.GK15154@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Brian Norris <computersforpeace@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Arnd Bergmann <arnd@arndb.de>, Pawel Moll <Pawel.Moll@arm.com>, Artem Bityutskiy <dedekind1@gmail.com>, Avinash Philip <avinashphilipk@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, "jp.francois@cynove.com" <jp.francois@cynove.com>, "Balbi, Felipe" <balbi@ti.com>, Rob Herring <robherring2@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, "olof@lixom.net" <olof@lixom.net>, Benoit Cousson <bcousson@baylibre.com>, Ivan Djelic <ivan.djelic@parrot.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>

Hi Tony,

> From: Tony Lindgren
> > * Brian Norris <computersforpeace@gmail.com> [131029 21:00]:
> > Tony, you mentioned the DTS update in patch 8 going in via an ARM
> > tree? This patch is not urgent, and it should probably wait until we
> > know what release the rest of the series makes it into. This may
> > depend on David Woodhouse's recommendation, but I'm not sure this
> > series will have enough time baking in linux-next before entering
> > mainline in 3.13 (the merge window is approaching).
> 
> Yes Benoit or I can apply that patch if Pekon pings me or resends
> that patch when it's OK to merge it.
> 
Yes, I'll keep track of this and would resend you and Benoit the .dts patch
separately when this these binding updates are merged in kernel.

with regards, pekon
