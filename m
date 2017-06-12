From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH] dt-bindings: power: supply: cpcap-battery: Add
 power-supplies property
Date: Mon, 12 Jun 2017 16:22:17 +0200
Message-ID: <20170612142217.tg7gidqg63uagwm4@earth>
References: <20170612072025.30033-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oltktef4nxtw3wip"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170612072025.30033-1-tony@atomide.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Marcel Partap <mpartap@gmx.net>, Michael Scott <michael.scott@linaro.org>
List-Id: linux-omap@vger.kernel.org


--oltktef4nxtw3wip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 12, 2017 at 12:20:25AM -0700, Tony Lindgren wrote:
> The binding for cpcap-battery is missing the standard power-supplies
> property as noted by Sebastian Reichel <sebastian.reichel@collabora.co.uk=
>.
>=20
> Cc: devicetree@vger.kernel.org
> Cc: Marcel Partap <mpartap@gmx.net>
> Cc: Michael Scott <michael.scott@linaro.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  Documentation/devicetree/bindings/power/supply/cpcap-battery.txt | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/cpcap-battery=
=2Etxt b/Documentation/devicetree/bindings/power/supply/cpcap-battery.txt
> --- a/Documentation/devicetree/bindings/power/supply/cpcap-battery.txt
> +++ b/Documentation/devicetree/bindings/power/supply/cpcap-battery.txt
> @@ -8,6 +8,7 @@ Required properties:
>  - io-channels: IIO ADC channel specifier for each name in io-channel-nam=
es
>  - io-channel-names: Should contain the following entries:
>  		    "battdetb", "battp", "chg_isense", "batti"
> +- power-supplies: List of devices that supply power, typically cpcap_cha=
rger

This is missing the info, that its about phandles. Maybe:

- power-supplies: List of phandles for power-supplying devices, as
                  described in power_supply.txt. Typically a reference
                  to cpcap_charger.

-- Sebastian

> =20
>  Example:
> =20
> @@ -24,4 +25,5 @@ cpcap_battery: battery {
>  		       &cpcap_adc 5 &cpcap_adc 6>;
>  	io-channel-names =3D "battdetb", "battp",
>  			   "chg_isense", "batti";
> +	power-supplies =3D <&cpcap_charger>;
>  };
> --=20
> 2.13.0

--oltktef4nxtw3wip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlk+o5kACgkQ2O7X88g7
+prqWA/+Lh/fb1Ivoj3suhrc5PAvjq4BKXrie0bkDLcEAhuvA18wOW1YrfAzex5i
aI5rHQ87kQaEwygK9ANrha9C9V93l8UJA6uFKwH3FX0kZ19tUvHXbfVW9Vat8NnJ
wo4ntXjX5pfyXeB1ypy8eR1wLpJH2Y2l08s3mq/cz6NrjK9Rb3PGSSR+apoC2AQa
efsAxjN9SXeX2snQsYENm+Stjhj5D0bbrrnGAXI0xQe7Tz+uCZYAFfxtcmi3GUXY
K3RNheYjBdQjiLp5SFsd1Lh7oA2ysPHS9oLxzVBt9y9yRi9kh2AWuyY9xyy44mfl
JH2WHRrhuBQ27Ja3b0Of8zJgjHFVc6QFSIRj7caOqcsUgehEQ6ukxjm/LSgDxBjK
X/NJV1++wARtaeqVNXfx3usl1ImOdc6hnazS8P1hYNz/Nu5wRHJemObofjBa0P42
s+vjeEfanWiKyx3YkIxxDSwhC5DL4IsoH0yzBTpJsHGhCKEgKDCl8rq78Oj8KF+W
Ul/tdhMj7OhLHOPPKQ87LWQqvzP+i+QhG/5gpc/T8HUqQ9HMfRWMRuST8WQ+B8ca
jOK7VjMc8B52QhumggwweZSDzLEut8Tud5kxvrPeeQB8bgcl9HFmdcIHu8VhzcMz
ox272EKEh6HLpulHTbKInYC69bRnIXy8YmduJHn821EGVfJ+sDo=
=xQHx
-----END PGP SIGNATURE-----

--oltktef4nxtw3wip--
