From: Tony Lindgren <tony@atomide.com>
Subject: Re: [alsa-devel] Regression in next with codec unload and
        snd_soc_component_get/put
Date: Fri, 9 Aug 2019 00:46:43 -0700
Message-ID: <20190809074643.GB52127@atomide.com>
References: <20190809070003.GA52127@atomide.com>
 <s5hwofmhkbs.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hwofmhkbs.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Takashi Iwai <tiwai@suse.de> [190809 07:25]:
> On Fri, 09 Aug 2019 09:00:03 +0200,
> Tony Lindgren wrote:
> > 
> > Hi,
> > 
> > Looks like commit 4a81e8f30d0b ("ASoC: soc-component: add
> > snd_soc_component_get/put()") causes a regression where trying
> > to rmmod a codec driver fails with module is in use error after
> > rmmod of snd-soc-audio-graph-card for example.
> > 
> > Any ideas what goes wrong there?
> 
> There is an obvious typo: soc_cleanup_component() should call
> snd_soc_component_module_put_when_remove() instead of *_close().

Making that change locally seems to fix it thanks.

> And the module_get_upon_open boolean switch is a bit hard to
> understand.  Maybe using enum would be simpler there.
> 
> > BTW, looks like the lore.kernel.org link in that commit also is
> > unreachable?
> 
> It's because alsa-devel ML isn't tracked on lore.kernel.org,
> unfortunately.
> 
> Jaroslav, I asked this already.  Shall we ask lore to track alsa-devel
> ML?
>   https://korg.wiki.kernel.org/userdoc/lore

Regards,

Tony
