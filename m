From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] ARM: dts: dra7-evm: Fix interrupt line of pcf@i2c1:0x21
Date: Fri, 26 Sep 2014 16:12:21 +0300
Message-ID: <54256635.1010704@ti.com>
References: <1411736556-4538-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49388 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753782AbaIZNMY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Sep 2014 09:12:24 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id s8QDCNqU014581
	for <linux-omap@vger.kernel.org>; Fri, 26 Sep 2014 08:12:23 -0500
Received: from DLEE70.ent.ti.com (dlemailx.itg.ti.com [157.170.170.113])
	by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id s8QDCNYv031839
	for <linux-omap@vger.kernel.org>; Fri, 26 Sep 2014 08:12:23 -0500
In-Reply-To: <1411736556-4538-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: nsekhar@ti.com
Cc: george.cherian@ti.com, balbi@ti.com, linux-omap@vger.kernel.org

Oops. send to the wrong mailing list. Please ignore.

cheers,
-roger

On 09/26/2014 04:02 PM, Roger Quadros wrote:
> The interrupt line of pcf I/O expander chip @i2c1:0x21
> is tied to gpio6_11 and not gpio6_14. Fix that.
> 
> Without this USB_ID detection will not work and I2C3 bus activity
> will cause spurious interrupts for the I/O expander chip.
> 
> Fixes: 87991e7b4dd4 (ARM: dts: dra7-evm: Add extcon nodes for USB)
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm/boot/dts/dra7-evm.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
> index 8ddd012..53b6fba 100644
> --- a/arch/arm/boot/dts/dra7-evm.dts
> +++ b/arch/arm/boot/dts/dra7-evm.dts
> @@ -606,7 +606,7 @@
>  		gpio-controller;
>  		#gpio-cells = <2>;
>  		interrupt-parent = <&gpio6>;
> -		interrupts = <14 IRQ_TYPE_EDGE_FALLING>;
> +		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
>  		interrupt-controller;
>  		#interrupt-cells = <2>;
>  	};
> 

