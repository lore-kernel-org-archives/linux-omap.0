Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9953B27C5;
	Mon, 23 Mar 2026 15:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278183; cv=none; b=fwjuQ9CjXeoNrK/V/eVeGY6RYN5MfSLQZVp87gGmIVQVfUe2RfuwbFY3KIdAXU7g7V9C6vQXMqUs+dGVx7ewOsdWYV+YQgY086/OhwIpni6Tfybqob7SKDj/cn9GAuGOzhmLy2Mr4DhqioXZBTwxlvG5HZVHjZNnWa18WWlxOqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278183; c=relaxed/simple;
	bh=1llMV2XrxLGYKxlvoSuxQuMv7LW/C1l7c6ICeXPKteU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y6OguBChEMhPJV3I9b05mmLi0wm3jwUzeXoP+w4414/LSzroKF1SmB3Nt+hGPAQZ2tc1lkz76HPiCVr1CZAwKsCC0g8LlidLXtjQ98E02tPPb6OXAjrTQIoS5LcJ0tT90ZmTQXI1j6wD2Yc1RoUkjfIB72ecKhsktQooSRIBLNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Tt8Z6K+W; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Tt8Z6K+W"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id BDA964E427B1;
	Mon, 23 Mar 2026 15:03:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 93D1D5FEF6;
	Mon, 23 Mar 2026 15:03:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 442D010450FE8;
	Mon, 23 Mar 2026 16:02:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774278179; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=mEj6I82Butstr1tfMlJeMGpvyxIOHycoQhYhLpOxC0A=;
	b=Tt8Z6K+W3HeAm+5jR2H7G0rHNIWDzjitLz6jlbcmPHaySRV54ZVpEbQSIRqa8f3Zi+R8+Q
	GWfUj9uvxKvA/sKRZ61hkcE/a/uKaNrhxziW6MDMvWg1wsoJaBvYjNJvqbgRrSJfYvvVd8
	t5nl+z8ly8rFcZ856f6rIVHJb64H91IhuO0r+HAfYj0qG7ueVxm4nw4VrrxxGkrm5Ynnfy
	b+IH6DxjFZo+wEXnCDO1+iOYNa617kShn1DVs9n6O+FWjn2eZd9Q1IyDV2MUgwcIi9ZUev
	afC2eYFcWx7PwZ/jZ7y0p6C6b42SpM7nlh90tzOUDhldmQd0lT98WCbqbypUdQ==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Mon, 23 Mar 2026 16:02:45 +0100
Subject: [PATCH 4/8] mfd: omap-usb-host: Sanitize error path in the probe()
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-omap4-fix-usb-support-v1-4-b668132124ac@bootlin.com>
References: <20260323-omap4-fix-usb-support-v1-0-b668132124ac@bootlin.com>
In-Reply-To: <20260323-omap4-fix-usb-support-v1-0-b668132124ac@bootlin.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

Use dev_err_probe() to simplify the code and standardize the error output.
Remove -ENOMEM messages, there's already enough output.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 drivers/mfd/omap-usb-host.c | 81 +++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 47 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 4e066a17cef0400edbfcb3012a16ceee06e52140..ac974285be341fa579ef198d1893b77af428b5f8 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -546,22 +546,17 @@ static int usbhs_omap_probe(struct platform_device *pdev)
 		dev->platform_data = pdata;
 	}
 
-	if (!pdata) {
-		dev_err(dev, "Missing platform data\n");
-		return -ENODEV;
-	}
+	if (!pdata)
+		return dev_err_probe(dev, -ENODEV, "Missing platform data\n");
 
-	if (pdata->nports > OMAP3_HS_USB_PORTS) {
-		dev_info(dev, "Too many num_ports <%d> in platform_data. Max %d\n",
-				pdata->nports, OMAP3_HS_USB_PORTS);
-		return -ENODEV;
-	}
+	if (pdata->nports > OMAP3_HS_USB_PORTS)
+		return dev_err_probe(dev, -ENODEV,
+				     "Too many num_ports <%d> in platform_data. Max %d\n",
+				     pdata->nports, OMAP3_HS_USB_PORTS);
 
 	omap = devm_kzalloc(dev, sizeof(*omap), GFP_KERNEL);
-	if (!omap) {
-		dev_err(dev, "Memory allocation failed\n");
+	if (!omap)
 		return -ENOMEM;
-	}
 
 	omap->uhh_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(omap->uhh_base))
