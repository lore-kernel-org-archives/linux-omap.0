From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 07/29] mfd: omap-usb: use clk_prepare_enable and clk_disable_unprepare
Date: Thu, 14 Jun 2012 18:16:56 +0530
Message-ID: <1339678038-23082-8-git-send-email-rnayak@ti.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48598 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755534Ab2FNMru (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jun 2012 08:47:50 -0400
In-Reply-To: <1339678038-23082-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, mturquette@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

As we move to Common clk framework use clk_prepare_enable()
instead of clk_enable() and similarly clk_disable_unprepare()
instead of clk_disable()

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 drivers/mfd/omap-usb-host.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 7e96bb2..d70d2fe 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -438,18 +438,18 @@ static int usbhs_runtime_resume(struct device *dev)
 	spin_lock_irqsave(&omap->lock, flags);
 
 	if (omap->ehci_logic_fck && !IS_ERR(omap->ehci_logic_fck))
-		clk_enable(omap->ehci_logic_fck);
+		clk_prepare_enable(omap->ehci_logic_fck);
 
 	if (is_ehci_tll_mode(pdata->port_mode[0])) {
-		clk_enable(omap->usbhost_p1_fck);
-		clk_enable(omap->usbtll_p1_fck);
+		clk_prepare_enable(omap->usbhost_p1_fck);
+		clk_prepare_enable(omap->usbtll_p1_fck);
 	}
 	if (is_ehci_tll_mode(pdata->port_mode[1])) {
-		clk_enable(omap->usbhost_p2_fck);
-		clk_enable(omap->usbtll_p2_fck);
+		clk_prepare_enable(omap->usbhost_p2_fck);
+		clk_prepare_enable(omap->usbtll_p2_fck);
 	}
-	clk_enable(omap->utmi_p1_fck);
-	clk_enable(omap->utmi_p2_fck);
+	clk_prepare_enable(omap->utmi_p1_fck);
+	clk_prepare_enable(omap->utmi_p2_fck);
 
 	spin_unlock_irqrestore(&omap->lock, flags);
 
@@ -472,18 +472,18 @@ static int usbhs_runtime_suspend(struct device *dev)
 	spin_lock_irqsave(&omap->lock, flags);
 
 	if (is_ehci_tll_mode(pdata->port_mode[0])) {
-		clk_disable(omap->usbhost_p1_fck);
-		clk_disable(omap->usbtll_p1_fck);
+		clk_disable_unprepare(omap->usbhost_p1_fck);
+		clk_disable_unprepare(omap->usbtll_p1_fck);
 	}
 	if (is_ehci_tll_mode(pdata->port_mode[1])) {
-		clk_disable(omap->usbhost_p2_fck);
-		clk_disable(omap->usbtll_p2_fck);
+		clk_disable_unprepare(omap->usbhost_p2_fck);
+		clk_disable_unprepare(omap->usbtll_p2_fck);
 	}
-	clk_disable(omap->utmi_p2_fck);
-	clk_disable(omap->utmi_p1_fck);
+	clk_disable_unprepare(omap->utmi_p2_fck);
+	clk_disable_unprepare(omap->utmi_p1_fck);
 
 	if (omap->ehci_logic_fck && !IS_ERR(omap->ehci_logic_fck))
-		clk_disable(omap->ehci_logic_fck);
+		clk_disable_unprepare(omap->ehci_logic_fck);
 
 	spin_unlock_irqrestore(&omap->lock, flags);
 
-- 
1.7.1

