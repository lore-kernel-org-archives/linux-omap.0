From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v3 next-next] drivers: net: davinci_mdio: prevent
 spurious timeout
Date: Thu, 10 May 2018 17:23:39 -0400 (EDT)
Message-ID: <20180510.172339.458302745153151907.davem@davemloft.net>
References: <20180509154515.5968-1-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180509154515.5968-1-nsekhar@ti.com>
Sender: netdev-owner@vger.kernel.org
To: nsekhar@ti.com
Cc: grygorii.strashko@ti.com, linux-omap@vger.kernel.org, netdev@vger.kernel.org, andrew@lunn.ch
List-Id: linux-omap@vger.kernel.org

From: Sekhar Nori <nsekhar@ti.com>
Date: Wed, 9 May 2018 21:15:15 +0530

> A well timed kernel preemption in the time_after() loop
> in wait_for_idle() can result in a spurious timeout
> error to be returned.
> 
> Fix it by using readl_poll_timeout() which takes care of
> this issue.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

Applied.
