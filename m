From: Tony Lindgren <tony@atomide.com>
Subject: Re: PM regression in next
Date: Fri, 12 Jan 2018 13:50:10 -0800
Message-ID: <20180112215010.GG4821@atomide.com>
References: <20180112000037.GA3875@atomide.com>
 <20180111161837.f1c1d891a1b80d97e30a9b1b@linux-foundation.org>
 <20180112002322.GB3875@atomide.com>
 <20180111164537.79165ac8918e6d38e1837062@linux-foundation.org>
 <20180112012019.GA4059@atomide.com>
 <20180112190046.GD4821@atomide.com>
 <20180112191251.GE21458@sirena.org.uk>
 <20180112210706.GE4821@atomide.com>
 <20180112211535.GH21458@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180112211535.GH21458@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Mark Brown <broonie@kernel.org> [180112 21:15]:
> On Fri, Jan 12, 2018 at 01:07:06PM -0800, Tony Lindgren wrote:
> 
> > (twl4030_dummy_read [snd_soc_twl4030]) from [<bf1cc3b4>]
> >   (snd_soc_codec_drv_read+0x1c/0x28 [snd_soc_core])
> > (snd_soc_codec_drv_read [snd_soc_core]) from [<bf1da1cc>]
> >   (snd_soc_dapm_new_widgets+0x29c/0x578 [snd_soc_core])
> > (snd_soc_dapm_new_widgets [snd_soc_core]) from [<bf1d2f30>]
> >   (snd_soc_register_card+0xad0/0xe30 [snd_soc_core])
> > (snd_soc_register_card [snd_soc_core]) from [<bf1e1850>]
> >   (devm_snd_soc_register_card+0x30/0x70 [snd_soc_core])
> > (devm_snd_soc_register_card [snd_soc_core]) from [<bf234364>]
> >   (omap_twl4030_probe+0x100/0x1d0 [snd_soc_omap_twl4030])
> > (omap_twl4030_probe [snd_soc_omap_twl4030]) from [<c0606660>]
> >   (platform_drv_probe+0x50/0xb0)
> 
> So does the read not happen otherwise?  Or is it failing somehow and the
> error getting ignored?

All the snd_soc_dapm_new_widgets() related reads go missing
without the .read being there. Probably the same story for
writes.

> > So probably there are other asoc drivers broken too with these
> > kind of patches until snd_soc_codec_drv_write() and
> > snd_soc_codec_drv_read() are fixed?
> 
> I rather suspect someone would've noticed by now TBH - I suspect this is
> more likely to be an issue with the rather baroque code that the TWL
> drivers have possibly coupled with the whole multiple I2C devices issue.

Hmm these calls are in sound/soc/soc-core.c though? But yeah, sure
it could be some legacy code issue somewhere..

Based on a quick grep these have .read and .write removed in next
so they may all be broken now:

sound/soc/codecs/cx20442.c
sound/soc/codecs/tlv320dac33.c
sound/soc/codecs/twl4030.c
sound/soc/codecs/twl6040.c
sound/soc/codecs/uda1380.c
sound/soc/fsl/fsl_ssi.c

Can you confirm that some of these are still working?

Regards,

Tony
