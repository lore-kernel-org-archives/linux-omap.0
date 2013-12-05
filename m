From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP3 NAND ECC selection
Date: Thu, 5 Dec 2013 11:38:34 -0800
Message-ID: <20131205193834.GJ26766@atomide.com>
References: <CAFqH_50vhgJ=ktqmYRo+ZO1bbRmiME+kXVt6sLJL91q9A2S7TA@mail.gmail.com>
 <52A04E75.3010609@corscience.de>
 <alpine.DEB.2.01.1312051711410.20976@pmeerw.net>
 <20131205171326.GA26766@atomide.com>
 <CABxcv=mtqkpyup0y-zv53YRvdgKH0bNXeCWf9mxPFoUTRQ=Gew@mail.gmail.com>
 <20131205182628.GF2345@localhost>
 <20980858CB6D3A4BAE95CA194937D5E73EA5222E@DBDE04.ent.ti.com>
 <20131205200618.19b33ee2@skate>
 <CAN8TOE-cv5ppz0Q_asK=6WdRPaK9SAd1ccZF0Ax7QCdGOE7Fjw@mail.gmail.com>
 <20131205203237.047cfbb9@skate>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:21372 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750723Ab3LETio (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Dec 2013 14:38:44 -0500
Content-Disposition: inline
In-Reply-To: <20131205203237.047cfbb9@skate>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Brian Norris <computersforpeace@gmail.com>, "Gupta, Pekon" <pekon@ti.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Javier Martinez Canillas <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Andreas =?utf-8?B?Qmllw59tYW5u?= <andreas.biessmann@corscience.de>, Peter Meerwald <pmeerw@pmeerw.net>

* Thomas Petazzoni <thomas.petazzoni@free-electrons.com> [131205 11:33]:
> Dear Brian Norris,
> 
> On Thu, 5 Dec 2013 11:24:18 -0800, Brian Norris wrote:
> 
> > > The long term benefits is simply to properly handle the hardware
> > > constraints. We have hardware platforms were parts of the NAND *MUST*
> > > use 1-bit ECC to be compatible with the ROM code, and other parts of
> > > the NAND *MUST* use stronger 4-bits or 8-bits ECC to comply with the
> > > NAND requirements.
> > 
> > Using 1-bit ECC on NAND is not a long-term solution. Given that fact,
> > I think your ROM code is what may need to change, not the entire MTD
> > subsystem.
> 
> As someone (Tom Rini maybe?) pointed out, today the shift is 1-bit ECC
> supported by ROM code vs. 4 or 8 bits required by NAND. But we can very
> well imagine that tomorrow ROM code will support BCH4 (and the NAND
> will ensure block 0 is OK for use with BCH4) but the rest of the NAND
> will require BCH16 or something like that.
> 
> I'm not designing ROM code, and the fact that they today have this
> limitation, should be an indication that Linux should be capable of
> handling different ECC schemes to handle those hardware constraints.

Yeah and it seems that for the bootloader partition we need to be able
to specify the ECC scheme in the .dts file to avoid having people trash
their system unless they really want to do it.

/me at least has rebooted and reflashed way too many times unnecessarily
while trying to update MLO or u-boot from the kernel.

Regards,

Tony
