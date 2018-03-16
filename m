From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: enable vlan rx vlan
 offload
Date: Fri, 16 Mar 2018 13:54:35 -0500
Message-ID: <00940f18-3426-4aa4-2fe2-cd2efbe7647f@ti.com>
References: <20180315201550.21487-1-grygorii.strashko@ti.com>
 <20180316002935.GB13119@lunn.ch>
 <20180316.143739.424933240477251284.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180316.143739.424933240477251284.davem@davemloft.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>, andrew@lunn.ch
Cc: netdev@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 03/16/2018 01:37 PM, David Miller wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> Date: Fri, 16 Mar 2018 01:29:35 +0100
> 
>> On Thu, Mar 15, 2018 at 03:15:50PM -0500, Grygorii Strashko wrote:
>>> In VLAN_AWARE mode CPSW can insert VLAN header encapsulation word on Host
>>> port 0 egress (RX) before the packet data if RX_VLAN_ENCAP bit is set in
>>> CPSW_CONTROL register. VLAN header encapsulation word has following format:
>>>
>>>   HDR_PKT_Priority bits 29-31 - Header Packet VLAN prio (Highest prio: 7)
>>>   HDR_PKT_CFI 	  bits 28 - Header Packet VLAN CFI bit.
>>>   HDR_PKT_Vid 	  bits 27-16 - Header Packet VLAN ID
>>>   PKT_Type         bits 8-9 - Packet Type. Indicates whether the packet is
>>>                   	VLAN-tagged, priority-tagged, or non-tagged.
>>> 	00: VLAN-tagged packet
>>> 	01: Reserved
>>> 	10: Priority-tagged packet
>>> 	11: Non-tagged packet
>>>
>>> This feature can be used to implement TX VLAN offload in case of
>>> VLAN-tagged packets and to insert VLAN tag in case Non-tagged packet was
>>> received on port with PVID set. As per documentation, CPSW never modifies
>>> packet data on Host egress (RX) and as result, without this feature
>>> enabled, Host port will not be able to receive properly packets which
>>> entered switch non-tagged through external Port with PVID set (when
>>> non-tagged packet forwarded from external Port with PVID set to another
>>> external Port - packet will be VLAN tagged properly).
>>
>> So, i think it is time to discuss the future of this driver. It should
>> really be replaced by a switchdev/DSA driver. There are plenty of
>> carrots for a new driver: Better statistics, working ethtool support
>> for all the PHYs, better user experience, etc. But maybe now it is
>> time for the stick. Should we Maintainers decide that no new features
>> should be added to the existing drivers, just bug fixes?
> 
> Andrew, I totally share your concerns.
> 
> However, I think the reality is that at best we can strongly urge
> people to do such a large amount of work such as writing a new
> switchdev/DSA driver for this cpsw hardware.
> 
> We can't really compel them.
> 
> And a stick could have the opposite of it's intended effect.  If still
> nobody wants to do the switchdev/DSA driver, then this existing one
> rots and even worse we can end up with an out-of-tree version of this
> driver that has the changes (such as this one) that people want.

Yeh :( This one was created to satisfy real customer use case.
So we'll have to carry it internally any way, but having it in LKML will 
allow to involve broader number of people in review, testing and fixing.
And the same code will have to be part of dsa switch driver also - it 
will be just more stable at time of migration to dsa.

> 
> I'd like to see the switchdev/DSA driver for cpsw as much as you do,
> but I am not convinced that rejecting patches like this one will
> necessarily make that happen.

+1. Hope this work will be started as soon as possible.

-- 
regards,
-grygorii
