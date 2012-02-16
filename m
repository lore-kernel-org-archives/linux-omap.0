From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2] OMAPDSS: HDMI: Add M2 divider while calculating
 clkout
Date: Thu, 16 Feb 2012 09:12:43 +0200
Message-ID: <1329376363.2046.12.camel@lappy>
References: <1329285034-16121-1-git-send-email-mythripk@ti.com>
	 <1329291660.1892.9.camel@deskari>
	 <CAP5A+B9cuUsAnVSgt4G3Hue2Kns2+es8bW-8zHo2tLB9Kg-O=g@mail.gmail.com>
	 <1329317541.1892.95.camel@deskari>
	 <CAP5A+B_4DwXgx=q3Eem5spsoR6=tPzCQBaBu2mEVQd7zWTTNeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-4o1Vne7N98dvfmP+L2S+"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:35800 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757359Ab2BPHMs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Feb 2012 02:12:48 -0500
Received: by mail-lpp01m010-f52.google.com with SMTP id y4so1892586lag.25
        for <linux-omap@vger.kernel.org>; Wed, 15 Feb 2012 23:12:46 -0800 (PST)
In-Reply-To: <CAP5A+B_4DwXgx=q3Eem5spsoR6=tPzCQBaBu2mEVQd7zWTTNeA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "K, Mythri P" <mythripk@ti.com>
Cc: linux-omap@vger.kernel.org


--=-4o1Vne7N98dvfmP+L2S+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-02-16 at 12:12 +0530, K, Mythri P wrote:
> Hi Tomi,
>=20
> On Wed, Feb 15, 2012 at 8:22 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> w=
rote:
> > On Wed, 2012-02-15 at 14:55 +0530, K, Mythri P wrote:
> >> Hi,
> >>
> >> On Wed, Feb 15, 2012 at 1:11 PM, Tomi Valkeinen <tomi.valkeinen@ti.com=
> wrote:
> >> > On Wed, 2012-02-15 at 11:20 +0530, mythripk@ti.com wrote:
> >> >> From: Mythri P K <mythripk@ti.com>
> >> >>
> >> >> Add M2 divider in the equation to calculate regm and regmf.
> >> >> Formula for calculating:
> >> >> Output clock on digital core domain:
> >> >>       CLKOUT =3D (M / (N+1))*CLKINP*(1/M2)
> >> >> Internal oscillator output clock on internal LDO domain:
> >> >>       CLKDCOLDO =3D (M / (N+1))*CLKINP
> >> >> The current code when allows variable M2 values as input
> >> >> ignores using M2 divider values in calculation of regm and regmf.
> >> >> so fix it by using M2 in calculation although the default value for
> >> >> M2 is 1.
> >> >>
> >> >> Signed-off-by: Mythri P K <mythripk@ti.com>
> >> >> ---
> >> >>  drivers/video/omap2/dss/hdmi.c |   16 ++++++++--------
> >> >>  1 files changed, 8 insertions(+), 8 deletions(-)
> >> >>
> >> >> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/d=
ss/hdmi.c
> >> >> index 92a6679..9185630 100644
> >> >> --- a/drivers/video/omap2/dss/hdmi.c
> >> >> +++ b/drivers/video/omap2/dss/hdmi.c
> >> >> @@ -256,24 +256,24 @@ static void hdmi_compute_pll(struct omap_dss_=
device *dssdev, int phy,
> >> >>
> >> >>       refclk =3D clkin / pi->regn;
> >> >>
> >> >> -     /*
> >> >> -      * multiplier is pixel_clk/ref_clk
> >> >> -      * Multiplying by 100 to avoid fractional part removal
> >> >> -      */
> >> >> -     pi->regm =3D (phy * 100 / (refclk)) / 100;
> >> >> -
> >> >>       if (dssdev->clocks.hdmi.regm2 =3D=3D 0)
> >> >>               pi->regm2 =3D HDMI_DEFAULT_REGM2;
> >> >>       else
> >> >>               pi->regm2 =3D dssdev->clocks.hdmi.regm2;
> >> >>
> >> >>       /*
> >> >> +      * multiplier is pixel_clk/ref_clk
> >> >> +      * Multiplying by 100 to avoid fractional part removal
> >> >> +      */
> >> >> +     pi->regm =3D (phy * 100 * pi->regm2 / (refclk)) / 100;
> >> >
> >> > No need for parenthesis around refclk.
> >> Well this is just a copy of old code will change.
> >
> > The multiplication and division with 100 is actually extra also, they
> > don't bring any precision here.
> >
> Well this is actually done to accommodate the pixel clock, For some
> pixel clock like 25175 for VGA VESA
> there is slight change which is detected by the analyzer so it is
> added for that reason.

These two will always return the same value, so I don't think the
analyzer has detected that:

(phy * 100 * pi->regm2 / (refclk)) / 100

phy * pi->regm2 / refclk

 Tomi


--=-4o1Vne7N98dvfmP+L2S+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPPKxrAAoJEPo9qoy8lh71NpIQAKQdW8cILOuKUGguXWR8/fX8
Y1fAwSm528es6tlaVZcfbUCANDw2Q4ZBUZTHdhLOcPlhKUThgnEzTKe7b5nQ02ML
JYgmG2owEuFt15EgkHNl+Bd0IZfbw4YQnSiAo5SubjkH+Y9lmxeLB600P/vdJFsy
drJeKJzsBnkqqmaOT3jbNL2IDMPqzZfbUdLN4nxAdkOqm8ou0X/I5+orFAhLIaKH
GvIvL2iJO9x6S4j7bipgd7Zuo8RmwMYwf2UActomF3rwm4ceJOk/p8euyXjilcCN
KuIsQOOQ+XQI/PMz/495vVrCDVwNBFnd2aU9BTVdbL8+eYjgqsjLWhAK8WuIryc2
3wKOYiiM8AFjmpPJg4TDVvvNUHGoOuEd7+kGcZkCv6opr539BLW9NHLfgvV2UbSp
J6XwAkxqabloO7IKjRnJfgbitsLoHSZWeGdLGPpzvr4vMtv3069b43JSXDefRXWs
CNi/CyeSDCi2WGw/T2oQv4cjdCS5h/MoNnCKo4rfjQb3E4VpgXVVN/4wfZOU/Ju2
Qn3RstyAwIRvIwkqSuzAEemPcjN/lMO7kcjSqVRVubCIZeTuZtm21bK0Fwi+gJqv
YHqaLxWdPIiLJWM5erh093f1+9H6ghlz+op0ab55iEE/N+1fdMxzGqiDFG3q8Tx1
aZq6/bt7iB5twAZ7iZ7x
=N58R
-----END PGP SIGNATURE-----

--=-4o1Vne7N98dvfmP+L2S+--

