From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [RFC PATCH 03/11] phy: ti: introduce phy-gmii-sel driver
Date: Tue, 9 Oct 2018 15:22:15 -0500
Message-ID: <cf3aba04-fad9-ad1d-1b51-1b6dbbd4ba5d@ti.com>
References: <20181008234949.15416-1-grygorii.strashko@ti.com>
 <20181008234949.15416-4-grygorii.strashko@ti.com>
 <20181009003935.GA23588@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181009003935.GA23588@lunn.ch>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Andrew,

On 10/08/2018 07:39 PM, Andrew Lunn wrote:
> On Mon, Oct 08, 2018 at 06:49:41PM -0500, Grygorii Strashko wrote:
>> +static int phy_gmii_sel_mode(struct phy *phy, phy_interface_t intf_mode)
>> +{
>> +	struct phy_gmii_sel_phy_priv *if_phy = phy_get_drvdata(phy);
>> +	const struct phy_gmii_sel_soc_data *soc_data = if_phy->priv->soc_data;
>> +	struct device *dev = if_phy->priv->dev;
>> +	struct regmap_field *regfield;
>> +	int ret, rgmii_id = 0;
>> +	u32 mode = 0;
>> +
>> +	if_phy->phy_if_mode = intf_mode;
>> +
>> +	switch (if_phy->phy_if_mode) {
>> +	case PHY_INTERFACE_MODE_RMII:
>> +		mode = AM33XX_GMII_SEL_MODE_RMII;
>> +		break;
>> +
>> +	case PHY_INTERFACE_MODE_RGMII:
>> +		mode = AM33XX_GMII_SEL_MODE_RGMII;
>> +		break;
>> +
>> +	case PHY_INTERFACE_MODE_RGMII_ID:
>> +	case PHY_INTERFACE_MODE_RGMII_RXID:
>> +	case PHY_INTERFACE_MODE_RGMII_TXID:
>> +		mode = AM33XX_GMII_SEL_MODE_RGMII;
>> +		rgmii_id = 1;
>> +		break;
> 
> Hi Grygorii
> 
> It looks like the MAC can do AM33XX_GMII_SEL_MODE_RGMII and
> AM33XX_GMII_SEL_MODE_RGMII_ID. I don't think it can do
> AM33XX_GMII_SEL_MODE_RGMII_RXID or AM33XX_GMII_SEL_MODE_RGMII_TXID?

Sry, but would prefer not to thought this logic as part of this series as i moved it here
unchanged rom cpsw-phy-sel.c (except adding possibility to update only supported field)
and any changes here would require separate review (including all existing TI DT boards)
and testing.

  I
> would prefer it return -EINVAL when asked to do something it cannot
> do.

Just to clarify rgmii_id = 1 means *disable* CPSW Internal Delay Mode.
> 
>> +
>> +	default:
>> +		dev_warn(dev,
>> +			 "port%u: unsupported mode: \"%s\". Defaulting to MII.\n",
>> +			 if_phy->id, phy_modes(rgmii_id));
>> +		/* fall through */
> 
> Returning -EINVAL would be better. Otherwise the DT might never get
> fixed.

ok

> 
>> +	case PHY_INTERFACE_MODE_MII:
>> +		mode = AM33XX_GMII_SEL_MODE_MII;
>> +		break;
>> +	};
>> +
>> +	dev_dbg(dev, "%s id:%u mode:%u rgmii_id:%d rmii_clk_ext:%d\n",
>> +		__func__, if_phy->id, mode, rgmii_id,
>> +		if_phy->rmii_clock_external);
>> +
>> +	regfield = if_phy->fields[PHY_GMII_SEL_PORT_MODE];
>> +	ret = regmap_field_write(regfield, mode);
>> +
>> +	if (soc_data->features & BIT(PHY_GMII_SEL_RGMII_ID_MODE) &&
>> +	    if_phy->fields[PHY_GMII_SEL_RGMII_ID_MODE]) {
>> +		regfield = if_phy->fields[PHY_GMII_SEL_RGMII_ID_MODE];
>> +		ret |= regmap_field_write(regfield, rgmii_id);
>> +	}
>> +
>> +	if (soc_data->features & BIT(PHY_GMII_SEL_RMII_IO_CLK_EN) &&
>> +	    if_phy->fields[PHY_GMII_SEL_RMII_IO_CLK_EN]) {
>> +		regfield = if_phy->fields[PHY_GMII_SEL_RMII_IO_CLK_EN];
>> +		ret |= regmap_field_write(regfield,
>> +					  if_phy->rmii_clock_external);
>> +	}
>> +
>> +	if (ret) {
>> +		dev_err(dev, "port%u: set mode fail %d", if_phy->id, ret);
>> +		return -EIO;
>> +	}
> 
> I would prefer each write had its own error check. The fact you don't
> return ret means you know ret could be -EINVAL|-EOIO, making
> -EMORECOFFEE.

:) right, sry.

-- 
regards,
-grygorii
