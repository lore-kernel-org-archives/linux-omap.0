From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/9] dt-bindings: ti-sysc: Update binding for timers and
 capabilities
Date: Sat, 16 Dec 2017 12:31:04 -0600
Message-ID: <20171216183059.ipsftfnvsyamv6fd@rob-hp-laptop>
References: <20171215180900.3243-1-tony@atomide.com>
 <20171215180900.3243-2-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171215180900.3243-2-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>, Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 15, 2017 at 10:08:52AM -0800, Tony Lindgren wrote:
> The ti-sysc binding does not yet describe the capabilities of the
> interconnect target module. So to make the ti-sysc binding usable
> for configuring the interconnect target module, we need to add few
> more properties:
> 
> 1. To detect between omap2 and omap4 timers, let's add compatibles
>    for them for "ti,sysc-omap2-timer" and,sysc-omap4-timer". This
>    makes it easier to pick up the already initialized system timers
>    later on
> 
> 2. Let's add "ti,sysc-mask" for a mask of features supported by the
>    interconnect target module. This describes what we have available
>    in the various SYSCONFIG registers
> 
> 3. Let's add "ti,sysc-midle" and "ti,sysc-sidle" lists for the master
>    and slave idle modes supported by the interconnect target module.
>    These describe the values available for MIDLE and SIDLE bits in
>    the SYSCONFIG registers
> 
> 4. Some interconnect target modules need a short delay after reset
>    before they can be accessed, let's use "ti,sysc-delay-us" for
>    that
> 
> 5. Let's add "ti,syss-mask" bit to describe the optional SYSSTATUS
>    register bits for reset done bits
> 
> 6. Let's support the two existing custom quirk properties already
>    listed in Documentation/devicetree/bindings/arm/omap/omap.txt for
>    "ti,no-reset-on-init" and "ti,no-idle-on-init"
> 
> 7. And finally, let's add a header for the binding for the dts
>    files and the driver to use
> 
> Cc: Benoît Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> Cc: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
> Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
> Cc: Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> Cc: Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
> Cc: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
> Cc: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
> Cc: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
> Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
> Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/bus/ti-sysc.txt | 36 +++++++++++++++++++++++
>  include/dt-bindings/bus/ti-sysc.h                 | 22 ++++++++++++++
>  2 files changed, 58 insertions(+)
>  create mode 100644 include/dt-bindings/bus/ti-sysc.h
> 
> diff --git a/Documentation/devicetree/bindings/bus/ti-sysc.txt b/Documentation/devicetree/bindings/bus/ti-sysc.txt
> --- a/Documentation/devicetree/bindings/bus/ti-sysc.txt
> +++ b/Documentation/devicetree/bindings/bus/ti-sysc.txt
> @@ -26,6 +26,8 @@ Required standard properties:
>  		or one of the following derivative types for hardware
>  		needing special workarounds:
>  
> +		"ti,sysc-omap2-timer"
> +		"ti,sysc-omap4-timer"
>  		"ti,sysc-omap3430-sr"
>  		"ti,sysc-omap3630-sr"
>  		"ti,sysc-omap4-sr"
> @@ -49,6 +51,26 @@ Required standard properties:
>  
>  Optional properties:
>  
> +- ti,sysc-mask	shall contain mask of supported register bits for the
> +		SYSCONFIG register as documented in the Technical Reference
> +		Manual (TRM) for the interconnect target module
> +
> +- ti,sysc-midle	list of master idle modes supported by the interconnect
> +		target module as documented in the TRM for SYSCONFIG
> +		register MIDLEMODE bits
> +
> +- ti,sysc-sidle	list of slave idle modes supported by the interconnect
> +		target module as documented in the TRM for SYSCONFIG
> +		register SIDLEMODE bits
> +
> +- ti,sysc-delay-us	delay needed after OCP softreset before accssing
> +			SYSCONFIG register again
> +
> +- ti,syss-mask	optional mask of reset done status bits as described in the
> +		TRM for SYSSTATUS registers, typically 1 with some devices
> +		having separate reset done bits for children like OHCI and
> +		EHCI
> +

Seems like a lot of this should be implied by specific compatible 
strings.

Are the bits you've defined all of them or there's more?

Rob
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
