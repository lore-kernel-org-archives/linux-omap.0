From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: Disable HDMI CEC internal pull-ups
Date: Tue, 27 Jun 2017 11:06:35 +0200
Message-ID: <20170627090635.bgizpseg3k5wnimn@earth>
References: <20170627085832.30949-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4li2qy32yrblxzza"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170627085832.30949-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--4li2qy32yrblxzza
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 27, 2017 at 01:58:32AM -0700, Tony Lindgren wrote:
> Devices using an external encoder, ESD protection and level shifter
> such as tpd12s015 or ip4791cz12 have the CEC pull in the encoder
> chip. And on var-som-om44, there is external pull up resistor R30.
>=20
> So the internal CEC pull-up resistor needs to be disabled as otherwise
> the external and internal pull are parallel making the pull value
> much smaller than intended. This leads into the CEC not working as
> reported by Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>.
>=20
> Reported-by: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
> Cc: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

Reviewed-by: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>

-- Sebastian

> ---
>=20
> Dmitry, care to check that also omap5-cm-t54 has external pull on CEC pin?
>=20
> ---
>  arch/arm/boot/dts/omap4-droid4-xt894.dts         | 2 +-
>  arch/arm/boot/dts/omap4-duovero-parlor.dts       | 2 +-
>  arch/arm/boot/dts/omap4-panda-common.dtsi        | 2 +-
>  arch/arm/boot/dts/omap4-sdp-es23plus.dts         | 2 +-
>  arch/arm/boot/dts/omap4-sdp.dts                  | 2 +-
>  arch/arm/boot/dts/omap4-var-om44customboard.dtsi | 2 +-
>  arch/arm/boot/dts/omap5-board-common.dtsi        | 2 +-
>  arch/arm/boot/dts/omap5-cm-t54.dts               | 2 +-
>  8 files changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts=
/omap4-droid4-xt894.dts
> --- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
> +++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
> @@ -373,7 +373,7 @@
>  	/* hdmi_cec.hdmi_cec, hdmi_scl.hdmi_scl, hdmi_sda.hdmi_sda */
>  	dss_hdmi_pins: pinmux_dss_hdmi_pins {
>  		pinctrl-single,pins =3D <
> -		OMAP4_IOPAD(0x09a, PIN_INPUT_PULLUP | MUX_MODE0)
> +		OMAP4_IOPAD(0x09a, PIN_INPUT | MUX_MODE0)
>  		OMAP4_IOPAD(0x09c, PIN_INPUT | MUX_MODE0)
>  		OMAP4_IOPAD(0x09e, PIN_INPUT | MUX_MODE0)
>  		>;
> diff --git a/arch/arm/boot/dts/omap4-duovero-parlor.dts b/arch/arm/boot/d=
ts/omap4-duovero-parlor.dts
> --- a/arch/arm/boot/dts/omap4-duovero-parlor.dts
> +++ b/arch/arm/boot/dts/omap4-duovero-parlor.dts
> @@ -100,7 +100,7 @@
>  	dss_hdmi_pins: pinmux_dss_hdmi_pins {
>  		pinctrl-single,pins =3D <
>  			OMAP4_IOPAD(0x098, PIN_INPUT | MUX_MODE3)		/* hdmi_hpd.gpio_63 */
> -			OMAP4_IOPAD(0x09a, PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_cec.hdmi_cec=
 */
> +			OMAP4_IOPAD(0x09a, PIN_INPUT | MUX_MODE0)		/* hdmi_cec.hdmi_cec */
>  			OMAP4_IOPAD(0x09c, PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_ddc_scl.hdmi=
_ddc_scl */
>  			OMAP4_IOPAD(0x09e, PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_ddc_sda.hdmi=
_ddc_sda */
>  		>;
> diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dt=
s/omap4-panda-common.dtsi
> --- a/arch/arm/boot/dts/omap4-panda-common.dtsi
> +++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
> @@ -267,7 +267,7 @@
> =20
>  	dss_hdmi_pins: pinmux_dss_hdmi_pins {
>  		pinctrl-single,pins =3D <
> -			OMAP4_IOPAD(0x09a, PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_cec.hdmi_cec=
 */
> +			OMAP4_IOPAD(0x09a, PIN_INPUT | MUX_MODE0)		/* hdmi_cec.hdmi_cec */
>  			OMAP4_IOPAD(0x09c, PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_scl.hdmi_scl=
 */
>  			OMAP4_IOPAD(0x09e, PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_sda.hdmi_sda=
 */
>  		>;
> diff --git a/arch/arm/boot/dts/omap4-sdp-es23plus.dts b/arch/arm/boot/dts=
/omap4-sdp-es23plus.dts
> --- a/arch/arm/boot/dts/omap4-sdp-es23plus.dts
> +++ b/arch/arm/boot/dts/omap4-sdp-es23plus.dts
> @@ -10,7 +10,7 @@
>  /* SDP boards with 4430 ES2.3+ or 4460 have external pullups on SCL & SD=
A */
>  &dss_hdmi_pins {
>  	pinctrl-single,pins =3D <
> -		OMAP4_IOPAD(0x09a, PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_cec.hdmi_cec =
*/
> +		OMAP4_IOPAD(0x09a, PIN_INPUT | MUX_MODE0)		/* hdmi_cec.hdmi_cec */
>  		OMAP4_IOPAD(0x09c, PIN_INPUT | MUX_MODE0)		/* hdmi_scl.hdmi_scl */
>  		OMAP4_IOPAD(0x09e, PIN_INPUT | MUX_MODE0)		/* hdmi_sda.hdmi_sda */
>  		>;
> diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sd=
p.dts
> --- a/arch/arm/boot/dts/omap4-sdp.dts
> +++ b/arch/arm/boot/dts/omap4-sdp.dts
> @@ -290,7 +290,7 @@
> =20
>  	dss_hdmi_pins: pinmux_dss_hdmi_pins {
>  		pinctrl-single,pins =3D <
> -			OMAP4_IOPAD(0x09a, PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_cec.hdmi_cec=
 */
> +			OMAP4_IOPAD(0x09a, PIN_INPUT | MUX_MODE0)		/* hdmi_cec.hdmi_cec */
>  			OMAP4_IOPAD(0x09c, PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_scl.hdmi_scl=
 */
>  			OMAP4_IOPAD(0x09e, PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_sda.hdmi_sda=
 */
>  		>;
> diff --git a/arch/arm/boot/dts/omap4-var-om44customboard.dtsi b/arch/arm/=
boot/dts/omap4-var-om44customboard.dtsi
> --- a/arch/arm/boot/dts/omap4-var-om44customboard.dtsi
> +++ b/arch/arm/boot/dts/omap4-var-om44customboard.dtsi
> @@ -122,7 +122,7 @@
> =20
>  	dss_hdmi_pins: pinmux_dss_hdmi_pins {
>  		pinctrl-single,pins =3D <
> -			OMAP4_IOPAD(0x09a, PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_cec.hdmi_cec=
 */
> +			OMAP4_IOPAD(0x09a, PIN_INPUT | MUX_MODE0)		/* hdmi_cec.hdmi_cec */
>  			OMAP4_IOPAD(0x09c, PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_scl.hdmi_scl=
 */
>  			OMAP4_IOPAD(0x09e, PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_sda.hdmi_sda=
 */
>  		>;
> diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dt=
s/omap5-board-common.dtsi
> --- a/arch/arm/boot/dts/omap5-board-common.dtsi
> +++ b/arch/arm/boot/dts/omap5-board-common.dtsi
> @@ -294,7 +294,7 @@
> =20
>  	dss_hdmi_pins: pinmux_dss_hdmi_pins {
>  		pinctrl-single,pins =3D <
> -			OMAP5_IOPAD(0x13c, PIN_INPUT_PULLUP | MUX_MODE0)	/* hdmi_cec.hdmi_cec=
 */
> +			OMAP5_IOPAD(0x13c, PIN_INPUT | MUX_MODE0)	/* hdmi_cec.hdmi_cec */
>  			OMAP5_IOPAD(0x140, PIN_INPUT | MUX_MODE0)	/* hdmi_ddc_scl.hdmi_ddc_sc=
l */
>  			OMAP5_IOPAD(0x142, PIN_INPUT | MUX_MODE0)	/* hdmi_ddc_sda.hdmi_ddc_sd=
a */
>  		>;
> diff --git a/arch/arm/boot/dts/omap5-cm-t54.dts b/arch/arm/boot/dts/omap5=
-cm-t54.dts
> --- a/arch/arm/boot/dts/omap5-cm-t54.dts
> +++ b/arch/arm/boot/dts/omap5-cm-t54.dts
> @@ -266,7 +266,7 @@
> =20
>  	dss_hdmi_pins: pinmux_dss_hdmi_pins {
>  		pinctrl-single,pins =3D <
> -			OMAP5_IOPAD(0x013c, PIN_INPUT_PULLUP | MUX_MODE0) /* hdmi_cec */
> +			OMAP5_IOPAD(0x013c, PIN_INPUT | MUX_MODE0) /* hdmi_cec */
>  			OMAP5_IOPAD(0x0140, PIN_INPUT | MUX_MODE0) /* hdmi_ddc_scl */
>  			OMAP5_IOPAD(0x0142, PIN_INPUT | MUX_MODE0) /* hdmi_ddc_sda */
>  		>;
> --=20
> 2.13.0
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--4li2qy32yrblxzza
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllSIBgACgkQ2O7X88g7
+ppB/w/+J/GqEuBSwsoY9LM8HPsWxx8hN0OTcVQy2WTyfuMHCXxhTCO8iJ6KoBIc
cEeQbDsukw4flvdb4eilHq6E1Bhv5MEKpgb1uYu1LWm9pP2C6MaUvEyUcG48NqLj
hwy9OVl79zQ1Ecg6glgqxpRMS5vwvt+5g7el2MZ48Lns5SbyOk6k+OMS0K4W9Dpi
1N90yVXSu8UWf7W56SqGm6qjPy9bfILswTnavdGn4+DNuORhrb1G+ACAAwtptPzp
CU6B0IixsBI6qiWoudzk9zIzF6Cuw/dndIGgfxMXGv3NGTy9wne7BjXlgDTjEL/D
lcdfgeHrWK1b37lgNbYM6G4ou1B1rW+qgQMWsHll7RvlwLdaIAKJw3rlM+ceAPhV
MBrTQnnipQxCfCHybrTDILgcR/gvN17e5YLkjjxHmWmPyltCVxRsQpAKLB/k+H1N
cBDvggjtwVWo6sMc60BlwzfymIlE6D+bZFW9zAuw7M1su3cGH+zzZNpaYUpGcRaW
QnJscI1ZG0pV7bVDQyeU3wr1n+oWteewYUIDbW+YZHPwsO8CvuI1uE1rJIeQMc+0
3eizW4VlhzEUXv/BKDJnAPhs4HK+RrALR1DhHP3AU59I7byjAIzeUGscyoSNT3e0
nFSPJ27rjLCOfYrchtUOqJW80opaHnluTYZO2qB0Aas7xtYAVdE=
=UG6S
-----END PGP SIGNATURE-----

--4li2qy32yrblxzza--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
