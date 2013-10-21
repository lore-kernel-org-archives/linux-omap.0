From: David Miller <davem@davemloft.net>
Subject: Re: [net PATCH 1/1] drivers: net: cpsw: fix kernel warn during
 iperf test with interrupt pacing
Date: Mon, 21 Oct 2013 17:23:29 -0400 (EDT)
Message-ID: <20131021.172329.1796326636104085244.davem@davemloft.net>
References: <1382252546-16382-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1382252546-16382-1-git-send-email-mugunthanvnm@ti.com>
Sender: netdev-owner@vger.kernel.org
To: mugunthanvnm@ti.com
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org, bigeasy@linutronix.de
List-Id: linux-omap@vger.kernel.org

From: Mugunthan V N <mugunthanvnm@ti.com>
Date: Sun, 20 Oct 2013 12:32:26 +0530

> When interrupt pacing is enabled, receive/transmit statistics are not
> updated properly by hardware which leads to ISR return with IRQ_NONE
> and inturn kernel disables the interrupt. This patch removed the checking
> of receive/transmit statistics from ISR.
> 
> This patch is verified with AM335x Beagle Bone Black and below is the
> kernel warn when interrupt pacing is enabled.
...
> Cc: Sebastian Siewior <bigeasy@linutronix.de>
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>

Applied, thanks.
