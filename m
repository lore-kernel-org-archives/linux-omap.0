From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2] ARM: dts: am57xx-beagle-x15: Add dual ethernet
Date: Thu, 4 Dec 2014 15:59:11 -0600
Message-ID: <5480D92F.8050505@ti.com>
References: <5480CADE.5010200@ti.com> <1417726977-2496-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59077 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932709AbaLDV7f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Dec 2014 16:59:35 -0500
In-Reply-To: <1417726977-2496-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Sekhar Nori <nsekhar@ti.com>

On 12/04/2014 03:02 PM, Felipe Balbi wrote:
> Add CPSW DT binding to beagle X15 DTS in order to
> get ethernet working with this board.
> 
> Note that we're also adding sleep state which will
> place all pins in mux mode 15 - which means "driver
> off" - thus conserving power.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
> 
> Changes since v1:
> 	- removed duplicated SoB from myself
> 	- Fixed s/Slave 1/Slave2/ in one comment
> 	- slightly improved commit log
> 
>  arch/arm/boot/dts/am57xx-beagle-x15.dts | 106 ++++++++++++++++++++++++++++++++
>  1 file changed, 106 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> index 49edbda..6c2e8e4 100644
> --- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
> +++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
> @@ -140,6 +140,86 @@
>  		>;
>  	};
>  
> +	cpsw_pins_default: cpsw_pins_default {
> +		pinctrl-single,pins = <
> +			/* Slave 1 */
> +			0x250 (PIN_OUTPUT | MUX_MODE0)	/* rgmii1_tclk */
> +			0x254 (PIN_OUTPUT | MUX_MODE0)	/* rgmii1_tctl */
> +			0x258 (PIN_OUTPUT | MUX_MODE0)	/* rgmii1_td3 */
> +			0x25c (PIN_OUTPUT | MUX_MODE0)	/* rgmii1_td2 */
> +			0x260 (PIN_OUTPUT | MUX_MODE0)	/* rgmii1_td1 */
> +			0x264 (PIN_OUTPUT | MUX_MODE0)	/* rgmii1_td0 */
> +			0x268 (PIN_INPUT | MUX_MODE0)	/* rgmii1_rclk */
> +			0x26c (PIN_INPUT | MUX_MODE0)	/* rgmii1_rctl */
> +			0x270 (PIN_INPUT | MUX_MODE0)	/* rgmii1_rd3 */
> +			0x274 (PIN_INPUT | MUX_MODE0)	/* rgmii1_rd2 */
> +			0x278 (PIN_INPUT | MUX_MODE0)	/* rgmii1_rd1 */
> +			0x27c (PIN_INPUT | MUX_MODE0)	/* rgmii1_rd0 */
> +
> +			/* Slave 2 */
> +			0x198 (PIN_OUTPUT | MUX_MODE3)	/* rgmii2_tclk */
> +			0x19c (PIN_OUTPUT | MUX_MODE3)	/* rgmii2_tctl */
> +			0x1a0 (PIN_OUTPUT | MUX_MODE3)	/* rgmii2_td3 */
> +			0x1a4 (PIN_OUTPUT | MUX_MODE3)	/* rgmii2_td2 */
> +			0x1a8 (PIN_OUTPUT | MUX_MODE3)	/* rgmii2_td1 */
> +			0x1ac (PIN_OUTPUT | MUX_MODE3)	/* rgmii2_td0 */
> +			0x1b0 (PIN_INPUT | MUX_MODE3)	/* rgmii2_rclk */
> +			0x1b4 (PIN_INPUT | MUX_MODE3)	/* rgmii2_rctl */
> +			0x1b8 (PIN_INPUT | MUX_MODE3)	/* rgmii2_rd3 */
> +			0x1bc (PIN_INPUT | MUX_MODE3)	/* rgmii2_rd2 */
> +			0x1c0 (PIN_INPUT | MUX_MODE3)	/* rgmii2_rd1 */
> +			0x1c4 (PIN_INPUT | MUX_MODE3)	/* rgmii2_rd0 */
> +		>;
> +
> +	};
> +
> +	cpsw_pins_sleep: cpsw_pins_sleep {
> +		pinctrl-single,pins = <
> +			/* Slave 1 */
> +			0x250 (PIN_INPUT | MUX_MODE15)
> +			0x254 (PIN_INPUT | MUX_MODE15)
> +			0x258 (PIN_INPUT | MUX_MODE15)
> +			0x25c (PIN_INPUT | MUX_MODE15)
> +			0x260 (PIN_INPUT | MUX_MODE15)
> +			0x264 (PIN_INPUT | MUX_MODE15)
> +			0x268 (PIN_INPUT | MUX_MODE15)
> +			0x26c (PIN_INPUT | MUX_MODE15)
> +			0x270 (PIN_INPUT | MUX_MODE15)
> +			0x274 (PIN_INPUT | MUX_MODE15)
> +			0x278 (PIN_INPUT | MUX_MODE15)
> +			0x27c (PIN_INPUT | MUX_MODE15)
> +
> +			/* Slave 2 */
> +			0x198 (PIN_INPUT | MUX_MODE15)
> +			0x19c (PIN_INPUT | MUX_MODE15)
> +			0x1a0 (PIN_INPUT | MUX_MODE15)
> +			0x1a4 (PIN_INPUT | MUX_MODE15)
> +			0x1a8 (PIN_INPUT | MUX_MODE15)
> +			0x1ac (PIN_INPUT | MUX_MODE15)
> +			0x1b0 (PIN_INPUT | MUX_MODE15)
> +			0x1b4 (PIN_INPUT | MUX_MODE15)
> +			0x1b8 (PIN_INPUT | MUX_MODE15)
> +			0x1bc (PIN_INPUT | MUX_MODE15)
> +			0x1c0 (PIN_INPUT | MUX_MODE15)
> +			0x1c4 (PIN_INPUT | MUX_MODE15)
> +		>;
> +	};
> +
> +	davinci_mdio_pins_default: davinci_mdio_pins_default {
> +		pinctrl-single,pins = <
> +			/* MDIO */
> +			0x23c (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* mdio_mclk */
> +			0x240 (PIN_INPUT_PULLUP | MUX_MODE0)	/* mdio_d */
> +		>;
> +	};
> +
> +	davinci_mdio_pins_sleep: davinci_mdio_pins_sleep {
> +		pinctrl-single,pins = <
> +			0x23c (PIN_INPUT | MUX_MODE15)
> +			0x240 (PIN_INPUT | MUX_MODE15)
> +		>;
> +	};
> +
>  	tps659038_pins_default: tps659038_pins_default {
>  		pinctrl-single,pins = <
>  			0x418 (PIN_INPUT_PULLUP | MUX_MODE14)	/* wakeup0.gpio1_0 */
> @@ -365,6 +445,32 @@
>  	pinctrl-0 = <&uart3_pins_default>;
>  };
>  
> +&mac {
> +	status = "okay";
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&cpsw_pins_default>;
> +	pinctrl-1 = <&cpsw_pins_sleep>;
> +	dual_emac;
> +};
> +
> +&cpsw_emac0 {
> +	phy_id = <&davinci_mdio>, <1>;
> +	phy-mode = "rgmii";
> +	dual_emac_res_vlan = <1>;
> +};
> +
> +&cpsw_emac1 {
> +	phy_id = <&davinci_mdio>, <2>;
> +	phy-mode = "rgmii";
> +	dual_emac_res_vlan = <2>;
> +};
> +
> +&davinci_mdio {
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&davinci_mdio_pins_default>;
> +	pinctrl-1 = <&davinci_mdio_pins_sleep>;
> +};
> +
>  &mmc1 {
>  	status = "okay";
>  
> 
Yep, looks better thanks.

depends on the ethernet dts and x15 patches queued previously for 3.19.

https://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/log/?h=omap-for-v3.19/dt-v2


-- 
Regards,
Nishanth Menon
