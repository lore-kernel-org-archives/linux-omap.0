From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: omap4-droid4: Configure EHCI so modems can be
 accessed
Date: Sun, 19 Mar 2017 06:31:15 +0100
Message-ID: <20170319053115.yvcoskpnjs7ltd63@earth>
References: <20170315004033.28852-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7q55rerxwd7raeb6"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170315004033.28852-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--7q55rerxwd7raeb6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 14, 2017 at 05:40:33PM -0700, Tony Lindgren wrote:
> Droid 4 has two modems, mdm6600 and w3glte. Both are on the HCI USB
> controller.
>=20
> Let's add a configuration for the HCI so the modems can be enabled.
>=20
> Note that the modems still need GPIO based configuration that can
> be done with the test-d4-echi shell script I've posted to:
>=20
> http://muru.com/linux/d4/test-d4-ehci
>=20
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
> Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Tested-by: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

-- Sebastian

> ---
>  arch/arm/boot/dts/omap4-droid4-xt894.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts=
/omap4-droid4-xt894.dts
> --- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
> +++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
> @@ -71,6 +71,11 @@
>  		regulator-always-on;
>  	};
> =20
> +	/* HS USB Host PHY on PORT 1 */
> +	hsusb1_phy: hsusb1_phy {
> +		compatible =3D "usb-nop-xceiv";
> +	};
> +
>  	/* LCD regulator from sw5 source */
>  	lcd_regulator: regulator-lcd {
>  		compatible =3D "regulator-fixed";
> @@ -475,6 +480,15 @@
>  			       &omap4_pmx_core 0x17c>;
>  };
> =20
> +&usbhsehci {
> +	phys =3D <&hsusb1_phy>;
> +};
> +
> +&usbhshost {
> +	port1-mode =3D "ohci-phy-4pin-dpdm";
> +	port2-mode =3D "ehci-tll";
> +};
> +
>  /* Internal UTMI+ PHY used for OTG, CPCAP ULPI PHY for detection and cha=
rger */
>  &usb_otg_hs {
>  	interface-type =3D <1>;
> --=20
> 2.11.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--7q55rerxwd7raeb6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljOF6EACgkQ2O7X88g7
+pro3Q//cpZKXbsSWHF8q2Ip9C5hzUYICN8osOeUTXo3Nf1SUtvBglT8M2dZwjdb
8ZmQT0bHA3QXbl1e0NFZKVlpKu37ovmcLEzjPv+jxwm2xUJTH9vkfweeGuwDzVCF
hGUorr9lOA48RGKm4SFuuI9IUVHbf/RDqq9aGC/EBAPSZ0w2FYgAJhlyqoEe81Su
5MqTyAJEoqWgqA1alqpz4/8W0o9m4lmqtRc6YeR/3uE8jIWiddBqqOsR7HpMxO4K
9MjxZxYvmD1fSFCXfNIKzPu6YR5UtcgUS8L1Rbfdm+4abgdFxQrha1kWo/fuksMH
+krfgUnHR/3Sw6Vicil7jM15/RnS+6DXpkBxmDEuFXmpcMeGz9uMMTa7KdRntxy6
0AMf3ZjW39II2+XYKmmCf9FpP6m7UmSykukPAYrad9KFHmHmLpduQcjhMr+YfJ/I
5kaA0jYG3v/xiF+aegNGAAtEYddFHXm/I9QtUCs6/bodKHRQJ2ORRBEWJMB+Tade
We4i0uWuNSKe4Q41CKbnWdCDC/PDcYLBlWL5emHQFIlniPtCwkVTgyTNrnyvSeZU
LZCLgNLPO6TDrfJRzSYXWtLiDWsg0eSiXZmIYnX/O09iFWiYMnmk5paXclxMt5hd
CsmkNvmJ1XF5dhb0+0c1dJp9/wbEjbG0Cjlt8Pz0d6fV2lfZ5mo=
=JU39
-----END PGP SIGNATURE-----

--7q55rerxwd7raeb6--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
