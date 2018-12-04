From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: Re: [RFC PATCH net-next 2/5] net: 8021q: vlan_dev: add vid tag for
 uc and mc address lists
Date: Tue, 4 Dec 2018 03:32:08 +0200
Message-ID: <20181204013207.GH23230@khorivan>
References: <20181203184023.3430-1-ivan.khoronzhuk@linaro.org>
 <20181203184023.3430-3-ivan.khoronzhuk@linaro.org>
 <b2a7baa7-b334-0f6f-c119-a2f30ac68c7b@gmail.com>
 <20181203235119.GF23230@khorivan>
 <35479973-2d2d-d673-f7ab-54d6369ce3d1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <35479973-2d2d-d673-f7ab-54d6369ce3d1@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: davem@davemloft.net, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@mellanox.com, andrew@lunn.ch
List-Id: linux-omap@vger.kernel.org

On Mon, Dec 03, 2018 at 03:57:03PM -0800, Florian Fainelli wrote:
>On 12/3/18 3:51 PM, Ivan Khoronzhuk wrote:
>> On Mon, Dec 03, 2018 at 02:17:00PM -0800, Florian Fainelli wrote:
>>> On 12/3/18 10:40 AM, Ivan Khoronzhuk wrote:
>>>> Update vlan mc and uc addresses with VID tag while propagating address
>>>> set to lower devices, do this only if address is not synched. It allows
>>>> on end driver level to distinguish address belonging to vlans.
>>>
>>> Underlying driver for the real device would be able to properly identify
>>> that you are attempting to add an address to a virtual device, which
>>> happens to be of VLAN kind so I am really not sure this is the right
>>> approach here.
>>>
>>> From there, it seems to me that we have two situations:
>>>
>>> - each of your network devices expose VLAN devices directly on top of
>>> the real device, in which case your driver should support
>>> ndo_vlan_rx_add_vid and ndo_vlan_rx_kill_vid to know when VLAN devices
>>> are create and maintain a VLAN device to VID correspondence if it needs
>>> to when being called while setting the addresses
>>>
>>> - you are setting up a bridge that is VLAN aware on one of your bridge
>>> ports, and there you can use switchdev to learn about such events and
>>> know about both addresses as well as VIDs that must be programmed into
>>> your real device
>> No limits to have any "middle" device between real end device and
>> virtual one, not only a bridge, but also other kind. And as it's generic
>> change, it should cover all such cases, the simplest example is:
>> real_dev/macvlan/vlan.
>
>It is not generic if the additional information is a VLAN ID, that
>construct does not apply to all types of virtual devices, that is part
>of my issue with the extra VID that is being added. If this was a void *
>priv and any virtual device could pass up/down information that might be
>more acceptable.
I tractate it as virtual identification not relating it to vlans only.
VID just uses for eth devices part of already reserved address.
I was also thinking about passing smth like pointer on vlan device,
frankly even don't remember what stopped me, probably size of pointer or
so, maybe it looked harder... but it still seems possible and at least for
ethernet address is enough space: 32 - 6 = 26, 26 > 8.

Despite it only combines methods with extended address space and passing
link to vlan device, it adds ability to apply allmulti and promisc modes
per vlans.


>
>>
>>>
>>> It seems to me that what you need may be something like either:
>>>
>>> - notifications on slave devices when addresses are added via
>>> ndo_set_rxmode()
>>>
>>> or
>>>
>>> - dev_{uc,mc}_sync() should be augmented with a "source net_device"
>>> argument which allows you to differentiate which network device is the
>>> source of the address programming. That way, no need to "hash" the MAC
>>> address with a VID, any network device specific information can be
>>> provided and in the real device driver you can do: if
>>> (netif_is_vlan()... etc.)
>> No issue to retrieve vlan dev if it's directly on top of real dev.
>> Issue is to get it when it's not directly connected as it's not in
>> vlan_info group list. Who knows what else can be "structed" on top of
>> real dev till the vlan device. Please look on reply for cover letter,
>> as it seems requires similar response.
>
>In that case, there are notifications generated that you must be
>listening to determine whether you have something like a VLAN device on
>top of a bond, which is a port member of a bridge, on which one of your
>real device port is enslaved (yes, it can be that type of stacking).

It becomes even harder, traversing all structure of devices, seems not very
simple task.

