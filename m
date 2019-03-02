From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH net-next 4/6] ethernet: eth: add default vid len for all
 ehternet kind devices
Date: Fri, 1 Mar 2019 19:33:26 -0800
Message-ID: <2f3bd59c-0662-7f8c-de22-28fd6a81067a@gmail.com>
References: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
 <20190226184556.16082-5-ivan.khoronzhuk@linaro.org>
 <30890ef3-7da8-8399-7388-cc22e000a67f@gmail.com>
 <20190301131153.GD4851@khorivan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190301131153.GD4851@khorivan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: davem@davemloft.net, grygorii.strashko@ti.com, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@mellanox.com, ilias.apalodimas@linaro.org
List-Id: linux-omap@vger.kernel.org



On 3/1/2019 5:11 AM, Ivan Khoronzhuk wrote:
> On Wed, Feb 27, 2019 at 08:29:20PM -0800, Florian Fainelli wrote:
>>
>>
>> On 2/26/2019 10:45 AM, Ivan Khoronzhuk wrote:
>>> IVDF - individual virtual device filtering. Allows to set per vlan
>>> l2 address filters on end real network device (for unicast and for
>>> multicast) and drop redundant not expected packet income.
>>>
>>> If CONFIG_VLAN_8021Q_IVDF is enabled the following changes are
>>> applied, and only for ethernet network devices.
>>>
>>> By default every ethernet netdev needs vid len = 2 bytes to be able to
>>> hold up to 4096 vids. So set it for every eth device to be correct,
>>> except vlan devs.
>>>
>>> In order to shrink all addresses of devices above vlan, the vid_len
>>> for vlan dev = 0, as result all suckers sync their addresses to common
>>> base not taking in to account vid part (vid_len of "to" devices is
>>> important only). And only vlan device is the source of addresses with
>>> actual its vid set, propagating it to parent devices while rx_mode().
>>>
>>> Also, don't bother those ethernet devices that at this moment are not
>>> moved to vlan addressing scheme, so while end ethernet device is
>>> created - set vid_len to 0, thus, while syncing, its address space is
>>> concatenated to one dimensional like usual, and who needs IVDF - set
>>> it to NET_8021Q_VID_TSIZE.
>>>
>>> There is another decision - is to inherit vid_len or some feature flag
>>> from end root device in order to all upper devices have vlan extended
>>> address space only if exact end real device have such capability. But
>>> I didn't, because it requires more changes and probably I'm not
>>> familiar with all places where it should be inherited, I would
>>> appreciate if someone can guid where it's applicable, then it could
>>> become a little bit more limited.
>>
>> I would think that a call to vlan_dev_ivdf_set() would be enough to
>> indicate that the underlying network device driver supports IVDF and
>> wants to make use of it. The infrastructure itself that you added costs
>> little memory, it is once the call to vlan_dev_ivdf_set() is made that
>> the memory consumption increases which is fine, since we want to make
>> use of that feature.
>>
>> While I appreciate the thoughts given to making this a configurable
>> option, I feel that enabling it unconditionally and having the
>> underlying driver decide would be more manageable.
> 
> Not exactly. Even system has no driver calling vlan_dev_ivdf_set()
> I still has this "mem consumption" from the very beginning. That's why I
> made
> this depended on the driver and CONF. For embedded world it looks fine.
> 
> The issues is that I can't change addressing scheme dynamically since some
> drivers and infrastructure that exists before I called vlan_dev_ivdf_set()
> can already have some synced addresses using old scheme. To do this
> dynamically it needs unsync vlans from old scheme and make sync again.
> Probably that is topic to "sync" :-| about....

Good one, that would be very complicated indeed.

> 
> I considered idea making "above infrastructure" IVDF to be dependent on
> underneath end device IVDF and remove this config at all, but here several
> issues with this, the infrastructure has to be "resynced" and some
> signal has
> to inform each vlan to do this, and while this happens, all end devices
> already
> configured and not supported IVDF shouldn't suffer. I can try but it
> looks not
> doable in normal way, and appreciate any thoughts about this.
> 
> Meanwhile, this option looks fine for small embedded paltforms.
> 
>>
>> We have had that conversation before, but let me ask again when we call
>> dev_{uc,mc}_sync() and ultimately the network device's
>> ndo_set_rx_mode(), by the time the ndo_set_rx_mode() function is called,
>> we lost track of the call chain, like which virtual device was it
>> originating from. If we somehow added a notification information about
>> the network device stack (and we could use netdevice notifiers for
>> that), then maybe we don't really need to add all of this code and we
>> can just derive the necessary bits of information we want by checking:
>> is this a VLAN network device? It is, okay what's your VLAN ID, etc.?
>>
>> Either approach would get us our cookie anyway :)
> 
> Postulate here is that address of vlan device is separate from netdevice
> entity
> with it's own context.
> 
> Several cases talking about this:
> 
> - bound device having 2 slaves can have added vid to both slave devices but
> synced addresses for only one of them. So, if vid is set in real device
> it doesn't mean it needs addresses of vlan device.
> 
> - I know that's crazy, but net device tree can contain 2 same vlan
> devices ).
> The scheme doesn't prevent this case. So one vid address can be counted
> by two
> vlan network devices.
> 
> - Any of the devices in _sync/rx_mode() chain is legal to do with addresses
> what ever it's allowed to do, drop some of them, combine with others and
> more,
> even add it's own vid addresses w/o actual vlan network device.
> 
> These made me to look in side of building rx_sync netdevice tree holding
> links
> on nodes per each address. And I've did this mostly...then after short look
> on this asked myself "who is going to support this ..." and it anyway
> doesn't
> cover all possible cases.
> 
> So, lost track of the device looks not so bad and opens more possibilities.

Sounds like you did give a lot of thoughts about the scheme, I am fine
with the current approach and will hook it up to DSA next week to make
sure this resolves the current issues I had with VLAN filtering enabled.
Thanks Ivan!
-- 
Florian
