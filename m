From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 6/7] am33xx: define syscon control module device node
Date: Mon, 25 Aug 2014 09:01:57 -0700
Message-ID: <20140825160156.GH17254@atomide.com>
References: <1408947828-22316-1-git-send-email-mpa@pengutronix.de>
 <1408947828-22316-7-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51615 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755980AbaHYQCF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Aug 2014 12:02:05 -0400
Content-Disposition: inline
In-Reply-To: <1408947828-22316-7-git-send-email-mpa@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Wolfram Sang <wsa@the-dreams.de>, Steven Rostedt <rostedt@goodmis.org>, Mugunthan V N <mugunthanvnm@ti.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

* Markus Pargmann <mpa@pengutronix.de> [140824 23:24]:
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> Reviewed-by: Wolfram Sang <wsa@the-dreams.de>

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/boot/dts/am33xx.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 3a0a161342ba..25e38b6ac376 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -132,6 +132,11 @@
>  			};
>  		};
>  
> +		cm: syscon@44e10000 {
> +			compatible = "ti,am33xx-controlmodule", "syscon";
> +			reg = <0x44e10000 0x800>;
> +		};
> +
>  		intc: interrupt-controller@48200000 {
>  			compatible = "ti,omap2-intc";
>  			interrupt-controller;
> -- 
> 2.1.0.rc1
> 