>
>>
>>>
>>> Hopefully someone else will chime in.
>>>
>>>>
>>>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>>>> ---
>>>>  include/linux/if_vlan.h |  1 +
>>>>  net/8021q/vlan_core.c   | 10 ++++++++++
>>>>  net/8021q/vlan_dev.c    | 26 ++++++++++++++++++++++++++
>>>>  3 files changed, 37 insertions(+)
>>>>
>>>> diff --git a/include/linux/if_vlan.h b/include/linux/if_vlan.h
>>>> index 4cca4da7a6de..94657f3c483a 100644
>>>> --- a/include/linux/if_vlan.h
>>>> +++ b/include/linux/if_vlan.h
>>>> @@ -136,6 +136,7 @@ extern struct net_device
>>>> *__vlan_find_dev_deep_rcu(struct net_device *real_dev,
>>>>  extern int vlan_for_each(struct net_device *dev,
>>>>               int (*action)(struct net_device *dev, int vid,
>>>>                         void *arg), void *arg);
>>>> +extern u16 vlan_dev_get_addr_vid(struct net_device *dev, const u8
>>>> *addr);
>>>>  extern struct net_device *vlan_dev_real_dev(const struct net_device
>>>> *dev);
>>>>  extern u16 vlan_dev_vlan_id(const struct net_device *dev);
>>>>  extern __be16 vlan_dev_vlan_proto(const struct net_device *dev);
>>>> diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
>>>> index a313165e7a67..5d17947d6988 100644
>>>> --- a/net/8021q/vlan_core.c
>>>> +++ b/net/8021q/vlan_core.c
>>>> @@ -454,6 +454,16 @@ bool vlan_uses_dev(const struct net_device *dev)
>>>>  }
>>>>  EXPORT_SYMBOL(vlan_uses_dev);
>>>>
>>>> +u16 vlan_dev_get_addr_vid(struct net_device *dev, const u8 *addr)
>>>> +{
>>>> +    u16 vid = 0;
>>>> +
>>>> +    vid = addr[dev->addr_len];
>>>> +    vid |= (addr[dev->addr_len + 1] & 0xf) << 8;
>>>> +    return vid;
>>>> +}
>>>> +EXPORT_SYMBOL(vlan_dev_get_addr_vid);
>>>> +
>>>>  static struct sk_buff *vlan_gro_receive(struct list_head *head,
>>>>                      struct sk_buff *skb)
>>>>  {
>>>> diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
>>>> index b2d9c8f27cd7..c05b313314b7 100644
>>>> --- a/net/8021q/vlan_dev.c
>>>> +++ b/net/8021q/vlan_dev.c
>>>> @@ -250,6 +250,14 @@ void vlan_dev_get_realdev_name(const struct
>>>> net_device *dev, char *result)
>>>>      strncpy(result, vlan_dev_priv(dev)->real_dev->name, 23);
>>>>  }
>>>>
>>>> +static void vlan_dev_set_addr_vid(struct net_device *vlan_dev, u8
>>>> *addr)
>>>> +{
>>>> +    u16 vid = vlan_dev_vlan_id(vlan_dev);
>>>> +
>>>> +    addr[vlan_dev->addr_len] = vid & 0xff;
>>>> +    addr[vlan_dev->addr_len + 1] = (vid >> 8) & 0xf;
>>>> +}
>>>> +
>>>>  bool vlan_dev_inherit_address(struct net_device *dev,
>>>>                    struct net_device *real_dev)
>>>>  {
>>>> @@ -481,8 +489,26 @@ static void vlan_dev_change_rx_flags(struct
>>>> net_device *dev, int change)
>>>>      }
>>>>  }
>>>>
>>>> +static void vlan_dev_align_addr_vid(struct net_device *vlan_dev)
>>>> +{
>>>> +    struct net_device *real_dev = vlan_dev_real_dev(vlan_dev);
>>>> +    struct netdev_hw_addr *ha;
>>>> +
>>>> +    if (!real_dev->vid_len)
>>>> +        return;
>>>> +
>>>> +    netdev_for_each_mc_addr(ha, vlan_dev)
>>>> +        if (!ha->sync_cnt)
>>>> +            vlan_dev_set_addr_vid(vlan_dev, ha->addr);
>>>> +
>>>> +    netdev_for_each_uc_addr(ha, vlan_dev)
>>>> +        if (!ha->sync_cnt)
>>>> +            vlan_dev_set_addr_vid(vlan_dev, ha->addr);
>>>> +}
>>>> +
>>>>  static void vlan_dev_set_rx_mode(struct net_device *vlan_dev)
>>>>  {
>>>> +    vlan_dev_align_addr_vid(vlan_dev);
>>>>      dev_mc_sync(vlan_dev_priv(vlan_dev)->real_dev, vlan_dev);
>>>>      dev_uc_sync(vlan_dev_priv(vlan_dev)->real_dev, vlan_dev);
>>>>  }
>>>>
>>>
>>>
>>> -- 
>>> Florian
>>
>
>
>-- 
>Florian

-- 
Regards,
Ivan Khoronzhuk
