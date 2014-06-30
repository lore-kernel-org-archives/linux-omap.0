From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 12/13] ARM: dts: am33xx: add the PRUSSv2 device
Date: Mon, 30 Jun 2014 10:36:42 +0100
Message-ID: <20140630093642.GV7262@leverpostej>
References: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
 <1404058907-21112-13-git-send-email-a.heider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:62158 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755147AbaF3JhU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jun 2014 05:37:20 -0400
Content-Disposition: inline
In-Reply-To: <1404058907-21112-13-git-send-email-a.heider@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andre Heider <a.heider@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Matt Porter <mporter@linaro.org>, "Hans J . Koch" <hjk@hansjkoch.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Sun, Jun 29, 2014 at 05:21:46PM +0100, Andre Heider wrote:
> Signed-off-by: Andre Heider <a.heider@gmail.com>
> ---
>  arch/arm/boot/dts/am33xx.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 4a4e02d..28a7e5d 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -409,6 +409,15 @@
>  			ti,hwmods = "rtc";
>  		};
>  
> +		pruss: pruss@4a300000 {
> +			compatible = "ti,pruss-v2";
> +			ti,hwmods = "pruss";
> +			reg = <0x4a300000 0x080000>;
> +			interrupts = <20 21 22 23 24 25 26 27>;

Could this please have entries individually bracketed?

Thanks,
Mark.

> +			interrupt-parent = <&intc>;
> +			status = "disabled";
> +		};
> +
>  		spi0: spi@48030000 {
>  			compatible = "ti,omap4-mcspi";
>  			#address-cells = <1>;
> -- 
> 2.0.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
