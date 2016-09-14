From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/3] ARM: dts: Add operating-points-v2 tables for TI
 platforms
Date: Wed, 14 Sep 2016 09:56:38 -0700
Message-ID: <20160914165635.h4afluenzlfhcyo5@atomide.com>
References: <20160901024816.32390-1-d-gerlach@ti.com>
 <20160913220244.txdiak6ikujvwzjk@atomide.com>
 <57D97E9A.90400@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57D97E9A.90400@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

* Dave Gerlach <d-gerlach@ti.com> [160914 09:45]:
> On 09/13/2016 05:02 PM, Tony Lindgren wrote:
> > Assuming this will have to wait based on what you mentioned about
> > am335x cpufreq regression. I guess you'll instead send few patches
> > to revert?
> > 
> 
> Correct, these should not be merged, I will be sending a fixup series until
> this series is ready.

OK

> I needed to resend the ti-cpufreq driver at [2] to get a response about the
> dt binding and other updates Viresh asked for and sent this to update the
> merged nodes so they would work with the driver. But the driver has not been
> merged yet, so in order to re-enable the previously existing cpufreq support
> on those platforms I must revert three patches from v1 [1] of this series
> that got merged, which I will send.
> 
> I also found that 7694ca6e1d6f ("cpufreq: omap: Use generic platdev driver")
> which went in v4.6-rc1 had already broken the existing cpufreq support on
> am335x and dra7xx, so it's been missing for some time. I can send a patch
> fixing that as well but I will need to remove it once the ti-cpufreq driver
> in [2] below gets merged as that driver must create the cpufreq-dt platform
> device instead of cpufreq-dt-platdev. So I will send a series that can fix
> cpufreq until ti-cpufreq is ready which will give us better support for more
> OPPs on am335x, am437x (which has no implementation today), and dra7xx.

OK yeah let's fix the regression & thanks for the update.

Regards,

Tony
