From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v5 net-next 06/12] net: ethernet: ti: introduce cpsw
 switchdev based driver part 1 - dual-emac
Date: Fri, 1 Nov 2019 22:16:34 +0200
Message-ID: <d87c72e1-cb91-04a2-c881-0d8eec4671e2@ti.com>
References: <20191024100914.16840-1-grygorii.strashko@ti.com>
 <20191024100914.16840-7-grygorii.strashko@ti.com>
 <20191029122422.GL15259@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191029122422.GL15259@lunn.ch>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Jiri Pirko <jiri@resnulli.us>, Florian Fainelli <f.fainelli@gmail.com>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>, Ivan Vecera <ivecera@redhat.com>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Andrew,

On 29/10/2019 14:24, Andrew Lunn wrote:
>>   config TI_CPTS
>>   	bool "TI Common Platform Time Sync (CPTS) Support"
>> -	depends on TI_CPSW || TI_KEYSTONE_NETCP || COMPILE_TEST
>> +	depends on TI_CPSW || TI_KEYSTONE_NETCP || COMPILE_TEST || TI_CPSW_SWITCHDEV
> 
> nit picking, but COMPILE_TEST is generally last on the line.
> 
>> +/**
>> + * cpsw_set_mc - adds multicast entry to the table if it's not added or deletes
>> + * if it's not deleted
>> + * @ndev: device to sync
>> + * @addr: address to be added or deleted
>> + * @vid: vlan id, if vid < 0 set/unset address for real device
>> + * @add: add address if the flag is set or remove otherwise
>> + */
>> +static int cpsw_set_mc(struct net_device *ndev, const u8 *addr,
>> +		       int vid, int add)
>> +{
>> +	struct cpsw_priv *priv = netdev_priv(ndev);
>> +	struct cpsw_common *cpsw = priv->cpsw;
>> +	int slave_no = cpsw_slave_index(cpsw, priv);
>> +	int mask, flags, ret;
> 
> David will complain about reverse Christmas tree. You need to move
> some of the assignments into the body of the function. This problems
> happens a few times in the code.
> 
>> +static int cpsw_set_pauseparam(struct net_device *ndev,
>> +			       struct ethtool_pauseparam *pause)
>> +{
>> +	struct cpsw_common *cpsw = ndev_to_cpsw(ndev);
>> +	struct cpsw_priv *priv = netdev_priv(ndev);
>> +
>> +	priv->rx_pause = pause->rx_pause ? true : false;
>> +	priv->tx_pause = pause->tx_pause ? true : false;
>> +
>> +	return phy_restart_aneg(cpsw->slaves[priv->emac_port - 1].phy);
>> +}
> 
> You should look at the value of pause.autoneg.

I'll use phy_validate_pause() and phy_set_asym_pause() here,
and fix other comments.

> 
>> +static const struct devlink_ops cpsw_devlink_ops;
> 
> It would be nice to avoid this forward declaration.

It's not declaration, it's definition of devlink_ops without any standard callbacks implemented.

> 
>> +static const struct devlink_param cpsw_devlink_params[] = {
>> +	DEVLINK_PARAM_DRIVER(CPSW_DL_PARAM_ALE_BYPASS,
>> +			     "ale_bypass", DEVLINK_PARAM_TYPE_BOOL,
>> +			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
>> +			     cpsw_dl_ale_ctrl_get, cpsw_dl_ale_ctrl_set, NULL),
>> +};
> 
> Is this documented?

In patch 9. But I'll update it and add standard devlink parameter definition, like:

ale_bypass	[DEVICE, DRIVER-SPECIFIC]
		Allows to enable ALE_CONTROL(4).BYPASS mode for debug purposes
		Type: bool
		Configuration mode: runtime

Thank you for review.

-- 
Best regards,
grygorii
