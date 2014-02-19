From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2] ARM/dts: hdmi-codec: panda/es dt entries
Date: Wed, 19 Feb 2014 10:15:24 +0200
Message-ID: <5304681C.4010106@ti.com>
References: <1392716606-7436-1-git-send-email-paolo.pisati@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35173 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122AbaBSIPa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Feb 2014 03:15:30 -0500
In-Reply-To: <1392716606-7436-1-git-send-email-paolo.pisati@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paolo Pisati <paolo.pisati@canonical.com>, bcousson@baylibre.com, tony@atomide.com
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org

Hi,

On 02/18/2014 11:43 AM, Paolo Pisati wrote:
> HDMI codec dummy entries for Panda/ES.
>=20
> Signed-off-by: Paolo Pisati <paolo.pisati@canonical.com>
> ---
> Depends on "0f7f3d1 ASoC: hdmi-codec: Add devicetree binding with doc=
umentation", eligible for a 3.14-rcX fix.
>=20
>  arch/arm/boot/dts/omap4-panda-common.dtsi |    9 ++++++++-
>  arch/arm/boot/dts/omap4-panda-es.dts      |    3 ++-
>  2 files changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boo=
t/dts/omap4-panda-common.dtsi
> index 88c6a05..f4aeaa1 100644
> --- a/arch/arm/boot/dts/omap4-panda-common.dtsi
> +++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
> @@ -36,9 +36,15 @@
>  		};
>  	};
> =20
> +	hdmi_audio: hdmi_audio@0 {
> +		compatible =3D "linux,hdmi-audio";
> +		status =3D "okay";
> +	};
> +
>  	sound: sound {
>  		compatible =3D "ti,abe-twl6040";
>  		ti,model =3D "PandaBoard";
> +		ti,audio-codec =3D <&hdmi_audio>;

I don't think this is going to work. The omap-abe-twl6040 machine drive=
r only
handles mcpdm and dmic right know.
'ti,audio-codec' is not even supported and it is kind of misleading nam=
ing in
this context since twl6040 is also a codec, so why only the dummy-hdmi =
codec
deserves to be called as codec.
=46urthermore: we have the omap-hdmi-card machine driver to handle the =
HDMI
audio. It lacks DT support AFAIK but should not be a big deal to add th=
e bindings.
To get the hdmi audio working you also need to have phandle for the oma=
p-hdmi
DAI, the codec alone is not enough.

Is this patch actually works at all?

> =20
>  		ti,mclk-freq =3D <38400000>;
> =20
> @@ -57,7 +63,8 @@
>  			"HSMIC", "Headset Mic",
>  			"Headset Mic", "Headset Mic Bias",
>  			"AFML", "Line In",
> -			"AFMR", "Line In";
> +			"AFMR", "Line In",
> +			"HDMI Out", "TX";
>  	};
> =20
>  	/* HS USB Port 1 Power */
> diff --git a/arch/arm/boot/dts/omap4-panda-es.dts b/arch/arm/boot/dts=
/omap4-panda-es.dts
> index 816d1c9..70152d6 100644
> --- a/arch/arm/boot/dts/omap4-panda-es.dts
> +++ b/arch/arm/boot/dts/omap4-panda-es.dts
> @@ -23,7 +23,8 @@
>  		"Line Out", "AUXL",
>  		"Line Out", "AUXR",
>  		"AFML", "Line In",
> -		"AFMR", "Line In";
> +		"AFMR", "Line In",
> +		"HDMI Out", "TX";
>  };
> =20
>  /* PandaboardES has external pullups on SCL & SDA */
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
