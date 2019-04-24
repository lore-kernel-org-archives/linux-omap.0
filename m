From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH net-next 11/19] net: ethernet: ti: cpsw: fix allmulti cfg
 in dual_mac mode
Date: Wed, 24 Apr 2019 17:55:10 +0300
Message-ID: <be83a21e-4831-d592-8fd4-608d4da05b63@ti.com>
References: <1556024950-20752-1-git-send-email-grygorii.strashko@ti.com>
 <1556024950-20752-12-git-send-email-grygorii.strashko@ti.com>
 <20190424122230.GA6075@khorivan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424122230.GA6075@khorivan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: netdev@vger.kernel.org, Ilias Apalodimas <ilias.apalodimas@linaro.org>, "David S . Miller" <davem@davemloft.net>, Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Murali Karicheri <m-karicheri2@ti.com>
List-Id: linux-omap@vger.kernel.org



On 24.04.19 15:22, Ivan Khoronzhuk wrote:
> On Tue, Apr 23, 2019 at 04:09:02PM +0300, Grygorii Strashko wrote:
>> Now CPSW ALE will set/clean Host port bit in Unregistered Multicast Flood
>> Mask (UNREG_MCAST_FLOOD_MASK) for every VLAN without checking if this port
>> belongs to VLAN or not when ALLMULTI mode flag is set for nedev. This is
>> working in non dual_mac mode, but in dual_mac - it causes
>> enabling/disabling ALLMULTI flag for both ports.
>>
>> Hence fix it by adding additional parameter to cpsw_ale_set_allmulti() to
>> specify ALE port number for which ALLMULTI has to be enabled and check if
>> port belongs to VLAN before modifying UNREG_MCAST_FLOOD_MASK.
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>> drivers/net/ethernet/ti/cpsw.c     | 12 +++++++++---
>> drivers/net/ethernet/ti/cpsw_ale.c | 12 ++++++++++--
>> drivers/net/ethernet/ti/cpsw_ale.h |  2 +-
>> 3 files changed, 20 insertions(+), 6 deletions(-)
>>
> [...]
>> +        vlan_members =
>> +            cpsw_ale_get_vlan_member_list(ale_entry,
>> +                              ale->vlan_field_bits);
> Seems like declaration for cpsw_ale_get_vlan_member_list() is not
> part of the patchset
> 
> 

It's define :)
DEFINE_ALE_FIELD1(vlan_member_list,	0)


-- 
Best regards,
grygorii
