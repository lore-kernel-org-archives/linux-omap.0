From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 0/2] Graph fixes for using multiple endpoints per port
Date: Tue, 11 Dec 2018 23:16:33 +0000
Message-ID: <87ftv33bpg.wl-kuninori.morimoto.gx@renesas.com>
References: <20181211020557.61783-1-tony@atomide.com>
        <8736r4bvf3.wl-kuninori.morimoto.gx@renesas.com>
        <20181211045220.GI6707@atomide.com>
        <871s6obqkb.wl-kuninori.morimoto.gx@renesas.com>
        <20181211053536.GJ6707@atomide.com>
        <87wooga9an.wl-kuninori.morimoto.gx@renesas.com>
        <20181211141649.GL6707@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211141649.GL6707@atomide.com>
Content-Language: en-US
Content-ID: <4E842C18E97DC84BBB6E2BD8AFE47627@jpnprd01.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org


Hi Tony

> The issue I have with that it does not then follow the binding doc :)
>=20
> See this part in Documentation/devicetree/bindings/graph.txt:
>=20
>  "If a single port is connected to more than one remote device, an
>  'endpoint' child node must be provided for each link."
>=20
> Isn't the I2C TDM case the same as "single port connecected to
> more than one remote device" rather than multiple ports?
>=20
> To me it seems we're currently only handling the multiple ports
> case, and not multiple endpoints for a port. Other than fixing
> that, things should work just as earlier with my two patches.
> That is unless I accidentally broke something.
>=20
> So just trying to correct the binding usage. Or am I missing
> something?

I'm not 100% sure your "I2C TDM case", but you can check
multi-endpoint sample on "Example: Multi DAI with DPCM" below.
"pcm3168a" is using multi-endpoint.
Does this help you ?

	https://patchwork.kernel.org/patch/10712877/


Best regards
---
Kuninori Morimoto
