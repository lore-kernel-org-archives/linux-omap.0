From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/2] net: ethernet: davinci_emac: use
 phy_ethtool_{get|set}_link_ksettings
Date: Sat, 02 Jul 2016 14:51:41 -0400 (EDT)
Message-ID: <20160702.145141.372304368206325956.davem@davemloft.net>
References: <1467410555-19514-1-git-send-email-tremyfr@gmail.com>
	<1467410555-19514-2-git-send-email-tremyfr@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1467410555-19514-2-git-send-email-tremyfr@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: tremyfr@gmail.com
Cc: mugunthanvnm@ti.com, grygorii.strashko@ti.com, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Philippe Reynes <tremyfr@gmail.com>
Date: Sat,  2 Jul 2016 00:02:35 +0200

> There are two generics functions phy_ethtool_{get|set}_link_ksettings,
> so we can use them instead of defining the same code in the driver.
> 
> Signed-off-by: Philippe Reynes <tremyfr@gmail.com>

Applied.
