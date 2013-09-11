From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 2/2] am335x-boneblack: add eMMC DT entry
Date: Wed, 11 Sep 2013 15:36:45 +0530
Message-ID: <523040B5.60407@ti.com>
References: <1378879946-13037-1-git-send-email-koen@dominion.thruhere.net>
 <1378879946-13037-3-git-send-email-koen@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1378879946-13037-3-git-send-email-koen@dominion.thruhere.net>
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

On Wednesday 11 September 2013 11:42 AM, Koen Kooi wrote:
> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
> ---
>  arch/arm/boot/dts/am335x-bone-common.dtsi |  7 +++++++
>  arch/arm/boot/dts/am335x-boneblack.dts    | 15 +++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
> index ced256c..9c61fef 100644
> --- a/arch/arm/boot/dts/am335x-bone-common.dtsi
> +++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
> @@ -241,6 +241,13 @@
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
> index 197cadf..c09947a 100644
> --- a/arch/arm/boot/dts/am335x-boneblack.dts
> +++ b/arch/arm/boot/dts/am335x-boneblack.dts
> @@ -15,3 +15,18 @@
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
> +	ti,non-removable;

There is a standard binding available for this: "non-removable"
There should not be a need to introduce a TI specific binding for this
(I know this is not your fault).

I will send a patch to change the existing .dts files and update the
driver - can you drop this line for now so we don't introduce more
incompatibilities? I can send a patch adding "non-removable" to this
node as part of my clean-up series.

Thanks,
Sekhar
