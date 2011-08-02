From: Felipe Balbi <balbi@ti.com>
Subject: Re: [alsa-devel] [PATCH 1/3] mfd: twl6040: Add initial support
Date: Tue, 2 Aug 2011 15:36:56 +0300
Message-ID: <20110802123655.GG7951@legolas.emea.dhcp.ti.com>
References: <1312284526-1656-1-git-send-email-peter.ujfalusi@ti.com>
 <1643706.AtbiBJoBSQ@barack>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DWg365Y4B18r8evw"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:33317 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754004Ab1HBMg7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Aug 2011 08:36:59 -0400
Received: by mail-fx0-f42.google.com with SMTP id 23so13178558fxe.1
        for <linux-omap@vger.kernel.org>; Tue, 02 Aug 2011 05:36:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1643706.AtbiBJoBSQ@barack>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, "Girdwood, Liam" <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>, "Guiriec, Sebastien" <s-guiriec@ti.com>, "Sebastien@alsa-project.org" <Sebastien@alsa-project.org>, "Lopez Cruz, Misael" <misael.lopez@ti.com>, "Misael@alsa-project.org" <Misael@alsa-project.org>


--DWg365Y4B18r8evw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 02, 2011 at 02:32:48PM +0300, P=E9ter Ujfalusi wrote:
> Oops...
>=20
> On Tuesday 02 August 2011 13:28:41 Ujfalusi, Peter wrote:
> > From: Misael Lopez Cruz <misael.lopez@ti.com>
> >=20
> > TWL6040 IC provides analog high-end audio codec functions for
> > handset applications. It contains several audio analog inputs
> > and outputs as well as vibrator support. It's connected to the
> > host processor via PDM interface for audio data communication.
> > The audio modules are controlled by internal registers that
> > can be accessed by I2C and PDM interface.
> >=20
> > TWL6040 MFD will be registered as a child of TWL-CORE, and will
> > have two children of its own: twl6040-codec and twl6040-vibra.
> >=20
> > This driver is based on TWL4030 and WM8350 MFD drivers.
>=20
> I have sent the patches from wrong directory :(
> Please disregard this series, this has been already merged...

too bad... You have missed my comments :-p

--=20
balbi

--DWg365Y4B18r8evw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJON+9nAAoJEAv8Txj19kN1JgAH/0wmtj9Da79xEEBGWUShp+Dd
ACanrf6muZ6Dgq5f6wD+zf+wQ8rChnUkFopy+XZk7dlM75gU4cd/5uiLjvIMq3Ks
pb1jTXk0IRgvWv39LOL8e8gqbEfhOwbGiwHMIXmdS21xuQspQiaRdPzUcoGigWhQ
SF2NcfrAtY3oxsChSFGgYnIZZAFc9ko+4ZKoZUmIHsCX4gtnDsaqIbKF2ficYBMn
pjK3Evnzac+By74WD9iUmyJpdyO4tpWEy5A9mdDl4YYa0BBh+5+w/SzCezTkDkET
9cIv2ue9i6phyArry8ZzdscI3fTzNp8SzVlBsBkJ3f0M3sKbuTjktJct8t2R6Ko=
=srys
-----END PGP SIGNATURE-----

--DWg365Y4B18r8evw--
