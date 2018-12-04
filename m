From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [RFC PATCH net-next 2/5] net: 8021q: vlan_dev: add vid tag for uc
 and mc address lists
Date: Tue, 4 Dec 2018 11:49:27 -0800
Message-ID: <756cbb25-3062-91e8-0613-66bb887f937e@gmail.com>
References: <20181203184023.3430-1-ivan.khoronzhuk@linaro.org>
 <20181203184023.3430-3-ivan.khoronzhuk@linaro.org>
 <b2a7baa7-b334-0f6f-c119-a2f30ac68c7b@gmail.com>
 <20181203235119.GF23230@khorivan>
 <35479973-2d2d-d673-f7ab-54d6369ce3d1@gmail.com>
 <20181204185720.GI23230@khorivan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181204185720.GI23230@khorivan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: davem@davemloft.net, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@mellanox.com, andrew@lunn.ch
List-Id: linux-omap@vger.kernel.org

On 12/4/18 10:57 AM, Ivan Khoronzhuk wrote:
> On Mon, Dec 03, 2018 at 03:57:03PM -0800, Florian Fainelli wrote:
>> On 12/3/18 3:51 PM, Ivan Khoronzhuk wrote:
>>> On Mon, Dec 03, 2018 at 02:17:00PM -0800, Florian Fainelli wrote:
>>>> On 12/3/18 10:40 AM, Ivan Khoronzhuk wrote:
>>>>> Update vlan mc and uc addresses with VID tag while propagating address
>>>>> set to lower devices, do this only if address is not synched. It
>>>>> allows
>>>>> on end driver level to distinguish address belonging to vlans.
>>>>
>>>> Underlying driver for the real device would be able to properly
>>>> identify
>>>> that you are attempting to add an address to a virtual device, which
>>>> happens to be of VLAN kind so I am really not sure this is the right
>>>> approach here.
>>>>
>>>> From there, it seems to me that we have two situations:
>>>>
>>>> - each of your network devices expose VLAN devices directly on top of
>>>> the real device, in which case your driver should support
>>>> ndo_vlan_rx_add_vid and ndo_vlan_rx_kill_vid to know when VLAN devices
>>>> are create and maintain a VLAN device to VID correspondence if it needs
>>>> to when being called while setting the addresses
>>>>
>>>> - you are setting up a bridge that is VLAN aware on one of your bridge
>>>> ports, and there you can use switchdev to learn about such events and
>>>> know about both addresses as well as VIDs that must be programmed into
>>>> your real device
>>> No limits to have any "middle" device between real end device and
>>> virtual one, not only a bridge, but also other kind. And as it's generic
>>> change, it should cover all such cases, the simplest example is:
>>> real_dev/macvlan/vlan.
>>
>> It is not generic if the additional information is a VLAN ID, that
>> construct does not apply to all types of virtual devices, that is part
>> of my issue with the extra VID that is being added. If this was a void *
>> priv and any virtual device could pass up/down information that might be
>> more acceptable.
> 
> You mean to create smth like common struct pinned to "an address" and
> pass information not only like vid, but in parallel what ever user wanted.
> Even if pass vlan device pointer it still considered like an address
> continuation and same sync method is used w/o modification. And here vid
> is considered as part of address, by a big account address+vid it's a
> separate address, same happens with the pointer, address+pointer it's
> still separate address.

That depends on the HW implementation, some switches do individual VLAN
learning (IVL) and some do shared VLAN learning (SVL) so whether the VID
becomes part of the address resolution logic is HW dependent, obviously
the more capable, the better (IVL).

> 
> I was thinking also about pinned list of vlans to the address, but in
> this case this information also has to be synced by members of device
> chain,
> because it can be modified on any device level and it looks not very
> friendly,
> and at the end address space has addresses with pinned lists of vlans with
> their pointers. But keeping this stuff in sync is not simplest decision.
> 
> 

I really think we are not communicating properly, it really seems to me
that if you had the information about the upper device trying to add an
address to the lower device filter's either through notification or call
to ndo_set_rxmode, you could be solving your problems. What are we
missing here?
--
Florian
