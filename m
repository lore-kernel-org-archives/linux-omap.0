From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [RFC PATCH 01/11] phy: core add phy_set_netif_mode() api
Date: Tue, 9 Oct 2018 17:43:00 -0500
Message-ID: <18219d97-f86e-27ee-a116-a8febc3dcd24@ti.com>
References: <20181008234949.15416-1-grygorii.strashko@ti.com>
 <20181008234949.15416-2-grygorii.strashko@ti.com>
 <54ba13bb-95e1-1519-a30f-8da198447489@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <54ba13bb-95e1-1519-a30f-8da198447489@ti.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>
Cc: Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 10/09/2018 12:22 AM, Kishon Vijay Abraham I wrote:
> Hi Grygorii,
> 
> On Tuesday 09 October 2018 05:19 AM, Grygorii Strashko wrote:
>> Add new API phy_set_netif_mode(struct phy *phy, phy_interface_t mode) and
>> new PHY operation callback .set_netif_mode() which intended to be implemnte
>> by PHY drivers which supports Network interrfaces mode selection. Both
>> accepts phy_interface_t vlaue as input parameter.
>>
>> Cc: Kishon Vijay Abraham I <kishon@ti.com>
>> Cc: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>>   drivers/phy/phy-core.c  | 15 +++++++++++++++
>>   include/linux/phy/phy.h | 12 ++++++++++++
>>   2 files changed, 27 insertions(+)
>>
>> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
>> index 35fd38c..d9aba1a 100644
>> --- a/drivers/phy/phy-core.c
>> +++ b/drivers/phy/phy-core.c
>> @@ -377,6 +377,21 @@ int phy_set_mode(struct phy *phy, enum phy_mode mode)
>>   }
>>   EXPORT_SYMBOL_GPL(phy_set_mode);
>>   
>> +int phy_set_netif_mode(struct phy *phy, phy_interface_t mode)
>> +{
>> +	int ret;
>> +
>> +	if (!phy || !phy->ops->set_netif_mode)
>> +		return 0;
>> +
>> +	mutex_lock(&phy->mutex);
>> +	ret = phy->ops->set_netif_mode(phy, mode);
>> +	mutex_unlock(&phy->mutex);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(phy_set_netif_mode);
> 
> We should try to add only generic PHY APIs and not subsystem specific APIs. In
> this case I think phy_set_mode should suffice.


This is what I've had in mind first, but all my guts argued against it after I've tried:

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index bc73d2b..961b156 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -41,6 +41,14 @@ enum phy_mode {
        PHY_MODE_10GKR,
        PHY_MODE_UFS_HS_A,
        PHY_MODE_UFS_HS_B,
+       PHY_MODE_MODE_MII,
+       PHY_MODE_MODE_GMII,
+       PHY_MODE_MODE_SGMII,
+       PHY_MODE_MODE_RMII,
+       PHY_MODE_MODE_RGMII,
+       PHY_MODE_MODE_RGMII_ID,
+       PHY_MODE_MODE_RGMII_RXID,
+       PHY_MODE_MODE_RGMII_TXID,
 };

above introduces ugly constants duplication and required every network phy driver
to maintain conversation table  phy_interface_t -> enum phy_mode.
More over, if above change happens third time (first time PHY_MODE_SGMII/PHY_MODE_10GKR were added,
second - PHY_MODE_2500SGMII) it will never ends (there are ~15 more items only in phy_interface_t).
As result, enum phy_mode might became a un-maintainable monster.

So, as per above, and considering that Network subsystem is based on standards (phy_interface_t lists standard intf)
I've tried to add separate PHY API.

As an idea:
- seems it could be reasonable to introduce PHY_MODE_NETWORK (or PHY_MODE_ETHERNET) and
add generic phy_set_submode(struct phy *phy, long submode). 

So, single functional PHY device can just use phy_set_submode() and
multi-functional devices (like serdes which can be muxed between PCIe, USB, NET), can use:

phy_set_mode(PHY_MODE_ETHERNET)
phy_set_submode(X);

Any way, if you still agree to just add new above phy_modes - i'll redo patches.

-- 
regards,
-grygorii
