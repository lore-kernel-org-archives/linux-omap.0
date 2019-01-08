From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [RFC PATCH net-next 2/5] net: 8021q: vlan_dev: add vid tag for uc
 and mc address lists
Date: Mon, 7 Jan 2019 21:01:25 -0800
Message-ID: <1dd05b34-e275-d67c-df30-e3694d90e9cc@gmail.com>
References: <20181203184023.3430-1-ivan.khoronzhuk@linaro.org>
 <20181203184023.3430-3-ivan.khoronzhuk@linaro.org>
 <b2a7baa7-b334-0f6f-c119-a2f30ac68c7b@gmail.com>
 <20181203235119.GF23230@khorivan>
 <35479973-2d2d-d673-f7ab-54d6369ce3d1@gmail.com>
 <20181204185720.GI23230@khorivan>
 <756cbb25-3062-91e8-0613-66bb887f937e@gmail.com>
 <20181205000450.GB3507@khorivan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205000450.GB3507@khorivan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: davem@davemloft.net, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@mellanox.com, andrew@lunn.ch
List-Id: linux-omap@vger.kernel.org

Le 12/4/18 à 4:04 PM, Ivan Khoronzhuk a écrit :
> On Tue, Dec 04, 2018 at 11:49:27AM -0800, Florian Fainelli wrote:
> 
> ...
> 
>>>
>>> I was thinking also about pinned list of vlans to the address, but in
>>> this case this information also has to be synced by members of device
>>> chain,
>>> because it can be modified on any device level and it looks not very
>>> friendly,
>>> and at the end address space has addresses with pinned lists of vlans
>>> with
>>> their pointers. But keeping this stuff in sync is not simplest decision.
>>>
>>>
>>
>> I really think we are not communicating properly, it really seems to me
>> that if you had the information about the upper device trying to add an
>> address to the lower device filter's either through notification or call
>> to ndo_set_rxmode, you could be solving your problems. What are we
>> missing here?
> 
> Sry, missed this one. The problem in getting  the owner of address.
> Just simple case: vlan/macvlan/real_dev or vlan/.../.../real_dev
> 
> The real dev hasn't simple way to get vid the address belong to, or it has?

Humm looks like your right, by the time the address lists are
synchronized (e.g: from = vlan_dev, to = real_dev), we lost that
information. It looks like I just managed to find such an use case
myself with VLAN filtering enabled on a bridge (so switch is VLAN aware)
and a VLAN device created on the bridge (br0.42) but with IGMP snooping
turned off (so we don't get HOST_MDB notifications with correct VLAN ID).

Maybe keeping the "from" net_device within the address list that is
processed by ndo_set_rx_mode() will do the job though?

Then you can do things like:

if (is_vlan_dev(ha->dev) && ha->dev != dev)
	vid = vlan_dev_vlan_id(ha->dev);

and it should scale to any type of stacked device, regardless of VID or
something else that we need?

Can you remind me of your use case again? Is it because your switch has
VLAN filtering enabled and you need to make sure that MC addresses on
VLAN device get programmed into the switch's multicast database with
correct VID?
-- 
Florian
