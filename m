From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next 04/22] net: cirrus: fix return type of ndo_start_xmit
 function
Date: Thu, 20 Sep 2018 20:32:48 +0800
Message-ID: <20180920123306.14772-5-yuehaibing@huawei.com>
References: <20180920123306.14772-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20180920123306.14772-1-yuehaibing@huawei.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: davem@davemloft.net, dmitry.tarnyagin@lockless.no, wg@grandegger.com, mkl@pengutronix.de, michal.simek@xilinx.com, hsweeten@visionengravers.com, madalin.bucur@nxp.com, pantelis.antoniou@gmail.com, claudiu.manoil@nxp.com, leoyang.li@nxp.com, linux@armlinux.org.uk, sammy@sammy.net, ralf@linux-mips.org, nico@fluxnic.net, steve.glendinning@shawell.net, f.fainelli@gmail.com, grygorii.strashko@ti.com, w-kwok2@ti.com, m-karicheri2@ti.com, t.sailer@alumni.ethz.ch, jreuter@yaina.de, kys@microsoft.com, haiyangz@microsoft.com, wei.liu2@citrix.com, paul.durrant@citrix.com, arvid.brodin@alten.se, pshelar@ovn.org
Cc: dev@openvswitch.org, linux-mips@linux-mips.org, xen-devel@lists.xenproject.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, devel@linuxdriverproject.org, linux-hams@vger.kernel.org, linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
which is a typedef for an enum type, so make sure the implementation in
this driver has returns 'netdev_tx_t' value, and change the function
return type to netdev_tx_t.

Found by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/cirrus/ep93xx_eth.c | 2 +-
 drivers/net/ethernet/cirrus/mac89x0.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cirrus/ep93xx_eth.c b/drivers/net/ethernet/cirrus/ep93xx_eth.c
index e2a7029..13dfdfc 100644
--- a/drivers/net/ethernet/cirrus/ep93xx_eth.c
+++ b/drivers/net/ethernet/cirrus/ep93xx_eth.c
@@ -332,7 +332,7 @@ static int ep93xx_poll(struct napi_struct *napi, int budget)
 	return rx;
 }
 
-static int ep93xx_xmit(struct sk_buff *skb, struct net_device *dev)
+static netdev_tx_t ep93xx_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct ep93xx_priv *ep = netdev_priv(dev);
 	struct ep93xx_tdesc *txd;
diff --git a/drivers/net/ethernet/cirrus/mac89x0.c b/drivers/net/ethernet/cirrus/mac89x0.c
index 3f8fe8f..6324e80 100644
--- a/drivers/net/ethernet/cirrus/mac89x0.c
+++ b/drivers/net/ethernet/cirrus/mac89x0.c
@@ -113,7 +113,7 @@ struct net_local {
 
 /* Index to functions, as function prototypes. */
 static int net_open(struct net_device *dev);
-static int net_send_packet(struct sk_buff *skb, struct net_device *dev);
+static netdev_tx_t net_send_packet(struct sk_buff *skb, struct net_device *dev);
 static irqreturn_t net_interrupt(int irq, void *dev_id);
 static void set_multicast_list(struct net_device *dev);
 static void net_rx(struct net_device *dev);
@@ -324,7 +324,7 @@ static int mac89x0_device_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int
+static netdev_tx_t
 net_send_packet(struct sk_buff *skb, struct net_device *dev)
 {
 	struct net_local *lp = netdev_priv(dev);
-- 
1.8.3.1
