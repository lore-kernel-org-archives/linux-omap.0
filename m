From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 2/4] mailbox/omap: add support for suspend/resume
Date: Wed, 6 Apr 2016 18:37:18 -0500
Message-ID: <1459985840-1106-3-git-send-email-s-anna@ti.com>
References: <1459985840-1106-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459985840-1106-1-git-send-email-s-anna@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>
List-Id: linux-omap@vger.kernel.org

Support has been added to the OMAP mailbox driver to allow it
to work across a system suspend/resume. The OMAP mailbox driver
requires only the interrupt configuration registers to be saved
and restored, and this is done in the suspend/resume callbacks.
The registers need to be saved only if there are active clients
at the time of suspend. The enabling and disabling of the mailbox
clocks is done automatically by the omap_device layer.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/mailbox/omap-mailbox.c | 45 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index adf37f494690..1b90eb380d44 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -88,6 +88,7 @@ struct omap_mbox_device {
 	struct device *dev;
 	struct mutex cfg_lock;
 	void __iomem *mbox_base;
+	u32 *irq_ctx;
 	u32 num_users;
 	u32 num_fifos;
 	u32 intr_type;
@@ -650,6 +651,44 @@ static const struct mbox_chan_ops omap_mbox_chan_ops = {
 	.shutdown       = omap_mbox_chan_shutdown,
 };
 
+#ifdef CONFIG_PM_SLEEP
+static int omap_mbox_suspend(struct device *dev)
+{
+	struct omap_mbox_device *mdev = dev_get_drvdata(dev);
+	u32 usr, reg;
+
+	if (pm_runtime_status_suspended(dev))
+		return 0;
+
+	for (usr = 0; usr < mdev->num_users; usr++) {
+		reg = MAILBOX_IRQENABLE(mdev->intr_type, usr);
+		mdev->irq_ctx[usr] = mbox_read_reg(mdev, reg);
+	}
+
+	return 0;
+}
+
+static int omap_mbox_resume(struct device *dev)
+{
+	struct omap_mbox_device *mdev = dev_get_drvdata(dev);
+	u32 usr, reg;
+
+	if (pm_runtime_status_suspended(dev))
+		return 0;
+
+	for (usr = 0; usr < mdev->num_users; usr++) {
+		reg = MAILBOX_IRQENABLE(mdev->intr_type, usr);
+		mbox_write_reg(mdev, mdev->irq_ctx[usr], reg);
+	}
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops omap_mbox_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(omap_mbox_suspend, omap_mbox_resume)
+};
+
 static const struct of_device_id omap_mailbox_of_match[] = {
 	{
 		.compatible	= "ti,omap2-mailbox",
@@ -777,6 +816,11 @@ static int omap_mbox_probe(struct platform_device *pdev)
 	if (IS_ERR(mdev->mbox_base))
 		return PTR_ERR(mdev->mbox_base);
 
+	mdev->irq_ctx = devm_kzalloc(&pdev->dev, num_users * sizeof(u32),
+				     GFP_KERNEL);
+	if (!mdev->irq_ctx)
+		return -ENOMEM;
+
 	/* allocate one extra for marking end of list */
 	list = devm_kzalloc(&pdev->dev, (info_count + 1) * sizeof(*list),
 			    GFP_KERNEL);
@@ -887,6 +931,7 @@ static struct platform_driver omap_mbox_driver = {
 	.remove	= omap_mbox_remove,
 	.driver	= {
 		.name = "omap-mailbox",
+		.pm = &omap_mbox_pm_ops,
 		.of_match_table = of_match_ptr(omap_mailbox_of_match),
 	},
 };
-- 
2.7.4
