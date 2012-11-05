From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH V2 2/3] ARM: dts: omap5: EMIF device tree data for OMAP5
 boards
Date: Mon, 5 Nov 2012 11:55:48 +0100
Message-ID: <50979B34.8010009@ti.com>
References: <1349959669-16366-1-git-send-email-lokeshvutla@ti.com> <1349959669-16366-3-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52041 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932092Ab2KEK4E (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 5 Nov 2012 05:56:04 -0500
In-Reply-To: <1349959669-16366-3-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On 10/11/2012 02:47 PM, Lokesh Vutla wrote:
> Adding EMIF device tree data for OMAP5 boards.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>  arch/arm/boot/dts/omap5.dtsi |   24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index 5db33f4..445aeea 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -319,5 +319,29 @@
>  			ti,buffer-size = <128>;
>  			ti,hwmods = "mcbsp3";
>  		};
> +
> +		emif1: emif@0x4c000000 {
> +			compatible	= "ti,emif-4d5";
> +			ti,hwmods	= "emif1";
> +			phy-type	= <2>;
> +			reg = <0x4c000000 0x3ff>;

Should 0x400. This parameter is the size, not the end address.

> +			interrupts = <0 110 0x4>;
> +			interrupt-parent = <&gic>;

Please remove the interrupt-parent. It is not needed since DT will use
the parent node to get it. It will avoid duplicating the entry for every
nodes.

> +			hw-caps-read-idle-ctrl;
> +			hw-caps-ll-interface;
> +			hw-caps-temp-alert;
> +		};
> +
> +		emif2: emif@0x4d000000 {
> +			compatible	= "ti,emif-4d5";
> +			ti,hwmods	= "emif2";
> +			phy-type	= <2>;

Can you just add a comment to give more information. I know this is in
the binding documentation, but some more comment never hurt.

> +			reg = <0x4d000000 0x3ff>;

0x400 as well.

> +			interrupts = <0 111 0x4>;
> +			interrupt-parent = <&gic>;

Ditto.

> +			hw-caps-read-idle-ctrl;
> +			hw-caps-ll-interface;
> +			hw-caps-temp-alert;
> +		};
>  	};
>  };
> 

Regards,
Benoit
