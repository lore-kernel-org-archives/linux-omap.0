From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 1/2] ARM: dts: dra7-evm: Add mmc1 node for micro-sd
 support
Date: Wed, 9 Oct 2013 08:14:40 -0500
Message-ID: <525556C0.1060100@ti.com>
References: <1381163104-6318-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45760 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753170Ab3JINPE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Oct 2013 09:15:04 -0400
In-Reply-To: <1381163104-6318-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Balaji T K <balajitk@ti.com>, bcousson@baylibre.com, devicetree@vger.kernel.org
Cc: linux-omap@vger.kernel.org, tony@atomide.com, linux-arm-kernel@lists.infradead.org

On 10/07/2013 11:25 AM, Balaji T K wrote:
> Add mmc1 dt node to dra7-evm board.
> Input for ldo1 regulator is controlled by gpio 5 of pcf8575 chip (0x21)
> on i2c1 bus. When dt support for gpio-pcf857x is available, input supply
> will be modelled as cascaded regulator.
> 
> Signed-off-by: Balaji T K <balajitk@ti.com>
> ---
> Rebase to for_3.13/dts
> 
>  arch/arm/boot/dts/dra7-evm.dts |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
> index fbbe406..65cd15a 100644
> --- a/arch/arm/boot/dts/dra7-evm.dts
> +++ b/arch/arm/boot/dts/dra7-evm.dts
> @@ -250,3 +250,9 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart3_pins>;
>  };
> +
> +&mmc1 {
> +	status = "okay";
> +	vmmc-supply = <&ldo1_reg>;
> +	bus-width = <4>;
> +};
> 
boot tested on DRA7-EVM
voltage rail is correct based on schematics(rev d1) too
(LDO1->MMC1_3V3->SDcard).

Reviewed-by: Nishanth Menon <nm@ti.com>
Tested-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
