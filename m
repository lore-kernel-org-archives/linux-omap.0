From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 04/11] mfd: omap-usb: add clk_prepare and clk_unprepare
Date: Fri, 22 Jun 2012 19:18:03 +0530
Message-ID: <1340372890-10091-5-git-send-email-rnayak@ti.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34287 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762174Ab2FVNsa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 22 Jun 2012 09:48:30 -0400
In-Reply-To: <1340372890-10091-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, mturquette@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

In preparation of OMAP moving to Common Clk Framework (CCF) add clk_prepare()
and clk_unprepare() for the various usb host clocks.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>
---
 drivers/mfd/omap-usb-host.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 7e96bb2..dcffa5c 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -632,6 +632,7 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 				dev_warn(dev, "ehci_logic_fck failed:%d\n",
 					 ret);
 			}
+			clk_prepare(omap->ehci_logic_fck);
 			break;
 		}
 
@@ -641,6 +642,7 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 		dev_err(dev, "utmi_p1_gfclk failed error:%d\n",	ret);
 		goto err_end;
 	}
+	clk_prepare(omap->utmi_p1_fck);
 
 	omap->xclk60mhsp1_ck = clk_get(dev, "xclk60mhsp1_ck");
 	if (IS_ERR(omap->xclk60mhsp1_ck)) {
@@ -648,6 +650,7 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 		dev_err(dev, "xclk60mhsp1_ck failed error:%d\n", ret);
 		goto err_utmi_p1_fck;
 	}
+	clk_prepare(omap->xclk60mhsp1_ck);
 
 	omap->utmi_p2_fck = clk_get(dev, "utmi_p2_gfclk");
 	if (IS_ERR(omap->utmi_p2_fck)) {
@@ -655,6 +658,7 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 		dev_err(dev, "utmi_p2_gfclk failed error:%d\n", ret);
 		goto err_xclk60mhsp1_ck;
 	}
+	clk_prepare(omap->utmi_p2_fck);
 
 	omap->xclk60mhsp2_ck = clk_get(dev, "xclk60mhsp2_ck");
 	if (IS_ERR(omap->xclk60mhsp2_ck)) {
@@ -662,6 +666,7 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 		dev_err(dev, "xclk60mhsp2_ck failed error:%d\n", ret);
 		goto err_utmi_p2_fck;
 	}
+	clk_prepare(omap->xclk60mhsp2_ck);
 
 	omap->usbhost_p1_fck = clk_get(dev, "usb_host_hs_utmi_p1_clk");
 	if (IS_ERR(omap->usbhost_p1_fck)) {
@@ -669,6 +674,7 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 		dev_err(dev, "usbhost_p1_fck failed error:%d\n", ret);
 		goto err_xclk60mhsp2_ck;
 	}
+	clk_prepare(omap->usbhost_p1_fck);
 
 	omap->usbtll_p1_fck = clk_get(dev, "usb_tll_hs_usb_ch0_clk");
 	if (IS_ERR(omap->usbtll_p1_fck)) {
@@ -676,6 +682,7 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 		dev_err(dev, "usbtll_p1_fck failed error:%d\n", ret);
 		goto err_usbhost_p1_fck;
 	}
+	clk_prepare(omap->usbtll_p1_fck);
 
 	omap->usbhost_p2_fck = clk_get(dev, "usb_host_hs_utmi_p2_clk");
 	if (IS_ERR(omap->usbhost_p2_fck)) {
@@ -683,6 +690,7 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 		dev_err(dev, "usbhost_p2_fck failed error:%d\n", ret);
 		goto err_usbtll_p1_fck;
 	}
+	clk_prepare(omap->usbhost_p2_fck);
 
 	omap->usbtll_p2_fck = clk_get(dev, "usb_tll_hs_usb_ch1_clk");
 	if (IS_ERR(omap->usbtll_p2_fck)) {
@@ -690,6 +698,7 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 		dev_err(dev, "usbtll_p2_fck failed error:%d\n", ret);
 		goto err_usbhost_p2_fck;
 	}
+	clk_prepare(omap->usbtll_p2_fck);
 
 	omap->init_60m_fclk = clk_get(dev, "init_60m_fclk");
 	if (IS_ERR(omap->init_60m_fclk)) {
@@ -697,6 +706,7 @@ static int __devinit usbhs_omap_probe(struct platform_device *pdev)
 		dev_err(dev, "init_60m_fclk failed error:%d\n", ret);
 		goto err_usbtll_p2_fck;
 	}
+	clk_prepare(omap->init_60m_fclk);
 
 	if (is_ehci_phy_mode(pdata->port_mode[0])) {
 		/* for OMAP3 , the clk set paretn fails */
@@ -773,33 +783,43 @@ err_tll:
 	iounmap(omap->uhh_base);
 
 err_init_60m_fclk:
+	clk_unprepare(omap->init_60m_fclk);
 	clk_put(omap->init_60m_fclk);
 
 err_usbtll_p2_fck:
+	clk_unprepare(omap->usbtll_p2_fck);
 	clk_put(omap->usbtll_p2_fck);
 
 err_usbhost_p2_fck:
+	clk_unprepare(omap->usbhost_p2_fck);
 	clk_put(omap->usbhost_p2_fck);
 
 err_usbtll_p1_fck:
+	clk_unprepare(omap->usbtll_p1_fck);
 	clk_put(omap->usbtll_p1_fck);
 
 err_usbhost_p1_fck:
+	clk_unprepare(omap->usbhost_p1_fck);
 	clk_put(omap->usbhost_p1_fck);
 
 err_xclk60mhsp2_ck:
+	clk_unprepare(omap->xclk60mhsp2_ck);
 	clk_put(omap->xclk60mhsp2_ck);
 
 err_utmi_p2_fck:
+	clk_unprepare(omap->utmi_p2_fck);
 	clk_put(omap->utmi_p2_fck);
 
 err_xclk60mhsp1_ck:
+	clk_unprepare(omap->xclk60mhsp1_ck);
 	clk_put(omap->xclk60mhsp1_ck);
 
 err_utmi_p1_fck:
+	clk_unprepare(omap->utmi_p1_fck);
 	clk_put(omap->utmi_p1_fck);
 
 err_end:
+	clk_unprepare(omap->ehci_logic_fck);
 	clk_put(omap->ehci_logic_fck);
 	pm_runtime_disable(dev);
 	kfree(omap);
-- 
1.7.1

