From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: DTS: am57xx-beagle-x15: Do not include the atl
 header
Date: Mon, 16 Mar 2015 16:15:18 -0700
Message-ID: <20150316231518.GV12397@atomide.com>
References: <1424958039-15523-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:37962 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751247AbbCPXUH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Mar 2015 19:20:07 -0400
Content-Disposition: inline
In-Reply-To: <1424958039-15523-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: nm@ti.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [150226 05:46]:
> AM57xx does not have ATL block integrated.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Applying into omap-for-v4.1/dt thanks.

Tony

> ---
>  arch/arm/boot/dts/am57xx-beagle-x15.dts | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> index 6463f9ef2b54..c1d82e830a96 100644
> --- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
> +++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> @@ -8,7 +8,6 @@
>  /dts-v1/;
>  
>  #include "dra74x.dtsi"
> -#include <dt-bindings/clk/ti-dra7-atl.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  
> -- 
> 2.3.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
