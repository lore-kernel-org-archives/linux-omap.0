From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2] net: ethernet: ti: cpsw: fix extra rx interrupt
Date: Sat, 07 Dec 2019 11:57:12 -0800 (PST)
Message-ID: <20191207.115712.355931673337702807.davem@davemloft.net>
References: <20191206122820.24811-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191206122820.24811-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@ti.com
Cc: netdev@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Fri, 6 Dec 2019 14:28:20 +0200

> Now RX interrupt is triggered twice every time, because in
> cpsw_rx_interrupt() it is asked first and then disabled. So there will be
> pending interrupt always, when RX interrupt is enabled again in NAPI
> handler.
> 
> Fix it by first disabling IRQ and then do ask.
> 
> Fixes: 870915feabdc ("drivers: net: cpsw: remove disable_irq/enable_irq as irq can be masked from cpsw itself")
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Applied and queued up for -stable.
