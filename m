From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH v2 3/4] arm/dts: Add tps65910 regulator DT data to
 am335x-evm.dts
Date: Tue, 14 Aug 2012 14:25:18 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA1293E@DBDE01.ent.ti.com>
References: <1343110735-10640-1-git-send-email-anilkumar@ti.com>
 <1343110735-10640-4-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60549 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756289Ab2HNOZ2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Aug 2012 10:25:28 -0400
In-Reply-To: <1343110735-10640-4-git-send-email-anilkumar@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>

Hi Mark,

On Tue, Jul 24, 2012 at 11:48:54, AnilKumar, Chimata wrote:
> Add tps65910 regulator device tree data to AM335x-EVM by adding
> regulator consumers with tightened constraints and regulator-name.
> TPS65910 regulator handle can be obtained by using this regulator
> name.
> 
> This patch also add I2C node with I2C frequency and tps65910 PMIC
> I2C slave address.
> 
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
>  arch/arm/boot/dts/am335x-evm.dts |   28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
> index d6a97d9..e4e1ccb 100644
> --- a/arch/arm/boot/dts/am335x-evm.dts
> +++ b/arch/arm/boot/dts/am335x-evm.dts
> @@ -18,3 +18,31 @@
>  		reg = <0x80000000 0x10000000>; /* 256 MB */
>  	};
>  };
> +
> +&i2c1 {
> +	clock-frequency = <400000>;
> +
> +	tps: tps@2D {
> +		reg = <0x2D>;
> +	};
> +};
> +
> +/include/ "tps65910.dtsi"
> +
> +&vdd1_reg {
> +	/* VDD_MPU voltage limits 0.95V - 1.26V with +/-4% tolerance */
> +	regulator-name = "vdd_mpu";
> +	regulator-min-microvolt = <912500>;
> +	regulator-max-microvolt = <1312500>;
> +	regulator-boot-on;
> +	regulator-always-on;
> +};

I want to understand how to add parent regulator nodes? Like input-supply
node to regulators.

With "regulator: tps65910: add support for input supply" patch, regulator
registration fails if we are not providing the input_supply node with
proper input supply name.

AM335x EVM have one dedicated input supply which provide supplies to all
the PMIC regulators. According to tps65910 "VDD1 regulator" input supply
is from vcc1 so we have to create a dummy/parent/some node to handle this.
Example below has the details.

In am335x-evm.dts file

vcc1_supply: fixedregulator@0 {
                compatible = "regulator-fixed";
                regulator-name = "vcc1";
                regulator-boot-on;
};

/include/ "tps65910.dtsi"

&tps {
	regulators {
		vcc1-supply = <&vcc1_supply>;
		...
	};
};

Similarly we have to add 7 more fixed regulators entries to provide input
supply to different PMIC regulators.

Am I doing correct thing? Or is there any better way to handle this?

Regards
AnilKumar
