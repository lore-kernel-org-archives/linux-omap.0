From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 09/17] ARM: dts: dra7: Use "syscon-phy-power" instead of
 "ctrl-module" in SATA PHY node
Date: Wed, 24 Jun 2015 15:06:02 +0300
Message-ID: <20150624150602.0e73fc8f9dda1624f22059db@ti.com>
References: <1435060743-5511-1-git-send-email-kishon@ti.com>
	<1435060743-5511-10-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1435060743-5511-10-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: bcousson@baylibre.com, tony@atomide.com, balbi@ti.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, gregkh@linuxfoundation.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

On Tue, 23 Jun 2015 17:28:54 +0530
Kishon Vijay Abraham I <kishon@ti.com> wrote:

> Add "syscon-phy-power" property and remove the deprecated "ctrl-module"
> property from SATA PHY node. Since "omap_control_sata" note is no longer
> used, remove it.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Acked-by: Roger Quadros <rogerq@ti.com>

cheers,
-roger

> ---
>  arch/arm/boot/dts/dra7.dtsi |   10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 3f434f7..92e0741 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -1115,14 +1115,6 @@
>  			status = "disabled";
>  		};
>  
> -		omap_control_sata: control-phy@4a002374 {
> -			compatible = "ti,control-phy-pipe3";
> -			reg = <0x4a002374 0x4>;
> -			reg-names = "power";
> -			clocks = <&sys_clkin1>;
> -			clock-names = "sysclk";
> -		};
> -
>  		/* OCP2SCP3 */
>  		ocp2scp@4a090000 {
>  			compatible = "ti,omap-ocp2scp";
> @@ -1137,7 +1129,7 @@
>  				      <0x4A096400 0x64>, /* phy_tx */
>  				      <0x4A096800 0x40>; /* pll_ctrl */
>  				reg-names = "phy_rx", "phy_tx", "pll_ctrl";
> -				ctrl-module = <&omap_control_sata>;
> +				syscon-phy-power = <&dra7_ctrl_core 0x374>;
>  				clocks = <&sys_clkin1>, <&sata_ref_clk>;
>  				clock-names = "sysclk", "refclk";
>  				syscon-pllreset = <&dra7_ctrl_core 0x3fc>;
> -- 
> 1.7.9.5
> 
