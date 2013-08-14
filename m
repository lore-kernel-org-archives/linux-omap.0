From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 4/4] ARM: dts: omap5-uevm: Provide USB PHY clock
Date: Wed, 14 Aug 2013 11:14:02 +0300
Message-ID: <520B3C4A.8060504@ti.com>
References: <1374676356-31286-1-git-send-email-rogerq@ti.com> <1374676356-31286-5-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49898 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759447Ab3HNIOb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Aug 2013 04:14:31 -0400
In-Reply-To: <1374676356-31286-5-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>
Cc: Roger Quadros <rogerq@ti.com>, tony@atomide.com, t-kristo@ti.com, mturquette@linaro.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

+Benoit

On 07/24/2013 05:32 PM, Roger Quadros wrote:
> The HS USB 2 PHY gets its clock from AUXCLK1. Provide this
> information.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm/boot/dts/omap5-uevm.dts |    8 ++------
>  1 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
> index 08b7267..a366cde 100644
> --- a/arch/arm/boot/dts/omap5-uevm.dts
> +++ b/arch/arm/boot/dts/omap5-uevm.dts
> @@ -42,12 +42,8 @@
>  	hsusb2_phy: hsusb2_phy {
>  		compatible = "usb-nop-xceiv";
>  		reset-supply = <&hsusb2_reset>;
> -	/**
> -	  * FIXME
> -	  * Put the right clock phandle here when available
> -	  *	clocks = <&auxclk1>;
> -	  *	clock-names = "main_clk";
> -	  */
> +		clocks = <&auxclk1_ck>;
> +		clock-names = "main_clk";
>  		clock-frequency = <19200000>;
>  	};
>  
> 

