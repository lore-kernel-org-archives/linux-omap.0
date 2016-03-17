From: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 04/15] irqchip/gic: WARN if setting the interrupt type
 fails
Date: Thu, 17 Mar 2016 15:51:35 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1603171550200.3978@nanos>
References: <1458224359-32665-1-git-send-email-jonathanh@nvidia.com> <1458224359-32665-5-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1458224359-32665-5-git-send-email-jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, =?ISO-8859-15?Q?Beno=EEt_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, 17 Mar 2016, Jon Hunter wrote:

> Setting the interrupt type for private peripheral interrupts (PPIs) may
> not be supported by a given GIC because it is IMPLEMENTATION DEFINED
> whether this is allowed. There is no way to know if setting the type is
> supported for a given GIC and so the value written is read back to
> verify it matches the desired configuration. If it does not match then
> an error is return.
> 
> There are cases where the interrupt configuration read from firmware
> (such as a device-tree blob), has been incorrect and hence
> gic_configure_irq() has returned an error. This error has gone
> undetected because the error code returned was ignored but the interrupt
> still worked fine because the configuration for the interrupt could not
> be overwritten.
> 
> Given that this has done undetected and we should only fail to set the
> type for PPIs whose configuration cannot be changed anyway, don't return
> an error and simply WARN if this fails. This will allows us to fix up any
> places in the kernel where we should be checking the return status and
> maintain back compatibility with firmware images that may have incorrect
> interrupt configurations.

Though silently returning 0 is really the wrong thing to do. You can add the
warn, but why do you want to return success?

Thanks,

	tglx

 
