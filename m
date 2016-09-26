From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/2] cpufreq: ti: Add cpufreq driver to determine
 available OPPs at runtime
Date: Mon, 26 Sep 2016 10:03:44 +0530
Message-ID: <20160926043344.GH17336@vireshk-i7>
References: <20160901025328.376-1-d-gerlach@ti.com>
 <20160901025328.376-3-d-gerlach@ti.com>
 <20160907052053.GO27345@vireshk-i7>
 <57D02C85.7020300@ti.com>
 <20160908033909.GR27345@vireshk-i7>
 <57E2E0BE.3070206@ti.com>
 <20160923051947.GC17336@vireshk-i7>
 <57E555B3.2010304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <57E555B3.2010304-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 23-09-16, 11:17, Dave Gerlach wrote:
> On 09/23/2016 12:19 AM, Viresh Kumar wrote:
> >On 21-09-16, 14:34, Dave Gerlach wrote:
> >>Viresh,
> >>On 09/07/2016 10:39 PM, Viresh Kumar wrote:
> >>>On 07-09-16, 10:04, Dave Gerlach wrote:
> >>>>>>+static const struct of_device_id ti_cpufreq_of_match[] = {
> >>>>>>+	{ .compatible = "operating-points-v2-ti-am3352-cpu",
> >>>>>>+	  .data = &am3x_soc_data, },
> >>>>>>+	{ .compatible = "operating-points-v2-ti-am4372-cpu",
> >>>>>>+	  .data = &am4x_soc_data, },
> >>>>>>+	{ .compatible = "operating-points-v2-ti-dra7-cpu",
> >>>>>>+	  .data = &dra7_soc_data },
> >>>>>
> >>>>>You should be using your SoC compatible strings here. OPP compatible
> >>>>>property isn't supposed to be (mis)used for this purpose.
> >>>>>
> >>>>
> >>>>Referring to my comments in patch 1, what if we end up changing the bindings
> >>>>based on DT maintainer comments? We will have these compatible strings, and
> >>>>at that point is it acceptable to match against them? Or is it still better
> >>>>to match to SoC compatibles? I think it makes sense to just probe against
> >>>>these.
> >>>
> >>>But even then I think these are not correct. You should have added a
> >>>single compatible string: operating-points-v2-ti-cpu.
> >>>
> >>>As the properties will stay the same across machines. And then you
> >>>need to use SoC strings here.
> >>>
> >>
> >>Are you opposed to moving _of_get_opp_desc_node from
> >>drivers/base/power/opp/opp.h to include/linux/pm_opp.h and renaming it
> >>appropriately?
> >
> >I am not opposed to that, but ...
> >
> >>If I move the ti properties out of the cpu node, as discussed in patch 1 of
> >>this series, and into the operating-points-v2 table, I need a way to get the
> >>operating-points-v2 device node and I think it makes sense to reuse this as
> >>it is what the opp framework uses internally to parse the phandle to the opp
> >>table.
> >
> >I am not sure if those registers belong to the OPP bindings. What are those
> >registers really? What all can be read from them? Why shouldn't they be present
> >as a separate node in DT on the respective bus? Look at how it is done for
> >sti-cpufreq driver.
> >
> 
> The sti-cpufreq driver in v4.8-rc7 appears to do what I am already doing in
> this revision of the patch, reading from a syscon phandle that is part of
> the cpu node in the DT which is what I was told not to do.
> 
> The register I am referencing in the syscon is a bit-field describing which
> OPPs are valid for the system, so it is very relevant to the OPP binding.
> They really are already present in a separate node, I'm just indexing into a
> syscon, same as the sti-cpufreq driver appears to be doing.

Okay, you can move that function out.

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
