From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] usb: dwc3: Remove redundant pci_set_drvdata
Date: Fri, 20 Sep 2013 15:16:34 +0530
Message-ID: <1379670394-10091-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:61869 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754221Ab3ITJqZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Sep 2013 05:46:25 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc17so179984pbc.32
        for <linux-omap@vger.kernel.org>; Fri, 20 Sep 2013 02:46:24 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, balbi@ti.com, gregkh@linuxfoundation.org, sachin.kamat@linaro.org

Driver core sets driver data to NULL upon failure or remove.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/usb/dwc3/dwc3-pci.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 997ebe4..f41ce36 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -164,7 +164,6 @@ static int dwc3_pci_probe(struct pci_dev *pci,
 	return 0;
 
 err3:
-	pci_set_drvdata(pci, NULL);
 	platform_device_put(dwc3);
 err1:
 	pci_disable_device(pci);
@@ -179,7 +178,6 @@ static void dwc3_pci_remove(struct pci_dev *pci)
 	platform_device_unregister(glue->dwc3);
 	platform_device_unregister(glue->usb2_phy);
 	platform_device_unregister(glue->usb3_phy);
-	pci_set_drvdata(pci, NULL);
 	pci_disable_device(pci);
 }
 
-- 
1.7.9.5

