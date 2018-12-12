From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 0/2] Graph fixes for using multiple endpoints per port
Date: Wed, 12 Dec 2018 00:12:40 +0000
Message-ID: <87efan393s.wl-kuninori.morimoto.gx@renesas.com>
References: <20181211020557.61783-1-tony@atomide.com>
        <8736r4bvf3.wl-kuninori.morimoto.gx@renesas.com>
        <20181211045220.GI6707@atomide.com>
        <871s6obqkb.wl-kuninori.morimoto.gx@renesas.com>
        <20181211053536.GJ6707@atomide.com>
        <87wooga9an.wl-kuninori.morimoto.gx@renesas.com>
        <20181211141649.GL6707@atomide.com>
        <87ftv33bpg.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87ftv33bpg.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Content-ID: <764C8D5A4E9FFE4F944940B81F85EED6@jpnprd01.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org


Hi Tony, again

> > The issue I have with that it does not then follow the binding doc :)
> >=20
> > See this part in Documentation/devicetree/bindings/graph.txt:
> >=20
> >  "If a single port is connected to more than one remote device, an
> >  'endpoint' child node must be provided for each link."

My understanding is that 1 "port" is for 1 "physical interface".
In sound case, it is 1 "DAI".
And, 1 "endpoint" is for 1 "connection".

	"If a single port is connected to more than one remote device, an
	'endpoint' child node must be provided for each link."

This meanns, "If 1 DAI (*1) is connected to multiple remote DAIs(*2),
this connection is indicated by multiple "endpoint"" or something like that=
.

(*2)
DAIA-endpoint---endpoint--\
DAIB-endpoint---endpoint-----DAI (*1)
DAIC-endpoint---endpoint--/

> > Isn't the I2C TDM case the same as "single port connecected to
> > more than one remote device" rather than multiple ports?

I re-checked https://lkml.org/lkml/2018/3/28/405.
Are MDM6600 / OMAP4 CPU portion, and are CPCAP / WL1285 Codec portion ?
Then, it is not yet supported (on ALSA SoC level?).
If my memory was correct, Lars-Peter had some idea for Mux,
But, not yet implemented I think.

audio-graph[-scu] / simple-card[-scu] are supporting DPCM,
but it is for multiple CPU - single Codec.

Best regards
---
Kuninori Morimoto
