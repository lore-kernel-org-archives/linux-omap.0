From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 0/2] Graph fixes for using multiple endpoints per port
Date: Wed, 12 Dec 2018 02:11:10 +0000
Message-ID: <877egf33m9.wl-kuninori.morimoto.gx@renesas.com>
References: <20181211020557.61783-1-tony@atomide.com>
        <8736r4bvf3.wl-kuninori.morimoto.gx@renesas.com>
        <20181211045220.GI6707@atomide.com>
        <871s6obqkb.wl-kuninori.morimoto.gx@renesas.com>
        <20181211053536.GJ6707@atomide.com>
        <87wooga9an.wl-kuninori.morimoto.gx@renesas.com>
        <20181211141649.GL6707@atomide.com>
        <87ftv33bpg.wl-kuninori.morimoto.gx@renesas.com>
        <20181212001950.GX6707@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181212001950.GX6707@atomide.com>
Content-Language: en-US
Content-ID: <1BF58D36F053954BB8A90ABD68999A1D@jpnprd01.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org


Hi Tony

> > 	https://patchwork.kernel.org/patch/10712877/
>=20
> Hmm, so do you have multiple separate ports at the "&sound" node
> hardware? If so then yeah multiple ports make sense.
>
> But if you only a single physical (I2S?) port at the
> "&sound" node hardware, then IMO you should only have one
> port and multiple endpoints there according to the graph.txt
> binding doc.
>=20
> In my McBSP case there is only a single physical I2S port
> that can be TDM split into timeslots.

Mine has 4 DAIs. Each DAI can output 2ch.
These will be merged and wil be 8ch TDM and goes to Codec.
But hmm.. it is 4 DAIs, but 1 "physical" interface...

So, your patch seems correct, but will breaks DPCM...
I will confirm it.

Best regards
---
Kuninori Morimoto
