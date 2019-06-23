From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: Re: [PATCH] net: ethernet: ti: cpsw: Fix suspend/resume break
Date: Mon, 24 Jun 2019 02:31:06 +0300
Message-ID: <20190623233105.GA5472@khorivan>
References: <20190622103140.22902-1-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190622103140.22902-1-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: davem@davemloft.net, andrew@lunn.ch, ilias.apalodimas@linaro.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-omap@vger.kernel.org, t-kristo@ti.com, grygorii.strashko@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

On Sat, Jun 22, 2019 at 04:01:40PM +0530, Keerthy wrote:

Hi Keerty,

>Commit bfe59032bd6127ee190edb30be9381a01765b958 ("net: ethernet:
>ti: cpsw: use cpsw as drv data")changes
>the driver data to struct cpsw_common *cpsw. This is done
>only in probe/remove but the suspend/resume functions are
>still left with struct net_device *ndev. Hence fix both
>suspend & resume also to fetch the updated driver data.
>
>Fixes: bfe59032bd6127ee1 ("net: ethernet: ti: cpsw: use cpsw as drv data")
>Signed-off-by: Keerthy <j-keerthy@ti.com>
>---
> drivers/net/ethernet/ti/cpsw.c | 36 +++++++++++-----------------------
> 1 file changed, 11 insertions(+), 25 deletions(-)
>
>diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
>index 7bdd287074fc..2aeaad15e20e 100644
>--- a/drivers/net/ethernet/ti/cpsw.c
>+++ b/drivers/net/ethernet/ti/cpsw.c
>@@ -2590,20 +2590,12 @@ static int cpsw_remove(struct platform_device *pdev)
> #ifdef CONFIG_PM_SLEEP
> static int cpsw_suspend(struct device *dev)
> {
>-	struct net_device	*ndev = dev_get_drvdata(dev);
>-	struct cpsw_common	*cpsw = ndev_to_cpsw(ndev);
>-
>-	if (cpsw->data.dual_emac) {
>-		int i;
>+	struct cpsw_common *cpsw = dev_get_drvdata(dev);
>+	int i;
>
>-		for (i = 0; i < cpsw->data.slaves; i++) {
>-			if (netif_running(cpsw->slaves[i].ndev))
>-				cpsw_ndo_stop(cpsw->slaves[i].ndev);
>-		}
>-	} else {
>-		if (netif_running(ndev))
>-			cpsw_ndo_stop(ndev);
>-	}
>+	for (i = 0; i < cpsw->data.slaves; i++)
>+		if (netif_running(cpsw->slaves[i].ndev))
Seems I've missed to add this, but in your fix potential issue in switch mode.
ndev is not necessarily present for slave, you need to check on ndev != null
before using it, if you still remove cpsw->data.dual_emac ofc.

Thanks.

>+			cpsw_ndo_stop(cpsw->slaves[i].ndev);
>
> 	/* Select sleep pin state */
> 	pinctrl_pm_select_sleep_state(dev);
>@@ -2613,25 +2605,19 @@ static int cpsw_suspend(struct device *dev)
>
> static int cpsw_resume(struct device *dev)
> {
>-	struct net_device	*ndev = dev_get_drvdata(dev);
>-	struct cpsw_common	*cpsw = ndev_to_cpsw(ndev);
>+	struct cpsw_common *cpsw = dev_get_drvdata(dev);
>+	int i;
>
> 	/* Select default pin state */
> 	pinctrl_pm_select_default_state(dev);
>
> 	/* shut up ASSERT_RTNL() warning in netif_set_real_num_tx/rx_queues */
> 	rtnl_lock();
>-	if (cpsw->data.dual_emac) {
>-		int i;
>
>-		for (i = 0; i < cpsw->data.slaves; i++) {
>-			if (netif_running(cpsw->slaves[i].ndev))
>-				cpsw_ndo_open(cpsw->slaves[i].ndev);
>-		}
>-	} else {
>-		if (netif_running(ndev))
>-			cpsw_ndo_open(ndev);
>-	}
>+	for (i = 0; i < cpsw->data.slaves; i++)
>+		if (netif_running(cpsw->slaves[i].ndev))
>+			cpsw_ndo_open(cpsw->slaves[i].ndev);
>+
same here

> 	rtnl_unlock();
>
> 	return 0;
>-- 
>2.17.1
>

-- 
Regards,
Ivan Khoronzhuk
