From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] ARM: dts: am57xx-beagle-x15: Provide supply for
 usb2_phy2
Date: Wed, 17 Jun 2015 17:50:02 +0300
Message-ID: <20150617175002.1abda8c85bd484fb96a6b5f2@ti.com>
References: <1434552378-11825-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48075 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752847AbbFQOuI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Jun 2015 10:50:08 -0400
In-Reply-To: <1434552378-11825-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, nm@ti.com, balbi@ti.com, linux-omap@vger.kernel.org, "v3.19+" <stable@vger.kernel>

On Wed, 17 Jun 2015 17:46:18 +0300
Roger Quadros <rogerq@ti.com> wrote:

> Without this USB2 breaks if USB1 is disabled or USB1
> initializes after USB2 e.g. due to deferred probing.
> 
> Fixes: 5a0f93c6576a ("ARM: dts: Add am57xx-beagle-x15")
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Cc: stable@vger.kernel (v3.19+)

oops. misspelled id for stable. will resend.

cheers,
-roger

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
