From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] usb: dwc3-pci: Ensure system sleep PM ops are defined only when used
Date: Tue,  6 Aug 2013 16:49:26 +0100
Message-ID: <1375804166-3205-1-git-send-email-broonie@kernel.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:44729 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755113Ab3HFPtz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Aug 2013 11:49:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-omap@vger.kernel.org, Andy Green <andy.green@linaro.org>, Mark Brown <broonie@linaro.org>

From: Andy Green <andy.green@linaro.org>

You might have CONFIG_PM, but you might not have CONFIG_SUSPEND, in which
case these are unused.

Signed-off-by: Andy Green <andy.green@linaro.org>
Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/usb/dwc3/dwc3-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 5d746e5..4902021 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -191,7 +191,7 @@ static DEFINE_PCI_DEVICE_TABLE(dwc3_pci_id_table) = {
 };
 MODULE_DEVICE_TABLE(pci, dwc3_pci_id_table);
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_SUSPEND
 static int dwc3_pci_suspend(struct device *dev)
 {
 	struct pci_dev	*pci = to_pci_dev(dev);
-- 
1.8.4.rc1

