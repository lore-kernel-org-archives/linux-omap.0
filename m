From: pekon <pekon@pek-sem.com>
Subject: Re: [PATCH 2/2] ARM: dts: dra7-evm: Fix 8th NAND partition's name
Date: Sat, 06 Sep 2014 16:25:12 +0530
Message-ID: <540AE810.2060803@pek-sem.com>
References: <1409743052-632-1-git-send-email-rogerq@ti.com> <1409743052-632-3-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from us2.outbound.mailhostbox.com ([208.91.199.216]:38189 "EHLO
	us2.outbound.mailhostbox.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751000AbaIFKz0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Sep 2014 06:55:26 -0400
In-Reply-To: <1409743052-632-3-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, tony@atomide.com
Cc: nm@ti.com, linux-omap@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>

On Wednesday 03 September 2014 04:47 PM, Roger Quadros wrote:
> The 8th NAND partition should be named "NAND.u-boot-env.backup1"
> instead of "NAND.u-boot-env". This is to be consistent with other
> TI boards as well as u-boot.
>
> CC: Pekon Gupta <pekon@pek-sem.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
>   arch/arm/boot/dts/dra7-evm.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
> index 42f5bc9..990ee6a 100644
> --- a/arch/arm/boot/dts/dra7-evm.dts
> +++ b/arch/arm/boot/dts/dra7-evm.dts
> @@ -483,7 +483,7 @@
>   			reg = <0x001c0000 0x00020000>;
>   		};
>   		partition@7 {
> -			label = "NAND.u-boot-env";
> +			label = "NAND.u-boot-env.backup1";
>   			reg = <0x001e0000 0x00020000>;
>   		};
>   		partition@8 {
>
Thanks for the fixing this typo.
Reviewed-by: Pekon Gupta <pekon@pek-sem.com>

with regards, pekon

------------------------
Powered by BigRock.com

