From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next] net: ethernet: ti: cpsw: use cpsw as drv data
Date: Fri, 14 Jun 2019 18:44:01 -0700 (PDT)
Message-ID: <20190614.184401.912941965819997323.davem@davemloft.net>
References: <20190611214903.32146-1-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190611214903.32146-1-ivan.khoronzhuk@linaro.org>
Sender: netdev-owner@vger.kernel.org
To: ivan.khoronzhuk@linaro.org
Cc: grygorii.strashko@ti.com, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Date: Wed, 12 Jun 2019 00:49:03 +0300

> No need to set ndev for drvdata when mainly cpsw reference is needed,
> so correct this legacy decision.
> 
> Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> ---
> 
> Based on net-next/master

Applied.
