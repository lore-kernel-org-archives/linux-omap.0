From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 3/4] ARM: dts: omap4-panda: Provide USB PHY clock
Date: Wed, 14 Aug 2013 11:11:49 +0300
Message-ID: <520B3BC5.4080409@ti.com>
References: <1374676356-31286-1-git-send-email-rogerq@ti.com> <1374676356-31286-4-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45309 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759379Ab3HNIMq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Aug 2013 04:12:46 -0400
In-Reply-To: <1374676356-31286-4-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: benoit.cousson@linaro.org
Cc: Roger Quadros <rogerq@ti.com>, tony@atomide.com, t-kristo@ti.com, mturquette@linaro.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

+Benoit

On 07/24/2013 05:32 PM, Roger Quadros wrote:
> The USB PHY gets its clock from AUXCLK3. Provide this
> information.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm/boot/dts/omap4-panda-common.dtsi |    8 ++------
>  1 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
> index faa95b5..dd793ca 100644
> --- a/arch/arm/boot/dts/omap4-panda-common.dtsi
> +++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
> @@ -99,12 +99,8 @@
>  		compatible = "usb-nop-xceiv";
>  		reset-supply = <&hsusb1_reset>;
>  		vcc-supply = <&hsusb1_power>;
> -	/**
> -	 * FIXME:
> -	 * put the right clock phandle here when available
> -	 *	clocks = <&auxclk3>;
> -	 *	clock-names = "main_clk";
> -	 */
> +		clocks = <&auxclk3_ck>;
> +		clock-names = "main_clk";
>  		clock-frequency = <19200000>;
>  	};
>  };
> 

