From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v3 net-next] net: ethernet: ti: cpsw: Fix inconsistent
 IS_ERR and PTR_ERR in cpsw_probe()
Date: Wed, 01 May 2019 14:29:48 -0400 (EDT)
Message-ID: <20190501.142948.1053446771181544161.davem@davemloft.net>
References: <20190429143157.79035-1-yuehaibing@huawei.com>
        <20190430015524.50997-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190430015524.50997-1-yuehaibing@huawei.com>
Sender: netdev-owner@vger.kernel.org
To: yuehaibing@huawei.com
Cc: grygorii.strashko@ti.com, ivan.khoronzhuk@linaro.org, andrew@lunn.ch, ilias.apalodimas@linaro.org, julia.lawall@lip6.fr, linux-omap@vger.kernel.org, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 30 Apr 2019 01:55:24 +0000

> Fix inconsistent IS_ERR and PTR_ERR in cpsw_probe,
> The proper pointer to use is clk instead of mode.
> 
> This issue was detected with the help of Coccinelle.
> 
> Fixes: 83a8471ba255 ("net: ethernet: ti: cpsw: refactor probe to group common hw initialization")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
> v3: Fix commit log
> v2: add Fixes tag

Applied.
