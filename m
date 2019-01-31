From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] phy: ti-pipe3: Add set_mode callback to configure usb3
 phy as pcie phy
Date: Thu, 31 Jan 2019 11:32:24 +0530
Message-ID: <66b1de88-dd11-178d-374b-09eb5739bfb3@ti.com>
References: <20190124104822.22411-1-kishon@ti.com> <5C51BBAD.3090304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5C51BBAD.3090304@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org

Roger,

On 30/01/19 8:28 PM, Roger Quadros wrote:
> Kishon,
> 
> On 24/01/19 12:48, Kishon Vijay Abraham I wrote:
>> DRA72 platform has the second instance of PHY shared between USB3
>> controller and PCIe controller with default as USB3 controller.
>> Since it is used with USB3 controller by default, it uses the
>> compatible specific to USB (ti,omap-usb3).
>>
>> Populate set_mode callback so that the USB3 PHY can be configured
>> to be used with PCIe controller.
> 
> How about rewording this to,
> 
> "On DRA72x SoCs, the USB3 PHY can be used either as USB Super-Speed
> lane or as PCIe Lane (i.e. second lane for PCIe_SS1 in 2 lane mode or single
> lane for PCIe_SS2). The default mode for the USB3 PHY is USB Super-Speed.
> Provide a way for the PHY user to choose the appropriate mode via the
> .set_mode hook"

