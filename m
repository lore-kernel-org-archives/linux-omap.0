From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: OMAP3 NAND ECC selection
Date: Thu, 5 Dec 2013 11:24:18 -0800
Message-ID: <CAN8TOE-cv5ppz0Q_asK=6WdRPaK9SAd1ccZF0Ax7QCdGOE7Fjw@mail.gmail.com>
References: <alpine.DEB.2.01.1312051000270.17561@pmeerw.net>
	<CAFqH_50vhgJ=ktqmYRo+ZO1bbRmiME+kXVt6sLJL91q9A2S7TA@mail.gmail.com>
	<52A04E75.3010609@corscience.de>
	<alpine.DEB.2.01.1312051711410.20976@pmeerw.net>
	<20131205171326.GA26766@atomide.com>
	<CABxcv=mtqkpyup0y-zv53YRvdgKH0bNXeCWf9mxPFoUTRQ=Gew@mail.gmail.com>
	<20131205182628.GF2345@localhost>
	<20980858CB6D3A4BAE95CA194937D5E73EA5222E@DBDE04.ent.ti.com>
	<20131205200618.19b33ee2@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ve0-f176.google.com ([209.85.128.176]:62467 "EHLO
	mail-ve0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809Ab3LETYT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Dec 2013 14:24:19 -0500
Received: by mail-ve0-f176.google.com with SMTP id oz11so14024928veb.7
        for <linux-omap@vger.kernel.org>; Thu, 05 Dec 2013 11:24:18 -0800 (PST)
In-Reply-To: <20131205200618.19b33ee2@skate>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: "Gupta, Pekon" <pekon@ti.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Javier Martinez Canillas <javier@dowhile0.org>, Tony Lindgren <tony@atomide.com>, Enric Balletbo Serra <eballetbo@gmail.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, =?ISO-8859-1?Q?Andreas_Bie=DFmann?= <andreas.biessmann@corscience.de>, Peter Meerwald <pmeerw@pmeerw.net>

On Thu, Dec 5, 2013 at 11:06 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> On Thu, 5 Dec 2013 19:02:22 +0000, Gupta, Pekon wrote:
>
>> >From: Ezequiel Garcia [mailto:ezequiel.garcia@free-electrons.com]
>> [...]
>> >AFAIK, there's no hardware limitation that would prevent us from setting
>> >a per-partition ECC, keep in mind this effort is not reduced to make
>> >devicetree accept ECC on the partitions.
>> >
>> I had some reservations in doing so.. (as mentioned in previous email also [2])
>> I would rather like to understand long term benefits of such implementation.
>
> The long term benefits is simply to properly handle the hardware
> constraints. We have hardware platforms were parts of the NAND *MUST*
> use 1-bit ECC to be compatible with the ROM code, and other parts of
> the NAND *MUST* use stronger 4-bits or 8-bits ECC to comply with the
> NAND requirements.

Using 1-bit ECC on NAND is not a long-term solution. Given that fact,
I think your ROM code is what may need to change, not the entire MTD
subsystem.

> Isn't handling hardware constraints properly not a sufficient
> motivation for doing something?

I'm not convinced your hardware constraints are reasonable or
generally useful. But I could be convinced otherwise.

>> Also, any constrain due to ROM code, or upgrading from remote can be
>> handled using various alternative approaches like [a] and [b].
>
> And you're not realizing that these solutions are ugly and impractical?

Solution [a] is both ugly and impractical. Solution [b] is only a
little ugly but quite practical (you could flesh out a better
user-space ECC library, then combine it with nanddump/nandwrite
--noecc). Rewriting both the MTD and NAND layers is not exactly
practical and may still yield something ugly.

Brian
