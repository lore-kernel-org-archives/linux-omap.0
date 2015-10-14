From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: am437x-gp-evm: Add wakeup interrupt source for
 pixcir_i2c_ts
Date: Wed, 14 Oct 2015 11:46:19 +0300
Message-ID: <561E165B.3000907@ti.com>
References: <1444801956-17817-1-git-send-email-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444801956-17817-1-git-send-email-vigneshr-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Gerlach, Dave" <d-gerlach-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

+Dave

On 14/10/15 08:52, Vignesh R wrote:
> On am437x-gp-evm, pixcir_i2c_ts can wakeup the system from lower power
> state via pinctrl and IO daisy chain using generic wakeirq framework.
> With commit 3fffd1283927 ("i2c: allow specifying separate wakeup
> interrupt in device tree") i2c core allows optional wakeirq to be
> specified via device tree. Add wakeup irq entry to enable pixcir_i2c_ts
> to wake the system from low power state.
> 
> Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/boot/dts/am437x-gp-evm.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
> index 22038f21f228..69e93af7df0d 100644
> --- a/arch/arm/boot/dts/am437x-gp-evm.dts
> +++ b/arch/arm/boot/dts/am437x-gp-evm.dts
> @@ -581,8 +581,13 @@
>  
>  		attb-gpio = <&gpio3 22 GPIO_ACTIVE_HIGH>;
>  
> +		interrupts-extended = <&gpio3 22 GPIO_ACTIVE_HIGH>,
> +				      <&am43xx_pinmux 0x264>;

How does this work?

interrupts-extended property must have
1) interrupt parent
2) interrupt number
3) interrupt flags

Your change doesn't seem to comply with those requirements.

> +		interrupt-names = "tsc", "wakeup";
> +
>  		touchscreen-size-x = <1024>;
>  		touchscreen-size-y = <600>;
> +		wakeup-source;
>  	};
>  
>  	ov2659@30 {
> 

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
