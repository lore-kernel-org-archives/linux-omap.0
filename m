From: pekon <pekon@pek-sem.com>
Subject: Re: [PATCH 1/6] ARM: dts: am43x-epos-evm: Use BCH16 ECC scheme instead
 of BCH8
Date: Tue, 02 Sep 2014 23:59:24 +0530
Message-ID: <54060C84.8030107@pek-sem.com>
References: <1409666227-20622-1-git-send-email-rogerq@ti.com> <1409666227-20622-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from us2.outbound.mailhostbox.com ([162.210.70.55]:43038 "EHLO
	us2.outbound.mailhostbox.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754487AbaIBSez (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2014 14:34:55 -0400
In-Reply-To: <1409666227-20622-2-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, tony@atomide.com
Cc: linux-omap@vger.kernel.org

On Tuesday 02 September 2014 07:27 PM, Roger Quadros wrote:
> am43x-epos-evm uses a NAND chip with page size 4096 bytes
> and spare area of 225 bytes per page.
>
> For such a setup it is preferrable to use BCH16 ECC scheme over
> BCH8. This also makes it compatible with ROM code ECC scheme so
> we can boot with NAND after flashing from kernel.
>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>   arch/arm/boot/dts/am43x-epos-evm.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
> index ed7dd23..f6c9898 100644
> --- a/arch/arm/boot/dts/am43x-epos-evm.dts
> +++ b/arch/arm/boot/dts/am43x-epos-evm.dts
> @@ -441,7 +441,7 @@
>   	ranges = <0 0 0x08000000 0x10000000>;	/* CS0: NAND */
>   	nand@0,0 {
>   		reg = <0 0 0>; /* CS0, offset 0 */
> -		ti,nand-ecc-opt = "bch8";
> +		ti,nand-ecc-opt = "bch16";
>   		ti,elm-id = <&elm>;
>   		nand-bus-width = <8>;
>   		gpmc,device-width = <1>;
>

As I have tested BCH16 on AM43x-EPOS board earlier So,
Reviewed-by: Pekon Gupta <pekon@pek-sem.com>


with regards, pekon

------------------------
Powered by BigRock.com

