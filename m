From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: drop vid0 configuration
 in dual_mac modey
Date: Mon, 26 Nov 2018 12:57:20 -0600
Message-ID: <7f2c5e66-3b42-f921-c52d-236f5adc44bf@ti.com>
References: <20181125234626.28474-1-grygorii.strashko@ti.com>
 <20181126162644.GA23230@khorivan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181126162644.GA23230@khorivan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 11/26/18 10:26 AM, Ivan Khoronzhuk wrote:
> On Sun, Nov 25, 2018 at 05:46:26PM -0600, Grygorii Strashko wrote:
>> In dual_mac mode CPSW driver uses vid1 and vid2 by default to implement
>> dual mac mode wich are used to configure pvids for each external ports.
>> But, historicaly, it also adds vid0 to ALE table and sets "untag" bits for both
>> ext. ports. As result, it's imposible to use priority tagged packets in
>> dual mac mode.
>>
>> Hence, drop vid0 configuration in dual mac mode as it's not required for dual
>> mac mode functionality and, this way, make it possible to use priority
>> tagged packet in dual mac mode.
> So, now it's enabled to be added via regular ndo.
> I have similar change in mind, but was going to send it after
> mcast/ucast, and - enabling same vlans patch...
> 
> 2 things stopped me to add this:
> 
> 1) Moving it to be enabled via regular call is Ok, but in dual mac mode
> it causes overlaps, at least while vid deletion. So decided to wait till
> same vlans series is applied.

TI driver documentation mentions this restriction
"While adding VLAN id to the eth interfaces, 
same VLAN id should not be added in both interfaces which will lead to VLAN
forwarding and act as switch"

> 
> 2) Wanted implement somehow similar handling for single port boards
> in one patch, not only for dual mac mode. This part was not clear and
> not verified completely...
> 
> So, if it's needed now, maybe better at this moment only remove
> untag field? and remove vlan0 later, once other vlan changes applied.
> 
> Say:
> 
> cpsw_ale_add_vlan(cpsw->ale, cpsw->data.default_vlan,
>            ALE_ALL_PORTS, 0, ALE_ALL_PORTS, 0);
> 
> instead of:
> cpsw_ale_add_vlan(cpsw->ale, cpsw->data.default_vlan,
>            ALE_ALL_PORTS, ALE_ALL_PORTS, 0, 0);
> 

This patch affects only dual_mac mode and in this mode adding vid0 by default is
definitely make no sense in any case. 

[1] http://processors.wiki.ti.com/index.php/Linux_Core_CPSW_User%27s_Guide#Dual_Standalone_EMAC_mode

>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> ---
>> drivers/net/ethernet/ti/cpsw.c | 7 ++-----
>> 1 file changed, 2 insertions(+), 5 deletions(-)
-- 
regards,
-grygorii
