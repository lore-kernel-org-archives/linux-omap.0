From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 0/2] Graph fixes for using multiple endpoints per port
Date: Tue, 11 Dec 2018 06:14:23 +0000
Message-ID: <87wooga9an.wl-kuninori.morimoto.gx@renesas.com>
References: <20181211020557.61783-1-tony@atomide.com>
        <8736r4bvf3.wl-kuninori.morimoto.gx@renesas.com>
        <20181211045220.GI6707@atomide.com>
        <871s6obqkb.wl-kuninori.morimoto.gx@renesas.com>
        <20181211053536.GJ6707@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211053536.GJ6707@atomide.com>
Content-Language: en-US
Content-ID: <B63FC647395F304C83C6BE3AD100530D@jpnprd01.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org


Hi Tony

> > And, your [2/2] patch,
> > I guess you are misunderstanding about "port" vs "endpoint",
> > or omap-mcbsp driver side need to update ?
>=20
> Yes omap-mcbsp driver needs to be updated for multiple endpoints.
>=20
> Adding Jarkko and Peter also to Cc, below is the WIP patch that I'm
> currently using for omap-mcbsp to add more DAIs.
>=20
> So far nothing else to do in the omap-mcbsp as it's the cpcap hardware
> that configures the TDM timeslots. And I'm currently assuming the
> first instance is the master, I guess that should be parsed from the
> the frame-master dts property instead.
(snip)
> +	if (np)
> +		mcbsp->dai_count =3D of_graph_get_endpoint_count(np);

OK, you have multi DAI.
Then, you need to count is "port", not "endpoint".

So, your DT will be below.
You want to have is *1 for asoc_simple_card_get_dai_id().
You want to double check is *2 (maybe).

	ports {
		mcbsp3_port0: port@0 {
*1			reg =3D <0>;
			cpu_dai3: endpoint {
	 			dai-format =3D "dsp_a";
 				frame-master =3D <&cpcap_audio_codec1>;
 				bitclock-master =3D <&cpcap_audio_codec1>;
 				remote-endpoint =3D <&cpcap_audio_codec1>;
	 		};
		};
		mcbsp3_port1: port@1 {
*1			reg =3D <1>;
			cpu_dai_mdm: endpoint {
				dai-format =3D "dsp_a";
*2				frame-master =3D <&cpcap_audio_codec1>;
*2				bitclock-master =3D <&cpcap_audio_codec1>;
				remote-endpoint =3D <&mot_mdm6600_audio_codec0>;
			};
	 	};
	};


Best regards
---
Kuninori Morimoto
