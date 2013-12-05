From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: OMAP3 NAND ECC selection
Date: Thu, 5 Dec 2013 15:26:29 -0300
Message-ID: <20131205182628.GF2345@localhost>
References: <alpine.DEB.2.01.1312051000270.17561@pmeerw.net>
 <CAFqH_50vhgJ=ktqmYRo+ZO1bbRmiME+kXVt6sLJL91q9A2S7TA@mail.gmail.com>
 <52A04E75.3010609@corscience.de>
 <alpine.DEB.2.01.1312051711410.20976@pmeerw.net>
 <20131205171326.GA26766@atomide.com>
 <CABxcv=mtqkpyup0y-zv53YRvdgKH0bNXeCWf9mxPFoUTRQ=Gew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:48611 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752009Ab3LES0Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Dec 2013 13:26:25 -0500
Content-Disposition: inline
In-Reply-To: <CABxcv=mtqkpyup0y-zv53YRvdgKH0bNXeCWf9mxPFoUTRQ=Gew@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Tony Lindgren <tony@atomide.com>, "Gupta, Pekon" <pekon@ti.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Enric Balletbo Serra <eballetbo@gmail.com>, linux-mtd@lists.infradead.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Andreas =?utf-8?B?Qmllw59tYW5u?= <andreas.biessmann@corscience.de>, Peter Meerwald <pmeerw@pmeerw.net>, Brian Norris <computersforpeace@gmail.com>

Hi Javier,

(CCing Brian: What do you think about this?)

On Thu, Dec 05, 2013 at 06:39:10PM +0100, Javier Martinez Canillas wrot=
e:
> On Thu, Dec 5, 2013 at 6:13 PM, Tony Lindgren <tony@atomide.com> wrot=
e:
>=20
> In the another thread [0] pointed out by Enric we were discussing the
> same issue. Thomas suggested [1] that ideally we should be able to se=
t
> a per MTD partition ECC scheme. That way we can set 1 bit hamming for
> the first MTD partition that has the SPL that the boot ROM needs to
> read and the other partitions can use a more secure ECC scheme. I
> completely agree with him.
>=20
[..]
> global ECC scheme and we should expand the GPMC NAND DT binding so
> partitions support the "ti,nand-ecc-opt". I'll see if I can get some
> free time to try to implement that.
>=20

AFAIK, there's no hardware limitation that would prevent us from settin=
g
a per-partition ECC, keep in mind this effort is not reduced to make
devicetree accept ECC on the partitions.

While there are some per MTD device (which model each partition), the
ECC mode is present in the, nand_chip structure. My understanding is th=
at
the NAND core hasn't been designed for this use case, and thus some
major re-work is needed to accomplish it.

Therefore, it's a much short-term solution to implement the OMAP
module parameter to fix the issue.

Of course, feel free to prove me wrong :-)
--=20
Ezequiel Garc=C3=ADa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
