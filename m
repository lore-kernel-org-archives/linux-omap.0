From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am335x-evm: Fix 5th NAND partition's name
Date: Thu, 6 Nov 2014 10:21:32 -0800
Message-ID: <20141106182131.GB31454@atomide.com>
References: <1413890745-3855-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:19163 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750877AbaKFSWc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2014 13:22:32 -0500
Content-Disposition: inline
In-Reply-To: <1413890745-3855-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: javier.martinez@collabora.co.uk, pekon@pek-sem.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sekhar Nori <nsekhar@ti.com>

* Roger Quadros <rogerq@ti.com> [141021 04:27]:
> The 5th NAND partition should be named "NAND.u-boot-spl-os"
> instead of "NAND.u-boot-spl". This is to be consistent with other
> TI boards as well as u-boot.

Applying into omap-for-v3.18/fixes thanks.

Tony
 
> Fixes: 91994facdd2d ("ARM: dts: am335x-evm: NAND: update MTD partition table")
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>  arch/arm/boot/dts/am335x-evm.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
> index e2156a5..c4b968f 100644
> --- a/arch/arm/boot/dts/am335x-evm.dts
> +++ b/arch/arm/boot/dts/am335x-evm.dts
> @@ -489,7 +489,7 @@
>  			reg = <0x00060000 0x00020000>;
>  		};
>  		partition@4 {
> -			label = "NAND.u-boot-spl";
> +			label = "NAND.u-boot-spl-os";
>  			reg = <0x00080000 0x00040000>;
>  		};
>  		partition@5 {
> -- 
> 1.8.3.2
> 
