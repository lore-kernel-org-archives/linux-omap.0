From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] smsc95xx: Add module parameter to override MAC address
Date: Fri, 25 Jun 2010 10:25:20 +0900
Message-ID: <20100625012520.GA12650@verge.net.au>
References: <1277367254-9345-1-git-send-email-s-jan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1277367254-9345-1-git-send-email-s-jan@ti.com>
Sender: netdev-owner@vger.kernel.org
To: Sebastien Jan <s-jan@ti.com>
Cc: Steve Glendinning <steve.glendinning@smsc.com>, netdev@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 24, 2010 at 10:14:14AM +0200, Sebastien Jan wrote:
> Define a new module parameter 'macaddr' to override the MAC address
> fetched either from eeprom, or randomly generated.
> 
> The expected MAC address shall be in the 01:23:45:67:89:AB format.

I'm confused as to why this is desirable when the mac address
can already be configured after module insertion via
smsc95xx_netdev_ops.eth_mac_addr().

