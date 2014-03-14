From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 7/8] ARM: dts: dra7: Add USB related nodes
Date: Fri, 14 Mar 2014 16:08:06 +0530
Message-ID: <5322DC0E.1020600@ti.com>
References: <1394197751-28984-1-git-send-email-rogerq@ti.com>
 <1394197751-28984-8-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1394197751-28984-8-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Roger Quadros <rogerq@ti.com>, balbi@ti.com, tony@atomide.com
Cc: devicetree@vger.kernel.org, george.cherian@ti.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Roger,

On Friday 07 March 2014 06:39 PM, Roger Quadros wrote:
> Add nodes for the Super Speed USB controllers, omap-control-usb,
> USB2 PHY and USB3 PHY devices.
>
> Remove ocp2scp1 address space from hwmod data as it is
> now provided via device tree.
>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>   arch/arm/boot/dts/dra7.dtsi               | 110 ++++++++++++++++++++++++++++++
>   arch/arm/mach-omap2/omap_hwmod_7xx_data.c |  10 ---
>   2 files changed, 110 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 597979b..1e73900 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -811,6 +811,116 @@
>   			clocks = <&sata_ref_clk>;
>   			ti,hwmods = "sata";
>   		};
> +
> +		omap_control_usb2phy1: control-phy@4a002300 {
> +			compatible = "ti,control-phy-usb2";
> +			reg = <0x4a002300 0x4>;
> +			reg-names = "power";
> +		};
> +
> +		omap_control_usb3phy1: control-phy@4a002370 {
> +			compatible = "ti,control-phy-pipe3";
> +			reg = <0x4a002370 0x4>;
> +			reg-names = "power";
> +		};
> +
> +		omap_control_usb2phy2: control-phy@0x4a002e74 {
> +			compatible = "ti,control-phy-usb2-dra7";
> +			reg = <0x4a002e74 0x4>;
> +			reg-names = "power";
> +		};
> +
> +		/* OCP2SCP1 */
> +		ocp2scp@4a080000 {
> +			compatible = "ti,omap-ocp2scp";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			reg = <0x4a080000 0x20>;
> +			ti,hwmods = "ocp2scp1";
> +
> +			usb2_phy1: phy@4a084000 {
> +				compatible = "ti,omap-usb2";
> +				reg = <0x4a084000 0x400>;
> +				ctrl-module = <&omap_control_usb2phy1>;
> +				clocks = <&usb_phy1_always_on_clk32k>,
> +					 <&usb_otg_ss1_refclk960m>;
> +				clock-names =	"wkupclk",
> +						"refclk";
> +				#phy-cells = <0>;
> +			};
> +
> +			usb2_phy2: phy@4a085000 {
> +				compatible = "ti,omap-usb2";
> +				reg = <0x4a085000 0x400>;
> +				ctrl-module = <&omap_control_usb2phy2>;
> +				clocks = <&usb_phy2_always_on_clk32k>,
> +					 <&usb_otg_ss2_refclk960m>;
> +				clock-names =	"wkupclk",
> +						"refclk";
> +				#phy-cells = <0>;
> +			};
> +
> +			usb3_phy1: phy@4a084400 {
> +				compatible = "ti,omap-usb3";
> +				reg = <0x4a084400 0x80>,
> +				      <0x4a084800 0x64>,
> +				      <0x4a084c00 0x40>;
> +				reg-names = "phy_rx", "phy_tx", "pll_ctrl";
> +				ctrl-module = <&omap_control_usb3phy1>;
> +				clocks = <&usb_phy3_always_on_clk32k>,
> +					 <&sys_clkin1>,
> +					 <&usb_otg_ss1_refclk960m>,
> +					 <&dpll_core_h13x2_ck>;
> +				clock-names =	"wkupclk",
> +						"sysclk",
> +						"refclk",
> +						"optclk";

Do we use this 'optclk' in driver?

-Kishon
