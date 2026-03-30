Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CCD3D811E
	for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 13:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774878272; cv=none; b=nYnm+XoEcK0yX3IZOa4QguSf3khPCmqdtZYJEscWCYgVM4T9mBLPSUDj9PEFEiaOW6siKQnwTvnYgHN67HwCb8F+6DIr1c3xUNLKbMk7lgahafBZj4o2oy5j/i7J9os/jRL5A0NejrdnPObceFRWRebQDHlYZBHOSSZQTUtQ7VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774878272; c=relaxed/simple;
	bh=U5bM6M1XI0Rz0zyCn/ENxbb7spjHQrV2vP4E19ZOZO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qEKxAwjqN541Hfeeb22BEePp++Rzj22pATjBDQg1eIUkws/vUh+IrgLIyG4B5KZQwmGfka/q8Gy+6cR2ljljWwlFDjtJ6P+L+6h1eh6AWwqJPF0WgiHyydyYEfhZ34WNojy+DS2S3yj2G9Jc0mSgl+mtKU9E/d/au7Emf8++NW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NPx0PXi9; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NPx0PXi9"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0DC691A3037;
	Mon, 30 Mar 2026 13:44:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D813A5FFA8;
	Mon, 30 Mar 2026 13:44:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2A081104505E1;
	Mon, 30 Mar 2026 15:44:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774878268; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Z9FZkXOZh4Zt1eTlRx67xH+sax/21doUxwEjY+KEWdo=;
	b=NPx0PXi9S0wfE8+2kIEQZaZIK/wc3jjO/uQauLNYrDY1gDOSveYdBrvsDvt6on2m9OqDFd
	kpZ2f5CWDy6ZZIbHcSlM2wKyB4mRhGndV0x00tGct7Z71/nDPTaMbz5Tth2koCJCU6d9A/
	BeNGEGNkfeUKFrEPQMpTEVD83DPt0EIsO1JXhPctKvlarnE6xBy4GBxpR1OItb8E7yjUez
	SjEOwoemZN9zueRRlYedQ7wVl6h7UJUhRUEfvTBZD0SLgBRR6t1qFTuKiqAKGF78rYQNQD
	4LMVoDw+ax1eytODKjqAlZ3Pego7F0+pzDu6PYYXUlEM94yIJRTvtitJbObwHA==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Mon, 30 Mar 2026 15:44:04 +0200
Subject: [PATCH v2 07/11] mfd: omap-usb-host: Refactor suspend and resume
 callbacks
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-omap4-fix-usb-support-v2-7-1c1e11b190dc@bootlin.com>
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

The clock handling logic in suspend and resume callbacks is very similar.
Create a new usbhs_clocks_enable() function to avoid code duplication.
Also remove ftrace-like debug messages.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 drivers/mfd/omap-usb-host.c | 94 ++++++++++++++++++++++-----------------------
 1 file changed, 46 insertions(+), 48 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index ac974285be34..17a54f0087c3 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -270,48 +270,56 @@ static bool is_ohci_port(enum usbhs_omap_port_mode pmode)
 	}
 }
 
