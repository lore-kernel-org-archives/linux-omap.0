From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH] ARM: dts: OMAP5: Add i2c aliases
Date: Wed, 16 Oct 2013 17:07:42 +0530
Message-ID: <525E7A86.4090507@ti.com>
References: <1381856405-30970-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49828 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933974Ab3JPLiK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Oct 2013 07:38:10 -0400
In-Reply-To: <1381856405-30970-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: =?ISO-8859-1?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tuesday 15 October 2013 10:30 PM, Nishanth Menon wrote:
> Currently, i2c1 and i2c5 defer probe due to pinctrl dependencies.
> This changes the i2c ID each bus is registered with in i2c-dev
> interface.
> 
> As a result of this, many userspace tools break and there is no
> consistent manner to fix the same if the i2c dev interface have no
> consistent numbering. Provide alias to allow ordering the i2c devices
> correctly.

This looks good Nishanth. Shouldn't we just go ahead and fix these for
all OMAPs/AMxx devices which would have the same problem as OMAP5 ;)

Acked-by: Rajendra Nayak <rnayak@ti.com> 
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
>  arch/arm/boot/dts/omap5.dtsi |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index e18ee7e..8970deb 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -21,6 +21,11 @@
>  	interrupt-parent = <&gic>;
>  
>  	aliases {
> +		i2c0 = &i2c1;
> +		i2c1 = &i2c2;
> +		i2c2 = &i2c3;
> +		i2c3 = &i2c4;
> +		i2c4 = &i2c5;
>  		serial0 = &uart1;
>  		serial1 = &uart2;
>  		serial2 = &uart3;
> 

