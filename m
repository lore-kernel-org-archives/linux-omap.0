From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: Re: [PATCH net-next 3/6] net: 8021q: vlan_dev: add vid tag for vlan
 device own address
Date: Fri, 1 Mar 2019 14:28:16 +0200
Message-ID: <20190301122815.GC4851@khorivan>
References: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
 <20190226184556.16082-4-ivan.khoronzhuk@linaro.org>
 <ec699573-87b3-76d2-6faa-3c23f32d7095@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ec699573-87b3-76d2-6faa-3c23f32d7095@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: davem@davemloft.net, grygorii.strashko@ti.com, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@mellanox.com, ilias.apalodimas@linaro.org
List-Id: linux-omap@vger.kernel.org

On Wed, Feb 27, 2019 at 08:13:34PM -0800, Florian Fainelli wrote:
>
>
>On 2/26/2019 10:45 AM, Ivan Khoronzhuk wrote:
>> The vlan device address is held separately from uc/mc lists and
>> handled differently. The vlan dev address is bound with real device
>> address only if it's inherited from init, in all other cases it's
>> separate address entry in uc list. With vid set, the address becomes
>> not inherited from real device after it's set manually as before, but
>> is part of uc list any way, with appropriate vid tag set. If vid_len
>> for real device is 0, the behaviour is the same as before this change,
>> so shouldn't be any impact on systems w/o individual virtual device
>> filtering (IVDF) enabled. This allows to control and sync vlan device
>> address and disable concrete vlan packet income when vlan interface is
>> down.
>>
>> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>> ---
>
>[snip]
>
>>
>> +static int vlan_dev_add_addr(struct net_device *dev, u8 *addr)
>> +{
>> +	struct net_device *real_dev = vlan_dev_real_dev(dev);
>> +	unsigned char naddr[ETH_ALEN + NET_8021Q_VID_TSIZE];
>> +
>> +	if (real_dev->vid_len) {
>
>Don't you need to check that real_dev->vid_len is >= NET_8021Q_VID_TSIZE
>here?

vid_len for all eth devices or 0 or NET_8021Q_VID_TSIZE and used here only as
a flag that different addressing scheme is used.
vlan_dev_set_addr_vid() do copy only < NET_8021Q_VID_TSIZE anyway.

Can add the following to be sure:
if (real_dev->vid_len) {
	if (real_dev->vid_len != NET_8021Q_VID_TSIZE)
		return -1;
	....
}

But frankly, if this happens the system is ill and this check can't help it.


>
>> +		memcpy(naddr, addr, dev->addr_len);
>> +		vlan_dev_set_addr_vid(dev, naddr);
>> +		return dev_vid_uc_add(real_dev, naddr);
>> +	}
>> +
>> +	if (ether_addr_equal(addr, real_dev->dev_addr))
>> +		return 0;
>> +
>> +	return dev_uc_add(real_dev, addr);
>> +}
>> +
>> +static void vlan_dev_del_addr(struct net_device *dev, u8 *addr)
>> +{
>> +	struct net_device *real_dev = vlan_dev_real_dev(dev);
>> +	unsigned char naddr[ETH_ALEN + NET_8021Q_VID_TSIZE];
>> +
>> +	if (real_dev->vid_len) {
>
>Same here.

Not same, it's void routine.
And del can't happen w/o add, no reason.

>
>> +		memcpy(naddr, addr, dev->addr_len);
>> +		vlan_dev_set_addr_vid(dev, naddr);
>> +		dev_vid_uc_del(real_dev, naddr);
>> +		return;
>> +	}
>> +
>> +	if (!ether_addr_equal(dev->dev_addr, real_dev->dev_addr))
>> +		dev_uc_del(real_dev, addr);
>> +}
>> +
>> +static int vlan_dev_subs_addr(struct net_device *dev, u8 *addr)
>> +{
>> +	int err;
>> +
>> +	err = vlan_dev_add_addr(dev, addr);
>> +	if (err < 0)
>> +		return err;
>> +
>> +	vlan_dev_del_addr(dev, dev->dev_addr);
>> +	return err;
>> +}
>> +
>>  bool vlan_dev_inherit_address(struct net_device *dev,
>>  			      struct net_device *real_dev)
>>  {
>>  	if (dev->addr_assign_type != NET_ADDR_STOLEN)
>>  		return false;
>>
>> +	if (real_dev->vid_len)
>> +		if (vlan_dev_subs_addr(dev, real_dev->dev_addr))
>> +			return false;
>
>The check on real_dev->vid_len can be absorbed into vlan_dev_subs_addr()?

No, I'd tried. vlan_dev_subs_addr() is used not only here and move it under
makes more not combined code.

>
>> +
>>  	ether_addr_copy(dev->dev_addr, real_dev->dev_addr);
>>  	call_netdevice_notifiers(NETDEV_CHANGEADDR, dev);
>>  	return true;
>> @@ -278,9 +327,10 @@ static int vlan_dev_open(struct net_device *dev)
>>  	    !(vlan->flags & VLAN_FLAG_LOOSE_BINDING))
>>  		return -ENETDOWN;
>>
>> -	if (!ether_addr_equal(dev->dev_addr, real_dev->dev_addr) &&
>> -	    !vlan_dev_inherit_address(dev, real_dev)) {
>> -		err = dev_uc_add(real_dev, dev->dev_addr);
>> +	if (ether_addr_equal(dev->dev_addr, real_dev->dev_addr) ||
>> +	    (!ether_addr_equal(dev->dev_addr, real_dev->dev_addr) &&
>> +	     !vlan_dev_inherit_address(dev, real_dev))) {
>
>Should this condition simply become if !vlan_dev_inherit_address() now?

It can't, I'd tried.
vlan_dev_inherit_address() is used in (vlan.c):
vlan_sync_address(struct net_device *dev, struct net_device *vlandev);

-- 
Regards,
Ivan Khoronzhuk
