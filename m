From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/1] net: cpsw: fix cpdma rx descriptor leak on down
 interface
Date: Mon, 03 Mar 2014 15:50:50 -0500 (EST)
Message-ID: <20140303.155050.1061715025396456537.davem@davemloft.net>
References: <1393843746-6554-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1393843746-6554-1-git-send-email-mugunthanvnm@ti.com>
Sender: netdev-owner@vger.kernel.org
To: mugunthanvnm@ti.com
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org, spatton@ti.com
List-Id: linux-omap@vger.kernel.org

From: Mugunthan V N <mugunthanvnm@ti.com>
Date: Mon, 3 Mar 2014 16:19:06 +0530

> From: Schuyler Patton <spatton@ti.com>
> 
> This patch fixes a CPDMA RX Descriptor leak that occurs after taking
> the interface down when the CPSW is in Dual MAC mode. Previously
> the CPSW_ALE port was left open up which causes packets to be received
> and processed by the RX interrupt handler and were passed to the
> non active network interface where they were ignored.
> 
> The fix is for the slave_stop function of the selected interface
> to disable the respective CPSW_ALE Port from forwarding packets. This
> blocks traffic from being received on the inactive interface.
> 
> Signed-off-by: Schuyler Patton <spatton@ti.com>
> Reviewed-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>

Applied.
