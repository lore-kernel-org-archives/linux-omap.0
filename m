From: Tony Lindgren <tony@atomide.com>
Subject: Re: PM regression in next
Date: Mon, 15 Jan 2018 16:36:23 -0800
Message-ID: <20180116003623.GB4042@atomide.com>
References: <20180112191251.GE21458@sirena.org.uk>
 <20180112210706.GE4821@atomide.com>
 <20180112211535.GH21458@sirena.org.uk>
 <20180112215010.GG4821@atomide.com>
 <20180112221126.GK21458@sirena.org.uk>
 <20180112224959.GH4821@atomide.com>
 <20180112225947.GL21458@sirena.org.uk>
 <87wp0jzyig.wl%kuninori.morimoto.gx@renesas.com>
 <20180115165050.GJ4821@atomide.com>
 <871siqbte4.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <871siqbte4.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Kuninori Morimoto <kuninori.morimoto.gx@renesas.com> [180115 23:22]:
> > For the next set of changes like this,
> > please make sure you Cc the driver authors so they can test
> > and ack the changes if you can't test them, OK?
> 
> Actually, I have posted "convert codec/platform to component"
> patch-set to ALSA ML, without Cc:ing to you.
> 
> 	Subject: [PATCH 00/38] ASoC: replace platform to component
> 	Date: Fri, 12 Jan 2018 09:40:29 +0900
> 
> 	Subject: [PATCH 000/187] ASoC: replace codec to component
> 	Date: Fri, 12 Jan 2018 10:05:05 +0900
> 
> I will send test request mail to each driver's authoer

Thanks, yeah that's something for Peter to look at :)

Regards,

Tony
