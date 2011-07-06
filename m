From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 2/5] OMAP4:I2C: Add device tree nodes for panda board
Date: Wed, 6 Jul 2011 12:57:12 -0600
Message-ID: <20110706185712.GK4871@ponder.secretlab.ca>
References: <1309426647-31587-1-git-send-email-manjugk@ti.com>
 <1309426647-31587-3-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:33987 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755481Ab1GFS5P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jul 2011 14:57:15 -0400
Received: by pzk9 with SMTP id 9so194014pzk.19
        for <linux-omap@vger.kernel.org>; Wed, 06 Jul 2011 11:57:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1309426647-31587-3-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, ben-linux@fluff.org

On Thu, Jun 30, 2011 at 03:07:24PM +0500, G, Manjunath Kondaiah wrote:
> 
> Add I2C and it's child device nodes for beagle board.
> The I2C1 controller child devices are not populated and it
> should be handled along with OMAP clock changes.
> 
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> ---
>  arch/arm/boot/dts/omap4-panda.dts |   57 +++++++++++++++++++++++++++++++++++++
>  1 files changed, 57 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
> index 58909e9..f9af72f 100644
> --- a/arch/arm/boot/dts/omap4-panda.dts
> +++ b/arch/arm/boot/dts/omap4-panda.dts
> @@ -8,4 +8,61 @@
>  / {
>  	model = "TI OMAP4 PandaBoard";
>  	compatible = "ti,omap4-panda", "ti,omap4430";
> +	interrupt-parent = <&gic>;
> +
> +	gic: interrupt-controller@48241000 {
> +		compatible = "ti,omap-gic", "arm,gic";

ti,omap4-gic

> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		reg = <0x48241000 0x1000>,
> +		      <0X48240100 0x0200>;
> +	};
> +
> +	i2c@48070000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "ti,omap_i2c";

ti,omap4-i2c.  Actually, it is quite possibly appropriate to do:

	compatible = "ti,omap4-i2c", "ti,omap3-i2c";

> +		reg = <0x48070000 0x100>;
> +		interrupts = < 88 >;
> +		interrupt-parent = <&gic>;
> +		clock-frequency = <400>;

Frequency should be a Hz value, not kHz or MHz.

> +		status = "disabled";
> +	};
> +
> +	i2c@48072000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "ti,omap_i2c";
> +		reg = <0x48072000 0x100>;
> +		interrupts = < 89 >;
> +		interrupt-parent = <&gic>;
> +		clock-frequency = <400>;
> +		status = "ok";
> +	};
> +
> +	i2c@48060000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "ti,omap_i2c";
> +		reg = <0x48060000 0x100>;
> +		interrupts = < 93 >;
> +		interrupt-parent = <&gic>;
> +		clock-frequency = <100>;
> +		status = "ok";
> +		eeprom@50 {
> +			compatible = "at,at24c01";
> +			reg = < 0x50 >;
> +		};
> +	};
> +
> +	i2c@48350000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "ti,omap_i2c";
> +		reg = <0x48350000 0x100>;
> +		interrupts = < 94 >;
> +		interrupt-parent = <&gic>;
> +		clock-frequency = <400>;
> +		status = "ok";
> +	};
>  };
> -- 
> 1.7.4.1
> 
