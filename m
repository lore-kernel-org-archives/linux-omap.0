From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/3] pinctrl: bindings: Add OMAP pinctrl binding
Date: Mon, 25 Aug 2014 10:25:07 -0700
Message-ID: <20140825172506.GM17254@atomide.com>
References: <1408716062-26055-1-git-send-email-nm@ti.com>
 <1408716062-26055-2-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1408716062-26055-2-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> [140822 07:03]:
> Add basic skeleton of OMAP pinctrl bindings. This is compatible with
> pinctrl,single bindings and is meant purely as a reference point.
> 
> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>

Looks like you have ti,omap2420-padconf and ti,omap2430-padconf missing
but after adding those too:

Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

> ---
>  .../bindings/pinctrl/ti,omap-pinctrl.txt           |    9 +++++++++
>  1 file changed, 9 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/ti,omap-pinctrl.txt
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/ti,omap-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/ti,omap-pinctrl.txt
> new file mode 100644
> index 0000000..156d964
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/ti,omap-pinctrl.txt
> @@ -0,0 +1,9 @@
> +OMAP Pinctrl definitions
> +
> +Required properties:
> +- compatible : Should be one of:
> +  "ti,omap3-padconf" - OMAP3 compatible pinctrl
> +  "ti,omap4-padconf" - OMAP4 compatible pinctrl
> +  "ti,omap5-padconf" - OMAP5 compatible pinctrl
> +
> +See Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt for further details.
> -- 
> 1.7.9.5
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
