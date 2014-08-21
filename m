From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [PATCH v4 5/7] net: cpsw: Add am33xx MACID readout
Date: Thu, 21 Aug 2014 14:51:53 +0530
Message-ID: <53F5BA31.6030703@ti.com>
References: <1408600314-19824-1-git-send-email-mpa@pengutronix.de> <1408600314-19824-6-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49946 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753849AbaHUJWg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 Aug 2014 05:22:36 -0400
In-Reply-To: <1408600314-19824-6-git-send-email-mpa@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>, "David S. Miller" <davem@davemloft.net>
Cc: =?windows-1252?Q?Beno=EEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@the-dreams.de>, Steven Rostedt <rostedt@goodmis.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

On Thursday 21 August 2014 11:21 AM, Markus Pargmann wrote:
> This patch adds a function to get the MACIDs from the am33xx SoC
> control module registers which hold unique vendor MACIDs. This is only
> used if of_get_mac_address() fails to get a valid mac address.
>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> Reviewed-by: Wolfram Sang <wsa@the-dreams.de>
> Tested-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  Documentation/devicetree/bindings/net/cpsw.txt |  4 +++
>  drivers/net/ethernet/ti/Kconfig                |  2 ++
>  drivers/net/ethernet/ti/cpsw.c                 | 46 ++++++++++++++++++++++++--
>  3 files changed, 50 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/net/cpsw.txt b/Documentation/devicetree/bindings/net/cpsw.txt
> index 107caf174a0e..33fe8462edf4 100644
> --- a/Documentation/devicetree/bindings/net/cpsw.txt
> +++ b/Documentation/devicetree/bindings/net/cpsw.txt
> @@ -24,6 +24,8 @@ Optional properties:
>  - ti,hwmods		: Must be "cpgmac0"
>  - no_bd_ram		: Must be 0 or 1
>  - dual_emac		: Specifies Switch to act as Dual EMAC
> +- syscon		: Phandle to the system control device node, which is
> +			  the control module device of the am33x
>  
>  Slave Properties:
>  Required properties:
> @@ -57,6 +59,7 @@ Examples:
>  		active_slave = <0>;
>  		cpts_clock_mult = <0x80000000>;
>  		cpts_clock_shift = <29>;
> +		syscon = <&cm>;
>  		cpsw_emac0: slave@0 {
>  			phy_id = <&davinci_mdio>, <0>;
>  			phy-mode = "rgmii-txid";
> @@ -85,6 +88,7 @@ Examples:
>  		active_slave = <0>;
>  		cpts_clock_mult = <0x80000000>;
>  		cpts_clock_shift = <29>;
> +		syscon = <&cm>;
>  		cpsw_emac0: slave@0 {
>  			phy_id = <&davinci_mdio>, <0>;
>  			phy-mode = "rgmii-txid";
> diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
> index 1769700a6070..5d8cb7956113 100644
> --- a/drivers/net/ethernet/ti/Kconfig
> +++ b/drivers/net/ethernet/ti/Kconfig
> @@ -62,6 +62,8 @@ config TI_CPSW
>  	select TI_DAVINCI_CPDMA
>  	select TI_DAVINCI_MDIO
>  	select TI_CPSW_PHY_SEL
> +	select MFD_SYSCON
> +	select REGMAP
>  	---help---
>  	  This driver supports TI's CPSW Ethernet Switch.
>  
> diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
> index 0bc2c2a2c236..aaf8a42f9633 100644
> --- a/drivers/net/ethernet/ti/cpsw.c
> +++ b/drivers/net/ethernet/ti/cpsw.c
> @@ -33,6 +33,8 @@
>  #include <linux/of_net.h>
>  #include <linux/of_device.h>
>  #include <linux/if_vlan.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
>  
>  #include <linux/pinctrl/consumer.h>
>  
> @@ -1816,6 +1818,39 @@ static void cpsw_slave_init(struct cpsw_slave *slave, struct cpsw_priv *priv,
>  	slave->port_vlan = data->dual_emac_res_vlan;
>  }
>  
> +#define AM33XX_CTRL_MAC_LO_REG(id) (0x630 + 0x8 * id)
> +#define AM33XX_CTRL_MAC_HI_REG(id) (0x630 + 0x8 * id + 0x4)
> +
> +static int cpsw_am33xx_cm_get_macid(struct device *dev, int slave,
> +		u8 *mac_addr)
> +{
> +	u32 macid_lo;
> +	u32 macid_hi;
> +	struct regmap *syscon;
> +
> +	if (!of_machine_is_compatible("ti,am33xx"))
> +		return 0;
> +
> +	syscon = syscon_regmap_lookup_by_phandle(dev->of_node, "syscon");
> +	if (IS_ERR(syscon)) {
> +		if (PTR_ERR(syscon) == -ENODEV)
> +			return 0;
> +		return PTR_ERR(syscon);
> +	}
> +
> +	regmap_read(syscon, AM33XX_CTRL_MAC_LO_REG(slave), &macid_lo);
> +	regmap_read(syscon, AM33XX_CTRL_MAC_HI_REG(slave), &macid_hi);
> +
> +	mac_addr[5] = (macid_lo >> 8) & 0xff;
> +	mac_addr[4] = macid_lo & 0xff;
> +	mac_addr[3] = (macid_hi >> 24) & 0xff;
> +	mac_addr[2] = (macid_hi >> 16) & 0xff;
> +	mac_addr[1] = (macid_hi >> 8) & 0xff;
> +	mac_addr[0] = macid_hi & 0xff;
> +
> +	return 0;
> +}
> +
>  static int cpsw_probe_dt(struct cpsw_platform_data *data,
>  			 struct platform_device *pdev)
>  {
> @@ -1928,8 +1963,15 @@ static int cpsw_probe_dt(struct cpsw_platform_data *data,
>  			 PHY_ID_FMT, mdio->name, phyid);
>  
>  		mac_addr = of_get_mac_address(slave_node);
> -		if (mac_addr)
> -			memcpy(slave_data->mac_addr, mac_addr, ETH_ALEN);
> +		if (mac_addr) {
> +			memcpy(slave_data->mac_addr, mac_addr,
> +					ETH_ALEN);

Alignment should match open parenthesis

> +		} else {
> +			ret = cpsw_am33xx_cm_get_macid(&pdev->dev, i,
> +					slave_data->mac_addr);
> +			if (ret)
> +				return ret;
> +		}
>  
>  		slave_data->phy_if = of_get_phy_mode(slave_node);
>  		if (slave_data->phy_if < 0) {

