From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH V2] ARM: dts: omap5-uevm: Add Uart wakeup interrupt
Date: Wed, 20 May 2015 11:03:16 -0700
Message-ID: <20150520180316.GH10274@atomide.com>
References: <1431728200-25486-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1431728200-25486-1-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Nishanth Menon <nm-l0cyMroinI0@public.gmane.org> [150515 15:18]:
> UART3 wakeup takes place with iodaisy chain. enable the wakeup pin.
> 
> Reported-by: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>

Applying into omap-for-v4.2/dt thanks.

Tony

> ---
> 
> Test on linus master (f0897f4cc0fc) with 8250  driver: http://pastebin.ubuntu.com/11154663/
> Applies on next-20150515 and linus master (f0897f4cc0fc)
> 
> Changes in V2:
> 	- switched over to wakeupgen instead of GIC.
> 	- retested.
> V1: https://patchwork.kernel.org/patch/6416981/
> 
>  arch/arm/boot/dts/omap5-uevm.dts |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
> index 74777a6e200a..c4dc487832ea 100644
> --- a/arch/arm/boot/dts/omap5-uevm.dts
> +++ b/arch/arm/boot/dts/omap5-uevm.dts
> @@ -604,6 +604,8 @@
>  &uart3 {
>          pinctrl-names = "default";
>          pinctrl-0 = <&uart3_pins>;
> +	interrupts-extended = <&wakeupgen GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
> +			      <&omap5_pmx_core 0x19c>;
>  };
>  
>  &uart5 {
> -- 
> 1.7.9.5
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
