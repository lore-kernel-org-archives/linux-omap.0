From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V2 8/8] cpufreq: OMAP: donot allow to be used with device
 tree
Date: Wed, 27 Mar 2013 15:59:40 -0500
Message-ID: <20130327205940.GA660@kahuna>
References: <1363715590-5131-1-git-send-email-nm@ti.com>
 <1363715590-5131-9-git-send-email-nm@ti.com>
 <87vc8c7kmq.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87vc8c7kmq.fsf@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: linux-omap@vger.kernel.org, Jon Hunter <jon-hunter@ti.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Shawn Guo <shawn.guo@linaro.org>, Keerthy <j-keerthy@ti.com>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11:39-20130327, Kevin Hilman wrote:
> Nishanth Menon <nm@ti.com> writes:
> >  #include <linux/module.h>
> > @@ -174,6 +175,19 @@ static inline void freq_table_free(void)
> >  static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
> >  {
> >  	int result = 0;
> > +	struct device_node *np;
> > +
> > +	/*
> > +	 * If we have a device tree node describing OPPs,
> > +	 * we will NOT permit usage of omap-cpufreq driver.
> > +	 * use cpufreq-cpu0 driver to manage.
> > +	 */
> > +	if (of_have_populated_dt()) {
> > +		for_each_child_of_node(of_find_node_by_path("/cpus"), np) {
> > +			if (of_get_property(np, "operating-points", NULL))
> > +				return -EPERM;
> > +		}
> > +	}
> 
> I think it's much cleaner to just convert this to a platform_driver like
> was done for the generic driver[1].  Then the registration in the
> previous patch can register the omap driver when needed.
Thanks for the review.
Yes. I agree. Will wait for any further comments on the DT angle before
I send out an V3.

-- 
Regards,
Nishanth Menon
