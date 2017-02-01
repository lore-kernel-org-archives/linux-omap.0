From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net: ethernet: ti: cpsw: fix NULL pointer dereference
 in switch mode
Date: Wed, 01 Feb 2017 12:06:23 -0500 (EST)
Message-ID: <20170201.120623.1662011578093223998.davem@davemloft.net>
References: <20170131200404.29150-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170131200404.29150-1-grygorii.strashko@ti.com>
Sender: netdev-owner@vger.kernel.org
To: grygorii.strashko@ti.com
Cc: netdev@vger.kernel.org, ivan.khoronzhuk@linaro.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Tue, 31 Jan 2017 14:04:04 -0600

> In switch mode on struct cpsw_slave->ndev field will be initialized with
> proper value only for the one cpsw slave port, as result
> cpsw_get_usage_count() will generate "Unable to handle kernel NULL pointer
> dereference" exception when first ethernet interface is opening
> cpsw_ndo_open(). This issue causes boot regression on AM335x EVM and
> reproducible on am57xx-evm (switch mode).
> Fix it by adding additional check for !cpsw->slaves[i].ndev in
> cpsw_get_usage_count().
> 
> Cc: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> fixes: 03fd01ad0eea ("net: ethernet: ti: cpsw: don't duplicate ndev_running")

Please capitalize "Fixes: " in the future.

> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Applied, thanks.
