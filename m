From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2] ARM/dts: hdmi-codec: panda/es dt entries
Date: Wed, 19 Feb 2014 14:13:34 +0200
Message-ID: <53049FEE.9070506@ti.com>
References: <1392716606-7436-1-git-send-email-paolo.pisati@canonical.com> <5304681C.4010106@ti.com> <20140219105434.GA5738@luxor.wired.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42896 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751606AbaBSMNl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Feb 2014 07:13:41 -0500
In-Reply-To: <20140219105434.GA5738@luxor.wired.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paolo Pisati <p.pisati@gmail.com>
Cc: Paolo Pisati <paolo.pisati@canonical.com>, bcousson@baylibre.com, tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, "Valkeinen, Tomi" <tomi.valkeinen@ti.com>, "Sarha, Jyri" <jsarha@ti.com>

On 02/19/2014 12:54 PM, Paolo Pisati wrote:
> On Wed, Feb 19, 2014 at 10:15:24AM +0200, Peter Ujfalusi wrote:
>>> diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/b=
oot/dts/omap4-panda-common.dtsi
>>> index 88c6a05..f4aeaa1 100644
>>> --- a/arch/arm/boot/dts/omap4-panda-common.dtsi
>>> +++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
>>> @@ -36,9 +36,15 @@
>>>  		};
>>>  	};
>>> =20
>>> +	hdmi_audio: hdmi_audio@0 {
>>> +		compatible =3D "linux,hdmi-audio";
>>> +		status =3D "okay";
>>> +	};
>>> +
>>>  	sound: sound {
>>>  		compatible =3D "ti,abe-twl6040";
>>>  		ti,model =3D "PandaBoard";
>>> +		ti,audio-codec =3D <&hdmi_audio>;
>>
>> I don't think this is going to work. The omap-abe-twl6040 machine dr=
iver only
>> handles mcpdm and dmic right know.
>> 'ti,audio-codec' is not even supported and it is kind of misleading =
naming in
>> this context since twl6040 is also a codec, so why only the dummy-hd=
mi codec
>> deserves to be called as codec.
>=20
> i see what you mean: i thought that hdmi_audio to actually work had t=
o be
> referenced inside the sound node (hence my inclusion there) but i was=
 wrong and
> it had nothing to do with twl6040,
> would this one be ok for you?
>=20
> diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boo=
t/dts/omap4-panda-common.dtsi
> index 88c6a05..b6dd458 100644
> --- a/arch/arm/boot/dts/omap4-panda-common.dtsi
> +++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
> @@ -36,6 +36,11 @@
>                 };
>         };
> =20
> +       hdmi_audio: hdmi_audio@0 {
> +               compatible =3D "linux,hdmi-audio";
> +               status =3D "okay";
> +       };
> +
>         sound: sound {
>                 compatible =3D "ti,abe-twl6040";
>                 ti,model =3D "PandaBoard";
>=20
>=20
>> Furthermore: we have the omap-hdmi-card machine driver to handle the=
 HDMI
>> audio. It lacks DT support AFAIK but should not be a big deal to add=
 the bindings.
>> To get the hdmi audio working you also need to have phandle for the =
omap-hdmi
>> DAI, the codec alone is not enough.
>>
> =20
> you mean sound/soc/omap/omap-hdmi-card.c? that's exactly what i'm try=
ing to fix.
>=20
> With the above patch, plus:
>=20
> -CONFIG_DISPLAY_CONNECTOR_HDMI=3Dm
> +CONFIG_DISPLAY_CONNECTOR_HDMI=3Dy
>  CONFIG_DISPLAY_ENCODER_TFP410=3Dm
> -CONFIG_DISPLAY_ENCODER_TPD12S015=3Dm
> +CONFIG_DISPLAY_ENCODER_TPD12S015=3Dy
>=20
> to make the omap-hdmi-audio-dai attach (sound/soc/omap/omap-hdmi.c)
> and something like this (that is not upstreamable as i understand
> but is an unfortunate fallout from the board removal[*]):
>=20
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -335,6 +335,11 @@ static struct platform_device omap_hdmi_audio =3D=
 {
>         .id     =3D -1,
>  };
> =20
> +static struct platform_device hdmi_audio_codec =3D {
> +       .name   =3D "hdmi-audio-codec",
> +       .id     =3D -1,
> +};
> +
>  static void __init omap_init_hdmi_audio(void)
>  {
>         struct omap_hwmod *oh;
> @@ -349,6 +354,7 @@ static void __init omap_init_hdmi_audio(void)
>              "Can't build omap_device for omap-hdmi-audio-dai.\n");
> =20
>         platform_device_register(&omap_hdmi_audio);
> +       platform_device_register(&hdmi_audio_codec);
>  }
>  #else
>  static inline void omap_init_hdmi_audio(void) {}
>=20
> i finally get my OMAPHDMI device back:
>=20
> flag@panda:~$ cat /proc/asound/cards=20
>  0 [OMAPHDMI       ]: OMAPHDMI - OMAPHDMI
>                       OMAPHDMI
>  1 [PandaBoardES   ]: PandaBoardES - PandaBoardES
>                       PandaBoardES
>=20

Yeah, the OMAP4 hdmi audio got hit by the move to DT hard. In legacy bo=
ot we
did created the needed devices for us to use but we still lack the DT s=
upport
for the HDMI audio (along with the DSS AFAIK).
The stack we have at the moment going to change for sure. I need to syn=
c up
with Tomi and Jyri regarding to this but right now there's no clean (ie
upstreamable ) way to enable HDMI audio.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
