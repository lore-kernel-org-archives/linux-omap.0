From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv3] power: supply: cpcap-charger: Add minimal CPCAP PMIC
 battery charger
Date: Tue, 11 Apr 2017 17:28:29 +0200
Message-ID: <20170411152829.padtau2mqtn6gxdg@earth>
References: <20170327032513.22890-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="czdz5yzc36xntb76"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170327032513.22890-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--czdz5yzc36xntb76
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Sun, Mar 26, 2017 at 08:25:13PM -0700, Tony Lindgren wrote:
> The custom CPCAP PMIC used on Motorola phones such as Droid 4 has a
> USB battery charger. It can optionally also have a companion chip that
> is used for wireless charging.
>=20
> The charger on CPCAP also can feed VBUS for the USB host mode. This
> can be handled by the existing kernel phy_companion interface.
>=20
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
> Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>=20
> Changes since v2:
>=20
> - Update binding based on comments by Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>=20
> - Drop "motorola,cpcap-charger" compatible for now as this seems specific
>   to the motorola-mapphone
>=20
> - Update Kconfig for "depends on IIO" and "default MFD_CPCAP"
>=20
> Changes since v1:
>=20
> - Fix scaling of IIO values as pointed out by Sebastian Reichel
>   <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>=20
> - Use iio_read_channel_processed() instead of iio_read_channel_scaled()
>   as changed in the v2 of the ADC driver
>=20
> - Add GPL v2 license header
>=20
> ---
>  .../bindings/power/supply/cpcap-charger.txt        |  38 ++
>  drivers/power/supply/Kconfig                       |   8 +
>  drivers/power/supply/Makefile                      |   1 +
>  drivers/power/supply/cpcap-charger.c               | 681 +++++++++++++++=
++++++
>  4 files changed, 728 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/cpcap-=
charger.txt
>  create mode 100644 drivers/power/supply/cpcap-charger.c
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/cpcap-charger=
=2Etxt b/Documentation/devicetree/bindings/power/supply/cpcap-charger.txt
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/cpcap-charger.txt
> @@ -0,0 +1,38 @@
> +Motorola CPCAP PMIC battery charger binding
> +
> +Required properties:
> +- compatible: Shall be "motorola,cpcap-charger" or
> +	      "motorola,mapphone-cpcap-charger"

I queued this with "motorola,cpcap-charger" also dropped from the
binding document.

-- Sebastian

--czdz5yzc36xntb76
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljs9hoACgkQ2O7X88g7
+prncg/+J1uTOD41TSyZrpnSHfcNQ2vXRUxmWRGSPDnN/l0xNOPp/xlKyCSnlV1Y
QoNar6M3IQABCnDbAWPNGOfo9NfKZbQTj36NuFNKaeFhZupa9RsnYROXn/sdsTNj
F/biJpdDmfqlcgOZvJjdhxxvLdRv3wCZFq5VlvC3ftcT1jgZ/IpCMZ6kILU5jfua
MdyszGbWvV3W1L/d72EV5EBzYjsR84wKDJLT+nvuT02mILPSJFPgkQHZllWATv4X
Lsbm1CauCXbULi1mi55bH+Wz8mMfLOPZkjXo7roYnvLGZhuisDIXxZt0plIi8exp
me3VJRZSAoSjUXwr1PlXMdx5890+qsX2o1Nl7W97NTf+bpxR2akQcBtlQuuGHRSl
7mHfrx9GbaJwooW07GAGUzbrNCCvq45B6cwXx+Zs/oQWuWNacaEjAHGydnRUCotv
8Qno8dvvArobPHHkheJCeWDdTNEzv2bG5nv7GtkIA2TfuuVe5RH3GKGIm6r9XCTn
ev05CqqICMzwoAlAscwOG0FjvYoBHWboWh0pET8RaJPyJ0GCB66L46zU4IcSSBQS
xTL5kP/kdtQnQ8GVjk51I0+d+QOw3dknRFVmwVZm95SIH5f0l1XKoFnK8RbfC9iM
wcxefxCBYl9WZ/eBQZA+5njzuWmIQWg2whg7WyDIVHDIahCfMlw=
=/7E8
-----END PGP SIGNATURE-----

--czdz5yzc36xntb76--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
