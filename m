From: Christoph Fritz <chf.fritz-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: Re: [PATCH v3 0/4] ARM: add omap3 INCOstartec board support
Date: Fri, 07 Feb 2014 11:19:43 +0100
Message-ID: <1391768383.4937.112.camel@mars>
References: <1390782797-24105-1-git-send-email-chf.fritz@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1390782797-24105-1-git-send-email-chf.fritz-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Hans J. Koch" <hjk-vqZO0P4V72/QD6PfKP4TzA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, 2014-01-27 at 01:33 +0100, Christoph Fritz wrote:
> This set of patches adds board support for an omap3 system from INCOstartec.
> It's based on next-20140124.
> 
> Due to a regression since next-20140115 the following errors are present:
> 
>  - pin sys_clkout2, which gets configured to 24 Mhz by the fourth patch
>    in this set, erroneously outputs only 12 Mhz.
>    Just out of curiosity, configuring it to 48 Mhz puts out desired 24 Mhz.
> 
>  - omap_dss, which gets configured by the third patch in this set, fails
>    to do 'dss_set_fck_rate(fck);' in
>    drivers/video/omap2/dss/dss.c:dss_setup_default_clock() which leads to:
> 
>     | omapdss_dss: probe of omapdss_dss failed with error -22
>     | omapdss CORE error: Failed to initialize DSS platform driver
>     | panel-dpi panel-dpi.0: failed to find video source 'dpi.0
> 
>   Both regressions seem to have something to do with the clock framework. 
>   Could this be related to the DT clock conversion patches?

Now with dt clock conversion fixes on its way, any chance to get this
upstream?


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
