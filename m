From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/7] dt-bindings: bus: Minimal TI sysc interconnect
 target module binding
Date: Tue, 10 Oct 2017 10:46:14 -0500
Message-ID: <20171010154614.gby64lglieag2lpn@rob-hp-laptop>
References: <20170929223411.9691-1-tony@atomide.com>
 <20170929223411.9691-2-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170929223411.9691-2-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Matthijs van Duin <matthijsvanduin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>, Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 29, 2017 at 03:34:05PM -0700, Tony Lindgren wrote:
> With the recently introduced omap clkctrl module binding, we can start
> moving omap hwmod data to device tree and drivers from arch/arm/mach-omap2.
> 
> To start doing this, let's introduce a device tree binding for TI
> sysc interconnect target module hardware. The sysc manages module clocks,
> idlemodes and interconnect level resets. Each interconnect target module
> can have one or more child devices connected to it.
> 
> TI sysc interconnect target module hardware is independent of the
> interconnect. It is used at least with TI L3 interconnect (Arteris NoC)
> and TI L4 interconnect (Sonics s3220). The sysc is mostly used for
> interaction between module and PRCM. It participates in the OCP Disconnect
> Protocol but other than that is mostly indepenent of the interconnect.
> 
> As all the features may not be supported for a given sysc module, we
> need to use device tree configuration for the revision of the interconnect
> target module.
> 
> Note that the interconnect target module control registers are always
> sprinked at varying locations in the unused address space of the first
> child device IP block. To avoid device tree reg conflicts, the sysc device
> provides ranges for it's children.
> 
> For a non-intrusive transition from static hwmod data to using device
> tree defined TI interconnect target module binding, we can keep things
> working with static hwmod data if device tree property "ti,hwmods" is
> specified for the the interconnect target module.
> 
> Note that additional properties for sysc capabilities will be added
> later on. For now, we can already use this binding for interconnect
> target modules that do not have any child device drivers available.
> This allows us to idle the unused interconnect target modules during
> init without the need for legacy hwmod platform data for doing it.
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
> Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>
> Cc: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
> Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
> Cc: Tomi Valkeinen <tomi.valkeinen-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/bus/ti-sysc.txt | 93 +++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/ti-sysc.txt

One typo below, otherwise:

Reviewed-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

> diff --git a/Documentation/devicetree/bindings/bus/ti-sysc.txt b/Documentation/devicetree/bindings/bus/ti-sysc.txt
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/ti-sysc.txt
> @@ -0,0 +1,93 @@
> +Texas Instruments sysc interconnect target module wrapper binding
> +
> +Texas Instruments SoCs can have a generic interconnect target module
> +hardware for devices connected to various interconnects such as L3
> +interconnect (Arteris NoC) and L4 interconnect (Sonics s3220). The sysc
> +is mostly used for interaction between module and PRCM. It participates
> +in the OCP Disconnect Protocol but other than that is mostly indepenent

s/indepenent/independent/

> +of the interconnect.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
