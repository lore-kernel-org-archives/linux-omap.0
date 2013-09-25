From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v6 4/4] ARM: dts: AM33xx: updated default ECC scheme in
 nand-ecc-opt
Date: Wed, 25 Sep 2013 12:15:59 -0700
Message-ID: <20130925191559.GF23337@ld-irv-0074.broadcom.com>
References: <1378986619-26765-1-git-send-email-pekon@ti.com>
 <1378986619-26765-5-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ye0-f173.google.com ([209.85.213.173]:52540 "EHLO
	mail-ye0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755Ab3IYTQF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Sep 2013 15:16:05 -0400
Content-Disposition: inline
In-Reply-To: <1378986619-26765-5-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pekon Gupta <pekon@ti.com>
Cc: dedekind1@gmail.com, olof@lixom.net, dwmw2@infradead.org, arnd@arndb.de, tony@atomide.com, benoit.cousson@linaro.org, avinashphilipk@gmail.com, balbi@ti.com, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

On Thu, Sep 12, 2013 at 05:20:19PM +0530, Pekon Gupta wrote:
> DT property values for OMAP based gpmc-nand have been updated
> to match changes in commit:
> 	6faf096 ARM: OMAP2+: cleaned-up DT support of various ECC schemes

Whose commit ID is this? Your patch is not merged yet, so don't use a
commit ID.

> Refer: Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> 
> Signed-off-by: Pekon Gupta <pekon@ti.com>
> ---
>  arch/arm/boot/dts/am335x-evm.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
> index e8ec875..e28a2ac 100644
> --- a/arch/arm/boot/dts/am335x-evm.dts
> +++ b/arch/arm/boot/dts/am335x-evm.dts
> @@ -268,7 +268,7 @@
>  			nand@0,0 {
>  				reg = <0 0 0>; /* CS0, offset 0 */
>  				nand-bus-width = <8>;
> -				ti,nand-ecc-opt = "bch8";
> +				ti,nand-ecc-scheme = "bch8";
>  				gpmc,device-nand = "true";
>  				gpmc,device-width = <1>;
>  				gpmc,sync-clk-ps = <0>;

This change should probably go in patch 1 anyway, when you break the
ABI.

Brian
