From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/2] Graph fixes for using multiple endpoints per port
Date: Wed, 12 Dec 2018 06:58:24 -0800
Message-ID: <20181212145824.GC6707@atomide.com>
References: <20181211020557.61783-1-tony@atomide.com>
 <8736r4bvf3.wl-kuninori.morimoto.gx@renesas.com>
 <20181211045220.GI6707@atomide.com>
 <871s6obqkb.wl-kuninori.morimoto.gx@renesas.com>
 <20181211053536.GJ6707@atomide.com>
 <433af235-47c9-8b22-aec2-afb1836c9ee0@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <433af235-47c9-8b22-aec2-afb1836c9ee0@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [181212 12:47]:
> McBSP have single DX and single DR pin. Iow each McBSP have single DAI.

Yeah it's single physical port for sure. But at least currently we need
additional secondary DAIs for each TDM channel in addition to the primary
DAI managing the McBSP registers.

Currently there's nothing to do for the secondary DAIs, but if McBSP was
also the clock master then the secondary DAI functions would need to take
care of the multiplexing McBSP hardware resources. But that can be done
later if we actually ever see some McBSP being TDM master use case..

Regards,

Tony
