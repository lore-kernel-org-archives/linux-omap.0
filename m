From: Sebastian Reichel <sre@debian.org>
Subject: Re: rx51: "omapfb: no driver for display"
Date: Mon, 28 Mar 2011 23:02:12 +0200
Message-ID: <20110328210212.GB13826@earth.universe>
References: <20110327023901.GB20163@earth.universe>
 <1301292089.2359.21.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comu.ring0.de ([46.4.151.82]:40906 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754077Ab1C1VCP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Mar 2011 17:02:15 -0400
Received: from sre.ring0.de (unknown [93.223.122.45])
	by smtp.ring0.de (Postfix) with ESMTP id D32B82B8016
	for <linux-omap@vger.kernel.org>; Mon, 28 Mar 2011 21:09:53 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1301292089.2359.21.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 28, 2011 at 09:01:29AM +0300, Tomi Valkeinen wrote:
> On Sun, 2011-03-27 at 04:39 +0200, Sebastian Reichel wrote:
> > Hi,
> >=20
> > I've got problems getting a working tty with the mainline 2.6.38
> > kernel on my Nokia N900. Here is the related output from dmesg:
> >=20
> > $ grep -E "(omapdss|omapfb|acx565akm)" dmesg
> > [    0.890899] omapdss CORE: clk ick, rate 83000000
> > [    0.890930] omapdss CORE: clk dss1_fck, rate 96000000
> > [    0.890991] omapdss CORE: clk dss2_fck, rate 19200000
> > [    0.891021] omapdss CORE: clk tv_fck, rate 54000000
> > [    0.891052] omapdss CORE: clk video_fck, rate 96000000
> > [    0.891143] omapdss CORE: initial ctx id 0
> > [    0.950469] omapdss CORE: save context
> > [    0.950714] omapdss CORE: bus_match. dev display0/panel-acx565akm, d=
rv panel-acx565akm
> > [    0.950775] omapdss CORE: driver_probe: dev display0/panel-acx565akm=
, drv panel-acx565akm
> > [    0.950805] omapdss SDI: SDI init
> > [    1.004455] omapdss CORE: save context
> > [    1.059173] omapdss CORE: save context
> > [    1.113830] omapdss CORE: save context
> > [    1.129608] acx565akm spi1.2: omapfb: acx565akm rev 8b LCD detected
> > [    1.130065] omapdss CORE: probe done for device display0
> > [    1.130096] omapdss CORE: bus_match. dev display1/venc, drv panel-ac=
x565akm
> > [    1.303741] OMAPFB: omapfb_init
> > [    1.303894] OMAPFB: omapfb_probe
> > [    1.303924] omapfb omapfb: no driver for display
> > [    1.304016] omapfb omapfb: failed to setup omapfb
> >=20
> > You can find the full dmesg and the full kernel config at [0] and
> > [1]. Can you tell me the reason for the "no driver for display"
> > message? I thought acx565akm has been registered as display driver
> > directly before.
>=20
> You also need VENC driver for the tv-out: CONFIG_OMAP2_DSS_VENC

thanks, that fixes the problem.

> Granted, DSS could handle this case a bit better, by continuing but
> refusing to let the user enable the tv-out...

uhm yes :) But first of all it would help to know which driver is
missing. Perhaps something like "no driver for display1/venc".

-- Sebastian

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJNkPdUAAoJENju1/PIO/qaC2EQAJ9rh3YihuZ861u1HoHUBisn
ohCHy6OKfP1UJQ1hnctcSFMIdw5keOw3+4uhoBuvss7inH4tA6MY7STcVoIisuQg
gSPZTiARF6zryMG8ME04aDT/nZarl4mmmtzITpHs5Vz3eqNhA7XbZnUCT7l9IGpF
TE9cmIk+Q7nxPiPEEJqVOGuKPGahg98UMT8REgl1aHFRaQw13/2MZbCxIAi5P/xV
2ptn0tTVHggj+S35F77+UKEv5btk9bWH/E0WI3dQ92tVVOoKZg/hnqZT9GQTN/Ob
4gwcnMfEQCoZ6GieF0paW4tfp3KW9T0zkLGUdgmKww5PB12CeuLk279C08i1mJuB
3+Wtc1BWjxA/vNFIO4nxD6lZUuKtfh9CRPZ4URe22Qo/h0cBznv/3aRC/vWC+xWB
7R4qQCJks136YMnYyoO0bUhvKoMNvd9hvBlXZ/tHTDztGNDGV1EQjssHN3totgtp
Y4bJKCdUo7aKsJVxTT+oB7vSl/WXyHkowHXRWKvd88RjN548MJrIHqfVakZeFHeA
F5PBaHioRIzt+crxXo1RJ+zoMN5BNMphb/7zA/BxfqDlieAxxpQreOv488rMA3Ew
FwLfDZw4IQFtT+Fman7eNEHukmpYTPyeStLTTX+VQcjKDTvgdPmEWQZPgJzcS18L
OVoNruSYvsw3wlKG9ejo
=j1BM
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
