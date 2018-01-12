From: Tony Lindgren <tony@atomide.com>
Subject: Re: PM regression in next
Date: Fri, 12 Jan 2018 13:07:06 -0800
Message-ID: <20180112210706.GE4821@atomide.com>
References: <20180112000037.GA3875@atomide.com>
 <20180111161837.f1c1d891a1b80d97e30a9b1b@linux-foundation.org>
 <20180112002322.GB3875@atomide.com>
 <20180111164537.79165ac8918e6d38e1837062@linux-foundation.org>
 <20180112012019.GA4059@atomide.com>
 <20180112190046.GD4821@atomide.com>
 <20180112191251.GE21458@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180112191251.GE21458@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Mark Brown <broonie@kernel.org> [180112 19:13]:
> On Fri, Jan 12, 2018 at 11:00:46AM -0800, Tony Lindgren wrote:
> 
> > It's commit 3bb0f7c31b1a ("ASoC: don't use snd_soc_write/read
> > on twl4030"). And that is for the PMIC on my test system, so
> > adding Kuninori and Mark to the thread :)
> 
> > Kuninori, it seems that commit 3bb0f7c31b1a causes higher
> > power consumption on an idle system on omap3 using twl4030.
> > Reverting 3bb0f7c31b1a makes things behave again. My guess
> > is that twl4030_read does not do the same as snd_soc_read
> > in the driver?
> 
> As far as I can tell it should end up boiling down to the same thing but
> I didn't follow through in detail, they should both bottom out in
> twl_i2c_read_u8() if they hit hardware - all snd_soc_read() did was call
> twl4030_read(), the patch just removes the indirection through assigning
> the pointer.
> 
> Could you try deleting the attempt to read from the cache in
> twl4030_read() and always go to hardware?

Thanks I tried that, but that's not it.

Tturns out just adding back .read = twl4030_read fixes it..
I added a dummy function for read and am now seeing a bunch
of reads that now don't happen:

(twl4030_dummy_read [snd_soc_twl4030]) from [<bf1cc3b4>]
  (snd_soc_codec_drv_read+0x1c/0x28 [snd_soc_core])
(snd_soc_codec_drv_read [snd_soc_core]) from [<bf1da1cc>]
  (snd_soc_dapm_new_widgets+0x29c/0x578 [snd_soc_core])
(snd_soc_dapm_new_widgets [snd_soc_core]) from [<bf1d2f30>]
  (snd_soc_register_card+0xad0/0xe30 [snd_soc_core])
(snd_soc_register_card [snd_soc_core]) from [<bf1e1850>]
  (devm_snd_soc_register_card+0x30/0x70 [snd_soc_core])
(devm_snd_soc_register_card [snd_soc_core]) from [<bf234364>]
  (omap_twl4030_probe+0x100/0x1d0 [snd_soc_omap_twl4030])
(omap_twl4030_probe [snd_soc_omap_twl4030]) from [<c0606660>]
  (platform_drv_probe+0x50/0xb0)

So probably there are other asoc drivers broken too with these
kind of patches until snd_soc_codec_drv_write() and
snd_soc_codec_drv_read() are fixed?

Regards,

Tony
