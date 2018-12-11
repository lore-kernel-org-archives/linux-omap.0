From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 0/2] Graph fixes for using multiple endpoints per port
Date: Tue, 11 Dec 2018 05:30:22 +0000
Message-ID: <87zhtcabc0.wl-kuninori.morimoto.gx@renesas.com>
References: <20181211020557.61783-1-tony@atomide.com>
        <8736r4bvf3.wl-kuninori.morimoto.gx@renesas.com>
        <20181211045220.GI6707@atomide.com>
        <871s6obqkb.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <871s6obqkb.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Content-ID: <5A47DDBBB932B94D8EDEDA2314739F32@jpnprd01.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org


Hi Tony, again

> >  	mcbsp3_port: port {
> > -		cpu_dai3: endpoint {
> > +		cpu_dai3: endpoint@0 {
> >  			dai-format =3D "dsp_a";
> >  			frame-master =3D <&cpcap_audio_codec1>;
> >  			bitclock-master =3D <&cpcap_audio_codec1>;
> >  			remote-endpoint =3D <&cpcap_audio_codec1>;
> >  		};
> > +		cpu_dai_mdm: endpoint@1 {
> > +			dai-format =3D "dsp_a";
> > +			frame-master =3D <&cpcap_audio_codec1>;
> > +			bitclock-master =3D <&cpcap_audio_codec1>;
> > +			remote-endpoint =3D <&mot_mdm6600_audio_codec0>;
> > +		};

audio-graph-scu-card and my posting merged audio-graph-card
are assuming multi-endpoint will be used for DPCM purpose.

But, above endpoint connection seems you want to is
not DPCM (?), I'm not sure.

Best regards
---
Kuninori Morimoto
