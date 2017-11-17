From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: Fix omap4 hang with GPS connected to USB by
 using wakeupgen
Date: Fri, 17 Nov 2017 09:00:32 -0800
Message-ID: <20171117170032.GN28152@atomide.com>
References: <20171117165658.21003-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171117165658.21003-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Adding Tero to Cc also.

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [171117 16:59]:
> There's been a reproducable USB OHCI/EHCI cpuidle related hang on omap4
> for a while that happens after about 20 - 40 minutes on an idle system
> with some data feeding device being connected, like a USB GPS device or
> a cellular modem.
> 
> This issue happens in cpuidle states C2 and C3 and does not happen if
> cpuidle is limited to C1 state only. The symptoms are that the whole
> system hangs and never wakes up from idle, and if a watchdog is
> configured the system reboots after a while.
> 
> Turns out that OHCI/EHCI devices on omap4 are trying to use the GIC
> interrupt controller directly as a parent instead of the WUGEN. We
> need to pass the interrupts through WUGEN to GIC to provide the wakeup
> events for the processor.
> 
> Let's fix the issue by removing the gic interrupt-parent and use the
> default interrupt-parent wakeupgen instead. Note that omap5.dtsi had
> this already fixes earlier by commit 7136d457f365 ("ARM: omap: convert
> wakeupgen to stacked domains") but we somehow missed omap4 at that
> point.
> 
> Fixes: 7136d457f365 ("ARM: omap: convert wakeupgen to stacked domains")
> Cc: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
> Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> Cc: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
> Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> Cc: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  arch/arm/boot/dts/omap4.dtsi | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -1081,14 +1081,12 @@
>  			usbhsohci: ohci@4a064800 {
>  				compatible = "ti,ohci-omap3";
>  				reg = <0x4a064800 0x400>;
> -				interrupt-parent = <&gic>;
>  				interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
>  			};
>  
>  			usbhsehci: ehci@4a064c00 {
>  				compatible = "ti,ehci-omap";
>  				reg = <0x4a064c00 0x400>;
> -				interrupt-parent = <&gic>;
>  				interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
>  			};
>  		};
> -- 
> 2.15.0
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
