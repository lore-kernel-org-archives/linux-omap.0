From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3 4/4] ARM: dts: am43xx: fix starting offset of
 NAND.filesystem MTD partition
Date: Tue, 6 May 2014 08:55:20 -0700
Message-ID: <20140506155520.GG18474@atomide.com>
References: <1398157362-32571-1-git-send-email-pekon@ti.com>
 <1398157362-32571-2-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52109 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757874AbaEFPzZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 May 2014 11:55:25 -0400
Content-Disposition: inline
In-Reply-To: <1398157362-32571-2-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: bcousson@baylibre.com, linux-omap <linux-omap@vger.kernel.org>

* Pekon Gupta <pekon@ti.com> [140422 02:03]:
> MTD NAND partition for file-system should start at offset=0xA00000

Applying to omap-for-v3.16/fixes-not-urgent with hex changed to use
lower case like we tend to do.

Hmm, how come you did not fold this into the original patch to the
mainline kernel as it seems you had the fix in the vendor tree
earlier?

Regards,

Tony
 
> Signed-off-by: Pekon Gupta <pekon@ti.com>
> ---
>  arch/arm/boot/dts/am43x-epos-evm.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
> index 167dbc8..d09e6fb 100644
> --- a/arch/arm/boot/dts/am43x-epos-evm.dts
> +++ b/arch/arm/boot/dts/am43x-epos-evm.dts
> @@ -341,7 +341,7 @@
>  		};
>  		partition@9 {
>  			label = "NAND.file-system";
> -			reg = <0x00800000 0x1F600000>;
> +			reg = <0x00A00000 0x1F600000>;
>  		};
>  	};
>  };
> -- 
> 1.8.5.1.163.gd7aced9
> 
