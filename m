From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] arm, am335x: add support for Moxa UC-8100-ME-T open
 platform
Date: Thu, 10 Aug 2017 10:03:41 -0700
Message-ID: <20170810170341.GM8569@atomide.com>
References: <20170802065757.1074-1-sz.lin@moxa.com>
 <20170810155246.pfaii3zb5jblluwy@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170810155246.pfaii3zb5jblluwy@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: SZ Lin <sz.lin-D4fb9hXD9d4@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [170810 08:53]:
> On Wed, Aug 02, 2017 at 02:57:57PM +0800, SZ Lin wrote:
> > Add support for Moxa UC-8100-ME-T open platform
...

> > +	vbat: fixedregulator@0 {
> 
> Unit address without reg property is not valid (build with W=2). Perhaps 
> vbat-regulator instead.
...

> > +	/* Power supply provides a fixed 3.3V @3A */
> > +	vmmcsd_fixed: fixedregulator@1 {
> 
> Ditto
> 
> With those fixed,
> 
> Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

I've fixed it up here and will apply into omap-for-v4.14/dt
thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
