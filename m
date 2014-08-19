From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v3 5/7] net: cpsw: Add am33xx MACID readout
Date: Tue, 19 Aug 2014 10:50:02 +0200
Message-ID: <20140819085002.GE12930@pengutronix.de>
References: <1408202315-20006-1-git-send-email-mpa@pengutronix.de>
 <1408202315-20006-6-git-send-email-mpa@pengutronix.de>
 <53F244DA.3070803@ti.com>
 <20140818154112.6601cbff@gandalf.local.home>
 <53F25AD1.8040504@ti.com>
 <CABxcv=npv6bRq=VF8RT5trNxUzDj3bAm-PkvDEhcLVJ+uf8hCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VdOwlNaOFKGAtAAV"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44701 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492AbaHSIuV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Aug 2014 04:50:21 -0400
Content-Disposition: inline
In-Reply-To: <CABxcv=npv6bRq=VF8RT5trNxUzDj3bAm-PkvDEhcLVJ+uf8hCg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Mugunthan V N <mugunthanvnm@ti.com>, Steven Rostedt <rostedt@goodmis.org>, "David S. Miller" <davem@davemloft.net>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@the-dreams.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, kernel@pengutronix.de


--VdOwlNaOFKGAtAAV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 19, 2014 at 12:50:59AM +0200, Javier Martinez Canillas wrote:
> Hello Mugunthan,
>=20
> On Mon, Aug 18, 2014 at 9:58 PM, Mugunthan V N <mugunthanvnm@ti.com> wrot=
e:
> >>
> >> Thus, for this patchset, as is:
> >>
> >> Tested-by: Steven Rostedt <rostedt@goodmis.org>
> >
> > This will fail for DRA7xx not in AM33xx
> >
>=20
> cpsw_am33xx_cm_get_macid() checks for
> of_machine_is_compatible("ti,am33xx") and returns 0 if the machine is
> not an am33xx. cpsw_probe_dt() only propagates the return value if is
> not 0 so this patch does not change the semantics for other SoCs
> besides am33xx.

Yes, this patch is only about the am33xx. I don't have the DRA7xx
hardware so I am not able to test on that hardware. Mugunthan, perhaps
you can supply some followup patches for DRA7xx.

Best regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--VdOwlNaOFKGAtAAV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJT8w+5AAoJEEpcgKtcEGQQjCcP/0hoofAuP32DcnajtPwClKLz
mXUDwGG4mysydUB6XV3q/DjEUwRZS5AxpTU15UyHM/vKEX5A4eVP99YhaUh4dQlg
IPGjLNxOYqWg+ZOSIsSYjXV7I8+zf0QaleN3Hq/zKCMQoFJwM2RyWeryGGXFAfEv
O3NApJmWqdQe2TyH70NYm61d/KSGhanMmbdX2dHEtBHpEJ9Vx7Mjc1tNlZfqcbdD
XbD52OhYM0MwDxo30bl33Q/D4MsJrbsfr+3/UPiGUNQiWG93ZTYVjsfsVgfEvM9I
PEGqm4ueHX1bqU9cV8G267egI9UAwvnhN4QRelk26SRdgkYdTYZ49HS8c6HcCamh
g4vM7zFBPJha9V/lZC550+NyyKzLojglREYNVzfmnDJGP+Mki3E/8sYsFPuKl1xY
NKwD+d2oSHrh4wU/0/SeMTaLfGBCJDoyw5k1yd+hVPsaQlbB7hgRrZjSufz7nwSx
m8ZLFCal1wk3VnUSaEHtoPoVKwkaM3+LQq7JzJFuW/nJYmiZu3KJwktQ49mWFijK
R4k/LSYMMeGLd8OaDJUp37vKkY7u0Ivo47QwxCS6lXmLtFxQ1jwp8bV2zwMejEQh
PkfCtCNBgqJMON3Zv1tnOZqKgKIrEjuS4FbojmqWfR2tl12icMWq4hdII67BSB/5
RFvpS5h9vXfvFDxY1q0N
=1F8K
-----END PGP SIGNATURE-----

--VdOwlNaOFKGAtAAV--
