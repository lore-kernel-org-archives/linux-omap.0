From: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 4/8] i2c: omap: Fix missing device tree flags for omap2
Date: Thu, 14 Nov 2013 11:07:21 +0000
Message-ID: <20131114110721.GE16396@e106331-lin.cambridge.arm.com>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
 <1384396537-3486-5-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1384396537-3486-5-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-US
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 14, 2013 at 02:35:33AM +0000, Tony Lindgren wrote:
> As we claim to support device tree for mach-omap2, we
> should have the necessary flags in the driver to make it
> usable.
> 
> Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
> 
> If this looks OK, I'd like to merge this as a fix via arm-soc tree
> along with the other patches in this series as my later patches
> depend on patches in this series.
> 
> ---
>  drivers/i2c/busses/i2c-omap.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)

[...]

> +	{
> +		.compatible = "ti,omap2430-i2c",
> +		.data = &omap2430_pdata,
> +	},
> +	{
> +		.compatible = "ti,omap2420-i2c",
> +		.data = &omap2420_pdata,

Please update Documentation/devicetree/bindings/i2c/i2c-omap.txt

Otherwise, this is fine.

Thanks,
Mark.
