From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net: ethernet: ti: cpsw: fix min eth packet size
Date: Thu, 16 Nov 2017 10:50:34 +0900 (KST)
Message-ID: <20171116.105034.2075526380204547211.davem@davemloft.net>
References: <20171115154635.26642-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171115154635.26642-1-grygorii.strashko@ti.com>
Sender: netdev-owner@vger.kernel.org
To: grygorii.strashko@ti.com
Cc: netdev@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Wed, 15 Nov 2017 09:46:35 -0600

> Now CPSW driver configures min eth packet size to 60 octets (ETH_ZLEN)
> which works in most of cases, but when port VLAN is configured on some
> switch port, it also can be configured to force all egress packets to be
> VLAN untagged. And in this case, CPSW driver will pad small packets to 60
> octets, but final packet size on port egress can became less than 60 octets
> due to VLAN tag removal and packet will be dropped.
> 
> Hence, fix it by accounting VLAN header in CPSW min eth packet size. While
> here, use proper defines for CPSW_MAX_PACKET_SIZE also, instead of open
> coding.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Applied.
