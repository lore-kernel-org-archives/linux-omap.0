From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/2] ARM: dts: N9/N950: fix boot hang with 3.14-rc1
Date: Tue, 11 Feb 2014 14:11:10 -0600
Message-ID: <52FA83DE.70504@ti.com>
References: <1391947956-24462-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53922 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753938AbaBKULr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Feb 2014 15:11:47 -0500
In-Reply-To: <1391947956-24462-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>, =?ISO-8859-1?Q?Beno=EEt_Couss?= =?ISO-8859-1?Q?on?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 02/09/2014 06:12 AM, Aaro Koskinen wrote:
> N9/N950 does not boot anymore with 3.14-rc1, because SoC compatible
> property is missing. Fix that.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Reviewed-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/boot/dts/omap3-n9.dts   | 2 +-
>  arch/arm/boot/dts/omap3-n950.dts | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-n9.dts b/arch/arm/boot/dts/omap3-n9.dts
> index 39828ce464ee..9938b5dc1909 100644
> --- a/arch/arm/boot/dts/omap3-n9.dts
> +++ b/arch/arm/boot/dts/omap3-n9.dts
> @@ -14,5 +14,5 @@
>  
>  / {
>  	model = "Nokia N9";
> -	compatible = "nokia,omap3-n9", "ti,omap3";
> +	compatible = "nokia,omap3-n9", "ti,omap36xx", "ti,omap3";
>  };
> diff --git a/arch/arm/boot/dts/omap3-n950.dts b/arch/arm/boot/dts/omap3-n950.dts
> index b076a526b999..261c5589bfa3 100644
> --- a/arch/arm/boot/dts/omap3-n950.dts
> +++ b/arch/arm/boot/dts/omap3-n950.dts
> @@ -14,5 +14,5 @@
>  
>  / {
>  	model = "Nokia N950";
> -	compatible = "nokia,omap3-n950", "ti,omap3";
> +	compatible = "nokia,omap3-n950", "ti,omap36xx", "ti,omap3";
>  };
> 


-- 
Regards,
Nishanth Menon
