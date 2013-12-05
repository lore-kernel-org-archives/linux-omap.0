From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: OMAP3 NAND ECC selection
Date: Thu, 5 Dec 2013 20:32:37 +0100
Message-ID: <20131205203237.047cfbb9@skate>
References: <alpine.DEB.2.01.1312051000270.17561@pmeerw.net>
	<CAFqH_50vhgJ=ktqmYRo+ZO1bbRmiME+kXVt6sLJL91q9A2S7TA@mail.gmail.com>
	<52A04E75.3010609@corscience.de>
	<alpine.DEB.2.01.1312051711410.20976@pmeerw.net>
	<20131205171326.GA26766@atomide.com>
	<CABxcv=mtqkpyup0y-zv53YRvdgKH0bNXeCWf9mxPFoUTRQ=Gew@mail.gmail.com>
	<20131205182628.GF2345@localhost>
	<20980858CB6D3A4BAE95CA194937D5E73EA5222E@DBDE04.ent.ti.com>
	<20131205200618.19b33ee2@skate>
	<CAN8TOE-cv5ppz0Q_asK=6WdRPaK9SAd1ccZF0Ax7QCdGOE7Fjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:49098 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751564Ab3LETcp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Dec 2013 14:32:45 -0500
In-Reply-To: <CAN8TOE-cv5ppz0Q_asK=6WdRPaK9SAd1ccZF0Ax7QCdGOE7Fjw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: "Gupta, Pekon" <pekon@ti.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Javier Martinez Canillas <javier@dowhile0.org>, Tony Lindgren <tony@atomide.com>, Enric Balletbo Serra <eballetbo@gmail.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Andreas =?UTF-8?B?Qmllw59tYW5u?= <andreas.biessmann@corscience.de>, Peter Meerwald <pmeerw@pmeerw.net>

Dear Brian Norris,

On Thu, 5 Dec 2013 11:24:18 -0800, Brian Norris wrote:

> > The long term benefits is simply to properly handle the hardware
> > constraints. We have hardware platforms were parts of the NAND *MUST*
> > use 1-bit ECC to be compatible with the ROM code, and other parts of
> > the NAND *MUST* use stronger 4-bits or 8-bits ECC to comply with the
> > NAND requirements.
> 
> Using 1-bit ECC on NAND is not a long-term solution. Given that fact,
> I think your ROM code is what may need to change, not the entire MTD
> subsystem.

As someone (Tom Rini maybe?) pointed out, today the shift is 1-bit ECC
supported by ROM code vs. 4 or 8 bits required by NAND. But we can very
well imagine that tomorrow ROM code will support BCH4 (and the NAND
will ensure block 0 is OK for use with BCH4) but the rest of the NAND
will require BCH16 or something like that.

I'm not designing ROM code, and the fact that they today have this
limitation, should be an indication that Linux should be capable of
handling different ECC schemes to handle those hardware constraints.

> > Isn't handling hardware constraints properly not a sufficient
> > motivation for doing something?
> 
> I'm not convinced your hardware constraints are reasonable or
> generally useful. But I could be convinced otherwise.

They may not be reasonable, but they exist :)

> >> Also, any constrain due to ROM code, or upgrading from remote can be
> >> handled using various alternative approaches like [a] and [b].
> >
> > And you're not realizing that these solutions are ugly and impractical?
> 
> Solution [a] is both ugly and impractical. Solution [b] is only a
> little ugly but quite practical (you could flesh out a better
> user-space ECC library, then combine it with nanddump/nandwrite
> --noecc). Rewriting both the MTD and NAND layers is not exactly
> practical and may still yield something ugly.

It's not practical because it wasn't thought like this originally, but
technically speaking, being able to use a different ECC scheme for
different areas of the NAND makes a lot of sense.

That being said, it is true that having a good and reusable userspace
tool to write data with arbitrary ECC schemes would be useful to
workaround this situation.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
