From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 7/7] arm: omap2: clksel: fix compile warning
Date: Mon, 17 Jan 2011 10:18:45 +0200
Message-ID: <20110117081845.GF2812@legolas.emea.dhcp.ti.com>
References: <1295238680-26738-1-git-send-email-balbi@ti.com>
 <1295238680-26738-8-git-send-email-balbi@ti.com>
 <AANLkTimO_Vt+bjS1rP1AwD9iSqd_cNLAZ+tukveOtneD@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:42765 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752925Ab1AQISy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Jan 2011 03:18:54 -0500
Received: by mail-yi0-f43.google.com with SMTP id 16so2064035yie.16
        for <linux-omap@vger.kernel.org>; Mon, 17 Jan 2011 00:18:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTimO_Vt+bjS1rP1AwD9iSqd_cNLAZ+tukveOtneD@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi,

On Mon, Jan 17, 2011 at 01:37:41PM +0530, Varadarajan, Charulatha wrote=
:
> On Mon, Jan 17, 2011 at 10:01, Felipe Balbi <balbi@ti.com> wrote:
> > Fix the following compile warning:
> > arch/arm/mach-omap2/clkt_clksel.c: In function '_get_div_and_fieldv=
al':
> > arch/arm/mach-omap2/clkt_clksel.c:100:35: warning: 'max_clkr' may b=
e
> > used uninitialized in this function
> >
> > While at that, also add a check to avoid using max_clkr while NULL.
> >
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> > =A0arch/arm/mach-omap2/clkt_clksel.c | =A0 =A05 ++++-
> > =A01 files changed, 4 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/clkt_clksel.c b/arch/arm/mach-omap=
2/clkt_clksel.c
> > index a781cd6..baf0b6b 100644
> > --- a/arch/arm/mach-omap2/clkt_clksel.c
> > +++ b/arch/arm/mach-omap2/clkt_clksel.c
> > @@ -97,7 +97,7 @@ static u8 _get_div_and_fieldval(struct clk *src_c=
lk, struct clk *clk,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 =
*field_val)
> > =A0{
> > =A0 =A0 =A0 =A0const struct clksel *clks;
> > - =A0 =A0 =A0 const struct clksel_rate *clkr, *max_clkr;
> > + =A0 =A0 =A0 const struct clksel_rate *clkr, *max_clkr =3D NULL;
> > =A0 =A0 =A0 =A0u8 max_div =3D 0;
> >
> > =A0 =A0 =A0 =A0clks =3D _get_clksel_by_parent(clk, src_clk);
> > @@ -123,6 +123,9 @@ static u8 _get_div_and_fieldval(struct clk *src=
_clk, struct clk *clk,
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> > =A0 =A0 =A0 =A0}
> >
> > + =A0 =A0 =A0 if (!max_clkr)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>=20
> Would it be more appropriate to move this check after the "if" check
> of max_div=3D=3D0 and it's warning?
> or add a warning before it returns?

Maybe this return isn't even necessary. max_clkr will be true if max_di=
v
is valid, so they cancel each other.

Tony ?

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
