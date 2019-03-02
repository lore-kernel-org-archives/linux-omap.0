From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH net-next 3/6] net: 8021q: vlan_dev: add vid tag for vlan
 device own address
Date: Fri, 1 Mar 2019 19:24:57 -0800
Message-ID: <b31925a9-4510-1e04-d2d9-714163fff296@gmail.com>
References: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
 <20190226184556.16082-4-ivan.khoronzhuk@linaro.org>
 <ec699573-87b3-76d2-6faa-3c23f32d7095@gmail.com>
 <20190301122815.GC4851@khorivan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190301122815.GC4851@khorivan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: davem@davemloft.net, grygorii.strashko@ti.com, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@mellanox.com, ilias.apalodimas@linaro.org
List-Id: linux-omap@vger.kernel.org



On 3/1/2019 4:28 AM, Ivan Khoronzhuk wrote:
> On Wed, Feb 27, 2019 at 08:13:34PM -0800, Florian Fainelli wrote:
>>
>>
>> On 2/26/2019 10:45 AM, Ivan Khoronzhuk wrote:
>>> The vlan device address is held separately from uc/mc lists and
>>> handled differently. The vlan dev address is bound with real device
>>> address only if it's inherited from init, in all other cases it's
>>> separate address entry in uc list. With vid set, the address becomes
>>> not inherited from real device after it's set manually as before, but
>>> is part of uc list any way, with appropriate vid tag set. If vid_len
>>> for real device is 0, the behaviour is the same as before this change,
>>> so shouldn't be any impact on systems w/o individual virtual device
>>> filtering (IVDF) enabled. This allows to control and sync vlan device
>>> address and disable concrete vlan packet income when vlan interface is
>>> down.
>>>
>>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>>> ---
>>
>> [snip]
>>
>>>
>>> +static int vlan_dev_add_addr(struct net_device *dev, u8 *addr)
>>> +{
>>> +    struct net_device *real_dev = vlan_dev_real_dev(dev);
>>> +    unsigned char naddr[ETH_ALEN + NET_8021Q_VID_TSIZE];
>>> +
>>> +    if (real_dev->vid_len) {
>>
>> Don't you need to check that real_dev->vid_len is >= NET_8021Q_VID_TSIZE
>> here?
> 
> vid_len for all eth devices or 0 or NET_8021Q_VID_TSIZE and used here
> only as
> a flag that different addressing scheme is used.
> vlan_dev_set_addr_vid() do copy only < NET_8021Q_VID_TSIZE anyway.
> 
> Can add the following to be sure:
> if (real_dev->vid_len) {
>     if (real_dev->vid_len != NET_8021Q_VID_TSIZE)
>         return -1;
>     ....
> }
> 
> But frankly, if this happens the system is ill and this check can't help
> it.

Fair enough. All of your responses below make sense to me, thanks!
-- 
Florian
