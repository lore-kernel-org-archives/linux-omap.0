From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net: ethernet: ti: cpsw: disable mq feature for
 "AM33xx ES1.0" devices
Date: Thu, 17 May 2018 15:12:23 -0400 (EDT)
Message-ID: <20180517.151223.1480085511338001366.davem@davemloft.net>
References: <20180516222145.26877-1-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180516222145.26877-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ivan.khoronzhuk@linaro.org
Cc: grygorii.strashko@ti.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Date: Thu, 17 May 2018 01:21:45 +0300

> The early versions of am33xx devices, related to ES1.0 SoC revision
> have errata limiting mq support. That's the same errata as
> commit 7da1160002f1 ("drivers: net: cpsw: add am335x errata workarround for
> interrutps")
> 
> AM33xx Errata [1] Advisory 1.0.9
> http://www.ti.com/lit/er/sprz360f/sprz360f.pdf
> 
> After additional investigation were found that drivers w/a is
> propagated on all AM33xx SoCs and on DM814x. But the errata exists
> only for ES1.0 of AM33xx family, limiting mq support for revisions
> after ES1.0. So, disable mq support only for related SoCs and use
> separate polls for revisions allowing mq.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> ---
> 
> Based on net-next/master

Patch applied to net-next, thank you.
