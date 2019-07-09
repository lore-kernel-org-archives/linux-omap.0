From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH v4 net-next 05/11] dt-bindings: net: ti: add new cpsw
 switch driver bindings
Date: Tue, 9 Jul 2019 16:48:53 -0600
Message-ID: <20190709224853.GA2365@bogus>
References: <20190621181314.20778-1-grygorii.strashko@ti.com>
 <20190621181314.20778-6-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190621181314.20778-6-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Jiri Pirko <jiri@resnulli.us>, Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Ivan Vecera <ivecera@redhat.com>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 21, 2019 at 09:13:08PM +0300, Grygorii Strashko wrote:
> Add bindings for the new TI CPSW switch driver. Comparing to the legacy
> bindings (net/cpsw.txt):
> - ports definition follows DSA bindings (net/dsa/dsa.txt) and ports can be
> marked as "disabled" if not physically wired.
> - ports definition follows DSA bindings (net/dsa/dsa.txt) and ports can be
> marked as "disabled" if not physically wired.
> - all deprecated properties dropped;
> - all legacy propertiies dropped which represents constant HW cpapbilities
> (cpdma_channels, ale_entries, bd_ram_size, mac_control, slaves,
> active_slave)
> - cpts properties grouped in "cpts" sub-node
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> ---
>  .../bindings/net/ti,cpsw-switch.txt           | 147 ++++++++++++++++++
>  1 file changed, 147 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/ti,cpsw-switch.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/ti,cpsw-switch.txt b/Documentation/devicetree/bindings/net/ti,cpsw-switch.txt
> new file mode 100644
> index 000000000000..787219cddccd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/ti,cpsw-switch.txt
> @@ -0,0 +1,147 @@
> +TI SoC Ethernet Switch Controller Device Tree Bindings (new)
> +------------------------------------------------------
> +
> +The 3-port switch gigabit ethernet subsystem provides ethernet packet
> +communication and can be configured as an ethernet switch. It provides the
> +gigabit media independent interface (GMII),reduced gigabit media
> +independent interface (RGMII), reduced media independent interface (RMII),
> +the management data input output (MDIO) for physical layer device (PHY)
> +management.
> +
> +Required properties:
> +- compatible : be one of the below:
> +	  "ti,cpsw-switch" for backward compatible
> +	  "ti,am335x-cpsw-switch" for AM335x controllers
> +	  "ti,am4372-cpsw-switch" for AM437x controllers
> +	  "ti,dra7-cpsw-switch" for DRA7x controllers
> +- reg : physical base address and size of the CPSW module IO range
> +- ranges : shall contain the CPSW module IO range available for child devices
> +- clocks : should contain the CPSW functional clock
> +- clock-names : should be "fck"
> +	See bindings/clock/clock-bindings.txt
> +- interrupts : should contain CPSW RX, TX, MISC, RX_THRESH interrupts
> +- interrupt-names : should contain "rx_thresh", "rx", "tx", "misc"

What's the defined order because it's not consistent here.

> +	See bindings/interrupt-controller/interrupts.txt
> +
> +Optional properties:
> +- syscon : phandle to the system control device node which provides access to
> +	efuse IO range with MAC addresses
> +
> +Required Sub-nodes:
> +- ports	: contains CPSW external ports descriptions

Use ethernet-ports to avoid 'ports' from the graph binding.

> +	Required properties:
> +	- #address-cells : Must be 1
> +	- #size-cells : Must be 0
> +	- reg : CPSW port number. Should be 1 or 2
> +	- phys : phandle on phy-gmii-sel PHY (see phy/ti-phy-gmii-sel.txt)
> +	- phy-mode : operation mode of the PHY interface [1]
> +	- phy-handle : phandle to a PHY on an MDIO bus [1]
> +
> +	Optional properties:
> +	- ti,label : Describes the label associated with this port

What's wrong with standard 'label' property.

> +	- ti,dual_emac_pvid : Specifies default PORT VID to be used to segregate

