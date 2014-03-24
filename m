From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net: micrel : ks8851-ml: add vdd-supply support
Date: Mon, 24 Mar 2014 00:37:58 -0400 (EDT)
Message-ID: <20140324.003758.1244022408748408267.davem@davemloft.net>
References: <1395384768-8461-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1395384768-8461-1-git-send-email-nm@ti.com>
Sender: netdev-owner@vger.kernel.org
To: nm@ti.com
Cc: rmk+kernel@arm.linux.org.uk, mpa@pengutronix.de, tony@atomide.com, devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Nishanth Menon <nm@ti.com>
Date: Fri, 21 Mar 2014 01:52:48 -0500

> Few platforms use external regulator to keep the ethernet MAC supplied.
> So, request and enable the regulator for driver functionality.
> 
> Fixes: 66fda75f47dc (regulator: core: Replace direct ops->disable usage)
> Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Suggested-by: Markus Pargmann <mpa@pengutronix.de>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Applied, thanks.
