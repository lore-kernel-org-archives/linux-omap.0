From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 0/2] Graph fixes for using multiple endpoints per port
Date: Tue, 11 Dec 2018 05:16:05 +0000
Message-ID: <871s6obqkb.wl-kuninori.morimoto.gx@renesas.com>
References: <20181211020557.61783-1-tony@atomide.com>
        <8736r4bvf3.wl-kuninori.morimoto.gx@renesas.com>
        <20181211045220.GI6707@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211045220.GI6707@atomide.com>
Content-Language: en-US
Content-ID: <4E720891F15990429C3E7D1D654E040D@jpnprd01.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org


Hi Tony

> > This looks a little bit strange for me.
> > Can you show me your DT for it ?
>=20
> Sure, adding also Sebastian to Cc. Here's what I currently have for droid=
 4
> dts with two codecs on I2S. Please just ignore the GNSS parts there..
>=20
> The TDM configuration is all done in the cpcap_audio_codec via set_tdm_sl=
ot().
> The modem voice call codec is a serdev driver :) I'll need some more time=
 to
> be able to post patches but it's basically working for voice calls.

Hmm... it seems strange...
I guess you are using "ti,omap4-mcbsp" driver (=3D linux/sound/soc/omap/oma=
p-mcbsp.c)
Is this correct ?

If so, your driver is registering component as

	ret =3D devm_snd_soc_register_component(&pdev->dev,
					      &omap_mcbsp_component,
					      &omap_mcbsp_dai, 1);

Your driver has only 1 DAI.

>  	mcbsp3_port: port {
> -		cpu_dai3: endpoint {
> +		cpu_dai3: endpoint@0 {
>  			dai-format =3D "dsp_a";
>  			frame-master =3D <&cpcap_audio_codec1>;
>  			bitclock-master =3D <&cpcap_audio_codec1>;
>  			remote-endpoint =3D <&cpcap_audio_codec1>;
>  		};
> +		cpu_dai_mdm: endpoint@1 {
> +			dai-format =3D "dsp_a";
> +			frame-master =3D <&cpcap_audio_codec1>;
> +			bitclock-master =3D <&cpcap_audio_codec1>;
> +			remote-endpoint =3D <&mot_mdm6600_audio_codec0>;
> +		};

And here, you have 1 port, 2 endpoint.
Then, asoc_simple_card_get_dai_id() should return 1.

And, your [2/2] patch,
I guess you are misunderstanding about "port" vs "endpoint",
or omap-mcbsp driver side need to update ?

Best regards
---
Kuninori Morimoto
