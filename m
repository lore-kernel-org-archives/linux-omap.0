From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv4] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600
 on Droid 4
Date: Fri, 9 Mar 2018 10:44:17 +0100
Message-ID: <20180309094417.GA5970@amd>
References: <20180309023750.108942-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180309023750.108942-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Let's add support for the GPIO controlled USB PHY on the MDM6600 modem.
> It is used on some Motorola Mapphone series of phones and tablets such
> as Droid 4.
=2E..
> So it seems that MDM6600 is currently not yet idling even with it's
> radio turned off, but that's something that is beyond the control of
> this USB PHY driver. This patch does get us to the point where modem
> data and GPS are usable with libqmi and ModemManager for example.
> Voice calls need more audio driver work.

Thanks for the good work. Looks like I'll need to get droid
4... fortunately it is not available in czech republic so I don't get
excuse to get another toy.

Oh.. no. It is available in Czech republic. Is Motorola Droid 4 XT894
the right one? Hmm, and LTE modem is useless in Europe, while the GSM
one does not work, right?

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqiV3EACgkQMOfwapXb+vJWGgCeMrjB8AWDMCJrtuyMHoVPf082
g+AAnR6pEWfuVoBDuFqtYDwn2yOzK56r
=GM3i
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
