From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] phy: cpcap-usb: Add CPCAP PMIC USB support
Date: Wed, 22 Mar 2017 03:18:28 +0100
Message-ID: <20170322021828.wkbx3es6dpuur42y@earth>
References: <20170317035152.18307-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ezlydcbo2exgsuvj"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170317035152.18307-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org


--ezlydcbo2exgsuvj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 16, 2017 at 08:51:52PM -0700, Tony Lindgren wrote:
> Some Motorola phones like droid 4 use a custom CPCAP PMIC that has a
> multiplexing USB PHY.
>=20
> This USB PHY can operate at least in four modes using pin multiplexing
> and two control GPIOS:
>=20
> - Pass through companion PHY for the SoC USB PHY
> - ULPI PHY for the SoC
> - Pass through USB for the modem
> - UART debug console for the SoC
>=20
> This patch adds support for droid 4 USB PHY and debug UART modes,
> support for other modes can be added later on as needed.
>=20
> Both peripheral and host mode are working for the USB. The
> host mode depends on the cpcap-charger driver for VBUS.
>=20
> VBUS and ID pin detection are done using cpcap-adc IIO ADC
> driver.

I tested UART, USB slave (cdc-ether) & USB host (keyboard & touchpad
=66rom Atrix lapdock) mode with Droid 4:

Tested-by: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--ezlydcbo2exgsuvj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljR3vQACgkQ2O7X88g7
+pqwhg//fJuU3z7wwyS3xM1i/mxLBJ4l1//VNp4yuvd2Suvk7fbA1htPYHnjWEXF
U4bjhbf2+D7E6bdMGbxK3Zi7Z7JfMQQRpnXE60Kep4SCKUfFKdwyRqBxBV712PUm
d7YwNDa/dol6t2NEswyrFGtOEf+hyRlUEt1VW8nO9ItP3jn311BOyDvU5tW/I7sd
+usAdLDlJ5vdiaOhx/V8joagWlFKqYiyYIH60IsMqMZGYXhj/exAjlYqO0/5X66f
wpi8EVn9a0/9cGizEKCKlhFy3ApfXsW5gyuo6aQ1Lv3lms8/e/HrN3W+3Yo6HZy4
NAHu/7OH6zrm684FvSZzQeA54f7r/9RCf5EhKKr5Zo+P8eK+n68AbOwtdQb/Sa3q
BMigUTL4QEVFKVVLnZHO7sHZqkhuHhrWT2xrWUeMSmQy9Dwi8mvXyBci47qenToM
EmohTHfgQqmrjdaPV7/3lFfkicmjsRxGfjDnoo8zj6SLBeUo3H4PZLLE0cQWhGAY
JxJeNxLdFv3N0Fq0x7GfGvKw3bSyB3ynMrhEiJ9juP3Xr03YCVF9GoRFaLbQLQH2
Q1kR7wiR8dHSfkTRhLzi7Hyu8EMo04E/tZTS9Rfn2dF3vNJwbv2OswDTdbO31jC+
QsTnnx0Tg0V43+DaBeTN2r8+C9pe+0NKIsl8C5yCATTXZ8MXAYY=
=uc5J
-----END PGP SIGNATURE-----

--ezlydcbo2exgsuvj--
