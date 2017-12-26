From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 05/25] arm: imx: dts: Remove leading 0x and 0s from
 bindings notation
Date: Tue, 26 Dec 2017 12:17:34 +0800
Message-ID: <20171226041733.GE4210@X250>
References: <20171214165350.27850-1-malat@debian.org>
 <20171215111620.20379-1-malat@debian.org>
 <20171215111620.20379-5-malat@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20171215111620.20379-5-malat@debian.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mathieu Malaterre <malat@debian.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Andrew Lunn <andrew@lunn.ch>, Heiko Stuebner <heiko@sntech.de>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@axis.com, Baoyou Xie <baoyou.xie@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Jesper Nilsson <jesper.nilsson@axis.com>, Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <vireshk@kernel.org>, Russell King <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk@kernel.org>, linux-samsung-soc@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>, Kukjin Kim <kgene@kernel.org>, bcm-kernel-feedback-list@broadcom.com, Niklas Cassel <niklas.cassel@axis.com>, linux-rockchip@lists.infradead.org, Sebastian Hesselbarth <sebastian>
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 15, 2017 at 12:15:55PM +0100, Mathieu Malaterre wrote:
> Improve the DTS files by removing all the leading "0x" and zeros to fix the
> following dtc warnings:
> 
> Warning (unit_address_format): Node /XXX unit name should not have leading "0x"
> 
> and
> 
> Warning (unit_address_format): Node /XXX unit name should not have leading 0s
> 
> Converted using the following command:
> 
> find . -type f \( -iname *.dts -o -iname *.dtsi \) -exec sed -i -e "s/@\([0-9a-fA-FxX\.;:#]+\)\s*{/@\L\1 {/g" -e "s/@0x\(.*\) {/@\1 {/g" -e "s/@0+\(.*\) {/@\1 {/g" {} +^C
> 
> For simplicity, two sed expressions were used to solve each warnings separately.
> 
> To make the regex expression more robust a few other issues were resolved,
> namely setting unit-address to lower case, and adding a whitespace before the
> the opening curly brace:
> 
> https://elinux.org/Device_Tree_Linux#Linux_conventions
> 
> This will solve as a side effect warning:
> 
> Warning (simple_bus_reg): Node /XXX@<UPPER> simple-bus unit address format error, expected "<lower>"
> 
> This is a follow up to commit 4c9847b7375a ("dt-bindings: Remove leading 0x from bindings notation")
> 
> Reported-by: David Daney <ddaney@caviumnetworks.com>
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
>  arch/arm/boot/dts/imx6q-display5.dtsi | 2 +-
>  arch/arm/boot/dts/imx7d.dtsi          | 2 +-
>  arch/arm/boot/dts/imx7s.dtsi          | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-display5.dtsi b/arch/arm/boot/dts/imx6q-display5.dtsi
> index 4084de43d4d9..09085fde3341 100644
> --- a/arch/arm/boot/dts/imx6q-display5.dtsi
> +++ b/arch/arm/boot/dts/imx6q-display5.dtsi
> @@ -255,7 +255,7 @@
>  	pinctrl-0 = <&pinctrl_i2c1>;
>  	status = "okay";
>  
> -	codec: tfa9879@6C {
> +	codec: tfa9879@6c {
>  		#sound-dai-cells = <0>;
>  		compatible = "nxp,tfa9879";
>  		reg = <0x6C>;
> diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
> index 4d308d17f040..369d5a166b3e 100644
> --- a/arch/arm/boot/dts/imx7d.dtsi
> +++ b/arch/arm/boot/dts/imx7d.dtsi
> @@ -129,7 +129,7 @@
>  		status = "disabled";
>  	};
>  
> -	pcie: pcie@0x33800000 {
> +	pcie: pcie@33800000 {
>  		compatible = "fsl,imx7d-pcie", "snps,dw-pcie";
>  		reg = <0x33800000 0x4000>,
>  		      <0x4ff00000 0x80000>;
> diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
> index 82ad26e766eb..a00ba897e58d 100644
> --- a/arch/arm/boot/dts/imx7s.dtsi
> +++ b/arch/arm/boot/dts/imx7s.dtsi
> @@ -583,7 +583,7 @@
>  					#address-cells = <1>;
>  					#size-cells = <0>;
>  
> -					pgc_pcie_phy: pgc-power-domain@IMX7_POWER_DOMAIN_PCIE_PHY {
> +					pgc_pcie_phy: pgc-power-domain@imx7_power_domain_pcie_phy {

I think this is broken, as IMX7_POWER_DOMAIN_PCIE_PHY is a define here.

Shawn

>  						#power-domain-cells = <0>;
>  						reg = <IMX7_POWER_DOMAIN_PCIE_PHY>;
>  						power-supply = <&reg_1p0d>;
> -- 
> 2.11.0
> 
