From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 14/19] ARM: omap4-panda-common.dtsi: Add HDMI audio nodes
Date: Fri, 16 May 2014 14:04:44 +0300
Message-ID: <5375F0CC.8090507@ti.com>
References: <cover.1399884780.git.jsarha@ti.com> <fdeddff24bc38efb7a155b2569a5f2056278cb9d.1399884780.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="vH7OmrmH9sb6mSlninSFhRFnhvxxcqleP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:55007 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757159AbaEPLEx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 May 2014 07:04:53 -0400
In-Reply-To: <fdeddff24bc38efb7a155b2569a5f2056278cb9d.1399884780.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, detheridge@ti.com

--vH7OmrmH9sb6mSlninSFhRFnhvxxcqleP
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/05/14 12:12, Jyri Sarha wrote:
> Adds a simple-card sound node for HDMI audio, the associated
> hdmi-codec node, and sound-dai-cells propeties to the DAI nodes.
>=20
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  arch/arm/boot/dts/omap4-panda-common.dtsi |   21 ++++++++++++++++++++-=

>  1 file changed, 20 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/=
dts/omap4-panda-common.dtsi
> index d2c45bf..c04f453 100644
> --- a/arch/arm/boot/dts/omap4-panda-common.dtsi
> +++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
> @@ -41,7 +41,7 @@
>  		};
>  	};
> =20
> -	sound: sound {
> +	sound: sound@0 {
>  		compatible =3D "ti,abe-twl6040";
>  		ti,model =3D "PandaBoard";
> =20
> @@ -65,6 +65,24 @@
>  			"AFMR", "Line In";
>  	};
> =20
> +	sound@1 {
> +		compatible =3D "simple-audio-card";
> +
> +		simple-audio-card,cpu {
> +			sound-dai =3D <&hdmi>;
> +		};
> +
> +		simple-audio-card,codec {
> +			sound-dai =3D <&hdmi_audio>;
> +		};
> +	};
> +
> +	hdmi_audio: hdmi_audio@0 {
> +		#sound-dai-cells =3D <0>;
> +		compatible =3D "linux,hdmi-audio";
> +		status =3D "okay";
> +	};
> +
>  	/* HS USB Port 1 Power */
>  	hsusb1_power: hsusb1_power_reg {
>  		compatible =3D "regulator-fixed";
> @@ -512,6 +530,7 @@
>  };
> =20
>  &hdmi {
> +	#sound-dai-cells =3D <0>;
>  	status =3D "ok";
>  	vdda-supply =3D <&vdac>;

Maybe this is how this has to be done, but I'll still ask:

Considering that the HDMI audio is basically inseparable part of the
OMAP HDMI video, and if a board has HDMI video connector connected to
the SoC's HDMI, then it has HDMI audio.

So all of the above .dts changes are already implied when we have HDMI
video on the board. Is there no way to prevent every board needing to
add those exact same nodes to get HDMI audio?

 Tomi



--vH7OmrmH9sb6mSlninSFhRFnhvxxcqleP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTdfDMAAoJEPo9qoy8lh71OaEQAJNPn7bip3/xcJ22p5KeRPFp
dbvGg5IUkHxMqTSVxushi7A+J64aL3U5xp63GPZdgrJEGi4KWLHotFyL6r+KhAMi
y7yH+iQrdNIyfRXVAt7UCiZN+F0th5t8tekBcdG3D0S7y4qihUWbfVe9aIfKqAG4
sEeV3fOHRaQkvKbIdRhruEGzYvlGRRGkwbWp0JE+CSVl706jxuawZ/iUutQbU99z
BPIZTcA0QREvw+GCsnwQ1q11CpUBsw9HGFVjDSmErcmbyYjn3WPI1p4lldmWkXVB
yyQ9XAU55XEJIHJ/UfhKkc2SuG6u6IUU1lcJyO4BUd3DwrraHXtxu/z2hdHSRFeV
F4yVCKhTcLtmJ1WFupHxfR3qHQDp/f2KFXuEmtZ4h5AEMAIx2nCJPf9y/HJUFeBm
XU+UpOpXeTOgzh9SV+Li0HVBG03htAhMLy+EiIvDkyF5Gu1lZ4tZQeK3WBSimoCq
1kVuhFI6cJW9kXb43vBXo/hz2w9DUYGhHklL7MGyIHNF7OMzQZQ2o6MiHdHB0yaP
TZYYGliCAn6zqJVTGTorJpRbTo0o5f4YJA0BrTXxabhQ4DnzZG0l5hPwtcCQv7I+
YJQvM58RAE2/xzI5yD6AYb9fFalrF+qTCDBTImhJHoH4UAT98ivI1OU8cZcd7GZW
x81GhrDPHjJs2lGvRLi8
=TaTc
-----END PGP SIGNATURE-----

--vH7OmrmH9sb6mSlninSFhRFnhvxxcqleP--
