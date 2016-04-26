From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 1/5] ARM: dts: twl6030: describe gpadc
Date: Tue, 26 Apr 2016 10:26:00 -0700
Message-ID: <20160426172559.GH5995@atomide.com>
References: <cover.1461003660.git.hns@goldelico.com>
 <279e70c9badea0356944093f9493e09922c6974b.1461003660.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <279e70c9badea0356944093f9493e09922c6974b.1461003660.git.hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "H. Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org, kernel-Jl6IXVxNIMRxAtABVqVhTwC/G2K4zDHf@public.gmane.org, letux-kernel-S0jZdbWzriLCfDggNXIi3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org> [160418 11:23]:
> tested on Pandaboard ES.
> 
> Signed-off-by: H. Nikolaus Schaller <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
> ---
>  arch/arm/boot/dts/twl6030.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/twl6030.dtsi b/arch/arm/boot/dts/twl6030.dtsi
> index 55eb35f..c45f97f 100644
> --- a/arch/arm/boot/dts/twl6030.dtsi
> +++ b/arch/arm/boot/dts/twl6030.dtsi
> @@ -99,4 +99,10 @@
>  		compatible = "ti,twl6030-pwmled";
>  		#pwm-cells = <2>;
>  	};
> +
> +	gpadc {
> +		compatible = "ti,twl6030-gpadc";
> +		interrupts = <3>;
> +		#io-channel-cells = <1>;
> +	};
>  };

Applying patches 1 & 2 into omap-for-v4.7/dt thanks.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
