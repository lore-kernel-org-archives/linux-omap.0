From: Felipe Balbi <balbi@ti.com>
Subject: Re: Help with clk API
Date: Wed, 16 Nov 2011 12:52:28 +0200
Message-ID: <20111116105228.GB27980@legolas.emea.dhcp.ti.com>
References: <20111111113159.GK19090@legolas.emea.dhcp.ti.com>
 <alpine.DEB.2.00.1111150610330.19654@utopia.booyaka.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:45648 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755569Ab1KPKwc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Nov 2011 05:52:32 -0500
Received: by mail-bw0-f44.google.com with SMTP id zv15so455957bkb.31
        for <linux-omap@vger.kernel.org>; Wed, 16 Nov 2011 02:52:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1111150610330.19654@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, r-woodruff@ti.com, mturquette@ti.com


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 15, 2011 at 06:45:17AM -0700, Paul Walmsley wrote:
> Hi Felipe
>=20
> On Fri, 11 Nov 2011, Felipe Balbi wrote:
>=20
> > I have a doubt about using clk API to change CLKSEL_UTMI_P1 bit for a
> > silicon errata (OMAP4460 i693) implementation.
> >=20
> > According to errata, I need to switch from external to internal clock
> > during USB port suspend, wait 1ms and switch back from internal to
> > external.
> >=20
> > How can I do that with clk API ? Is it by changing clk parent ? Any tips
> > would be helpful ;-) thanks
>=20
> clk_set_parent() is the way to go.  There are 44xx struct clks that=20
> references CLKSEL_UTMI_P1 and CLKSEL_UTMI_P2: see utmi_p1_gfclk and=20
> utmi_p2_gfclk in mach-omap2/clock44xx_data.c.  The possible parent clocks=
=20
> are listed in utmi_p1_gfclk_sel and utmi_p2_gfclk_sel in the same file.
>=20
> So you should be able to clk_get() the possible parent clocks and=20
> utmi_p1_gfclk during module init, then use clk_set_parent() to switch=20
> between them.  For example, for port 1:
>=20
> new_parent =3D clk_set_parent(utmi_p1_clk, init_60m_clk);
> /* test new_parent for error */
> /* delay 1ms */
> new_parent =3D clk_set_parent(utmi_p1_clk, xclk60mhsp1_ck);

ok, so if I understood correctly, xclk60mhsp1_ck is the external clock
for port 1 and init_60m_clk is the internal optional 60MHz clock, right?
So the final workaround would be something like:

clk =3D uhh->utmi_p1_fck;

/* ensure optional clock is disabled */
clk_disable(clk);

ret =3D clk_set_parent(clk, parent);
if (ret) {
	dev_err(uhh->dev, "can't change %s's parent to %s\n",
		clk->name, parent->name);
	return;
}

ret =3D clk_enable(clk);
if (ret) {
	dev_err(uhh->dev, "failed to enable %s\n", clk->name);
	return;
}

/* wait 1ms */
msleep(1);

parent =3D uhh->xclk60mhsp1_ck;
clk_disable(clk);

ret =3D clk_set_parent(clk, parent);
if (ret) {
	dev_err(uhh->dev, "can't change %s's parent to %s\n",
		clk->name, parent->name);
	return;
}

ret =3D clk_enable(clk);
if (ret) {
dev_err(uhh->dev, "failed to enable %s\n", clk->name);
}

and similarly for port 2, but :%s/p1/p2/g

right ?

--=20
balbi

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJOw5XrAAoJEIaOsuA1yqREVnMP/0Ft/8b0+1bvt3UlO7EftDRA
i3bVJxRJMPseYb7Nbllpverxy7OzEZqsgWnLbtf+tK8eqQajrRXrZok2awrd/J9Z
dDS14epCKsU8GI46AHUM4ykuIMCYX8232nBOeDFJMs61c8rDVMFj9UthTcoVgWNI
jxfSvuX1+aFTHrX2Ze5TLjcI2gLA6U9O5kfMlFpd+CrjpqZxY4b39M5ct3LzDWWM
2X2rE1jwat8gX6KOWrGt77X/ebnVSgY1VmIco2Enhy2rF5HODQotUjHpWBzDk4iK
KQLX28q/2wyaAr0gy8bouVOqxIPgo+/do2/k+hYTMcmIcADQqFomQNvVedcU9Xyl
6Cf/U27HK57sPHgiuujpNewP6eHVF4SUxOtYZ10F4rA0x05TyqO77DZx/dy8pCW8
st1QlHBPQRF45oH2TC1KAC1NoyviAmRE6dirL1ItHyYVrgiwOV2NOo+wwIw+8JHr
AvCn4WQpVFB5ECtnhqWr7tanLYJAzhM3gWIThtK3vH2O1WCs1RjXH4UkIHIhDSIS
zBiS1DO5rqQZIby9siFoHakNG0n1aF8L7HFIEA4yyQvtBr73awHh0uN7/pCcO3LW
oSBaKHSw6ndBYTBIkmI/jXPJ0h5UMxcuthNm+1A+42ENOLPUbRHhM5viVwbBGgZ8
sGoAyA2mVtar3WAKWBvx
=4wpC
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
