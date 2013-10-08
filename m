From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] ARM: dts: omap5-uevm: mark TWL6037 as system-power-controller
Date: Tue, 8 Oct 2013 10:43:15 -0500
Message-ID: <52542813.7020208@ti.com>
References: <1379617896-15213-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60817 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754541Ab3JHPnj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Oct 2013 11:43:39 -0400
In-Reply-To: <1379617896-15213-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 09/19/2013 02:11 PM, Nishanth Menon wrote:
> This allows the palmas pm_power_off to kick in on power off command
> and switch off the board.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Based on: (benoit's for_3.13/dts branch)
> https://git.kernel.org/cgit/linux/kernel/git/bcousson/linux-omap-dt.git/log/?h=for_3.13/dts
> This uses the support introduced by:
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=b81eec09a484c588ead035003ce7555ca8a9963a
> 
>  arch/arm/boot/dts/omap5-uevm.dts |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
> index da25a14..8227386 100644
> --- a/arch/arm/boot/dts/omap5-uevm.dts
> +++ b/arch/arm/boot/dts/omap5-uevm.dts
> @@ -271,6 +271,7 @@
>  		reg = <0x48>;
>  		interrupt-controller;
>  		#interrupt-cells = <2>;
> +		ti,system-power-controller;
>  
>  		extcon_usb3: palmas_usb {
>  			compatible = "ti,palmas-usb-vid";
> 
Gentle ping.
patchworks link: https://patchwork.kernel.org/patch/2913111/

-- 
Regards,
Nishanth Menon
