From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net: ethernet: ti: cpsw: fix packet leaking in
 dual_mac mode
Date: Wed, 02 May 2018 11:08:41 -0400 (EDT)
Message-ID: <20180502.110841.378324128079268584.davem@davemloft.net>
References: <20180501174122.11323-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180501174122.11323-1-grygorii.strashko@ti.com>
Sender: netdev-owner@vger.kernel.org
To: grygorii.strashko@ti.com
Cc: netdev@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Tue, 1 May 2018 12:41:22 -0500

> In dual_mac mode packets arrived on one port should not be forwarded by
> switch hw to another port. Only Linux Host can forward packets between
> ports. The below test case (reported in [1]) shows that packet arrived on
> one port can be leaked to anoter (reproducible with dual port evms):
>  - connect port 1 (eth0) to linux Host 0 and run tcpdump or Wireshark
>  - connect port 2 (eth1) to linux Host 1 with vlan 1 configured
>  - ping <IPx> from Host 1 through vlan 1 interface.
> ARP packets will be seen on Host 0.
> 
> Issue happens because dual_mac mode is implemnted using two vlans: 1 (Port
> 1+Port 0) and 2 (Port 2+Port 0), so there are vlan records created for for
> each vlan. By default, the ALE will find valid vlan record in its table
> when vlan 1 tagged packet arrived on Port 2 and so forwards packet to all
> ports which are vlan 1 members (like Port.
> 
> To avoid such behaviorr the ALE VLAN ID Ingress Check need to be enabled
> for each external CPSW port (ALE_PORTCTLn.VID_INGRESS_CHECK) so ALE will
> drop ingress packets if Rx port is not VLAN member.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Applied and queued up for -stable, thank you.
