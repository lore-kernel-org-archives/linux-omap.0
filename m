From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: Re: [RFC PATCH net-next 0/5] net: allow hw addresses for virtual
 devices
Date: Tue, 4 Dec 2018 03:15:07 +0200
Message-ID: <20181204011506.GG23230@khorivan>
References: <20181203184023.3430-1-ivan.khoronzhuk@linaro.org>
 <ec39f484-0fec-0721-f944-01e3a552a667@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ec39f484-0fec-0721-f944-01e3a552a667@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: davem@davemloft.net, grygorii.strashko@ti.com, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@mellanox.com, andrew@lunn.ch
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 03, 2018 at 02:25:40PM -0800, Florian Fainelli wrote:
>On 12/3/18 10:40 AM, Ivan Khoronzhuk wrote:
>> One of the reasons of this proposition is safety and performance -
>> host should not receive traffic which is not designated for it.
>>
>> Some network devices can hold separate address tables for vlans and
>> real device, but for some reason there is no possibility to apply it
>> with generic net addressing scheme easily. At this moment the fastest
>> solution is to add mcast/ucast entries for every created vlan
>> including real device. But it also adds holes in the filtering and
>> thus wastes cpus cycles.
>>
>> This patchseries tries to correct core to assign mcast and ucast
>> addresses only for vlans that really require it and as result an end
>> driver can exclusively and simply set its rx filters. As an example
>> it's implemented on cpsw TI driver, but generic changes provided by
>> this series can be reused by other ethernet drivers having similar
>> rx filter address possibilities.
>>
>> An address+vid is considered as separate address. The reserved device
>> address length is 32 Bytes, for ethernet devices it's additional
>> opportunity to pass auxiliary address info, like virtual ID
>> identifying a device the address belongs to. This series makes it
>> possible at least for ETH_P_8021Q, but can be easily extended for ab.
>> Thus end real device can setup separate tables for virtual devices
>> just retrieving VID from the address. A device address space can
>> maintain addresses and references on them separately for each virtual
>> device if it needs so, or only addresses for real device (and all its
>> vlans) it holds usually.
>>
>> A vlan device can be in any place of device chain upper real device,
>> say smth like rdevice/bonding/vlan or even rdevice/macvlan/vlan.
>> Similar approach can be used for passing additional information for
>> virtual devices as allmulti flag or/and promisc flag and do this per
>> vlan, but this is separate story and could be added as a continuation.
>>
>> I was biased by try to add exclusive mcast and ucast support for vlans
>> and now have same with small generic correction and mostly locally in
>> the cpsw driver:
>> https://git.linaro.org/people/ivan.khoronzhuk/tsn_kernel.git/log/?h=ucast_vlan_fix
>> https://git.linaro.org/people/ivan.khoronzhuk/tsn_kernel.git/log/?h=mcast_vlan
>> and can say it looks better with generic changes provided by this patchset,
>> that's why this RFC. Above links can be used as fallback.
>>
>> This series is verified on TI am572x EVM that can hold separate tables
>> for vlans. Potentially it can be easily extended to netcp driver for
>> keystone 2 boards (including k2g) and also new am6 chipsets. As a
>> simple test case, different combinations of vlan+macvlan, macvlan+vlan
>> were used and tested as with unicast as multicast addresses.
>
>I think I get what you want to do, which is make sure that on per VID
>basis, only the necessary UC and MC addresses are programmed into the
>respective filters, when each of your network ports operate in what cpsw
>calls "dual emac"? Which is really something that should be called "NIC"
dual emac here is just a mode when two ports using shared h/w tried to
behave as a completely separate interfaces. But no sense here about it, as
this change is applicable for just one NIC that can be part of any struct
of above devices.


>mode, and/or is analogous to how we bring up ports in DSA: each of them
>acts as a separate network device. Speaking of the later, we have some
>known issues in unmanaged mode with MC addresses which I am working on
>addressing.
>
>It seems to me, as replied in patch 2, that what you are missing is the
>source of the address programming request, and therefore either you pass
>an additional "source net_device" to functions like dev_{uc,mc}_sync(),
I don't know correct way to propagate vlan device to the end real devices.
The closest I've found is to propagate it along with adding vid to parent
devices, but even in this case, it requires changes for every device
being able to propagate vid to real dev, where not always "structure" is
clear. But this approach also has drawbacks with code on end device,
see next comments.

