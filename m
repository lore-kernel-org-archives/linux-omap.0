From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 7/7] arm: dts: am33xx, Add syscon phandle to cpsw node
Date: Mon, 25 Aug 2014 09:02:25 -0700
Message-ID: <20140825160225.GI17254@atomide.com>
References: <1408947828-22316-1-git-send-email-mpa@pengutronix.de>
 <1408947828-22316-8-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52555 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755979AbaHYQCd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Aug 2014 12:02:33 -0400
Content-Disposition: inline
In-Reply-To: <1408947828-22316-8-git-send-email-mpa@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Wolfram Sang <wsa@the-dreams.de>, Steven Rostedt <rostedt@goodmis.org>, Mugunthan V N <mugunthanvnm@ti.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

* Markus Pargmann <mpa@pengutronix.de> [140824 23:24]:
> There are 2 MACIDs stored in the control module of the am33xx. These are
> read by the cpsw driver if no valid MACID was found in the devicetree.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> Reviewed-by: Wolfram Sang <wsa@the-dreams.de>

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/boot/dts/am33xx.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 25e38b6ac376..13e44b0f5adc 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -701,6 +701,7 @@
>  			 */
>  			interrupts = <40 41 42 43>;
>  			ranges;
> +			syscon = <&cm>;
>  			status = "disabled";
>  
>  			davinci_mdio: mdio@4a101000 {
> -- 
> 2.1.0.rc1
> 
