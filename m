From: Tony Lindgren <tony@atomide.com>
Subject: Re: PM regression in next
Date: Mon, 15 Jan 2018 09:52:20 -0800
Message-ID: <20180115175220.GK4821@atomide.com>
References: <20180112191251.GE21458@sirena.org.uk>
 <20180112210706.GE4821@atomide.com>
 <20180112211535.GH21458@sirena.org.uk>
 <20180112215010.GG4821@atomide.com>
 <20180112221126.GK21458@sirena.org.uk>
 <20180112224959.GH4821@atomide.com>
 <20180112225947.GL21458@sirena.org.uk>
 <87wp0jzyig.wl%kuninori.morimoto.gx@renesas.com>
 <20180115165050.GJ4821@atomide.com>
 <20180115171917.GB12018@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180115171917.GB12018@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Mark Brown <broonie@kernel.org> [180115 17:19]:
> On Mon, Jan 15, 2018 at 08:50:51AM -0800, Tony Lindgren wrote:
> > * Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> [180115 01:46]:
> 
> > > I hope your driver will be OK by using regmap.
> > > In worst case, we can back .read/.write, but it will be component driver side.
> 
> > Well we have the merge window about to open in a week, so
> > please just revert the known broken patches.
> 
> Did anyone actually try testing the fix I posted yet?

Hmm I don't seem to have anything in my inbox. What might
be the subject for it?

Regards,

Tony
