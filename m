From: Tony Lindgren <tony@atomide.com>
Subject: Re: PM regression in next
Date: Mon, 15 Jan 2018 10:06:26 -0800
Message-ID: <20180115180626.GL4821@atomide.com>
References: <20180112211535.GH21458@sirena.org.uk>
 <20180112215010.GG4821@atomide.com>
 <20180112221126.GK21458@sirena.org.uk>
 <20180112224959.GH4821@atomide.com>
 <20180112225947.GL21458@sirena.org.uk>
 <87wp0jzyig.wl%kuninori.morimoto.gx@renesas.com>
 <20180115165050.GJ4821@atomide.com>
 <20180115171917.GB12018@sirena.org.uk>
 <20180115175220.GK4821@atomide.com>
 <20180115175626.GC12018@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180115175626.GC12018@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Mark Brown <broonie@kernel.org> [180115 17:56]:
> On Mon, Jan 15, 2018 at 09:52:20AM -0800, Tony Lindgren wrote:
> > * Mark Brown <broonie@kernel.org> [180115 17:19]:
> 
> > > Did anyone actually try testing the fix I posted yet?
> 
> > Hmm I don't seem to have anything in my inbox. What might
> > be the subject for it?
> 
> Sorry, I didn't actually post it - just suggested adding the
> snd_soc_codec_set_regmap() call.

Oh I see. Yeah that seems like a good long term solution after
the regressions are fixed.

Regards,

Tony
