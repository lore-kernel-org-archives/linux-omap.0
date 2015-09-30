From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH 11/11] arm: boot: dts: omap: add missing default
 status for 32k counter
Date: Wed, 30 Sep 2015 09:12:09 -0500
Message-ID: <20150930141209.GB31865@saruman.tx.rr.com>
References: <1443559446-26969-1-git-send-email-balbi@ti.com>
 <1443559446-26969-12-git-send-email-balbi@ti.com>
 <4815825.NCBBBMgLGf@wuerfel>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4815825.NCBBBMgLGf@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, daniel.lezcano@linaro.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, tglx@linutronix.de, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2015 at 10:15:25AM +0200, Arnd Bergmann wrote:
> On Tuesday 29 September 2015 15:44:06 Felipe Balbi wrote:
> > All devices should have a default status. Ignoring
> > the arguments if it should be 'okay' or 'disabled'
> > by default, let's set them all the 'disabled' and
> > have boards enable 32k counter.
> >=20
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> >=20
>=20
> The patch looks good, but the description is slightly incorrect:
> There is no reason to list "status=3D'okay'" other than overriding
> the 'disabled' status.
>=20
> I'd phrase it something like:
>=20
> "We want the use of the 32k counter to be a per-board setting,
> so let's disable it by default in each dtsi file and override the
> setting in the boards. Any board that does not wire up the counter
> should leave it disabled".
>=20
> However, if you really want all boards to provide the counter all
> the time, I'd argue that we're better off dropping this patch. We
> use the status=3D"disabled" trick for anything that may or may not
> be working based on the board design, but things that are present
> everywhere don't need this.

okay, so here's the thing. While fiddling with the 32k counter, I noticed
that even though there was no status listed, the thing still initializes
fine. However, when moving 32k to drivers/clocksource and using
CLOCKSOURCE_OF_DECLARE(), 32k would *NOT* probe unless I had an explicit
status =3D "okay" in DT.

This is where this patch came from. I've used disabled by default
because we just might have a board somewhere which doesn't want to use 32k
counter and having it enabled per-board would help with that. Although,
we could just set status =3D "disabled" for that one board.

Whatever Tony prefers, I can change the patch accordingly.

--=20
balbi

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIbBAEBAgAGBQJWC+25AAoJEIaOsuA1yqRE/FIP9ivTJ+OJubWwBuxio2Wv2YxS
tDIy/eCmeWX1EbKdvxRyPGPXgdrPWBRw07YgQKf1AycoDlKIj90CpntIu2yC4bYP
zGyOVjq8g8dGn45N1rNFl4jGfvISniH8c50aZdwny+nzmV913f6rBjgz/oBflZRf
egYbqTIwUkPCFOAMpXx6oQeBXjcUoT3sNNqivU+1kOv+dG/A+IzZ2VMCVEFSiOYS
SgV7urhPD4IjImphwPH9+MjwyLiWhV2/Cc1hWo5eaTAMpYVOhhQtlFbPOifDehUw
QGSNlRC9H33WWuxCOX3c5RkgVd9KPG6/pxYImT1LUInwS3AINGyu2njQHg0KWHei
YEWljSHuNrBVvRA6TsYAhHnX+gejLAvd5WdWXNSllM4uLVrgeWX12TmldY5al8vQ
PagZeeh0IjRJAOyosiv/iAQEtfltdFT4KVuvy/eoKTceALqaVnNVMMsQXRduf4UP
JtC7Glu6/GlzQTQ8l1womP5adC3SnjwyfuvNHRm10nEecLRUjAiK7qsLTXVlrVcO
9hvUOeP7vgx4Zbon1e5wC9PwNVVw45YSRNrYoQ1sNbVMUOoTY0C26RmuwUyLAO1F
0TT8BQ3Hcj6wCSN9GRl7wdcyIj/xqndvv67aZfroJU9zH1DSf6A3t504VuULBp+7
tLfRVeiqMCKM+DCO+dE=
=ji3+
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--
