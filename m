From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] Documentation: devicetree: mfd: twl4030-power: Use
 the standard 'ti,system-power-controller' to mark power control
Date: Wed, 3 Sep 2014 21:53:18 +0200
Message-ID: <20140903195317.GA678@earth.universe>
References: <1409771208-21867-1-git-send-email-nm@ti.com>
 <1409771208-21867-2-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1409771208-21867-2-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 03, 2014 at 02:06:47PM -0500, Nishanth Menon wrote:
> ti,system-power-controller is more or less the standard way of
> indicating that the PMIC is the system wide power controller and hence
> may be used to switch off the system. Almost ALL TI PMIC drivers and
> many Maxim PMIC drivers follow the same style.
>=20
> So support 'ti,system-power-controller' in addition to the usual
> 'ti,use_poweroff' to indicate that the PMIC instance has control for
> switching off the system.
>=20
> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> ---
>  .../devicetree/bindings/mfd/twl4030-power.txt      |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/twl4030-power.txt b/Do=
cumentation/devicetree/bindings/mfd/twl4030-power.txt
> index b9ee7b9..e1dff57 100644
> --- a/Documentation/devicetree/bindings/mfd/twl4030-power.txt
> +++ b/Documentation/devicetree/bindings/mfd/twl4030-power.txt
> @@ -23,8 +23,11 @@ down during off-idle. Note that this does not work on =
all boards
>  depending on how the external oscillator is wired.
> =20
>  Optional properties:
> -- ti,use_poweroff: With this flag, the chip will initiates an ACTIVE-to-=
OFF or
> -		   SLEEP-to-OFF transition when the system poweroffs.
> +
> +- ti,system-power-controller OR ti,use_poweroff: This indicates that
> +  TWL4030 is the power supply master of the system. With this flag, the
> +  chip will initiates an ACTIVE-to-OFF or SLEEP-to-OFF transition when
> +  the system poweroffs.

I suggest the following wording:

- ti,system-power-controller: This indicates that TWL4030 is the
  power supply master of the system. With this flag, the chip will
  initiates an ACTIVE-to-OFF or SLEEP-to-OFF transition when the
  system poweroffs.

- ti,use_poweroff: Deprecated name for ti,system-power-controller

-- Sebastian

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUB3GtAAoJENju1/PIO/qaz3MP/0I+AAUY4/f+13Lat1nw8uNX
V9IbOh/x2FjfKx4riW6guCC+wJw1UKoNLKs1F8T0a1ZmlifYW+xQ26Bt5hoaX03T
++/FhOV/LwIHTU0n2JPYBEmFJlJ5/e4+rEVJKFGv7RKxocqekkiiArrIndtNY8rD
zo22iZSBr0AaQdIBhkXM+W0Us3zwInIaOQrmoAj/zlFM4oM6eBua62czl+PK6V5a
1zQGRFIcV1Y19D758PNs10WJAf7rv6ol/u6jg6Kbw0vip3opPjisfpjMdPiNth97
j62Dmi3HcdzF2w8gyZd8H5Xb2LsyAiNUhg+oZs5eZ3Wk1+/ZHEsu+G9T4D9rxa1q
KC49DORkf37D8C7sN85aL9ceIwdURLfEyZnzh9nDnpM+kB+AcWUax18KlUjOOtEF
Wqa5Msoa55kerw6OIVK7ThpQRhzBummccOGNpkeDMSEZSQARpjasMdVhZ+Sh7Qfg
sSLJK8FS+At7kEqC9DFJOcGnaGYSyKF24fXV7geEc1OdrV9j7Mpq6z9nn/9JznUp
YF2X3Dyj5r6iiO9j80xVXcvt7NvOZzG+FEBJ7E95YdguMw6kX9UqV7vRxS/8GbaO
1TAYxpANldA97G5tspfvz3ytj3KHB9zwKu8BVA+56Q85ptU+CLSD/egJGlqtIlmq
sMCeej6hgVMWkVBCidaa
=vA3i
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
