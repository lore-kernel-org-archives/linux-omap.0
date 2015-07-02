From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: DTS: am437x-sk-evm: Switch using
 simple-audio-card for audio support
Date: Thu, 2 Jul 2015 07:23:38 -0500
Message-ID: <20150702122337.GE5837@saruman.tx.rr.com>
References: <1435838286-30491-1-git-send-email-peter.ujfalusi@ti.com>
 <1435838286-30491-3-git-send-email-peter.ujfalusi@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qOrJKOH36bD5yhNe"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1435838286-30491-3-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--qOrJKOH36bD5yhNe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 02, 2015 at 02:58:06PM +0300, Peter Ujfalusi wrote:
> The sound support consist only Headset output on the board and can be
> handled by "simple-audio-card"
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>

Still works fine:

Tested-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

one question though, should Line In be listed below ? Also, unrelated to
$subject, but if I wait for a few seconds between runs of speaker-test
(iow, if I allow mcasp to idle) then I hear a slight chopping sound when
starting, perhaps we're unmuting too early ?

> ---
>  arch/arm/boot/dts/am437x-sk-evm.dts | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am43=
7x-sk-evm.dts
> index b5de6b0d622c..e09216cb14df 100644
> --- a/arch/arm/boot/dts/am437x-sk-evm.dts
> +++ b/arch/arm/boot/dts/am437x-sk-evm.dts
> @@ -32,14 +32,26 @@
>  	};
> =20
>  	sound {
> -		compatible =3D "ti,da830-evm-audio";
> -		ti,model =3D "AM437x-SK-EVM";
> -		ti,audio-codec =3D <&tlv320aic3106>;
> -		ti,mcasp-controller =3D <&mcasp1>;
> -		ti,codec-clock-rate =3D <24000000>;
> -		ti,audio-routing =3D
> -			"Headphone Jack",       "HPLOUT",
> -			"Headphone Jack",       "HPROUT";
> +		compatible =3D "simple-audio-card";
> +		simple-audio-card,name =3D "AM437x-SK-EVM";
> +		simple-audio-card,widgets =3D
> +			"Headphone", "Headphone Jack";
> +		simple-audio-card,routing =3D
> +			"Headphone Jack",	"HPLOUT",
> +			"Headphone Jack",	"HPROUT";
> +		simple-audio-card,format =3D "dsp_b";
> +		simple-audio-card,bitclock-master =3D <&sound_master>;
> +		simple-audio-card,frame-master =3D <&sound_master>;
> +		simple-audio-card,bitclock-inversion;
> +
> +		simple-audio-card,cpu {
> +			sound-dai =3D <&mcasp1>;
> +		};
> +
> +		sound_master: simple-audio-card,codec {
> +			sound-dai =3D <&tlv320aic3106>;
> +			system-clock-frequency =3D <24000000>;
> +		};
>  	};
> =20
>  	matrix_keypad: matrix_keypad@0 {
> @@ -489,6 +501,7 @@
>  	};
> =20
>  	tlv320aic3106: tlv320aic3106@1b {
> +		#sound-dai-cells =3D <0>;
>  		compatible =3D "ti,tlv320aic3106";
>  		reg =3D <0x1b>;
>  		status =3D "okay";
> @@ -649,6 +662,7 @@
>  };
> =20
>  &mcasp1 {
> +	#sound-dai-cells =3D <0>;
>  	pinctrl-names =3D "default", "sleep";
>  	pinctrl-0 =3D <&mcasp1_pins>;
>  	pinctrl-1 =3D <&mcasp1_pins_sleep>;
> --=20
> 2.4.5
>=20

--=20
balbi

--qOrJKOH36bD5yhNe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVlS1JAAoJEIaOsuA1yqRE+b4P/1FfT9x7F+vcJL77enYsAYwg
8XP46FtjkGk5FZc+FIaOIIkOCdssgfjGPagjFa38Ilr8noSU6GOChIVaQVdumCgs
dUAM4YpZZMmZ4OHP22Ok+fGjKCZaS5EbSV6bzIKn4gSwp6uK0aY/gUqNFH04pD5W
ysC0JwYbj5oQ7grRn6nHFzYbrR2s8btS3XX3vR71tipiqcVJDncIydioe0U7wCf/
8YOlZ8L5/p1AzaP9ewQk/u3IowiHg6ZzAT1IMPL6T4cQXOZeZ6XexFrMbs5+iLFs
5xnNKS/2mgafNphQ8dz/ul2btOEOxmxSxqguMGM0ioM6F90EswlwNvgtARCktx4L
rl4eV4KFKm45xAyBwqQbqANwXxuMhz95/XNnBma53u1zKbBjOCIzDip2jVSmAwnN
xO+HR/aJ4aXcI830OZ4TT0MMHBELZV1uxT3qNG7eEuufJNSCa88GRoQZ5cC0Gmgm
VDCyhlJKjkr2Bc3ic08XT5tGHc6qeUpywX3HOt8i99JdG39NuF/Ul/8x0lwa1XaP
BoOMKRgO47eVrKfLpkgY1xD+OE0OEsK5nnqx44ZqSwKCpCLtHGOJATCCPntbaILX
ZX/n4jF8g5kKFdNQbMILh7Fz0J2E4qjnYAG4YuOqxVndLXilaVWGAPVagtmKYkoJ
6iaSQvSO56sAI6qjapLV
=JQZQ
-----END PGP SIGNATURE-----

--qOrJKOH36bD5yhNe--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
