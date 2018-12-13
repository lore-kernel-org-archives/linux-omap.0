From: Tony Lindgren <tony@atomide.com>
Subject: Re: [alsa-devel] [PATCH 0/2] Graph fixes for using multiple
        endpoints per port
Date: Wed, 12 Dec 2018 17:13:04 -0800
Message-ID: <20181213011304.GL6707@atomide.com>
References: <87wooga9an.wl-kuninori.morimoto.gx@renesas.com>
 <20181211141649.GL6707@atomide.com>
 <87ftv33bpg.wl-kuninori.morimoto.gx@renesas.com>
 <20181212001950.GX6707@atomide.com>
 <877egf33m9.wl-kuninori.morimoto.gx@renesas.com>
 <87k1kfs0u5.wl-kuninori.morimoto.gx@renesas.com>
 <20181212152725.GE6707@atomide.com>
 <87imzy2sh1.wl-kuninori.morimoto.gx@renesas.com>
 <20181213004009.GK6707@atomide.com>
 <87h8fi2qit.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87h8fi2qit.wl-kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

* Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> [181213 01:06]:
> 
> Hi Tony
> 
> > > According to OF graph maintainer, he said that
> > > counting port / endpoint are not guaranteed,
> > > and we need to use "reg".
> > > (It is the reason of b6f3fc005a2c8b425d7a0973b43bef05890bf479)
> > > 
> > > If you could double checked, and we could agreed
> > > that "reg" is the solution for us.
> > > I will post patches.
> > 
> > OK yes your "reg" proposal works for me.
> 
> OK, thanks.
> I will post patch-set, soon.

OK sounds good to me.

Thanks,

Tony
