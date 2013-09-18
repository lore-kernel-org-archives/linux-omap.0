From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFCv2 2/3] ARM: OMAP2+: HSI: Introduce OMAP SSI driver
Date: Wed, 18 Sep 2013 12:23:31 -0700
Message-ID: <20130918192331.GD9994@atomide.com>
References: <1379277856-24571-1-git-send-email-sre@debian.org>
 <1379277856-24571-3-git-send-email-sre@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1379277856-24571-3-git-send-email-sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Carlos Chinea <cch.devel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, =?utf-8?Q?'Beno=C3=AEt?= Cousson' <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org> [130915 13:56]:
> This patch adds an OMAP SSI driver to the HSI framework.

Thanks for working on this.
 
> +config OMAP_SSI
> +	tristate "OMAP SSI hardware driver"
> +	depends on ARCH_OMAP && HSI
> +	default n
> +	---help---
> +	  SSI is a legacy version of HSI. It is usually used to connect
> +	  an application engine with a cellular modem.
> +	  If you say Y here, you will enable the OMAP SSI hardware driver.

You can drop the "default n" line here, it's the default.

> +/* TODO: HACK: define omap_pm_get_dev_context_loss_count, because it is defined
> + * in arch/arm/mach-omap2/omap-pm.h and thus not available via #include */
> +int omap_pm_get_dev_context_loss_count(struct device *dev);

You can drop this and related calls completely and rely on some
SSI configuration registers instead to detect if context was lost.

The reason for that is that the context loss count should be
implemented in Linux generic way if needed at all and we can leave
out a dependency to that.

If there's a chance that the context is only partially lost,
then of course something else is needed. So far I have not
hit that issue for MMC or serial at least, but you'd have to
test this with off-idle to verify it.

Regards,

Tony

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
