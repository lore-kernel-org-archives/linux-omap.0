From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: omap5-uevm: Add Palmas power button support
Date: Mon, 20 Jul 2015 15:58:13 -0500
Message-ID: <55AD60E5.60301@ti.com>
References: <omap5uevm_palmas> <1437426451-27372-1-git-send-email-aparnab@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1437426451-27372-1-git-send-email-aparnab-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aparna Balasubramanian <aparnab-l0cyMroinI0@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 07/20/2015 04:07 PM, Aparna Balasubramanian wrote:
> Palmas on OMAP5uevm has support for power button, so enable it.
> 
> Signed-off-by: Aparna Balasubramanian <aparnab-l0cyMroinI0@public.gmane.org>
> ---
> 
> Based on kernel tag 4.2.0-rc1 and test result log is at
> http://pastebin.ubuntu.com/11910178/
> 
>  arch/arm/boot/dts/omap5-uevm.dts |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
> index 275618f..3cc8f35 100644
> --- a/arch/arm/boot/dts/omap5-uevm.dts
> +++ b/arch/arm/boot/dts/omap5-uevm.dts
> @@ -510,6 +510,13 @@
>  				};
>  			};
>  		};
> +
> +		palmas_power_button: palmas_power_button {
> +			compatible = "ti,palmas-pwrbutton";
> +			interrupt-parent = <&palmas>;
> +			interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
> +			wakeup-source;
> +		};
>  	};
>  
>  	twl6040: twl@4b {
> 

Tested (with evtest) and verified on v4.2-rc3

Acked-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>

-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
