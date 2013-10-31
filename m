From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v11 00/10] [PATCH v10 00/10] mtd:nand:omap2: clean-up
 of supported ECC schemes
Date: Thu, 31 Oct 2013 14:23:49 -0700
Message-ID: <20131031212348.GK15154@atomide.com>
References: <1382619026-4182-1-git-send-email-pekon@ti.com>
 <20131024135258.GC9958@localhost>
 <CAN8TOE_KQxW4-6KgjQDczyB31wmYB_y9Tirxa34GWQGgY39sNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:22578 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751495Ab3JaVYA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 31 Oct 2013 17:24:00 -0400
Content-Disposition: inline
In-Reply-To: <CAN8TOE_KQxW4-6KgjQDczyB31wmYB_y9Tirxa34GWQGgY39sNQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Pekon Gupta <pekon@ti.com>, Mark Rutland <mark.rutland@arm.com>, "olof@lixom.net" <olof@lixom.net>, Artem Bityutskiy <dedekind1@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, "jp.francois@cynove.com" <jp.francois@cynove.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Avinash Philip <avinashphilipk@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, Rob Herring <robherring2@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, Ivan Djelic <ivan.djelic@parrot.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>

* Brian Norris <computersforpeace@gmail.com> [131029 21:00]:
> 
> Tony, you mentioned the DTS update in patch 8 going in via an ARM
> tree? This patch is not urgent, and it should probably wait until we
> know what release the rest of the series makes it into. This may
> depend on David Woodhouse's recommendation, but I'm not sure this
> series will have enough time baking in linux-next before entering
> mainline in 3.13 (the merge window is approaching).

Yes Benoit or I can apply that patch if Pekon pings me or resends
that patch when it's OK to merge it.

Regards,

Tony
