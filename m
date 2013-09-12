From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/4] am335x-boneblack: add eMMC DT entry
Date: Thu, 12 Sep 2013 11:18:30 -0500
Message-ID: <5231E956.8060209@ti.com>
References: <1379000532-27376-1-git-send-email-koen@dominion.thruhere.net>
 <1379000532-27376-3-git-send-email-koen@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1379000532-27376-3-git-send-email-koen@dominion.thruhere.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@arm.linux.org.uk, pawel.moll@arm.com, swarren@wwwdotorg.org, tony@atomide.com, ijc+devicetree@hellion.org.uk, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Nitpick minor comment:
$subject:
ARM: dts: am335x-boneblack: add eMMC DT entry

On 09/12/2013 10:42 AM, Koen Kooi wrote:
> The pinmux is specified in am335x-bone-common.dtsi to be reused by the eMMC cape.
> 
Also might want to state that vmmcsd_fixed 3.3 voltage rail is present
in BeagleBone White and Black, however used for emmc in bone-black.

> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
> ---
> 
> Changes since v2:
> 	add missing pinmux entries
> 
> Changes since v1:
> 	dropped the ti,non-removable entry per Sekhars request
> 
>  arch/arm/boot/dts/am335x-bone-common.dtsi | 22 ++++++++++++++++++++++
>  arch/arm/boot/dts/am335x-boneblack.dts    | 14 ++++++++++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
> index ced256c..cfec441 100644
> --- a/arch/arm/boot/dts/am335x-bone-common.dtsi
> +++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
> @@ -112,6 +112,21 @@
>  				0x160 (PIN_INPUT | MUX_MODE7) /* GPIO0_6 */
>  			>;
>  		};
> +
> +		emmc_pins: pinmux_emmc_pins {
> +			pinctrl-single,pins = <
> +				0x80 (PIN_INPUT_PULLUP | MUX_MODE2) /* gpmc_csn1.mmc1_clk, INPUT_PULLUP | MODE2 */
> +				0x84 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_csn2.mmc1_cmd, INPUT_PULLUP | MODE2 */
> +				0x00 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad0.mmc1_dat0, INPUT_PULLUP | MODE1 */
> +				0x04 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad1.mmc1_dat1, INPUT_PULLUP | MODE1 */
> +				0x08 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad2.mmc1_dat2, INPUT_PULLUP | MODE1 */
> +				0x0c (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad3.mmc1_dat3, INPUT_PULLUP | MODE1 */
> +				0x10 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad4.mmc1_dat4, INPUT_PULLUP | MODE1 */
> +				0x14 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad5.mmc1_dat5, INPUT_PULLUP | MODE1 */
> +				0x18 (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad6.mmc1_dat6, INPUT_PULLUP | MODE1 */
> +				0x1c (PIN_INPUT_PULLUP | MUX_MODE1) /* gpmc_ad7.mmc1_dat7, INPUT_PULLUP | MODE1 */
> +			>;
> +		};
>  	};
>  
>  	ocp {
> @@ -241,6 +256,13 @@
>  			regulator-always-on;
>  		};
>  	};
> +
> +	vmmcsd_fixed: fixedregulator@0 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vmmcsd_fixed";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
>  };
>  
>  &cpsw_emac0 {
> diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
> index 197cadf..f4703cf 100644
> --- a/arch/arm/boot/dts/am335x-boneblack.dts
> +++ b/arch/arm/boot/dts/am335x-boneblack.dts
> @@ -15,3 +15,17 @@
>  	regulator-max-microvolt = <1800000>;
>  	regulator-always-on;
>  };
> +
> +&mmc1 { 
> +	vmmc-supply = <&vmmcsd_fixed>;
> +};
> +
> +&mmc2 { 
> +	vmmc-supply = <&vmmcsd_fixed>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&emmc_pins>;
> +	bus-width = <8>;
> +	status = "okay";
> +	ti,vcc-aux-disable-is-sleep;
> +};
> +
> 


-- 
Regards,
Nishanth Menon
