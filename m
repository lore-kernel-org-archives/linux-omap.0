From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/2] cpufreq: ti: Add cpufreq driver to determine
 available OPPs at runtime
Date: Thu, 8 Sep 2016 09:09:09 +0530
Message-ID: <20160908033909.GR27345@vireshk-i7>
References: <20160901025328.376-1-d-gerlach@ti.com>
 <20160901025328.376-3-d-gerlach@ti.com>
 <20160907052053.GO27345@vireshk-i7>
 <57D02C85.7020300@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <57D02C85.7020300-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 07-09-16, 10:04, Dave Gerlach wrote:
> >>+static const struct of_device_id ti_cpufreq_of_match[] = {
> >>+	{ .compatible = "operating-points-v2-ti-am3352-cpu",
> >>+	  .data = &am3x_soc_data, },
> >>+	{ .compatible = "operating-points-v2-ti-am4372-cpu",
> >>+	  .data = &am4x_soc_data, },
> >>+	{ .compatible = "operating-points-v2-ti-dra7-cpu",
> >>+	  .data = &dra7_soc_data },
> >
> >You should be using your SoC compatible strings here. OPP compatible
> >property isn't supposed to be (mis)used for this purpose.
> >
> 
> Referring to my comments in patch 1, what if we end up changing the bindings
> based on DT maintainer comments? We will have these compatible strings, and
> at that point is it acceptable to match against them? Or is it still better
> to match to SoC compatibles? I think it makes sense to just probe against
> these.

But even then I think these are not correct. You should have added a
single compatible string: operating-points-v2-ti-cpu.

As the properties will stay the same across machines. And then you
need to use SoC strings here.

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
