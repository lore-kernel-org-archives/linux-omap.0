From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Add USB hooks into NanoBone DTS file
Date: Wed, 14 Oct 2015 12:23:35 -0700
Message-ID: <20151014192335.GG10113@atomide.com>
References: <561E5908.8010004@newflow.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <561E5908.8010004@newflow.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Jackson <mpfj@newflow.co.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

* Mark Jackson <mpfj@newflow.co.uk> [151014 06:35]:
> Add USB hooks into NanoBone DTS file

Hmm looking at things, we really should not set status = "disabled"
for any of the internal devices. Setting "disabled" makes the kernel
completely ignore the device and we're better off from PM point of
view to probe and idle the device. The devices are there for sure, and
typically just the pins are not configured for them.

How about just remove the status = "disabled" from am33xx.dtsi
instead?

Regards,

Tony

> Signed-off-by: Mark Jackson <mpfj@newflow.co.uk>
> ---
>  arch/arm/boot/dts/am335x-nano.dts | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am335x-nano.dts b/arch/arm/boot/dts/am335x-nano.dts
> index 5ed4ca6..b86937a 100644
> --- a/arch/arm/boot/dts/am335x-nano.dts
> +++ b/arch/arm/boot/dts/am335x-nano.dts
> @@ -375,6 +375,23 @@
>  	wp-gpios = <&gpio3 18 0>;
>  };
>  
> +&usb {
> +	status = "okay";
> +};
> +
> +&usb_ctrl_mod {
> +	status = "okay";
> +};
> +
> +&usb0_phy {
> +	status = "okay";
> +};
> +
> +&usb0 {
> +	status = "okay";
> +	dr_mode = "host";
> +};
> +
>  #include "tps65217.dtsi"
>  
>  &tps {
> -- 
> 1.9.1
> 