s/_/-/

> +		ports. Default value - CPSW port number.
> +	- mac-address : array of 6 bytes, specifies the MAC address. Always
> +		accounted first if present [1]

No need to re-define this here. 

> +	- local-mac-address : See [1]
> +
> +- mdio : CPSW MDIO bus block description
> +	- bus_freq : MDIO Bus frequency
> +	See bindings/net/mdio.txt and davinci-mdio.txt

Standard properties clock-frequency or bus-frequency would have been 
better...

> +
> +- cpts : The Common Platform Time Sync (CPTS) module description
> +	- clocks : should contain the CPTS reference clock
> +	- clock-names : should be "cpts"
> +	See bindings/clock/clock-bindings.txt
> +
> +	Optional properties - all ports:
> +	- cpts_clock_mult : Numerator to convert input clock ticks into ns
> +	- cpts_clock_shift : Denominator to convert input clock ticks into ns
> +			  Mult and shift will be calculated basing on CPTS
> +			  rftclk frequency if both cpts_clock_shift and
> +			  cpts_clock_mult properties are not provided.

Should have 'ti' prefix and use '-' rather than '_'. However, these are 
already defined somewhere else, right? I can't tell that from reading 
this.

> +
> +[1] See Documentation/devicetree/bindings/net/ethernet.txt
> +
> +Examples - SOC:

Please don't split example into SoC and board. Just show the flat 
example.

> +mac_sw: ethernet_switch@0 {

switch@0

> +	compatible = "ti,dra7-cpsw-switch","ti,cpsw-switch";
> +	reg = <0x0 0x4000>;
> +	ranges = <0 0 0x4000>;
> +	clocks = <&gmac_main_clk>;
> +	clock-names = "fck";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	syscon = <&scm_conf>;
> +	status = "disabled";
> +
> +	interrupts = <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
> +		     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>;
> +	interrupt-names = "rx_thresh", "rx", "tx", "misc"
> +
> +	ports {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpsw_port1: port@1 {
> +			reg = <1>;
> +			ti,label = "port1";

Not really any better than the node name. Do you really even need this 
property?

> +			/* Filled in by U-Boot */
> +			mac-address = [ 00 00 00 00 00 00 ];
> +			phys = <&phy_gmii_sel 1>;
> +		};
> +
> +		cpsw_port2: port@2 {
> +			reg = <2>;
> +			ti,label = "port2";
> +			/* Filled in by U-Boot */
> +			mac-address = [ 00 00 00 00 00 00 ];
> +			phys = <&phy_gmii_sel 2>;
> +		};
> +	};
> +
> +	davinci_mdio_sw: mdio@1000 {
> +		compatible = "ti,cpsw-mdio","ti,davinci_mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		ti,hwmods = "davinci_mdio";
> +		bus_freq = <1000000>;
> +		reg = <0x1000 0x100>;
> +	};
> +
> +	cpts {
> +		clocks = <&gmac_clkctrl DRA7_GMAC_GMAC_CLKCTRL 25>;
> +		clock-names = "cpts";
> +	};
> +};
> +
> +Examples - platform/board:
> +
> +&mac_sw {
> +	pinctrl-names = "default", "sleep";
> +	status = "okay";
> +};
> +
> +&cpsw_port1 {
> +	phy-handle = <&ethphy0_sw>;
> +	phy-mode = "rgmii";
> +	ti,dual_emac_pvid = <1>;
> +};
> +
> +&cpsw_port2 {
> +	phy-handle = <&ethphy1_sw>;
> +	phy-mode = "rgmii";
> +	ti,dual_emac_pvid = <2>;
> +};
> +
> +&davinci_mdio_sw {
> +	ethphy0_sw: ethernet-phy@0 {
> +		reg = <0>;
> +	};
> +
> +	ethphy1_sw: ethernet-phy@1 {
> +		reg = <1>;
> +	};
> +};
> -- 
> 2.17.1
> 
