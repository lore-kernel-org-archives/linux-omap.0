From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: OMAP3 NAND ECC selection
Date: Thu, 5 Dec 2013 20:06:18 +0100
Message-ID: <20131205200618.19b33ee2@skate>
References: <alpine.DEB.2.01.1312051000270.17561@pmeerw.net>
	<CAFqH_50vhgJ=ktqmYRo+ZO1bbRmiME+kXVt6sLJL91q9A2S7TA@mail.gmail.com>
	<52A04E75.3010609@corscience.de>
	<alpine.DEB.2.01.1312051711410.20976@pmeerw.net>
	<20131205171326.GA26766@atomide.com>
	<CABxcv=mtqkpyup0y-zv53YRvdgKH0bNXeCWf9mxPFoUTRQ=Gew@mail.gmail.com>
	<20131205182628.GF2345@localhost>
	<20980858CB6D3A4BAE95CA194937D5E73EA5222E@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:48878 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750723Ab3LETGV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Dec 2013 14:06:21 -0500
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EA5222E@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Pekon" <pekon@ti.com>
Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Javier Martinez Canillas <javier@dowhile0.org>, Tony Lindgren <tony@atomide.com>, Enric Balletbo Serra <eballetbo@gmail.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Andreas =?UTF-8?B?Qmllw59tYW5u?= <andreas.biessmann@corscience.de>, Peter Meerwald <pmeerw@pmeerw.net>, Brian Norris <computersforpeace@gmail.com>

Dear Gupta, Pekon,

On Thu, 5 Dec 2013 19:02:22 +0000, Gupta, Pekon wrote:

> >From: Ezequiel Garcia [mailto:ezequiel.garcia@free-electrons.com]
> [...]
> >AFAIK, there's no hardware limitation that would prevent us from setting
> >a per-partition ECC, keep in mind this effort is not reduced to make
> >devicetree accept ECC on the partitions.
> >
> I had some reservations in doing so.. (as mentioned in previous email also [2])
> I would rather like to understand long term benefits of such implementation.

The long term benefits is simply to properly handle the hardware
constraints. We have hardware platforms were parts of the NAND *MUST*
use 1-bit ECC to be compatible with the ROM code, and other parts of
the NAND *MUST* use stronger 4-bits or 8-bits ECC to comply with the
NAND requirements.

Isn't handling hardware constraints properly not a sufficient
motivation for doing something?

> Also, any constrain due to ROM code, or upgrading from remote can be
> handled using various alternative approaches like [a] and [b].

And you're not realizing that these solutions are ugly and impractical?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
