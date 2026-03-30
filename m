Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5601B3D75AF;
	Mon, 30 Mar 2026 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774878270; cv=none; b=bPoWbnG6B7R6nWq6iSNFLusoT0UJoxzuws+GHwkzLWDMjhS5ULyDm4/M3c1dDy6BE8eVdRdZ9VHPplU3CsJwOJK3lMSUztc+eQ562DTYsiodJa99+hLpD7L13iGf26V5wiSOv5DKCDFIdKtrhYBdXRWn+cndCmX1dkNQ4G1UCvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774878270; c=relaxed/simple;
	bh=+38KUZ/Rs7dbW6HrwRQzInMhtrAK0L0P+qLf5Syq1F8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BQyW2j17Lr/WotSYHlkBByaaooI2G2bvheUV2roUHHftVQlV8vP8otqr12TV4Pvg1lWTdPLmC6GMaqD+BE65NAuS6e+5cRAke4yJlf0MBFXSzsuUGKwlqIQR5tKDi+aIZfwoi8ndFGPNwqzfuMNlhmgeOnuFjzpbIk8E6/rBQMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=yaD15mcC; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="yaD15mcC"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 154BA1A308C;
	Mon, 30 Mar 2026 13:44:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D902F5FFA8;
	Mon, 30 Mar 2026 13:44:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6F868104505C9;
	Mon, 30 Mar 2026 15:44:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774878266; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Ezp+PRZ6T3jPeC3HkeP1u9t98A2F7H08ZdBPtkGsQ+c=;
	b=yaD15mcCwqvpt0Y+s7mMyhVNqm7J8ejZLPZmdsbJCE5MH+dhUjGTviuEGrICjpAInpRbyJ
	ZapT8VHpdp7HePeE1tTKwJ7amWfvczVxBIV3s7cZk38UA8hFOqHzfcxgRDMC5aYNBtvAeg
	slrem3AJ1mza6Oiedu8w/2eMv3pjVnT3i6NLrY+8STk0qGiBCpFIdf0ehA5BnusZU4HHnC
	E0/XNr1FR5RMsUxfuDICqS5q3swzJIcbdco/h6+WYGoR6k9G3Z674GMAdTPU46IGbdelwk
	mb99mPhXge4YYngjKM+tIKNElAG2BHNud6AQRns72Sei9qDulMwBMYD+sFwfFg==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Mon, 30 Mar 2026 15:44:03 +0200
Subject: [PATCH v2 06/11] mfd: omap-usb-host: Sanitize error path in the
 probe()
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-omap4-fix-usb-support-v2-6-1c1e11b190dc@bootlin.com>
References: <20260330-omap4-fix-usb-support-v2-0-1c1e11b190dc@bootlin.com>
In-Reply-To: <20260330-omap4-fix-usb-support-v2-0-1c1e11b190dc@bootlin.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Thomas Richard <thomas.richard@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Use dev_err_probe() to simplify the code and standardize the error output.
Remove -ENOMEM messages, there's already enough output.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 drivers/mfd/omap-usb-host.c | 81 +++++++++++++++++++--------------------------
 1 file changed, 34 insertions(+), 47 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 4e066a17cef0..ac974285be34 100644
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

