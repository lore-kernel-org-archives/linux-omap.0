From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCHv4] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600
 on Droid 4
Date: Thu, 22 Mar 2018 14:55:53 +0100
Message-ID: <20180322135553.GA27648@amd>
References: <20180309023750.108942-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180309023750.108942-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> idle lcd off	phy-mapphone-mdm6600	ohci-platform
> 153mW		284mW			344mW
>=20
> So it seems that MDM6600 is currently not yet idling even with it's
> radio turned off, but that's something that is beyond the control of
> this USB PHY driver. This patch does get us to the point where modem
> data and GPS are usable with libqmi and ModemManager for example.
> Voice calls need more audio driver work.

Ok, let me try. I believe I should see the modem device on lsusb, but
I don't.

user@devuan:/sys/devices/platform/44000000.ocp/4a064000.usbhshost$
sudo lsusb
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
user@devuan:/sys/devices/platform/44000000.ocp/4a064000.usbhshost$
zcat /proc/config.gz | grep MAPPH
CONFIG_PHY_MAPPHONE_MDM6600=3Dy
user@devuan:/sys/devices/platform/44000000.ocp/4a064000.usbhshost$
zcat /proc/config.gz | grep OHCI_
CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy
CONFIG_USB_OHCI_HCD=3Dy
CONFIG_USB_OHCI_HCD_OMAP3=3Dy
CONFIG_USB_OHCI_HCD_PLATFORM=3Dy
user@devuan:/sys/devices/platform/44000000.ocp/4a064000.usbhshost$

As far as I can tell,

+CONFIG_USB_WDM=3Dy
+CONFIG_USB_SERIAL=3Dy
+CONFIG_USB_SERIAL_QUALCOMM=3Dy
+CONFIG_USB_SERIAL_WWAN=3Dy

should be enabled to enable the drivers (and I did that), but without
device showing on the bus...

Any ideas?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqztegACgkQMOfwapXb+vIqfQCfarnENvRNJy/2ZqTZSAKuiD8V
3tEAoIUsdOYhKl1971CiW7Z+SIInnO3T
=/46F
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
