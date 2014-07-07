From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 6/6] ARM: dts: dra7-evm: Add regulator information to
 USB2 PHYs
Date: Mon, 7 Jul 2014 01:29:56 -0700
Message-ID: <20140707082956.GJ28884@atomide.com>
References: <1404467748-12154-1-git-send-email-rogerq@ti.com>
 <1404467748-12154-7-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:15908 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751768AbaGGI3z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jul 2014 04:29:55 -0400
Content-Disposition: inline
In-Reply-To: <1404467748-12154-7-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: kishon@ti.com, balbi@ti.com, nsekhar@ti.com, nm@ti.com, george.cherian@ti.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [140704 02:58]:
> The ldousb_reg regulator provides power to the USB1 and USB2
> High Speed PHYs.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>

This too:

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/boot/dts/dra7-evm.dts | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
> index 8308954..50f8022 100644
> --- a/arch/arm/boot/dts/dra7-evm.dts
> +++ b/arch/arm/boot/dts/dra7-evm.dts
> @@ -496,3 +496,11 @@
>  		};
>  	};
>  };
> +
> +&usb2_phy1 {
> +	phy-supply = <&ldousb_reg>;
> +};
> +
> +&usb2_phy2 {
> +	phy-supply = <&ldousb_reg>;
> +};
> -- 
> 1.8.3.2
> 
