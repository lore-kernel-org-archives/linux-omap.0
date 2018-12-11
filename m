From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 0/2] Graph fixes for using multiple endpoints per port
Date: Tue, 11 Dec 2018 03:31:10 +0000
Message-ID: <8736r4bvf3.wl-kuninori.morimoto.gx@renesas.com>
References: <20181211020557.61783-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211020557.61783-1-tony@atomide.com>
Content-Language: en-US
Content-ID: <5471F9A4D4154640BA492E029ECBC348@jpnprd01.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org


Hi Tony

> Here are two fixes that allow me to have multiple endpoints defined in
> the dts file for audio-graph-card. To do that, we need to fix up few
> issues as the graph binding Documentation/devicetree/bindings/graph.txt
> allows multiple endpoints per port. This allows configuring TDM codecs
> for I2S for example.
>=20
> Kuninori-san, can you please check if this makes sense to you and
> compare against the graph binding?

This looks a little bit strange for me.
Can you show me your DT for it ?

Best regards
---
Kuninori Morimoto
