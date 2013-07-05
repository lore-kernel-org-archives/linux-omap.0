From: Ruchika Kharwar <ruchika-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/5] arm: dts: am33xx: add USB phy nodes
Date: Fri, 5 Jul 2013 09:41:25 -0500
Message-ID: <51D6DB15.1050701@ti.com>
References: <1373031178-8871-1-git-send-email-bigeasy@linutronix.de> <1373031178-8871-3-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1373031178-8871-3-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, george.cherian-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org


On 07/05/2013 08:32 AM, Sebastian Andrzej Siewior wrote:
> The memory address contains three pieces that is the reset module which
> is currently the only one used and two other pices which seem
> interresting based on what the register.
Please fix typos "pices.. interresting".. also the description is not clear.
> The phy id (0 or 1) can be obtained via of_alias_get_id(). However once
> we need this, we should used something for common register access.

>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
> ---
>   arch/arm/boot/dts/am33xx.dtsi | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 0d4df90..a24f1cb 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -333,6 +333,22 @@
>   			status = "disabled";
>   		};
>   
> +		musb0_phy: phy0@47401000 {
> +			compatible = "ti,am335x-usb-phy";
> +			reg = <0x44e10620 0x2c		/* reset module */
> +				0x47401000 0x200
> +				0x47401300 0x100>;
> +			status = "disabled";
> +		};
> +
> +		musb1_phy: phy1@47401800 {
> +			compatible = "ti,am335x-usb-phy";
> +			reg = <0x44e10628 0x24		/* reset module */
> +				0x47401800 0x200
> +				0x47401b00 0x100>;
> +			status = "disabled";
> +		};
> +
>   		usb@47400000 {
>   			compatible = "ti,musb-am33xx";
>   			reg = <0x47400000 0x1000	/* usbss */

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
