From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: am437x-idk: Configure uart0 padconf wakeirq
Date: Mon, 12 Feb 2018 10:23:58 +0530
Message-ID: <b5fba201-a1ad-9192-27a6-f7d8d5bc6a40@ti.com>
References: <20180209161913.19542-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180209161913.19542-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Gerlach, Dave" <d-gerlach-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Friday 09 February 2018 09:49 PM, Tony Lindgren wrote:
> We can use CTRL_CONF_UART0_RXD pad as the wakeirq and then
> the serial console will work with wake up events.
> 
> Note that the uart still needs to be configured for idle
> timeouts for PM runtime for the wakeirq to get activated.
> That can be done via sysfs to set autosuspend_delay_ms to
> 3000, wakeup enabled and and control auto.
> 
> Cc: Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>  arch/arm/boot/dts/am437x-idk-evm.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am437x-idk-evm.dts
> b/arch/arm/boot/dts/am437x-idk-evm.dts
> --- a/arch/arm/boot/dts/am437x-idk-evm.dts
> +++ b/arch/arm/boot/dts/am437x-idk-evm.dts
> @@ -533,3 +533,9 @@
>                  opp-suspend;
>          };
>  };
> +
> +&uart0 {
> +       /* UART0 interrupt and CTRL_CONF_UART0_RXD pad as wakeirq */
> +       interrupts-extended = <&gic GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
> +                             <&am43xx_pinmux 0x170>;
> +};

As per Section 6.4.5 Wakeup Sources/Events AM437x TRM, UART0 is in
Wakeup Power domain  and can wakeup the system directly. AFAIK, there is
no need to use CTRL_CONF_UART0_RXD pad as the wakeirq.

-- 
Regards
Vignesh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
