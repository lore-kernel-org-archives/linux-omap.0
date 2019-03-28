From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH net-next] net: ethernet: ti: davinci_mdio: switch to
 readl/writel_relaxed()
Date: Thu, 28 Mar 2019 19:09:53 +0200
Message-ID: <1553792993-7722-1-git-send-email-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "David S. Miller" <davem@davemloft.net>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, netdev@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Switch to readl/writel_relaxed() APIs, because this is recommended
API and the MDIO block is reused on Keystone 2 SoCs
where LE/BE modes are supported.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/ethernet/ti/davinci_mdio.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
index a98aedae1b41..64776b47799b 100644
--- a/drivers/net/ethernet/ti/davinci_mdio.c
+++ b/drivers/net/ethernet/ti/davinci_mdio.c
@@ -140,7 +140,7 @@ static void davinci_mdio_init_clk(struct davinci_mdio_data *data)
 static void davinci_mdio_enable(struct davinci_mdio_data *data)
 {
 	/* set enable and clock divider */
-	__raw_writel(data->clk_div | CONTROL_ENABLE, &data->regs->control);
+	writel_relaxed(data->clk_div | CONTROL_ENABLE, &data->regs->control);
 }
 
 static int davinci_mdio_reset(struct mii_bus *bus)
@@ -159,7 +159,7 @@ static int davinci_mdio_reset(struct mii_bus *bus)
 	msleep(PHY_MAX_ADDR * data->access_time);
 
 	/* dump hardware version info */
-	ver = __raw_readl(&data->regs->version);
+	ver = readl_relaxed(&data->regs->version);
 	dev_info(data->dev,
 		 "davinci mdio revision %d.%d, bus freq %ld\n",
 		 (ver >> 8) & 0xff, ver & 0xff,
@@ -169,7 +169,7 @@ static int davinci_mdio_reset(struct mii_bus *bus)
 		goto done;
 
 	/* get phy mask from the alive register */
-	phy_mask = __raw_readl(&data->regs->alive);
+	phy_mask = readl_relaxed(&data->regs->alive);
 	if (phy_mask) {
 		/* restrict mdio bus to live phys only */
 		dev_info(data->dev, "detected phy mask %x\n", ~phy_mask);
@@ -196,11 +196,11 @@ static inline int wait_for_user_access(struct davinci_mdio_data *data)
 	u32 reg;
 
 	while (time_after(timeout, jiffies)) {
-		reg = __raw_readl(&regs->user[0].access);
+		reg = readl_relaxed(&regs->user[0].access);
 		if ((reg & USERACCESS_GO) == 0)
 			return 0;
 
-		reg = __raw_readl(&regs->control);
+		reg = readl_relaxed(&regs->control);
 		if ((reg & CONTROL_IDLE) == 0) {
 			usleep_range(100, 200);
 			continue;
@@ -216,7 +216,7 @@ static inline int wait_for_user_access(struct davinci_mdio_data *data)
 		return -EAGAIN;
 	}
 
-	reg = __raw_readl(&regs->user[0].access);
+	reg = readl_relaxed(&regs->user[0].access);
 	if ((reg & USERACCESS_GO) == 0)
 		return 0;
 
@@ -263,7 +263,7 @@ static int davinci_mdio_read(struct mii_bus *bus, int phy_id, int phy_reg)
 		if (ret < 0)
 			break;
 
-		__raw_writel(reg, &data->regs->user[0].access);
+		writel_relaxed(reg, &data->regs->user[0].access);
 
 		ret = wait_for_user_access(data);
 		if (ret == -EAGAIN)
@@ -271,7 +271,7 @@ static int davinci_mdio_read(struct mii_bus *bus, int phy_id, int phy_reg)
 		if (ret < 0)
 			break;
 
-		reg = __raw_readl(&data->regs->user[0].access);
+		reg = readl_relaxed(&data->regs->user[0].access);
 		ret = (reg & USERACCESS_ACK) ? (reg & USERACCESS_DATA) : -EIO;
 		break;
 	}
@@ -307,7 +307,7 @@ static int davinci_mdio_write(struct mii_bus *bus, int phy_id,
 		if (ret < 0)
 			break;
 
-		__raw_writel(reg, &data->regs->user[0].access);
+		writel_relaxed(reg, &data->regs->user[0].access);
 
 		ret = wait_for_user_access(data);
 		if (ret == -EAGAIN)
@@ -472,9 +472,9 @@ static int davinci_mdio_runtime_suspend(struct device *dev)
 	u32 ctrl;
 
 	/* shutdown the scan state machine */
-	ctrl = __raw_readl(&data->regs->control);
+	ctrl = readl_relaxed(&data->regs->control);
 	ctrl &= ~CONTROL_ENABLE;
-	__raw_writel(ctrl, &data->regs->control);
+	writel_relaxed(ctrl, &data->regs->control);
 	wait_for_idle(data);
 
 	return 0;
-- 
2.17.1
