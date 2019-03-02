From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH net-next 2/6] net: 8021q: vlan_dev: add vid tag to
 addresses of uc and mc lists
Date: Fri, 1 Mar 2019 19:19:50 -0800
Message-ID: <3b3dcc51-39d9-0f23-ab5a-6d0375593c79@gmail.com>
References: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
 <20190226184556.16082-3-ivan.khoronzhuk@linaro.org>
 <72ecf925-f818-3d6b-4f96-b01daabd21f2@gmail.com>
 <20190301122417.GB4851@khorivan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190301122417.GB4851@khorivan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: davem@davemloft.net, grygorii.strashko@ti.com, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@mellanox.com, ilias.apalodimas@linaro.org
List-Id: linux-omap@vger.kernel.org



On 3/1/2019 4:24 AM, Ivan Khoronzhuk wrote:
> On Wed, Feb 27, 2019 at 08:09:44PM -0800, Florian Fainelli wrote:
>>
>>
>> On 2/26/2019 10:45 AM, Ivan Khoronzhuk wrote:
>>> Update vlan mc and uc addresses with VID tag while propagating
>>> addresses to lower devices, do this only if address is not synced.
>>> It allows at end driver level to distinguish addresses belonging
>>> to vlan devices.
>>>
>>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>>> ---
>>
>> [snip]
>>
>>>
>>> +u16 vlan_dev_get_addr_vid(struct net_device *dev, const u8 *addr)
>>
>> Having some kernel doc comment here would also be nice.
> 
> yes can be: vlan_dev_get_addr_vid - get vlan id the address belongs to
> 
> 
>>
>>> +{
>>> +    u16 vid = 0;
>>> +
>>> +    if (dev->vid_len != NET_8021Q_VID_TSIZE)
>>> +        return vid;
>>> +
>>> +    vid = addr[dev->addr_len];
>>> +    vid |= (addr[dev->addr_len + 1] & 0xf) << 8;
>>
>> This uses knowledge of the maximum VLAN ID is 4095, which is fine, might
>> be a good idea to add a check on VID not exceeding the maximum VLAN ID
>> number instead of doing a silent truncation?
> 
> and then return -1, not sure, just because it's 0 or directly set by vlan
> layer and is verified anyway. But no harm to verify even it looks like
> redundancy.

I would have thought that there would be an existing helper function to
put/get a VLAN identifier into/from two bytes but that is fine as-is.

> 
>>
>> [snip]
>>
>>> +static void vlan_dev_align_addr_vid(struct net_device *vlan_dev)
>>> +{
>>> +    struct net_device *real_dev = vlan_dev_real_dev(vlan_dev);
>>> +    struct netdev_hw_addr *ha;
>>> +
>>> +    if (!real_dev->vid_len)
>>> +        return;
>>
>> Should not this check be moved to dev_{mc,uc}_sync? It does not seem to
>> me like this would scale really well across different stacked devices
>> (VLAN, bond, macvlan) as well as underlying drivers (cpsw, dsa, etc.).
>> Or maybe the check should be if vlan_dev->vid_len > real_dev->vid_len ->
>> error, right?
> 
> It shouldn't be part of netdev addr module, no any
> vlan_dev_vlan_id(vlan_dev)
> should be there.
> 
> It's scaled becouse bond/team ...etc, are ethernet devices and have IVDF
> enabled while configuration. Address propagation always is from leafs to
> real root device, every underneeth device knows nothing about above, so
> check is only in one direction.
> 

OK, indeed stacked devices would lead to that, thanks for explaining!
-- 
Florian
