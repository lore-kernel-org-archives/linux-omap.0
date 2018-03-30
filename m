From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: 4.16-rc5 on Motorola Droid 4
Date: Fri, 30 Mar 2018 14:19:59 +0200
Message-ID: <20180330121959.uxx6kcl7v5w777vq@earth.universe>
References: <20180318220418.GA22880@amd>
 <20180320140322.GU5799@atomide.com>
 <20180320170029.rv3u5wlvqxfl7z2v@earth.universe>
 <20180327212156.GA10834@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t36mcocinwj2f7cz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180327212156.GA10834@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Tony Lindgren <tony@atomide.com>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, nekit1000@gmail.com, mpartap@gmx.net
List-Id: linux-omap@vger.kernel.org


--t36mcocinwj2f7cz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Mar 27, 2018 at 11:21:56PM +0200, Pavel Machek wrote:
> Also, if you know how to get information from light sensor, that would
> be nice.

You need CONFIG_SENSORS_ISL29028. Once the driver is probed:

$ cat /sys/bus/iio/devices/iio\:device1/name
isl29030
$ cat /sys/bus/iio/devices/iio\:device1/in_illuminance_input
19

-- Sebastian

--t36mcocinwj2f7cz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlq+K2sACgkQ2O7X88g7
+ppnWw//cKUGh0xfm8MD93Qp6pmtl+Ewm7kJi2bZjYomXG3GNzeP0xKQeUFhNqhI
Mm/O7jLHDlh5GLjAmeWg6lWEEkkOJgM8ule2gUuE5ZaOLlvjaQ73E9Tk6YKyUbhB
n7hv+DLXeJuS/hQUs+5AsHHsWwl+gUIr2RiS0HvpQzyMUPFyhZFTtNL2UslVH7C+
r8CcZ58ugFUGzA8nwRbfePJTAbAKNqhNOqGCJR6WRpA3KuU4l73ByBOggqRV3yQC
uz/5/WJA1nkMYksIZuIiwCGbkrherxPnR/xT8IQbQ+zUJCFP5MlhKWn0RVueb9la
s+MRDdzuXY/U5xpNRb0FECR7IHMVW45s5zeI8qzwIgVhj9btN1DMXJv8LS0sCiXv
soqxFwZVYL8cuxkrnJ9yG4w2J4/flch269uWVJPuPVAPzZ/a4LUK18P6NJU8Apwt
x5b2BFOj8BlnjFgQtI0zcqTkqpyc283ioLYQl9sO06u+rQRX0aprsFRcmO1UIeFe
fWvOUqzuOF8Xo1ioC0wdfhR0V9jaSeAfWIMj43arndCZttb8/TnIk2GjSKfq4M2n
mvRpvxbuMIFK2UOKcT4IpmOGUjkst5eeiyx7ZBqZ6hv1ErSVLXRFtjo3q3fD0dPZ
ZCEi4f0fzDX+fOnD90urBjJdG4K9Gup6diOvYWJRF0WWiT7wDLY=
=ebH4
-----END PGP SIGNATURE-----

--t36mcocinwj2f7cz--
