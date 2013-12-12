From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/2] drivers: net: cpsw: fix for cpsw crash when build
 as modules
Date: Thu, 12 Dec 2013 13:47:20 -0500 (EST)
Message-ID: <20131212.134720.844724034413976971.davem@davemloft.net>
References: <1386821345-30555-1-git-send-email-balbi@ti.com>
	<1386821345-30555-2-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1386821345-30555-2-git-send-email-balbi@ti.com>
Sender: netdev-owner@vger.kernel.org
To: balbi@ti.com
Cc: mugunthanvnm@ti.com, bigeasy@linutronix.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Felipe Balbi <balbi@ti.com>
Date: Wed, 11 Dec 2013 22:09:05 -0600

> From: Mugunthan V N <mugunthanvnm@ti.com>
> 
> When CPSW and Davinci MDIO are build as modules, CPSW crashes when
> accessing CPSW registers in CPSW probe. The same is working in built-in
> as the CPSW clocks are enabled in Davindi MDIO probe, SO Enabling the
> clocks before accessing the version register and moving out the other
> register access to cpsw device open.
> 
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>

Applied, thanks.
