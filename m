From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH V2] net: ethernet: ti: cpsw: Fix suspend/resume break
Date: Mon, 24 Jun 2019 07:23:33 -0700 (PDT)
Message-ID: <20190624.072333.2300932810459542260.davem@davemloft.net>
References: <20190624051619.20146-1-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190624051619.20146-1-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: j-keerthy@ti.com
Cc: ivan.khoronzhuk@linaro.org, andrew@lunn.ch, ilias.apalodimas@linaro.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-omap@vger.kernel.org, t-kristo@ti.com, grygorii.strashko@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

From: Keerthy <j-keerthy@ti.com>
Date: Mon, 24 Jun 2019 10:46:19 +0530

> Commit bfe59032bd6127ee190edb30be9381a01765b958 ("net: ethernet:
> ti: cpsw: use cpsw as drv data")changes
> the driver data to struct cpsw_common *cpsw. This is done
> only in probe/remove but the suspend/resume functions are
> still left with struct net_device *ndev. Hence fix both
> suspend & resume also to fetch the updated driver data.
> 
> Fixes: bfe59032bd6127ee1 ("net: ethernet: ti: cpsw: use cpsw as drv data")
> Signed-off-by: Keerthy <j-keerthy@ti.com>

Applied but please make it clear that changes are targetting net-next in the
future by saying "[PATCH net-next v2] ...." in your Subject line.

Thank you.
