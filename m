From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v4 2/4] Documentation: dt: add bindings for ti-cpufreq
Date: Fri, 20 Jan 2017 10:43:24 -0800
Message-ID: <20170120184324.GJ7403@atomide.com>
References: <20170117131808.29798-1-d-gerlach@ti.com>
 <20170117131808.29798-3-d-gerlach@ti.com>
 <20170119180702.62xg2ta5pq4mf7sd@rob-hp-laptop>
 <b7d11925-879a-9be0-fdd8-45b70e642ce1@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <b7d11925-879a-9be0-fdd8-45b70e642ce1-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org> [170119 10:32]:
> On 01/19/2017 12:07 PM, Rob Herring wrote:
> > > +	/*
> > > +	 * The three following nodes are marked with opp-suspend
> > > +	 * because they can not be enabled simultaneously on a
> > > +	 * single SoC.
> > > +	 */
> > > +	opp50@300000000 {
> > 
> > What's the 50, 100, 120 in the names?
> 
> Those are the names of the OPPs given in Table 5-7 of the AM335x data
> manual, seen here http://www.ti.com/lit/ds/symlink/am3359.pdf . I typically
> reference the table and document in the commit message of the actual DT
> patches but didn't here for the binding.

If you don't need the names, you could maybe use:

opp100: opp@275000000 {
	...
};

opp200: opp@300000000 {
	...
};
...

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
