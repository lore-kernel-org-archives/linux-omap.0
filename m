From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: enable vlan rx vlan
 offload
Date: Fri, 16 Mar 2018 14:37:39 -0400 (EDT)
Message-ID: <20180316.143739.424933240477251284.davem@davemloft.net>
References: <20180315201550.21487-1-grygorii.strashko@ti.com>
        <20180316002935.GB13119@lunn.ch>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180316002935.GB13119@lunn.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: andrew@lunn.ch
Cc: grygorii.strashko@ti.com, netdev@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>
Date: Fri, 16 Mar 2018 01:29:35 +0100

> On Thu, Mar 15, 2018 at 03:15:50PM -0500, Grygorii Strashko wrote:
>> In VLAN_AWARE mode CPSW can insert VLAN header encapsulation word on Host
>> port 0 egress (RX) before the packet data if RX_VLAN_ENCAP bit is set in
>> CPSW_CONTROL register. VLAN header encapsulation word has following format:
>> 
>>  HDR_PKT_Priority bits 29-31 - Header Packet VLAN prio (Highest prio: 7)
>>  HDR_PKT_CFI 	  bits 28 - Header Packet VLAN CFI bit.
>>  HDR_PKT_Vid 	  bits 27-16 - Header Packet VLAN ID
>>  PKT_Type         bits 8-9 - Packet Type. Indicates whether the packet is
>>                  	VLAN-tagged, priority-tagged, or non-tagged.
>> 	00: VLAN-tagged packet
>> 	01: Reserved
>> 	10: Priority-tagged packet
>> 	11: Non-tagged packet
>> 
>> This feature can be used to implement TX VLAN offload in case of
>> VLAN-tagged packets and to insert VLAN tag in case Non-tagged packet was
>> received on port with PVID set. As per documentation, CPSW never modifies
>> packet data on Host egress (RX) and as result, without this feature
>> enabled, Host port will not be able to receive properly packets which
>> entered switch non-tagged through external Port with PVID set (when
>> non-tagged packet forwarded from external Port with PVID set to another
>> external Port - packet will be VLAN tagged properly).
> 
> So, i think it is time to discuss the future of this driver. It should
> really be replaced by a switchdev/DSA driver. There are plenty of
> carrots for a new driver: Better statistics, working ethtool support
> for all the PHYs, better user experience, etc. But maybe now it is
> time for the stick. Should we Maintainers decide that no new features
> should be added to the existing drivers, just bug fixes?

Andrew, I totally share your concerns.

However, I think the reality is that at best we can strongly urge
people to do such a large amount of work such as writing a new
switchdev/DSA driver for this cpsw hardware.

We can't really compel them.

And a stick could have the opposite of it's intended effect.  If still
nobody wants to do the switchdev/DSA driver, then this existing one
rots and even worse we can end up with an out-of-tree version of this
driver that has the changes (such as this one) that people want.

I'd like to see the switchdev/DSA driver for cpsw as much as you do,
but I am not convinced that rejecting patches like this one will
necessarily make that happen.

Also, it would be a completely different situation if we had someone
working on the switchdev/DSA version already.

So as it stands I really don't think we can block this patch.

Thank you.
