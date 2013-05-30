From: Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 2/7] usb, dwc3: remove redundant D0 power state set
Date: Thu, 30 May 2013 18:19:40 +0800
Message-ID: <1369909180-33136-1-git-send-email-wangyijing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:37989 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968106Ab3E3KUF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 May 2013 06:20:05 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>, Jiang Liu <liuj97@gmail.com>, Yijing Wang <wangyijing@huawei.com>

Pci_enable_device() will set device power state to D0,
so it's no need to do it again in dwc3_pci_probe().

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
---
 drivers/usb/dwc3/dwc3-pci.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 227d4a7..c068608 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -133,7 +133,6 @@ static int dwc3_pci_probe(struct pci_dev *pci,
 		return -ENODEV;
 	}
 
-	pci_set_power_state(pci, PCI_D0);
 	pci_set_master(pci);
 
 	ret = dwc3_pci_register_phys(glue);
-- 
1.7.1


