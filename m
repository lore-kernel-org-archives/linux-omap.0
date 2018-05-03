From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Droid 4: very confusing config around OHCI_OMAP3_HCD
Date: Thu, 3 May 2018 21:38:38 +0200
Message-ID: <20180503193837.GC32572@amd>
References: <20180503192510.GB32572@amd>
 <20180503192838.GY98604@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Izn7cH1Com+I3R9J"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180503192838.GY98604@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--Izn7cH1Com+I3R9J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2018-05-03 12:28:38, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [180503 19:27]:
> > Hi!
> >=20
> > For power management experiments, I tried
> >=20
> > CONFIG_USB_OHCI_HCD=3Dy
> > CONFIG_USB_OHCI_HCD_OMAP3=3Dm
> > CONFIG_USB_OHCI_HCD_PLATFORM=3Dy
> >=20
> > and could not find resulting .ko.
> >=20
> > Help text says:
> >=20
> > CONFIG_USB_OHCI_HCD_OMAP3:
> >=20
> > This option is deprecated now and the driver was removed, use
> > USB_OHCI_HCD_PLATFORM instead.
> >=20
> > Enables support for the on-chip OHCI controller on
> > OMAP3 and later chips.
> >=20
> > Which may partly explain it. But if the option no longer does
> > anything, why keep it? Certainly second part is confusing if option is
> > NOP...
>=20
> Yeah it's ohci-platform now, I think we decided to keep the old one
> around to avoid breaking people's .config files for booting rather
> than silently fail.

Ok, what about this? (Should I do the same for the other drivers?)
Or at least put (DEPRECATED) as other drivers do?

Situation is quite confusing if you already have PLATFORM=3Dy. OMAP=3Dm
can be selected, but nothing happens.

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 5d958da..67c151a 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -455,7 +455,7 @@ config USB_OHCI_HCD_AT91
           Atmel chips.
=20
 config USB_OHCI_HCD_OMAP3
-	tristate "OHCI support for OMAP3 and later chips"
+	tristate "dummy option for backwards compatibility"
 	depends on (ARCH_OMAP3 || ARCH_OMAP4 || SOC_OMAP5)
 	select USB_OHCI_HCD_PLATFORM
 	default y
@@ -463,9 +463,6 @@ config USB_OHCI_HCD_OMAP3
 	  This option is deprecated now and the driver was removed, use
 	  USB_OHCI_HCD_PLATFORM instead.
=20
-	  Enables support for the on-chip OHCI controller on
-	  OMAP3 and later chips.
-
 config USB_OHCI_HCD_DAVINCI
 	tristate "OHCI support for TI DaVinci DA8xx"
 	depends on ARCH_DAVINCI_DA8XX

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Izn7cH1Com+I3R9J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrrZT0ACgkQMOfwapXb+vKVFgCgjcD7UqPIJXhHo4DkK9yy0jPS
Z7YAoKQvccjh+vq1XjV6p5W9TCWsXNn/
=C7fz
-----END PGP SIGNATURE-----

--Izn7cH1Com+I3R9J--
