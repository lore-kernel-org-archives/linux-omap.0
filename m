From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next 20/22] rionet: fix return type of ndo_start_xmit function
Date: Thu, 20 Sep 2018 20:33:04 +0800
Message-ID: <20180920123306.14772-21-yuehaibing@huawei.com>
References: <20180920123306.14772-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920123306.14772-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: davem@davemloft.net, dmitry.tarnyagin@lockless.no, wg@grandegger.com, mkl@pengutronix.de, michal.simek@xilinx.com, hsweeten@visionengravers.com, madalin.bucur@nxp.com, pantelis.antoniou@gmail.com, claudiu.manoil@nxp.com, leoyang.li@nxp.com, linux@armlinux.org.uk, sammy@sammy.net, ralf@linux-mips.org, nico@fluxnic.net, steve.glendinning@shawell.net, f.fainelli@gmail.com, grygorii.strashko@ti.com, w-kwok2@ti.com, m-karicheri2@ti.com, t.sailer@alumni.ethz.ch, jreuter@yaina.de, kys@microsoft.com, haiyangz@microsoft.com, wei.liu2@citrix.com, paul.durrant@citrix.com, arvid.brodin@alten.se, pshelar@ovn.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org, linux-omap@vger.kernel.org, linux-hams@vger.kernel.org, devel@linuxdriverproject.org, linux-usb@vger.kernel.org, xen-devel@lists.xenproject.org, dev@openvswitch.org, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-omap@vger.kernel.org

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, so make sure the implementation in
this driver has returns 'netdev_tx_t' value, and change the function
return type to netdev_tx_t.

Found by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/rionet.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/rionet.c b/drivers/net/rionet.c
index e9f101c..de391c7 100644
--- a/drivers/net/rionet.c
+++ b/drivers/net/rionet.c
@@ -170,7 +170,8 @@ static int rionet_queue_tx_msg(struct sk_buff *skb, struct net_device *ndev,
 	return 0;
 }
 
-static int rionet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+static netdev_tx_t
+rionet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	int i;
 	struct rionet_private *rnet = netdev_priv(ndev);
-- 
1.8.3.1
