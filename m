From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 1/4] arm: bone: dts: add CD for mmc1
Date: Thu, 12 Sep 2013 11:15:58 -0500
Message-ID: <5231E8BE.7080009@ti.com>
References: <1379000532-27376-1-git-send-email-koen@dominion.thruhere.net>
 <1379000532-27376-2-git-send-email-koen@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1379000532-27376-2-git-send-email-koen@dominion.thruhere.net>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@arm.linux.org.uk, pawel.moll@arm.com, swarren@wwwdotorg.org, tony@atomide.com, ijc+devicetree@hellion.org.uk, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, bcousson@baylibre.com, Alexander Holler <holler@ahsoftware.de>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

nitpick minor comment:
$subject: ARM: dts: am335x-bone: add card detect for mmc1

btw, please use V3 in $subject next time. --subject-prefix "PATCH V3"
when generating patch should do the job.

On 09/12/2013 10:42 AM, Koen Kooi wrote:
> From: Alexander Holler <holler@ahsoftware.de>
> 
> This enables the use of MMC cards even when no card was inserted at boot.
> 
> Signed-off-by: Alexander Holler <holler@ahsoftware.de>
> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
> ---
> 
> Changes since v2:
> 	None, again a simple repost
> 
> Changes since v1:
> 	None, simple repost
> 
>  arch/arm/boot/dts/am335x-bone-common.dtsi | 14 ++++++++++++++
>  arch/arm/boot/dts/am335x-bone.dts         |  4 ----
>  2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
> index 2f66ded..ced256c 100644
> --- a/arch/arm/boot/dts/am335x-bone-common.dtsi
> +++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
> @@ -107,6 +107,11 @@
>  				0x14c (PIN_INPUT_PULLDOWN | MUX_MODE7)
>  			>;
>  		};

An EOL here would be nice to separate the nodes.

> +		mmc1_pins: pinmux_mmc1_pins {
> +			pinctrl-single,pins = <
> +				0x160 (PIN_INPUT | MUX_MODE7) /* GPIO0_6 */
> +			>;
> +		};
>  	};
>  
>  	ocp {
> @@ -260,3 +265,12 @@
>  	pinctrl-0 = <&davinci_mdio_default>;
>  	pinctrl-1 = <&davinci_mdio_sleep>;
>  };
> +
> +&mmc1 {
> +	status = "okay";
> +	vmmc-supply = <&ldo3_reg>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&mmc1_pins>;
> +	cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
> +	cd-inverted;
> +};
> diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
> index d5f43fe..d34469c 100644
> --- a/arch/arm/boot/dts/am335x-bone.dts
> +++ b/arch/arm/boot/dts/am335x-bone.dts
> @@ -16,7 +16,3 @@
>  	regulator-always-on;
>  };
>  
> -&mmc1 {
> -	status = "okay";
> -	vmmc-supply = <&ldo3_reg>;
> -};
> 


-- 
Regards,
Nishanth Menon
