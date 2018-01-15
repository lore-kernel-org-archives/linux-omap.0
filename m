From: Tony Lindgren <tony@atomide.com>
Subject: Re: PM regression in next
Date: Mon, 15 Jan 2018 08:50:51 -0800
Message-ID: <20180115165050.GJ4821@atomide.com>
References: <20180112012019.GA4059@atomide.com>
 <20180112190046.GD4821@atomide.com>
 <20180112191251.GE21458@sirena.org.uk>
 <20180112210706.GE4821@atomide.com>
 <20180112211535.GH21458@sirena.org.uk>
 <20180112215010.GG4821@atomide.com>
 <20180112221126.GK21458@sirena.org.uk>
 <20180112224959.GH4821@atomide.com>
 <20180112225947.GL21458@sirena.org.uk>
 <87wp0jzyig.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87wp0jzyig.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> [180115 01:46]:
> 
> Hi all
> 
> > > > Most devices have one regmap per device which can be retrieved with
> > > > dev_get_regmap(), it's the attempt to use that which I suspect is
> > > > broken.  Like I said snd_soc_codec_init_regmap() ought to fix things if
> > > > that's the issue.
> > 
> > > OK. Adding Peter to loop as it's his driver after all. Not sure
> > > how well mixing regmap register access to the same module with
> > > cached twl4030_read() would work :)
> > 
> > Yes, that local cache is not a super good idea any more and hopefully
> > redundant.
> > 
> > > Maybe there should also be some big warning happening if
> > > snd_soc_codec_init_regmap() is now needed and no regmap is
> > > found?
> > 
> > Some devices just plain don't have registers at all (perhaps GPIOs or
> > just stub drivers providing capability information).  However we should
> > be screaming loudly about the fact that the I/O we tried to do fails,
> > that clearly shouldn't be being ignored.
> 
> I'm sorry that my patch breaks your drivers.
> It seems removing .read/.write callback was too much aggressive.

No problem, things happen. The thing I'm worried about here
though is that these patches were "completely untested
clean-up patches" :) For the next set of changes like this,
please make sure you Cc the driver authors so they can test
and ack the changes if you can't test them, OK?

> I hope your driver will be OK by using regmap.
> In worst case, we can back .read/.write, but it will be component driver side.

Well we have the merge window about to open in a week, so
please just revert the known broken patches.

Like I described, it looks all the non-regmap drivers with
read/write function pointers removed are broken now.

Just adding back the read/write function pointers while
keeping your other changes seems also risky to me at this
point. It seems it should work for twl4030 and twl6030
though, have not checked the other drivers but they seem
to have more changes.

Regards,

Tony