>or you pass a well defined structured that can encode the address as
>well as the interface type, but the approach you have right now, where
>the address storage is extended to include the VID is both extremely
The address length is not changed, only used part that was reserved and
was present always. Changing addr len is much more harder then it looks
like, I've tried ).

>specific to VLAN devices, as well as not scaling particularly well.
I would rather decipher it as virtual ID. VID, virtual ID is smth not
strictly related for vlans, it can be considered as any device
identification with assumptions other types of net devs can have also
some kind of virtual devices with its ids. And it's naming only, I think
name is Ok, but can be changed.

>With
>your patches we have VLAN devices covered, but what about MACVLAN, bond,
>team or anything that needs to look at specific MAC addresses to be
>filtered to make management decisions?
That why actually this fix, if it's part of vlan addressing scheme,
bond/team/macvlan/whatever should be aware of such scheme. Particularly
if take bond, it still syncs its addresses with its parent devices
using same mc_sync and uc_sync APIs, that were changed to propagate all
vlan addresses farther (implemented in patch 1 and enabled in patch 2).

>
>Also imagine being able to store up to 4K MAC addresses for a total of
>4K VLANs, this would have occupied 4K * sizeof(some structure) and now
Yes it's additional addresses, but kernel holds separate address entries
for each device in the structure and no problems...updating not only
references. In this change, in best case, only end device contains
additional set of addresses for vlans, but pay attention, it holds also
references and sync information for each address with h/w (in normal
implementations using dev_mc/uc_sync), and allows to make updates only
if address added/removed.

In contrast to "memory wasting" approach.
Lets assume the ability to get vlan dev, not depending on the device
structure on top of it, is present. Then each end real device needs to
pass thru each vlan, compare each address, refcounters and so, to be
able to identify the vlans. Drawback: any change in vlan core / netdev
core can brake it. Assume I need to add it to several devices....,
frankly it looks not very portable, then I can try to create auxiliary
function and reuse it, but it looks not very.
For comparison on cpsw:

mc implementation using vlan device from the vlan_info list:
https://git.linaro.org/people/ivan.khoronzhuk/tsn_kernel.git/commit/?h=mcast_vlan&id=984782e8e2f8907593a4956e0922477307c73999

uc implementation using vlan device from the vlan_info list even bigger:
https://git.linaro.org/people/ivan.khoronzhuk/tsn_kernel.git/commit/?h=ucast_vlan_fix&id=ebc88a7d8758759322d9ff88f25f8bac51ce7219

Both, mc and uc implementations using proposed patchset is much simpler:
https://git.linaro.org/people/ivan.khoronzhuk/tsn_kernel.git/commit/?h=just_mc_uc_cpsw_vaddr_example&id=e9613ef0acafb6cb00db73b068fc0445ae737b5a


>it's 2 bytes bigger...
Not bigger, it still uses same reserved length - 32 bytes
(26 of each were not used).

>
>>
>> Based on net-next/master
>>
>> Ivan Khoronzhuk (5):
>>   net: core: dev_addr_lists: add VID to device address space
>>   net: 8021q: vlan_dev: add vid tag for uc and mc address lists
>>   net: 8021q: vlan_dev: add vid tag for vlan device mac address
>>   net: ethernet: add default vid len for all ehternet kind devices
>>   net: ethernet: ti: cpsw: update mc vlan and add uc vlan support based
>>     on addr vids
>>
>>  drivers/net/ethernet/ti/cpsw.c |  86 +++++++++++++++++++----
>>  include/linux/if_vlan.h        |   1 +
>>  include/linux/netdevice.h      |   7 ++
>>  net/8021q/vlan.c               |   3 +
>>  net/8021q/vlan_core.c          |  10 +++
>>  net/8021q/vlan_dev.c           | 103 ++++++++++++++++++++++-----
>>  net/core/dev_addr_lists.c      | 124 +++++++++++++++++++++++++++------
>>  net/ethernet/eth.c             |  15 +++-
>>  8 files changed, 290 insertions(+), 59 deletions(-)
>>
>
>
>-- 
>Florian

-- 
Regards,
Ivan Khoronzhuk