-static int usbhs_runtime_resume(struct device *dev)
+static int usbhs_clocks_enable(struct device *dev, bool enable)
 {
-	struct usbhs_hcd_omap		*omap = dev_get_drvdata(dev);
-	struct usbhs_omap_platform_data	*pdata = omap->pdata;
-	int i, r;
-
-	dev_dbg(dev, "usbhs_runtime_resume\n");
+	struct usbhs_hcd_omap *omap = dev_get_drvdata(dev);
+	struct usbhs_omap_platform_data *pdata = omap->pdata;
+	int r = 0, i;
 
-	omap_tll_enable(pdata);
-
-	if (!IS_ERR(omap->ehci_logic_fck))
-		clk_prepare_enable(omap->ehci_logic_fck);
+	if (!enable && !IS_ERR(omap->ehci_logic_fck))
+		clk_disable_unprepare(omap->ehci_logic_fck);
 
 	for (i = 0; i < omap->nports; i++) {
 		switch (pdata->port_mode[i]) {
 		case OMAP_EHCI_PORT_MODE_HSIC:
 			if (!IS_ERR(omap->hsic60m_clk[i])) {
-				r = clk_prepare_enable(omap->hsic60m_clk[i]);
-				if (r) {
-					dev_err(dev,
-					 "Can't enable port %d hsic60m clk:%d\n",
-					 i, r);
+				if (enable) {
+					r = clk_prepare_enable(omap->hsic60m_clk[i]);
+					if (r) {
+						dev_err(dev,
+							"Can't enable port %d hsic60m clk:%d\n",
+							i, r);
+					}
+				} else {
+					clk_disable_unprepare(omap->hsic60m_clk[i]);
 				}
 			}
 
 			if (!IS_ERR(omap->hsic480m_clk[i])) {
-				r = clk_prepare_enable(omap->hsic480m_clk[i]);
-				if (r) {
-					dev_err(dev,
-					 "Can't enable port %d hsic480m clk:%d\n",
-					 i, r);
+				if (enable) {
+					r = clk_prepare_enable(omap->hsic480m_clk[i]);
+					if (r) {
+						dev_err(dev,
+							"Can't enable port %d hsic480m clk:%d\n",
+							i, r);
+					}
+				} else {
+					clk_disable_unprepare(omap->hsic480m_clk[i]);
 				}
 			}
 			fallthrough;	/* as HSIC mode needs utmi_clk */
 
 		case OMAP_EHCI_PORT_MODE_TLL:
 			if (!IS_ERR(omap->utmi_clk[i])) {
-				r = clk_prepare_enable(omap->utmi_clk[i]);
-				if (r) {
-					dev_err(dev,
-					 "Can't enable port %d clk : %d\n",
-					 i, r);
+				if (enable) {
+					r = clk_prepare_enable(omap->utmi_clk[i]);
+					if (r) {
+						dev_err(dev,
+							"Can't enable port %d clk : %d\n",
+							i, r);
+					}
+				} else {
+					clk_disable_unprepare(omap->utmi_clk[i]);
 				}
 			}
 			break;
@@ -320,38 +328,28 @@ static int usbhs_runtime_resume(struct device *dev)
 		}
 	}
 
-	return 0;
+	if (enable && !IS_ERR(omap->ehci_logic_fck))
+		r = clk_prepare_enable(omap->ehci_logic_fck);
+
+	return r;
 }
 
-static int usbhs_runtime_suspend(struct device *dev)
+static int usbhs_runtime_resume(struct device *dev)
 {
 	struct usbhs_hcd_omap		*omap = dev_get_drvdata(dev);
 	struct usbhs_omap_platform_data	*pdata = omap->pdata;
-	int i;
 
-	dev_dbg(dev, "usbhs_runtime_suspend\n");
-
-	for (i = 0; i < omap->nports; i++) {
-		switch (pdata->port_mode[i]) {
-		case OMAP_EHCI_PORT_MODE_HSIC:
-			if (!IS_ERR(omap->hsic60m_clk[i]))
-				clk_disable_unprepare(omap->hsic60m_clk[i]);
+	omap_tll_enable(pdata);
 
-			if (!IS_ERR(omap->hsic480m_clk[i]))
-				clk_disable_unprepare(omap->hsic480m_clk[i]);
-			fallthrough;	/* as utmi_clks were used in HSIC mode */
+	return usbhs_clocks_enable(dev, true);
+}
 
-		case OMAP_EHCI_PORT_MODE_TLL:
-			if (!IS_ERR(omap->utmi_clk[i]))
-				clk_disable_unprepare(omap->utmi_clk[i]);
-			break;
-		default:
-			break;
-		}
-	}
+static int usbhs_runtime_suspend(struct device *dev)
+{
+	struct usbhs_hcd_omap		*omap = dev_get_drvdata(dev);
+	struct usbhs_omap_platform_data	*pdata = omap->pdata;
 
-	if (!IS_ERR(omap->ehci_logic_fck))
-		clk_disable_unprepare(omap->ehci_logic_fck);
+	usbhs_clocks_enable(dev, false);
 
 	omap_tll_disable(pdata);
 

-- 
2.53.0

