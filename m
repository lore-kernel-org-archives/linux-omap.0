From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: LDP: next-20150402: twl4030 regression?
Date: Mon, 6 Apr 2015 14:58:29 +0100
Message-ID: <20150406135829.GH4027@n2100.arm.linux.org.uk>
References: <5522886D.5050409@ti.com>
 <20150406134541.GE6023@sirena.org.uk>
 <55228FE0.2040702@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55228FE0.2040702@ti.com>
Sender: linux-next-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Mark Brown <broonie@kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-next@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Apr 06, 2015 at 08:53:36AM -0500, Nishanth Menon wrote:
> On 04/06/2015 08:45 AM, Mark Brown wrote:
> > On Mon, Apr 06, 2015 at 08:21:49AM -0500, Nishanth Menon wrote:
> > 
> >> https://github.com/nmenon/kernel-test-logs/blob/next-20150401/omap2plus_defconfig/ldp.txt
> >> looks clean, but
> > 
> >> https://github.com/nmenon/kernel-test-logs/blob/next-20150402/omap2plus_defconfig/ldp.txt#L488
> >> seems to have picked up a regression in the regulator driver.
> > 
> > Please provide actual bug reports if you're trying to report something -
> 
> Apologies, I should have been a little more clear.
> 
> > at least a description of the problem you're seeing and some attempt at
> 
> Test was a simple boot test. There seems to be a lockdep reported at the
> very least in the log provided (see
> https://github.com/nmenon/kernel-test-logs/blob/next-20150402/omap2plus_defconfig/ldp.txt#L488
> ).

I think what Mark is trying to say is to include a fuller description of
the problem, and don't expect people to fire up their web browser to get
a basic overview of what the problem is.

My guess is that the problem _appears_ to be that someone's added a call
to debug_check_no_locks_held() into schedule_hrtimeout_range_clock()
without considering what this means.

What it means is that you can't now use usleep_range() from within any
driver probe function - which is absolutely absurd.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
