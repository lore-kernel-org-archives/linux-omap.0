From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: Re: [PATCH v2 1/2] arm/dts: AM33XX: Add D_CAN device tree data
Date: Fri, 3 Aug 2012 11:58:41 +0530
Message-ID: <501B6F99.4020506@ti.com>
References: <1343219012-19472-1-git-send-email-anilkumar@ti.com> <1343219012-19472-2-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42664 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751056Ab2HCG26 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Aug 2012 02:28:58 -0400
In-Reply-To: <1343219012-19472-2-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, mkl@pengutronix.de, linux-arm-kernel@lists.infradead.org



On 7/25/2012 5:53 PM, AnilKumar Ch wrote:
> Add Bosch D_CAN controller device tree data to AM33XX dtsi file
> by adding d_can device node with all the necessary parameters.
> 
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
>  arch/arm/boot/dts/am33xx.dtsi |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 9b974dc..2db2ffb 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -163,5 +163,10 @@
>  			#size-cells = <0>;
>  			ti,hwmods = "i2c3";
>  		};
> +
> +		dcan1: d_can@481D0000 {
> +			compatible = "bosch,d_can";
> +			ti,hwmods = "d_can1";
> +		};

Anil,

Any reason why we are only specifying dcan1 instance? Shouldn't we
specify dcan0 as well here?

Thanks,
Vaibhav


>  	};
>  };
> 