@@ -614,7 +609,6 @@ static int usbhs_omap_probe(struct platform_device *pdev)
 	omap->hsic60m_clk = devm_kzalloc(dev, i, GFP_KERNEL);
 
 	if (!omap->utmi_clk || !omap->hsic480m_clk || !omap->hsic60m_clk) {
-		dev_err(dev, "Memory allocation failed\n");
 		ret = -ENOMEM;
 		goto err_mem;
 	}
@@ -648,9 +642,8 @@ static int usbhs_omap_probe(struct platform_device *pdev)
 			omap->ehci_logic_fck = devm_clk_get(dev,
 							    "usbhost_120m_fck");
 			if (IS_ERR(omap->ehci_logic_fck)) {
-				ret = PTR_ERR(omap->ehci_logic_fck);
-				dev_err(dev, "usbhost_120m_fck failed:%d\n",
-					ret);
+				ret = dev_err_probe(dev, PTR_ERR(omap->ehci_logic_fck),
+						    "usbhost_120m_fck failed\n");
 				goto err_mem;
 			}
 		}
@@ -660,36 +653,36 @@ static int usbhs_omap_probe(struct platform_device *pdev)
 	/* for OMAP4+ i.e. USBHS REV2+ */
 	omap->utmi_p1_gfclk = devm_clk_get(dev, "utmi_p1_gfclk");
 	if (IS_ERR(omap->utmi_p1_gfclk)) {
-		ret = PTR_ERR(omap->utmi_p1_gfclk);
-		dev_err(dev, "utmi_p1_gfclk failed error:%d\n", ret);
+		ret = dev_err_probe(dev, PTR_ERR(omap->utmi_p1_gfclk),
+				    "utmi_p1_gfclk failed error\n");
 		goto err_mem;
 	}
 
 	omap->utmi_p2_gfclk = devm_clk_get(dev, "utmi_p2_gfclk");
 	if (IS_ERR(omap->utmi_p2_gfclk)) {
-		ret = PTR_ERR(omap->utmi_p2_gfclk);
-		dev_err(dev, "utmi_p2_gfclk failed error:%d\n", ret);
+		ret = dev_err_probe(dev, PTR_ERR(omap->utmi_p2_gfclk),
+				    "utmi_p2_gfclk failed error\n");
 		goto err_mem;
 	}
 
 	omap->xclk60mhsp1_ck = devm_clk_get(dev, "refclk_60m_ext_p1");
 	if (IS_ERR(omap->xclk60mhsp1_ck)) {
-		ret = PTR_ERR(omap->xclk60mhsp1_ck);
-		dev_err(dev, "refclk_60m_ext_p1 failed error:%d\n", ret);
+		ret = dev_err_probe(dev, PTR_ERR(omap->xclk60mhsp1_ck),
+				    "refclk_60m_ext_p1 failed error\n");
 		goto err_mem;
 	}
 
 	omap->xclk60mhsp2_ck = devm_clk_get(dev, "refclk_60m_ext_p2");
 	if (IS_ERR(omap->xclk60mhsp2_ck)) {
-		ret = PTR_ERR(omap->xclk60mhsp2_ck);
-		dev_err(dev, "refclk_60m_ext_p2 failed error:%d\n", ret);
+		ret = dev_err_probe(dev, PTR_ERR(omap->xclk60mhsp2_ck),
+				    "refclk_60m_ext_p2 failed error\n");
 		goto err_mem;
 	}
 
 	omap->init_60m_fclk = devm_clk_get(dev, "refclk_60m_int");
 	if (IS_ERR(omap->init_60m_fclk)) {
-		ret = PTR_ERR(omap->init_60m_fclk);
-		dev_err(dev, "refclk_60m_int failed error:%d\n", ret);
+		ret = dev_err_probe(dev, PTR_ERR(omap->init_60m_fclk),
+				    "refclk_60m_int failed error\n");
 		goto err_mem;
 	}
 
@@ -706,9 +699,9 @@ static int usbhs_omap_probe(struct platform_device *pdev)
 		 */
 		omap->utmi_clk[i] = devm_clk_get(dev, clkname);
 		if (IS_ERR(omap->utmi_clk[i])) {
-			ret = PTR_ERR(omap->utmi_clk[i]);
-			dev_err(dev, "Failed to get clock : %s : %d\n",
-				clkname, ret);
+			ret = dev_err_probe(dev, PTR_ERR(omap->utmi_clk[i]),
+					    "Failed to get clock : %s\n",
+					    clkname);
 			goto err_mem;
 		}
 
