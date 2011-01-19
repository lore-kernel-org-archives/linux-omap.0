From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 7/7] arm: omap2: clksel: fix compile warning
Date: Wed, 19 Jan 2011 15:09:39 -0800
Message-ID: <20110119230939.GL4957@atomide.com>
References: <1295238680-26738-1-git-send-email-balbi@ti.com>
 <1295238680-26738-8-git-send-email-balbi@ti.com>
 <AANLkTimO_Vt+bjS1rP1AwD9iSqd_cNLAZ+tukveOtneD@mail.gmail.com>
 <20110117081845.GF2812@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:35114 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174Ab1ASXJw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jan 2011 18:09:52 -0500
Content-Disposition: inline
In-Reply-To: <20110117081845.GF2812@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: "Varadarajan, Charulatha" <charu@ti.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

* Felipe Balbi <balbi@ti.com> [110117 00:18]:
> Hi,
>=20
> On Mon, Jan 17, 2011 at 01:37:41PM +0530, Varadarajan, Charulatha wro=
te:
> > On Mon, Jan 17, 2011 at 10:01, Felipe Balbi <balbi@ti.com> wrote:
> > > Fix the following compile warning:
> > > arch/arm/mach-omap2/clkt_clksel.c: In function '_get_div_and_fiel=
dval':
> > > arch/arm/mach-omap2/clkt_clksel.c:100:35: warning: 'max_clkr' may=
 be
> > > used uninitialized in this function
> > >
> > > While at that, also add a check to avoid using max_clkr while NUL=
L.
> > >
> > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > ---
> > > =C2=A0arch/arm/mach-omap2/clkt_clksel.c | =C2=A0 =C2=A05 ++++-
> > > =C2=A01 files changed, 4 insertions(+), 1 deletions(-)
> > >
> > > diff --git a/arch/arm/mach-omap2/clkt_clksel.c b/arch/arm/mach-om=
ap2/clkt_clksel.c
> > > index a781cd6..baf0b6b 100644
> > > --- a/arch/arm/mach-omap2/clkt_clksel.c
> > > +++ b/arch/arm/mach-omap2/clkt_clksel.c
> > > @@ -97,7 +97,7 @@ static u8 _get_div_and_fieldval(struct clk *src=
_clk, struct clk *clk,
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 *field_val)
> > > =C2=A0{
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct clksel *clks;
> > > - =C2=A0 =C2=A0 =C2=A0 const struct clksel_rate *clkr, *max_clkr;
> > > + =C2=A0 =C2=A0 =C2=A0 const struct clksel_rate *clkr, *max_clkr =
=3D NULL;
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0u8 max_div =3D 0;
> > >
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0clks =3D _get_clksel_by_parent(clk, sr=
c_clk);
> > > @@ -123,6 +123,9 @@ static u8 _get_div_and_fieldval(struct clk *s=
rc_clk, struct clk *clk,
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> > > =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> > >
> > > + =C2=A0 =C2=A0 =C2=A0 if (!max_clkr)
> > > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> >=20
> > Would it be more appropriate to move this check after the "if" chec=
k
> > of max_div=3D=3D0 and it's warning?
> > or add a warning before it returns?
>=20
> Maybe this return isn't even necessary. max_clkr will be true if max_=
div
> is valid, so they cancel each other.
>=20
> Tony ?

Looks like the max_div test should catch it to me. Paul?

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
