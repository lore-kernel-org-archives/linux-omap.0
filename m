From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: omap3-devkit8000: Fix NAND DT node
Date: Wed, 20 May 2015 09:49:02 -0700
Message-ID: <20150520164901.GV10274@atomide.com>
References: <1432069793-10141-1-git-send-email-anthoine.bourgeois@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:52442 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753534AbbETQtE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 May 2015 12:49:04 -0400
Content-Disposition: inline
In-Reply-To: <1432069793-10141-1-git-send-email-anthoine.bourgeois@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>
Cc: linux-omap@vger.kernel.org

* Anthoine Bourgeois <anthoine.bourgeois@gmail.com> [150519 14:11]:
> Add nand-ecc-opt and device-width properties to enable nand support on
> Devkit8000.
> 
> Signed-off-by: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>
> ---
>  arch/arm/boot/dts/omap3-devkit8000.dts | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-devkit8000.dts b/arch/arm/boot/dts/omap3-devkit8000.dts
> index 169037e..283db1d 100644
> --- a/arch/arm/boot/dts/omap3-devkit8000.dts
> +++ b/arch/arm/boot/dts/omap3-devkit8000.dts
> @@ -111,6 +111,8 @@
>  	nand@0,0 {
>  		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
>  		nand-bus-width = <16>;
> +		gpmc,device-width = <2>;
> +		ti,nand-ecc-opt = "sw";
>  
>  		gpmc,sync-clk-ps = <0>;
>  		gpmc,cs-on-ns = <0>;

Applying into omap-for-v4.1/fixes thanks.

Tony