@@ -716,9 +709,9 @@ static int usbhs_omap_probe(struct platform_device *pdev)
 				"usb_host_hs_hsic480m_p%d_clk", i + 1);
 		omap->hsic480m_clk[i] = devm_clk_get(dev, clkname);
 		if (IS_ERR(omap->hsic480m_clk[i])) {
-			ret = PTR_ERR(omap->hsic480m_clk[i]);
-			dev_err(dev, "Failed to get clock : %s : %d\n",
-				clkname, ret);
+			ret = dev_err_probe(dev, PTR_ERR(omap->hsic480m_clk[i]),
+					    "Failed to get clock : %s\n",
+					    clkname);
 			goto err_mem;
 		}
 
@@ -726,9 +719,9 @@ static int usbhs_omap_probe(struct platform_device *pdev)
 				"usb_host_hs_hsic60m_p%d_clk", i + 1);
 		omap->hsic60m_clk[i] = devm_clk_get(dev, clkname);
 		if (IS_ERR(omap->hsic60m_clk[i])) {
-			ret = PTR_ERR(omap->hsic60m_clk[i]);
-			dev_err(dev, "Failed to get clock : %s : %d\n",
-				clkname, ret);
+			ret = dev_err_probe(dev, PTR_ERR(omap->hsic60m_clk[i]),
+					    "Failed to get clock : %s\n",
+					    clkname);
 			goto err_mem;
 		}
 	}
@@ -737,16 +730,14 @@ static int usbhs_omap_probe(struct platform_device *pdev)
 		ret = clk_set_parent(omap->utmi_p1_gfclk,
 					omap->xclk60mhsp1_ck);
 		if (ret != 0) {
-			dev_err(dev, "xclk60mhsp1_ck set parent failed: %d\n",
-				ret);
+			dev_err_probe(dev, ret, "xclk60mhsp1_ck set parent failed\n");
 			goto err_mem;
 		}
 	} else if (is_ehci_tll_mode(pdata->port_mode[0])) {
 		ret = clk_set_parent(omap->utmi_p1_gfclk,
 					omap->init_60m_fclk);
 		if (ret != 0) {
-			dev_err(dev, "P0 init_60m_fclk set parent failed: %d\n",
-				ret);
+			dev_err_probe(dev, ret, "P0 init_60m_fclk set parent failed\n");
 			goto err_mem;
 		}
 	}
@@ -755,16 +746,14 @@ static int usbhs_omap_probe(struct platform_device *pdev)
 		ret = clk_set_parent(omap->utmi_p2_gfclk,
 					omap->xclk60mhsp2_ck);
 		if (ret != 0) {
-			dev_err(dev, "xclk60mhsp2_ck set parent failed: %d\n",
-				ret);
+			dev_err_probe(dev, ret, "xclk60mhsp2_ck set parent failed\n");
 			goto err_mem;
 		}
 	} else if (is_ehci_tll_mode(pdata->port_mode[1])) {
 		ret = clk_set_parent(omap->utmi_p2_gfclk,
 						omap->init_60m_fclk);
 		if (ret != 0) {
-			dev_err(dev, "P1 init_60m_fclk set parent failed: %d\n",
-				ret);
+			dev_err_probe(dev, ret, "P1 init_60m_fclk set parent failed\n");
 			goto err_mem;
 		}
 	}
@@ -775,17 +764,15 @@ static int usbhs_omap_probe(struct platform_device *pdev)
 	if (dev->of_node) {
 		ret = of_platform_populate(dev->of_node,
 				usbhs_child_match_table, NULL, dev);
-
 		if (ret) {
-			dev_err(dev, "Failed to create DT children: %d\n", ret);
+			dev_err_probe(dev, ret, "Failed to create DT children\n");
 			goto err_mem;
 		}
 
 	} else {
 		ret = omap_usbhs_alloc_children(pdev);
 		if (ret) {
-			dev_err(dev, "omap_usbhs_alloc_children failed: %d\n",
-						ret);
+			dev_err_probe(dev, ret, "omap_usbhs_alloc_children failed\n");
 			goto err_mem;
 		}
 	}

-- 
2.53.0

