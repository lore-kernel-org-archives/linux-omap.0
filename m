From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 5/7] net: cpsw: Add am33xx MACID readout
Date: Mon, 25 Aug 2014 09:01:19 -0700
Message-ID: <20140825160118.GG17254@atomide.com>
References: <1408947828-22316-1-git-send-email-mpa@pengutronix.de>
 <1408947828-22316-6-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50402 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754797AbaHYQBe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Aug 2014 12:01:34 -0400
Content-Disposition: inline
In-Reply-To: <1408947828-22316-6-git-send-email-mpa@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Wolfram Sang <wsa@the-dreams.de>, Steven Rostedt <rostedt@goodmis.org>, Mugunthan V N <mugunthanvnm@ti.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

* Markus Pargmann <mpa@pengutronix.de> [140824 23:24]:
> This patch adds a function to get the MACIDs from the am33xx SoC
> control module registers which hold unique vendor MACIDs. This is only
> used if of_get_mac_address() fails to get a valid mac address.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> Reviewed-by: Wolfram Sang <wsa@the-dreams.de>
> Tested-by: Steven Rostedt <rostedt@goodmis.org>
> ---
> 
> Notes:
>     Changes in v5:
>      - Fixed indention
> 
>  Documentation/devicetree/bindings/net/cpsw.txt |  4 +++
>  drivers/net/ethernet/ti/Kconfig                |  2 ++
>  drivers/net/ethernet/ti/cpsw.c                 | 43 +++++++++++++++++++++++++-
>  3 files changed, 48 insertions(+), 1 deletion(-)
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
> index 0bc2c2a2c236..7c94a0fb24bc 100644
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

I think this only works for the first instance of the cpsw?

Can the other instances of cpsw use this too and just increment
some value in it?

>  static int cpsw_probe_dt(struct cpsw_platform_data *data,
>  			 struct platform_device *pdev)
>  {
> @@ -1928,8 +1963,14 @@ static int cpsw_probe_dt(struct cpsw_platform_data *data,
>  			 PHY_ID_FMT, mdio->name, phyid);
>  
>  		mac_addr = of_get_mac_address(slave_node);
> -		if (mac_addr)
> +		if (mac_addr) {
>  			memcpy(slave_data->mac_addr, mac_addr, ETH_ALEN);
> +		} else {
> +			ret = cpsw_am33xx_cm_get_macid(&pdev->dev, i,
> +						       slave_data->mac_addr);
> +			if (ret)
> +				return ret;
> +		}
>  
>  		slave_data->phy_if = of_get_phy_mode(slave_node);
>  		if (slave_data->phy_if < 0) {

The cpsw_am33xx_cm_get_macid() should only get called based on the
compatible flag to avoid random register access on other SoCs.

So how about add the of_machine_is_compatible("ti,am33xx")
check here instead and skip calling cpsw_am33xx_cm_get_macid()
otherwise?

That allows adding support for other omaps as we already have
ti,am4372-cpsw and people have pointed out issues with dra7xx
already.

Regards,

Tony
