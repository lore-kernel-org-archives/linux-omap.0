From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 3/7] usb: dwc3: pci: add pm_runtime support
Date: Thu, 12 Dec 2013 15:38:41 -0600
Message-ID: <1386884325-11440-4-git-send-email-balbi@ti.com>
References: <1386884325-11440-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1386884325-11440-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, w-kwok2-l0cyMroinI0@public.gmane.org, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

teach the PCI glue about pm_runtime so that
it's easier to teach dwc3 core about it
later.

No functional changes otherwise.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/dwc3/dwc3-pci.c | 66 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 665686e..78cd0b0 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -109,18 +109,17 @@ static int dwc3_pci_probe(struct pci_dev *pci,
 
 	glue->dev = dev;
 
-	ret = pci_enable_device(pci);
+	pm_runtime_enable(dev);
+	ret = pm_runtime_get_sync(dev);
 	if (ret) {
 		dev_err(dev, "failed to enable pci device\n");
 		return -ENODEV;
 	}
 
-	pci_set_master(pci);
-
 	ret = dwc3_pci_register_phys(glue);
 	if (ret) {
 		dev_err(dev, "couldn't register PHYs\n");
-		return ret;
+		goto err1;
 	}
 
 	dwc3 = platform_device_alloc("dwc3", PLATFORM_DEVID_AUTO);
@@ -167,7 +166,8 @@ static int dwc3_pci_probe(struct pci_dev *pci,
 err3:
 	platform_device_put(dwc3);
 err1:
-	pci_disable_device(pci);
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
 
 	return ret;
 }
@@ -175,11 +175,13 @@ err1:
 static void dwc3_pci_remove(struct pci_dev *pci)
 {
 	struct dwc3_pci	*glue = pci_get_drvdata(pci);
+	struct device *dev = &pci->dev;
 
 	platform_device_unregister(glue->dwc3);
 	platform_device_unregister(glue->usb2_phy);
 	platform_device_unregister(glue->usb3_phy);
-	pci_disable_device(pci);
+	pm_runtime_put_sync(dev);
+	pm_runtime_disable(dev);
 }
 
 static const struct pci_device_id dwc3_pci_id_table[] = {
@@ -193,24 +195,20 @@ static const struct pci_device_id dwc3_pci_id_table[] = {
 };
 MODULE_DEVICE_TABLE(pci, dwc3_pci_id_table);
 
-#ifdef CONFIG_PM_SLEEP
-static int dwc3_pci_suspend(struct device *dev)
+static int __dwc3_pci_suspend(struct pci_dev *pci)
 {
-	struct pci_dev	*pci = to_pci_dev(dev);
-
 	pci_disable_device(pci);
 
 	return 0;
 }
 
-static int dwc3_pci_resume(struct device *dev)
+static int __dwc3_pci_resume(struct pci_dev *pci)
 {
-	struct pci_dev	*pci = to_pci_dev(dev);
-	int		ret;
+	int ret;
 
 	ret = pci_enable_device(pci);
 	if (ret) {
-		dev_err(dev, "can't re-enable device --> %d\n", ret);
+		dev_err(&pci->dev, "can't re-enable device --> %d\n", ret);
 		return ret;
 	}
 
@@ -218,10 +216,48 @@ static int dwc3_pci_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP */
+
+static int dwc3_pci_suspend(struct device *dev)
+{
+	struct pci_dev	*pci = to_pci_dev(dev);
+
+	return __dwc3_pci_suspend(pci);
+}
+
+static int dwc3_pci_resume(struct device *dev)
+{
+	struct pci_dev	*pci = to_pci_dev(dev);
+	int		ret;
+
+	ret = __dwc3_pci_resume(pci);
+	if (ret)
+		return ret;
+
+	pm_runtime_disable(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_disable(dev);
+
+	return 0;
+}
+
+static int dwc3_pci_runtime_suspend(struct device *dev)
+{
+	struct pci_dev	*pci = to_pci_dev(dev);
+
+	return __dwc3_pci_suspend(pci);
+}
+
+static int dwc3_pci_runtime_resume(struct device *dev)
+{
+	struct pci_dev	*pci = to_pci_dev(dev);
+
+	return __dwc3_pci_resume(pci);
+}
 
 static const struct dev_pm_ops dwc3_pci_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(dwc3_pci_suspend, dwc3_pci_resume)
+	SET_RUNTIME_PM_OPS(dwc3_pci_runtime_suspend, dwc3_pci_runtime_resume,
+			NULL)
 };
 
 static struct pci_driver dwc3_pci_driver = {
-- 
1.8.4.GIT

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
