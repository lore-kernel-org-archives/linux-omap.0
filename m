From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Enabling 3530 sys_clkout2
Date: Tue, 15 Dec 2009 14:34:45 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0912151433150.12561@utopia.booyaka.com>
References: <e0727e900912141230q1e98d4c3ge408101664a0c712@mail.gmail.com>  <alpine.DEB.2.00.0912141457110.12561@utopia.booyaka.com>  <e0727e900912141458i2737b7favfe1ecc8feceafe40@mail.gmail.com> <e0727e900912141534g1ed3cee8pc592eae39e71353@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1752130198-1260912885=:12561"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50746 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755057AbZLOVeq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Dec 2009 16:34:46 -0500
In-Reply-To: <e0727e900912141534g1ed3cee8pc592eae39e71353@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: John Faith <jfaith7@gmail.com>
Cc: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1752130198-1260912885=:12561
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hello John,

On Mon, 14 Dec 2009, John Faith wrote:

> On Mon, Dec 14, 2009 at 2:58 PM, John Faith <jfaith7@gmail.com> wrote:
> > On Mon, Dec 14, 2009 at 1:59 PM, Paul Walmsley <paul@pwsan.com> wrote:
> >> On Mon, 14 Dec 2009, John Faith wrote:
> >>
> >>> I'm trying to enable the sys_clkout2 pin in a 2.6.29 kernel for my
> >>> 3530EVM-like board for the main clock line of an FPGA. =A0I've added =
a
> >>> MUX_CFG_34XX entry in mux.c, set the gpio direction in my board.c
> >>> file, and set the rate in my driver with clk_set_parent(),
> >>> clk_set_rate() but I do not see any output clock when probed with a
> >>> scope.
> >>
> >> Sounds like either the clock is not enabled (use clk_enable() for this=
),
> >> or there is a mux problem.
> >>
> >> You might also want to make sure that you've set the parent of
> >> clkout2_src_ck appropriately, although you still should be able to get
> >> something out of it.
> >
> > After 3 clk_get() for clkout2_src_ck, sys_clkout2, and func_96m_ck, I
> > set the parent the same as n810.c with:
> >
> > =A0clk_set_parent(sys_clkout2_src, func96m_clk);
> > =A0clk_set_rate(sys_clkout2, 12000000);
> >
> > Calling clk_enable(sys_clkout2); returns zero.
> >
>=20
> To answer my own question, I was using:
>   func96m_clk =3D clk_get(&dev->dev, "func_96m_ck");
>=20
> , but apparently should have been using:
>  func96m_clk =3D clk_get(&dev->dev, "cm_96m_fck");
>=20
> which produces the expected clock output.

Good to hear that it works :-)  Do you think it would be a good idea to=20
add a WARN() to clk_set_parent() for situations like this?  The return=20
value should indicate an error, of course, but those are rarely checked.


- Paul
--155748971-1752130198-1260912885=:12561--
