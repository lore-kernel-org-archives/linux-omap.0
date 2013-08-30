From: Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH 1/1] arm: dts: am33xx: correcting dt node unit address for usb
Date: Fri, 30 Aug 2013 14:10:38 -0500
Message-ID: <50F5779C-87B6-43C2-81A8-C72A0614464F@codeaurora.org>
References: <1377885140-3529-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:57489 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753657Ab3H3TKY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Aug 2013 15:10:24 -0400
In-Reply-To: <1377885140-3529-1-git-send-email-mugunthanvnm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: balbi@ti.com, bigeasy@linutronix.de, bcousson@baylibre.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-usb@vger.kernel.org


On Aug 30, 2013, at 12:52 PM, Mugunthan V N wrote:

> DT node's unit address should be its own register offset address to make it a
> unique across the system. This patch corrects the incorrect USB entries with
> correct register offset for unit address.
> 
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
> ---
> arch/arm/boot/dts/am33xx.dtsi | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index f9c5da9..e9b6775 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -346,7 +346,7 @@
> 			ti,hwmods = "usb_otg_hs";
> 			status = "disabled";
> 
> -			ctrl_mod: control@44e10000 {
> +			ctrl_mod: control@44e10620 {
> 				compatible = "ti,am335x-usb-ctrl-module";
> 				reg = <0x44e10620 0x10
> 					0x44e10648 0x4>;
> @@ -449,7 +449,7 @@
> 					"tx14", "tx15";
> 			};
> 
> -			cppi41dma: dma-controller@07402000 {
> +			cppi41dma: dma-controller@47402000 {

Why isn't the unit address 47400000 ?

> 				compatible = "ti,am3359-cppi41";
> 				reg =  <0x47400000 0x1000
> 					0x47402000 0x1000
> -- 
> 1.8.4

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

