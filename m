From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v7 4/4] ARM: dts: am43xx: fix starting offset of
 NAND.filesystem MTD partition
Date: Mon, 19 May 2014 15:12:52 -0700
Message-ID: <20140519221252.GH11945@atomide.com>
References: <1400490948-11571-1-git-send-email-pekon@ti.com>
 <1400490948-11571-5-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:43417 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751284AbaESWM4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 May 2014 18:12:56 -0400
Content-Disposition: inline
In-Reply-To: <1400490948-11571-5-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Stefan Roese <sr@denx.de>, Javier Martinez Canillas <javier@dowhile0.org>, Roger Quadros <rogerq@ti.com>

* Pekon Gupta <pekon@ti.com> [140519 02:16]:
> MTD NAND partition for file-system should start at offset=0xA00000
> 
> Signed-off-by: Pekon Gupta <pekon@ti.com>
> Reviewed-by: Javier Martinez Canillas <javier@dowhile0.org>

Applying this too into omap-for-v3.16/dt.

Tony

> ---
>  arch/arm/boot/dts/am43x-epos-evm.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
> index 2a0fbbb..ad362c5 100644
> --- a/arch/arm/boot/dts/am43x-epos-evm.dts
> +++ b/arch/arm/boot/dts/am43x-epos-evm.dts
> @@ -366,7 +366,7 @@
>  		};
>  		partition@9 {
>  			label = "NAND.file-system";
> -			reg = <0x00800000 0x1F600000>;
> +			reg = <0x00a00000 0x1f600000>;
>  		};
>  	};
>  };
> -- 
> 1.8.5.1.163.gd7aced9
> 
