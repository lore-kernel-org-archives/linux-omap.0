From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2] net: ethernet: ti: cpsw_ethtool: fix ethtool ring
 param set
Date: Mon, 03 Jun 2019 14:34:09 -0700 (PDT)
Message-ID: <20190603.143409.1580682037956010747.davem@davemloft.net>
References: <20190531134725.2054-1-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190531134725.2054-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ivan.khoronzhuk@linaro.org
Cc: grygorii.strashko@ti.com, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Date: Fri, 31 May 2019 16:47:25 +0300

> Fix ability to set RX descriptor number, the reason - initially
> "tx_max_pending" was set incorrectly, but the issue appears after
> adding sanity check, so fix is for "sanity" patch.
> 
> Fixes: 37e2d99b59c476 ("ethtool: Ensure new ring parameters are within bounds during SRINGPARAM")
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>

Applied and queued up for -stable, thanks.
