From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] ARM: dts: am57xx-beagle-x15: Provide supply for
 usb2_phy2
Date: Mon, 6 Jul 2015 05:20:41 -0700
Message-ID: <20150706122040.GE10705@atomide.com>
References: <1434552763-16782-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1434552763-16782-1-git-send-email-rogerq@ti.com>
Sender: stable-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: nm@ti.com, balbi@ti.com, linux-omap@vger.kernel.org, "v3.19+" <stable@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [150617 07:54]:
> Without this USB2 breaks if USB1 is disabled or USB1
> initializes after USB2 e.g. due to deferred probing.
> 
> Fixes: 5a0f93c6576a ("ARM: dts: Add am57xx-beagle-x15")
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Cc: stable@vger.kernel.org (v3.19+)

Applying into omap-for-v4.2/fixes thanks.

Tony

> ---
>  arch/arm/boot/dts/am57xx-beagle-x15.dts | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> index 7128fad..c9df40e 100644
> --- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
> +++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> @@ -544,6 +544,10 @@
>  	phy-supply = <&ldousb_reg>;
>  };
>  
> +&usb2_phy2 {
> +	phy-supply = <&ldousb_reg>;
> +};
> +
>  &usb1 {
>  	dr_mode = "host";
>  	pinctrl-names = "default";
> -- 
> 2.1.4
> 
