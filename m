From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH] ARM: dts: AM33XX: Add tsl2550 ambient light sensor DT
 data
Date: Thu, 18 Oct 2012 05:46:47 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA53C2B@DBDE01.ent.ti.com>
References: <1348242551-21293-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57572 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754091Ab2JRFqz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Oct 2012 01:46:55 -0400
In-Reply-To: <1348242551-21293-1-git-send-email-anilkumar@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, Sep 21, 2012 at 21:19:11, AnilKumar, Chimata wrote:
> Add tsl2550 ambient light sensor DT data to am335x-evm.dts. In AM335x
> EVM tsl2550 ambient light sensor is connected to I2C2 bus. So this patch
> adds child node inside i2c2 node with i2c slave address.
> 
> TAOS tsl2550 sensor with two-wire SMBus serial interface. This patch
> also reduces I2C2 clock frequency to 100KHz from 400KHz because the
> maximum clock frequency of SMBus is 100KHz.
> 
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
>  arch/arm/boot/dts/am335x-evm.dts |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
> index 3b1f313..d99aa0f 100644
> --- a/arch/arm/boot/dts/am335x-evm.dts
> +++ b/arch/arm/boot/dts/am335x-evm.dts
> @@ -49,7 +49,7 @@
>  
>  		i2c2: i2c@4802a000 {
>  			status = "okay";
> -			clock-frequency = <400000>;
> +			clock-frequency = <100000>;
>  
>  			lis331dlh: lis331dlh@18 {
>  				compatible = "st,lis331dlh", "st,lis3lv02d";
> @@ -79,6 +79,11 @@
>  				st,max-limit-z = <750>;
>  			};
>  
> +			tsl2550: tsl2550@39 {
> +				compatible = "taos,tsl2550";
> +				reg = <0x39>;
> +			};
> +
>  			tmp275: tmp275@48 {
>  				compatible = "ti,tmp275";
>  				reg = <0x48>;

Hi Tony/Benoit,

If there are no comments in this patch could you please take this in?

Thanks
AnilKumar
