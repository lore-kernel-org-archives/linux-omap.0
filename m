From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 00/37] ARM: dts: Fix fixed regulators enable GPIO polarity
Date: Mon, 12 Oct 2015 14:46:54 -0700
Message-ID: <20151012214654.GE23801@atomide.com>
References: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1444684386-17094-1-git-send-email-laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> [151012 14:17]:
> Hello,
> 
> While working on regulators, GPIOs and DT I noticed that many of our DT source
> files incorrectly describe fixed regulators. The common error patterns are
> 
> - Usage of the undefined (and never parsed) enable-active-low property
> - Usage of the enable-active-high property without specifying an enable GPIO
> - Typos in the enabl GPIO property name (gpios instead of gpio)
> - Mismatch between the enable-active-high property (or the lack thereof) and
>   the enable GPIO flags
> 
> This patch series fixes those issues in all the DT sources after locating the
> errors using the following script.
> 
> ------------------------------------------------------------------------------
> #!/bin/sh
> 
> echo $1
> cat $1 | awk '
> BEGIN {
> 	open_drain = 0;
> 	active_high = 0;
> 	gpio = 0;
> 	flags = 0;
> }
> 
> match($0, /([a-zA-Z0-9@_-]*) {/, ary) {
> 	name = ary[1];
> }
> 
> /compatible.*"regulator-fixed"/ {
> 	found = 1;
> }
> 
> /enable-active-high/ {
> 	active_high = 1;
> }
> 
> /gpio-open-drain/ {
> 	open_drain = 1;
> }
> 
> match($0, /gpio += <.* ([^ ]*)>/, ary) {
> 	gpio = 1;
> 	flags = ary[1];
> 	if (flags == 0)
> 		flags = "GPIO_ACTIVE_HIGH";
> }
> 
> /}/ {
> 	if (found) {
> 		if (gpio) {
> 			print "\t" name ": active high " active_high " " flags " open drain " open_drain;
> 			if ((active_high && flags == "GPIO_ACTIVE_LOW") ||
> 			    (!active_high && flags == "GPIO_ACTIVE_HIGH"))
> 				print "WARNING: enable-active-high and flags do not match"
> 		} else {
> 			if (active_high)
> 				print "WARNING: active high without GPIO"
> 			if (open_drain)
> 				print "WARNING: open drain without GPIO"
> 		}
> 	}
> 
> 	gpio = 0;
> 	found = 0;
> 	active_high = 0;
> 	open_drain = 0;
> 	flags = 0;
> }
> '
> ------------------------------------------------------------------------------
> 
> All patches except for the ones touching omap3-beagle-xm and omap3-overo-base
> are untested as I lack test hardware.
> 
> As there's no dependency between the patches touching different source files
> the appropriate maintainers could take their share of the patches in their
> tree. Alternatively I could send a single pull request after collecting all
> acks but that might be more complex.

Nice clean-up. For omaps, there's an earlier patch posted by
Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org> as "[PATCH] ARM: dts: Use
defined GPIO constants in flags cell for OMAP2+ boards". Can you guys do some
cross checking and let me know which combination I should appluy for omaps?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
