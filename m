From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: drop vid0 configuration
 in dual_mac modey
Date: Mon, 26 Nov 2018 19:08:44 -0600
Message-ID: <472813b7-2e57-1a42-3f15-c8c54570e7da@ti.com>
References: <20181125234626.28474-1-grygorii.strashko@ti.com>
 <20181126162644.GA23230@khorivan>
 <7f2c5e66-3b42-f921-c52d-236f5adc44bf@ti.com>
 <20181126200757.GB23230@khorivan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181126200757.GB23230@khorivan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 11/26/18 2:07 PM, Ivan Khoronzhuk wrote:
> On Mon, Nov 26, 2018 at 12:57:20PM -0600, Grygorii Strashko wrote:
>>
>>
>> On 11/26/18 10:26 AM, Ivan Khoronzhuk wrote:
>>> On Sun, Nov 25, 2018 at 05:46:26PM -0600, Grygorii Strashko wrote:
>>>> In dual_mac mode CPSW driver uses vid1 and vid2 by default to implement
>>>> dual mac mode wich are used to configure pvids for each external ports.
>>>> But, historicaly, it also adds vid0 to ALE table and sets "untag" bits for both
>>>> ext. ports. As result, it's imposible to use priority tagged packets in
>>>> dual mac mode.
>>>>
>>>> Hence, drop vid0 configuration in dual mac mode as it's not required for dual
>>>> mac mode functionality and, this way, make it possible to use priority
>>>> tagged packet in dual mac mode.
>>> So, now it's enabled to be added via regular ndo.
>>> I have similar change in mind, but was going to send it after
>>> mcast/ucast, and - enabling same vlans patch...
>>>
>>> 2 things stopped me to add this:
>>>
>>> 1) Moving it to be enabled via regular call is Ok, but in dual mac mode
>>> it causes overlaps, at least while vid deletion. So decided to wait till
>>> same vlans series is applied.
>>
>> TI driver documentation mentions this restriction
>> "While adding VLAN id to the eth interfaces,
>> same VLAN id should not be added in both interfaces which will lead to VLAN
>> forwarding and act as switch"
> It's not accurate now.
> This sw bug "acting like a switch" was fixed indirectly in LKML ).
> And at least for upstream version, not TISDK, desc should be updated,
> but better do this when it fixed completely and merged with TISDK.
> 
> I know about this "written" restriction
> (for tiSDK, and it's not TRM after all ...),
> it can be avoided and it's partly avoided now ...
> 
> Also, for notice, while you add any of the vlans to any of
> the ports, vlan0 is added to both of them.....restricted it or not.
> Thanks to last changes in the driver it's not "acting like a switch"
> The patch in question enables this in ndo, not me.
> 
> #ip link add link eth0 name eth0.400 type vlan id 400
> [  326.538989] 8021q: 802.1Q VLAN Support v1.8
> [  326.543217] 8021q: adding VLAN 0 to HW filter on device eth0
> [  326.554645] 8021q: adding VLAN 0 to HW filter on device eth1
> [  326.572236] net eth0: Adding vlanid 400 to vlan filter
> 
> I just propose to extend it later, when it's correct to do.
> But if no harm (basically no harm, only if someone decides
> to add vlan0 to both ports and then delete on one of them)
> , at least you should take this into account.
> 
>>
>>>
>>> 2) Wanted implement somehow similar handling for single port boards
>>> in one patch, not only for dual mac mode. This part was not clear and
>>> not verified completely...
>>>
>>> So, if it's needed now, maybe better at this moment only remove
>>> untag field? and remove vlan0 later, once other vlan changes applied.
>>>
>>> Say:
>>>
>>> cpsw_ale_add_vlan(cpsw->ale, cpsw->data.default_vlan,
>>>            ALE_ALL_PORTS, 0, ALE_ALL_PORTS, 0);
>>>
>>> instead of:
>>> cpsw_ale_add_vlan(cpsw->ale, cpsw->data.default_vlan,
>>>            ALE_ALL_PORTS, ALE_ALL_PORTS, 0, 0);
>>>
>>
>> This patch affects only dual_mac mode and in this mode adding vid0 by default is
>> definitely make no sense in any case.
> The above proposition is only to your change, only for dual-mac.
> 
Thank you for your review. Seems not everything works as expected with this patch,
so ignore it please.

regards,
-grygorii