hmm okay
> 
> More comments below.
> 
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>>  drivers/phy/ti/phy-ti-pipe3.c | 66 ++++++++++++++++++++++++++++-------
>>  1 file changed, 54 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/phy/ti/phy-ti-pipe3.c b/drivers/phy/ti/phy-ti-pipe3.c
>> index 68ce4a082b9b..8c98f366416d 100644
>> --- a/drivers/phy/ti/phy-ti-pipe3.c
>> +++ b/drivers/phy/ti/phy-ti-pipe3.c
>> @@ -56,6 +56,12 @@
>>  
>>  #define SATA_PLL_SOFT_RESET	BIT(18)
>>  
>> +#define PHY_RX_ANA_PRGRAMMABILITY_REG	0xC
>> +#define MEM_EN_PLLBYP			BIT(7)
>> +
>> +#define PHY_TX_TEST_CONFIG		0x2C
>> +#define MEM_ENTESTCLK			BIT(31)
>> +
>>  #define PIPE3_PHY_PWRCTL_CLK_CMD_MASK	0x003FC000
>>  #define PIPE3_PHY_PWRCTL_CLK_CMD_SHIFT	14
>>  
>> @@ -110,6 +116,8 @@
>>  #define PLL_IDLE_TIME	100	/* in milliseconds */
>>  #define PLL_LOCK_TIME	100	/* in milliseconds */
>>  
>> +#define PIPE3_PHY_DISABLE_SYNC_POWER	BIT(4)
>> +
>>  struct pipe3_dpll_params {
>>  	u16	m;
>>  	u8	n;
>> @@ -141,6 +149,7 @@ struct ti_pipe3 {
>>  	unsigned int		power_reg; /* power reg. index within syscon */
>>  	unsigned int		pcie_pcs_reg; /* pcs reg. index in syscon */
>>  	bool			sata_refclk_enabled;
>> +	u32			mode;
>>  };
>>  
>>  static struct pipe3_dpll_map dpll_map_usb[] = {
>> @@ -233,7 +242,10 @@ static int ti_pipe3_power_on(struct phy *x)
>>  	rate = rate / 1000000;
>>  	mask = OMAP_CTRL_PIPE3_PHY_PWRCTL_CLK_CMD_MASK |
>>  		  OMAP_CTRL_PIPE3_PHY_PWRCTL_CLK_FREQ_MASK;
>> -	val = PIPE3_PHY_TX_RX_POWERON << PIPE3_PHY_PWRCTL_CLK_CMD_SHIFT;
>> +	val = PIPE3_PHY_TX_RX_POWERON;
>> +	if (phy->mode == PHY_MODE_PCIE)
>> +		val |= PIPE3_PHY_DISABLE_SYNC_POWER;
> 
> Is this required only for the USB3 PHY being used as PCIe lane or can it
> be done for the PCIe PHY as well?

This setting was given only for USB3 PHY. I did check PCIe PHY (1-lane) to see
if this is causing issues before posting the patch.

Thinking again, it might be safer to just use this setting for USB3 PHY.
> 
> I ask this because phy->mode can be PHY_MODE_PCIE for both USB3 PHY and PCIe PHY
> and it might break PCIe PHY as we don't do PIPE3_PHY_DISABLE_SYNC_POWER for that
> currently.
> 
> Maybe this is safer?
> 
> 	if (phy->mode == PHY_MODE_PCIE && of_device_is_compatible(node, "ti,phy-usb3"))

yeah..
> 
>> +	val <<= PIPE3_PHY_PWRCTL_CLK_CMD_SHIFT;
>>  	val |= rate << OMAP_CTRL_PIPE3_PHY_PWRCTL_CLK_FREQ_SHIFT;
>>  
>>  	ret = regmap_update_bits(phy->phy_power_syscon, phy->power_reg,
>> @@ -328,13 +340,11 @@ static void ti_pipe3_calibrate(struct ti_pipe3 *phy)
>>  	ti_pipe3_writel(phy->phy_rx, PCIEPHYRX_EQUALIZER, val);
>>  }
>>  
>> -static int ti_pipe3_init(struct phy *x)
>> +static int ti_pipe3_pcie_init(struct ti_pipe3 *phy)
>>  {
>> -	struct ti_pipe3 *phy = phy_get_drvdata(x);
>> -	u32 val;
>>  	int ret = 0;
>> +	u32 val;
>>  
>> -	ti_pipe3_enable_clocks(phy);
>>  	/*
>>  	 * Set pcie_pcs register to 0x96 for proper functioning of phy
>>  	 * as recommended in AM572x TRM SPRUHZ6, section 18.5.2.2, table
>> @@ -353,10 +363,31 @@ static int ti_pipe3_init(struct phy *x)
>>  			return ret;
>>  
>>  		ti_pipe3_calibrate(phy);
>> -
>> -		return 0;
>> +	} else {
> 
> How about
> 
> 	else if (of_device_is_compatible(node, "ti,phy-usb3")) {

This check is implicit no?
> 		/* USB3 PHY being used as PCIe Lane */
> 
>> +		val = ti_pipe3_readl(phy->phy_rx,
>> +				     PHY_RX_ANA_PRGRAMMABILITY_REG);
>> +		val |= MEM_EN_PLLBYP;
>> +		ti_pipe3_writel(phy->phy_rx, PHY_RX_ANA_PRGRAMMABILITY_REG,
>> +				val);
>> +		val = ti_pipe3_readl(phy->phy_tx, PHY_TX_TEST_CONFIG);
>> +		val |= MEM_ENTESTCLK;
>> +		ti_pipe3_writel(phy->phy_tx, PHY_TX_TEST_CONFIG, val);
>>  	}
>>  
>> +	return 0;
>> +}
>> +
>> +static int ti_pipe3_init(struct phy *x)
>> +{
>> +	struct ti_pipe3 *phy = phy_get_drvdata(x);
>> +	u32 val;
>> +	int ret = 0;
>> +
>> +	ti_pipe3_enable_clocks(phy);
>> +
>> +	if (phy->mode == PHY_MODE_PCIE)
> 
> Here you expect PHY "ti,phy-pipe3-pcie" to have mode = PHY_MODE_PCIE.
> Should we set the mode to PCI_MODE_PCIE explicitly it in probe?

The set_mode callback checks if the phy->mode is INVALID before setting the
mode. The phy_set_mode in the PCIe consumer driver will return error if it is
already set. The phy_set_mode will be called for both the lanes by the PCIe driver.
> 
>> +		return ti_pipe3_pcie_init(phy);
>> +
>>  	/* Bring it out of IDLE if it is IDLE */
>>  	val = ti_pipe3_readl(phy->pll_ctrl_base, PLL_CONFIGURATION2);
>>  	if (val & PLL_IDLE) {
>> @@ -395,7 +426,7 @@ static int ti_pipe3_exit(struct phy *x)
>>  		return 0;
>>  
>>  	/* PCIe doesn't have internal DPLL */
>> -	if (!of_device_is_compatible(phy->dev->of_node, "ti,phy-pipe3-pcie")) {
>> +	if (!(phy->mode == PHY_MODE_PCIE)) {
> 
> But this might be a USB3 PHY, which has DPLL.

hmm. I have to check this. We should also then reset PLL_IDLE bit in phy_init.
> 
>>  		/* Put DPLL in IDLE mode */
>>  		val = ti_pipe3_readl(phy->pll_ctrl_base, PLL_CONFIGURATION2);
>>  		val |= PLL_IDLE;
>> @@ -429,11 +460,25 @@ static int ti_pipe3_exit(struct phy *x)
>>  
>>  	return 0;
>>  }
>> +
>> +static int ti_pipe3_set_mode(struct phy *x, enum phy_mode mode, int submode)
>> +{
>> +	struct ti_pipe3 *phy = phy_get_drvdata(x);
>> +
>> +	if (phy->mode != PHY_MODE_INVALID)
>> +		return -EBUSY;
>> +
>> +	phy->mode = mode;
> 
> We need to do a sanity check here and prevent unsupported modes being set.
> 
> e.g. we don't want PCIe mode being set on omap-usb3 PHY or SATA PHY.
> 
> Which makes me wonder, if all PHYs with compatible "ti,phy-usb3" don't support
> PCIe mode then we might need to add a new compatible for USB3 PHY's that do support
> PCIe mode?
> 
> Or maybe a DT-property of supported PHY modes?

hmm yeah, makes sense.
> 
>> +
>> +	return 0;
>> +}
>> +
>>  static const struct phy_ops ops = {
>>  	.init		= ti_pipe3_init,
>>  	.exit		= ti_pipe3_exit,
>>  	.power_on	= ti_pipe3_power_on,
>>  	.power_off	= ti_pipe3_power_off,
>> +	.set_mode	= ti_pipe3_set_mode,
>>  	.owner		= THIS_MODULE,
>>  };
>>  
>> @@ -589,12 +634,8 @@ static int ti_pipe3_get_tx_rx_base(struct ti_pipe3 *phy)
>>  {
>>  	struct resource *res;
>>  	struct device *dev = phy->dev;
>> -	struct device_node *node = dev->of_node;
>>  	struct platform_device *pdev = to_platform_device(dev);
>>  
>> -	if (!of_device_is_compatible(node, "ti,phy-pipe3-pcie"))
>> -		return 0;
>> -
> 
> Do all USB3 and SATA PHYs have "phy_rx" and "phy_tx" regions?
> If not it will break them.

yes they have.

Thanks
Kishon
