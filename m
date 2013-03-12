From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/2] cpufreq: cpufreq-cpu0: provide compatibility string
 for DT matchup
Date: Tue, 12 Mar 2013 09:43:34 -0500
Message-ID: <20130312144334.GB21599@kahuna>
References: <1363043130-30270-1-git-send-email-nm@ti.com>
 <1363043130-30270-3-git-send-email-nm@ti.com>
 <513EB7FE.1070000@ti.com>
 <513F3B98.6050909@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <513F3B98.6050909@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-pm@vger.kernel.org, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, linux-kernel@vger.kernel.org, cpufreq <cpufreq@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 15:28-20130312, Benoit Cousson wrote:
> On 03/12/2013 06:07 AM, Santosh Shilimkar wrote:
> > On Tuesday 12 March 2013 04:35 AM, Nishanth Menon wrote:
> >> commit 5553f9e (cpufreq: instantiate cpufreq-cpu0 as a platform_driver)
> >> now forces platform device to be registered for allowing cpufreq-cpu0
> >> to be used by SoCs. example: drivers/cpufreq/highbank-cpufreq.c
> >>
> >> However, for SoCs that wish to link up using device tree, instead
> >> of platform device, provide compatibility string match:
> >> compatible = "cpufreq,cpu0";
> 
> You cannot add a non-HW relative binding... DT is supposed to represent
> the pure HW.
> AFAIK, cpufreq has nothing to do with the HW definition.
Ref:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/cpufreq/highbank-cpufreq.c#n61
there is a need for a device of some sort.  in the example above, we
register a dummy device for linking up with cpufreq-cpu0 driver.
what we do in this patch is to indicate that SoC CPUs are managed by
cpufreq-cpu0 driver.

I am a bit curious to see how else would we represent drivers to manage
real h/w devices like CPU? Is the highbank style the recommended way to do
things?
> 
> >>
> >> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> >> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> >> Cc: Shawn Guo <shawn.guo@linaro.org>
> >> Cc: linux-kernel@vger.kernel.org
> >> Cc: cpufreq@vger.kernel.org
> >> Cc: linux-pm@vger.kernel.org
> >> Cc: linux-omap@vger.kernel.org
> >>
> >> Signed-off-by: Nishanth Menon <nm@ti.com>
> >> ---
> >>  .../devicetree/bindings/cpufreq/cpufreq-cpu0.txt   |    3 +++
> >>  drivers/cpufreq/cpufreq-cpu0.c                     |    6 ++++++
> >>  2 files changed, 9 insertions(+)
> >>
> > Looks fine to me. CC'ing dt list in case some one has
> > comments on binding updates.
> > 
> > Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Not-Acked-by-me.

-- 
Regards,
Nishanth Menon
