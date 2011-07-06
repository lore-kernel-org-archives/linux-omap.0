From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH 1/5] OMAP3:I2C: Add device tree nodes for beagle board
Date: Wed, 6 Jul 2011 12:55:46 -0600
Message-ID: <20110706185546.GJ4871@ponder.secretlab.ca>
References: <1309426647-31587-1-git-send-email-manjugk@ti.com>
 <1309426647-31587-2-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:61103 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755435Ab1GFSzt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jul 2011 14:55:49 -0400
Received: by pzk9 with SMTP id 9so192972pzk.19
        for <linux-omap@vger.kernel.org>; Wed, 06 Jul 2011 11:55:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1309426647-31587-2-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, ben-linux@fluff.org

On Thu, Jun 30, 2011 at 03:07:23PM +0500, G, Manjunath Kondaiah wrote:
> 
> Add I2C and it's child device nodes for beagle board.
> The I2C1 controller child devices are not populated and it
> should be handled along with OMAP clock changes.
> 
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> ---
>  arch/arm/boot/dts/omap3-beagle-nunchuck.dts |    5 ---
>  arch/arm/boot/dts/omap3-beagle.dts          |   42 +++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-beagle-nunchuck.dts b/arch/arm/boot/dts/omap3-beagle-nunchuck.dts
> index 2607be5..479be11 100644
> --- a/arch/arm/boot/dts/omap3-beagle-nunchuck.dts
> +++ b/arch/arm/boot/dts/omap3-beagle-nunchuck.dts

This hunk is of course only for my tree since I'm the only one who
actually has this modified beagleboard.  :-)

> @@ -2,11 +2,6 @@
>  
>  / {
>  	i2c@48072000 {
> -		compatible = "ti,omap3-i2c";
> -		reg = <0x48072000 0x80>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
>  		eeprom@50 {
>  			compatible = "at,at24c01";
>  			reg = < 0x50 >;
> diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
> index 4439466..491ee2b 100644
> --- a/arch/arm/boot/dts/omap3-beagle.dts
> +++ b/arch/arm/boot/dts/omap3-beagle.dts
> @@ -4,4 +4,46 @@
>  / {
>  	model = "TI OMAP3 BeagleBoard";
>  	compatible = "ti,omap3-beagle";
> +	interrupt-parent = <&gic>;
> +
> +	gic: interrupt-controller@48241000 {
> +		compatible = "ti,omap-gic", "arm,gic";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		reg = <0x48200000 0x1000>;
> +	};
> +
> +	i2c@48070000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "ti,omap_i2c";

ti,omap3-i2c

Use '-' not '_'. and the specific silicon implementation should be
specified (omap3 vs. omap).

> +		reg = <0x48070000 0x100>;
> +		interrupts = < 88 >;
> +		interrupt-parent = <&gic>;

interrupt-parent isn't needed because it is inherited from the root node.

> +		clock-frequency = <2600>;
> +		status = "disabled";

Drop 'status' when you move this node definition to
arch/arm/boot/dts/omap3.dtsi.  Board overlay files that include the
omap3.dtsi should explicitly disable any devices that it does not use
(which is opposite to what tegra currently does, but I'm going to
change that).

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

Okay is spelled 'okay'.  :-)  The kernel does accept 'ok', but I
discourage its usage... just because I'm a nitpick about stuff like
that.

Actually, if the device is enabled, the status property can be dropped
entirely because the default behaviour is to enable.

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
> +	};
> +
>  };
> -- 
> 1.7.4.1
> 
