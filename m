From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH] dt-bindings: power: supply: cpcap-battery: Add
 power-supplies property
Date: Thu, 15 Jun 2017 14:54:48 +0200
Message-ID: <20170615125448.mwrk6zpcfdbbvtuo@earth>
References: <20170612072025.30033-1-tony@atomide.com>
 <20170612142217.tg7gidqg63uagwm4@earth>
 <20170612160400.GY3730@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k5jlhrxa5bgsgjhf"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170612160400.GY3730-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>, Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--k5jlhrxa5bgsgjhf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 12, 2017 at 09:04:00AM -0700, Tony Lindgren wrote:
> * Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org> [170612 07:26]:
> > On Mon, Jun 12, 2017 at 12:20:25AM -0700, Tony Lindgren wrote:
> > > +- power-supplies: List of devices that supply power, typically cpcap=
_charger
> >=20
> > This is missing the info, that its about phandles. Maybe:
> >=20
> > - power-supplies: List of phandles for power-supplying devices, as
> >                   described in power_supply.txt. Typically a reference
> >                   to cpcap_charger.
>=20
> Sure, updated patch below.

I queued that one.

-- Sebastian

> 8< ------
> From tony Mon Sep 17 00:00:00 2001
> From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> Date: Mon, 12 Jun 2017 00:13:45 -0700
> Subject: [PATCH] dt-bindings: power: supply: cpcap-battery: Add
>  power-supplies property
>=20
> The binding for cpcap-battery is missing the standard power-supplies
> property as noted by Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org=
>.
>=20
> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Cc: Marcel Partap <mpartap-hi6Y0CQ0nG0@public.gmane.org>
> Cc: Michael Scott <michael.scott-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/power/supply/cpcap-battery.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/cpcap-battery=
=2Etxt b/Documentation/devicetree/bindings/power/supply/cpcap-battery.txt
> --- a/Documentation/devicetree/bindings/power/supply/cpcap-battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/cpcap-battery.txt
> @@ -8,6 +8,9 @@ Required properties:
>  - io-channels: IIO ADC channel specifier for each name in io-channel-nam=
es
>  - io-channel-names: Should contain the following entries:
>  		    "battdetb", "battp", "chg_isense", "batti"
> +- power-supplies: List of phandles for power-supplying devices, as
> +		  described in power_supply.txt. Typically a reference
> +		  to cpcap_charger.
> =20
>  Example:
> =20
> @@ -24,4 +27,5 @@ cpcap_battery: battery {
>  		       &cpcap_adc 5 &cpcap_adc 6>;
>  	io-channel-names =3D "battdetb", "battp",
>  			   "chg_isense", "batti";
> +	power-supplies =3D <&cpcap_charger>;
>  };
> --=20
> 2.13.0
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--k5jlhrxa5bgsgjhf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllCg5gACgkQ2O7X88g7
+pphlw//QAviHbafPaQdODRke0+XDgy2kzwFZJBWX4VsWKCwdpsoTXYzUY4Spfu2
6nrmGwhgkpRLjDS5CBjd49f+ITjklUyio6cdiJ3wtkXnOZN0YQ4S9shNBkFuYJfJ
I5CJblsnI4z+SLLrZHqfPLBaRiKIFIetA1tpGn/8ruCu5akWnO3KLwbf13KPmM5Z
ytluZYHVYFEZsFohHZ9GgGp0hayILU+cWk1tvBSHkmKh8wrHtR7DRl+y1sZwQRMg
OC3E+vWimgPZWlFIXvPEb57n1JbJ1QMS4dOGH8bdHw1D86ri3aPoOK1hAXubGyb1
zbGSnDVhFsa8vcWX93IUVJ5GICNRUZBZAfpwGk7GbtNwNm1Spl04uGiHacioPe6E
Tci+PZcqyoNnatxf2wI+1iqCc+fZRgDfrsdD/71iUZcgdJFJmsh1UDjHkgIhj/Hw
ZqhzFUaIjFwnUl3i8pHQYuPwao3Vea7l7fiw653fqjjSOg9miPPJw6Gjauh3JT9/
CWOAfG/QFQNjwNgF+6R0v2gvwxN28k7Xfjn7b/yO/rnpHx87T8kJ1Qt/4BOAAiZQ
cO6MQ2g2HeuQ4PAsNXILtR+AfWitTrGabxQd5VKVE2ef90AwXPIBRQPRKuo4jkYn
llgJbL7z3betGkDTNfRdQBqmw1YsMQImMSFLz+VVcI8LEDwaeMo=
=ADmv
-----END PGP SIGNATURE-----

--k5jlhrxa5bgsgjhf--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
