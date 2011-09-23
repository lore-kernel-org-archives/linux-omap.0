From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/6] OMAP4: Clock: Associate clocks for OMAP temperature
 sensor
Date: Thu, 22 Sep 2011 23:58:41 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1109222357440.10719@utopia.booyaka.com>
References: <1316705361-12175-1-git-send-email-j-keerthy@ti.com> <1316705361-12175-3-git-send-email-j-keerthy@ti.com> <alpine.DEB.2.00.1109222316350.10719@utopia.booyaka.com> <CAJ6a13aKoca1ny3ek7R3+T6GKVEKF1OhoxoDywcaPfpCnk0WzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1911425418-1316757521=:10719"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58824 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751325Ab1IWF6m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Sep 2011 01:58:42 -0400
In-Reply-To: <CAJ6a13aKoca1ny3ek7R3+T6GKVEKF1OhoxoDywcaPfpCnk0WzQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1911425418-1316757521=:10719
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 23 Sep 2011, J, KEERTHY wrote:

> On Fri, Sep 23, 2011 at 10:48 AM, Paul Walmsley <paul@pwsan.com> wrote:
> > On Thu, 22 Sep 2011, Keerthy wrote:
> >
> >> ---
> >> =A0arch/arm/mach-omap2/clock44xx_data.c | =A0 =A04 ++--
> >> =A01 files changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap=
2/clock44xx_data.c
> >> index 946bf04..c51e513 100644
> >> --- a/arch/arm/mach-omap2/clock44xx_data.c
> >> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> >> @@ -3185,9 +3185,9 @@ static struct omap_clk omap44xx_clks[] =3D {
> >> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "aes2_fck", =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 &aes2_fck, =A0 =A0 =A0CK_443X),
> >> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "aess_fck", =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 &aess_fck, =A0 =A0 =A0CK_443X),
> >> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "bandgap_fclk", =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 &bandgap_fclk, =A0CK_443X),
> >> - =A0 =A0 CLK(NULL, =A0 =A0 =A0 "bandgap_ts_fclk", =A0 =A0 =A0 =A0 =A0=
 =A0 =A0&bandgap_ts_fclk, =A0 =A0 =A0 CK_446X),
> >> + =A0 =A0 CLK("omap4460plus_scm.0", =A0 =A0 =A0 "fck", =A0 =A0 =A0 =A0=
 =A0&bandgap_ts_fclk, =A0 =A0 =A0 CK_446X),
> >> =A0 =A0 =A0 CLK(NULL, =A0 =A0 =A0 "des3des_fck", =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0&des3des_fck, =A0 CK_443X),
> >> - =A0 =A0 CLK(NULL, =A0 =A0 =A0 "div_ts_ck", =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0&div_ts_ck, =A0 =A0 CK_446X),
> >> + =A0 =A0 CLK("omap4460plus_scm.0", =A0 =A0 =A0 "div_ck", =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &div_ts_ck, =A0 =A0 CK_446X),
> >
> > Clearly this device is incorrectly named. =A0You're setting up a clkdev
> > entry that's marked as being valid for OMAP4430, but your device is cal=
led
> > "omap4460plus_scm". =A0They can't both be right...
>=20
> This is addressed in Patch 06.

How does patch 6 address it?=20


- Paul
--155748971-1911425418-1316757521=:10719--
