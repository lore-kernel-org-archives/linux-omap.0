From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: enable vlan rx vlan
 offload
Date: Sat, 17 Mar 2018 19:51:43 -0400 (EDT)
Message-ID: <20180317.195143.836068598453066845.davem@davemloft.net>
References: <20180315201550.21487-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180315201550.21487-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@ti.com
Cc: netdev@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Thu, 15 Mar 2018 15:15:50 -0500

> In VLAN_AWARE mode CPSW can insert VLAN header encapsulation word on Host
> port 0 egress (RX) before the packet data if RX_VLAN_ENCAP bit is set in
> CPSW_CONTROL register. VLAN header encapsulation word has following format:
> 
>  HDR_PKT_Priority bits 29-31 - Header Packet VLAN prio (Highest prio: 7)
>  HDR_PKT_CFI 	  bits 28 - Header Packet VLAN CFI bit.
>  HDR_PKT_Vid 	  bits 27-16 - Header Packet VLAN ID
>  PKT_Type         bits 8-9 - Packet Type. Indicates whether the packet is
>                  	VLAN-tagged, priority-tagged, or non-tagged.
> 	00: VLAN-tagged packet
> 	01: Reserved
> 	10: Priority-tagged packet
> 	11: Non-tagged packet
> 
> This feature can be used to implement TX VLAN offload in case of
> VLAN-tagged packets and to insert VLAN tag in case Non-tagged packet was
> received on port with PVID set. As per documentation, CPSW never modifies
> packet data on Host egress (RX) and as result, without this feature
> enabled, Host port will not be able to receive properly packets which
> entered switch non-tagged through external Port with PVID set (when
> non-tagged packet forwarded from external Port with PVID set to another
> external Port - packet will be VLAN tagged properly).
> 
> Implementation details:
> - on RX driver will check CPDMA status bit RX_VLAN_ENCAP BIT(19) in CPPI
> descriptor to identify when VLAN header encapsulation word is present.
> - PKT_Type = 0x01 or 0x02 then ignore VLAN header encapsulation word and
> pass packet as is;
> - if HDR_PKT_Vid = 0 then ignore VLAN header encapsulation word and pass
> packet as is;
> - In dual mac mode traffic is separated between ports using default port
> vlans, which are not be visible to Host and so should not be reported.
> Hence, check for default port vlans in dual mac mode and ignore VLAN header
> encapsulation word;
> - otherwise fill SKB with VLAN info using __vlan_hwaccel_put_tag();
> - PKT_Type = 0x00 (VLAN-tagged) then strip out VLAN header from SKB.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Applied, thank you.
