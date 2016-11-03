From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/3] Documentation: dt: add bindings for ti-cpufreq
Date: Thu, 3 Nov 2016 07:44:55 +0530
Message-ID: <20161103021455.GE10786@vireshk-i7>
References: <20161027214131.1725-1-d-gerlach@ti.com>
 <20161027214131.1725-3-d-gerlach@ti.com>
 <20161102035941.GA10786@vireshk-i7>
 <9a185460-a241-4876-2915-6975c57527ca@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9a185460-a241-4876-2915-6975c57527ca-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 02-11-16, 11:03, Dave Gerlach wrote:
> >>+cpu0_opp_table: opp_table0 {
> >>+	compatible = "operating-points-v2-ti-am3352-cpu";
> >>+	ti,syscon-efuse = <&scm_conf 0x7fc 0x1fff 0>;
> >>+	ti,syscon-rev = <&scm_conf 0x600>;
> >>+
> >>+	/*
> >>+	 * The three following nodes are marked with opp-suspend
> >>+	 * because they can not be enabled simultaneously on a
> >>+	 * single SoC.
> >>+	 */

I missed reading this comment :(

>>+	opp50@300000000 {
> >>+		opp-hz = /bits/ 64 <300000000>;
> >>+		opp-microvolt = <950000 931000 969000>;
> >>+		opp-supported-hw = <0x06 0x0010>;
> >>+		opp-suspend;
> >>+	};
> >>+
> >>+	opp100@275000000 {
> >>+		opp-hz = /bits/ 64 <275000000>;
> >>+		opp-microvolt = <1100000 1078000 1122000>;
> >>+		opp-supported-hw = <0x01 0x00FF>;
> >>+		opp-suspend;
> >>+	};
> >>+
> >>+	opp100@300000000 {
> >>+		opp-hz = /bits/ 64 <300000000>;
> >>+		opp-microvolt = <1100000 1078000 1122000>;
> >>+		opp-supported-hw = <0x06 0x0020>;
> >>+		opp-suspend;
> >
> >Only one OPP in the table can be marked as suspend OPP.
> >
> 
> Does that still apply when opp-supported-hw is involved? Based on the
> comment at the start of the table, those OPPs are all mutually exclusive and
> will not ever be enabled on the same piece of silicon, they represent the
> lowest OPP for each of three different supported-hw configurations.

You are right, its fine.

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
