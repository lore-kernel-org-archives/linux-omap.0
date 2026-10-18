Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000F23B9956
	for <linux-omap@vger.kernel.org>; Sun, 18 Oct 2026 11:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792321894; cv=none; b=OtlrCiNnbHS18mb1ZMtr3zv0IT41ohDbh38OYYw5T4Ik2ckjVGAfmhOsa9cJEUXCBfrSi7JJFxs6XEQTdQqU69MiTdY1Mm+Dy2Y2lXOW86oYk3ctvuXp417v6CdZkNMDsVE3ekUm4eSJxFPHSb3L+6+RQU+WbZ/mnO/ssBCb7ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792321894; c=relaxed/simple;
	bh=7My8JmNvnhBR3H4hP1APkhv+P/R/t75wo6tfVjATvy8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qcrx2vWqyFWVgLtcaYd6f+swiPfOXqAXEKErB363PnFD+7cADvYrzGlALnAYMuyz34LjNZf1emWN335xVXEIF9V6fyjKSv8DDwq8D9mdYNRQ1KJIJonNar/xOZlz/R+N6MypAC4c6QobpIN+Pw2lrYlfFEZWucizBgLW+PUKpLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=okPgIrOx; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="okPgIrOx"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso602428f8f.1
        for <linux-omap@vger.kernel.org>; Sun, 18 Oct 2026 04:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792321891; x=1792926691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vgkxqhTApoOBhs/mRrfpjGowBj0GWwdL18OZhQTvCnI=;
        b=okPgIrOxKos/sNXwaqFsaU+n1Z/Cj7RteI3TJ5Q8mR21W6sAGQ+Bck/oZhNfvtV8xB
         TlllE+T2969gz9g2GSYSFCVVjPf9n2AcLYZr2xpNXYQRgZcHX24Q2k9VnAg7HnQR4p/h
         G4pwwKVQ/BsN+tRsImCzQhVQk8rPch3LpSbCQYegF/GPHrywbjrApxVZRKsmDvlGUQ9P
         T+nrQ/lAn+iVIn5tr5e6v1XmMHHbi55d00Ke/XU4Z2snEMMCopFBLdS65U1DdUS451OX
         vMsNwnKPW6OhuFt6zzcWsihT8gan7Mt4qk6fQM2+muuEwqDyetcf9C6mwYSoB7iNWCts
         2Q9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792321891; x=1792926691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vgkxqhTApoOBhs/mRrfpjGowBj0GWwdL18OZhQTvCnI=;
        b=gnxM9g3FZTNG7aebdWvajzuwtXJ4JfbdWepajKr6iereZPl0F1VF10WLSVhScGlgm4
         BQTn+OlPfz7ua3MeHSwZpacQZgN8Rzk6UImo4nzKTb7R+EdhJILQofZXb90gTh8KSkyu
         0D6A1gsFV3YjYRuQQt98pyaDp7hta2B7ctO8zR7swmcfh+cm4/iR6+j1T6Me2i5JE2n7
         Wwx0RalTyqrw8+s/+obqQ+cDfjDms7T3Z2XhobFDKXp/XkZDg5ElWXCdTL80h8uxBbP9
         gh3MEyVqHk9sLVQ5wLhCso7HLvM/48RRaJ5JAeDIhCBF1giotVCq9XG7LYTQxnoG2GbJ
         9CbA==
X-Forwarded-Encrypted: i=1; AKwUvBz0mrFnrUt/FZh3UEleVhFvas341sIWWaBvuSeINFr136Rh+CLPoSEQPn9GhiKc7gS500Wbxvoz48b7@vger.kernel.org
X-Gm-Message-State: AFq9FYJXoOY0BVbFhBr9qtcBf0CPRccc9uUPX/nZyfBRjpiRq/o0AXlJ
	io7UDXOzGNWBt4vMLbdZYlXBDIAzjMtrw8Z/kXjPp4/ZUBG5BWo57Bge
X-Gm-Gg: AYBFou0WsrsGXPTjzQTG6pc2dQ5Mu9Xu4b/Ng6s80VzItzLohyDVsjiKzxDrvIK8YN5
	R1M9GaismkJ89F45AJlA10mnlNynOUKo1lBKnCehvQt8To3zIGkhFc+Oycit6aFBoevgbW2XlRC
	zWA379IRgA+v1oMpJMZBp59/Urv8gOLlWCCYW4j4U56TwUCGYDlh7S0dftbXd1gM14+LMbzUgII
	5LPQg+sJU8Lu2AYLde/r6hSOua/5ydLCyEgogzufOTf3IzC381DJGHgd0xKvOIWb0IUoXtAkswC
	o8yth2NWEEwwB9IbyiFM0HKwPHlbkYNG+3vMt2Kx9pLvDswp5jAsM1k/gqECbzuhF3v+CGHBRfH
	wPkOKJefWkjlUFP2sxRhBwgBHANeilSp8ec1kh5o04CfSRzRt0AtiYb6LIXeBSzFJi8+93FFZ1Q
	VWqmVTYbZPuXs1S1MLv9p37Iy49oS2WRHU7vd6X591xQBW6DsCfK+8mMKSs0YtLYq5l9aMUDCel
	FjcEtM=
X-Received: by 2002:a05:600c:6749:b0:4a1:e51d:9244 with SMTP id 5b1f17b1804b1-4a1e51d93f4mr16785525e9.25.1792321890988;
        Sun, 18 Oct 2026 04:11:30 -0700 (PDT)
Received: from fedora.domain.name ([217.218.152.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f5177sm15928100f8f.30.2026.10.18.04.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 04:11:30 -0700 (PDT)
From: Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>
To: stern@rowland.harvard.edu
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>
Subject: [PATCH v2] usb: ohci-omap: handle root hub overcurrent
Date: Sun, 18 Oct 2026 14:41:24 +0330
Message-ID: <20261018111124.32979-1-ampr.mhd@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261018015747.246611-1-ampr.mhd@gmail.com>
References: <20261018015747.246611-1-ampr.mhd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle overcurrent GPIO interrupts, disable port power when
overcurrent is detected, and report the status through the
root hub port status.

Signed-off-by: Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>
---
 drivers/usb/host/ohci-omap.c | 212 +++++++++++++++++++++++++++++++----
 1 file changed, 191 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index f6e56c4b9914..2a08147dc5fa 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -15,6 +15,7 @@
  * This file is licenced under the GPL.
  */
 
+#include <linux/irqreturn.h>
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
@@ -33,6 +34,9 @@
 #include <linux/signal.h>
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+#include <linux/usb/ch11.h>
 
 #include "ohci.h"
 
@@ -46,6 +50,10 @@ struct ohci_omap_priv {
 	struct clk *usb_dc_ck;
 	struct gpio_desc *power;
 	struct gpio_desc *overcurrent;
+	spinlock_t overcurrent_lock;
+	bool overcurrent_status;
+	bool overcurrent_changed;
+	int overcurrent_irq;
 };
 
 static const char hcd_name[] = "ohci-omap";
@@ -181,11 +189,110 @@ static int ohci_omap_reset(struct usb_hcd *hcd)
 	return 0;
 }
 
+static irqreturn_t ohci_omap_overcurrent_irq(int irq, void *data)
+{
+	struct usb_hcd *hcd = data;
+	struct ohci_omap_priv *priv = hcd_to_ohci_omap_priv(hcd);
+	unsigned long flags;
+	int status;
+
+	status = gpiod_get_value_cansleep(priv->overcurrent);
+	if (status < 0)
+		return IRQ_HANDLED;
+
+	if (status && priv->power)
+		gpiod_set_value_cansleep(priv->power, 0);
+
+	spin_lock_irqsave(&priv->overcurrent_lock, flags);
+	if (!!status != priv->overcurrent_status)
+		priv->overcurrent_changed = true;
+	priv->overcurrent_status = !!status;
+	spin_unlock_irqrestore(&priv->overcurrent_lock, flags);
+
+	usb_hcd_poll_rh_status(hcd);
+
+	return IRQ_HANDLED;
+}
+
+static int ohci_omap_hub_status_data(struct usb_hcd *hcd, char *buf)
+{
+	struct ohci_omap_priv *priv = hcd_to_ohci_omap_priv(hcd);
+	unsigned long flags;
+	bool changed;
+	int length;
+
+	length = ohci_hub_status_data(hcd, buf);
+
+	spin_lock_irqsave(&priv->overcurrent_lock, flags);
+	changed = priv->overcurrent_changed;
+	spin_unlock_irqrestore(&priv->overcurrent_lock, flags);
+
+	if (changed) {
+		if (!length) {
+			buf[0] = 0;
+			length = 1;
+		}
+		buf[0] |= BIT(1);
+	}
+
+	return length;
+}
+
+static int ohci_omap_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
+				 u16 wIndex, char *buf, u16 wLength)
+{
+	struct ohci_omap_priv *priv = hcd_to_ohci_omap_priv(hcd);
+	unsigned long flags;
+	bool status, changed;
+	__le32 *portstatus;
+	u32 value;
+	int ret;
+
+	ret = ohci_hub_control(hcd, typeReq, wValue, wIndex, buf, wLength);
+	if (ret)
+		return ret;
+
+	if (typeReq == ClearPortFeature && wIndex == 1 &&
+	    wValue == USB_PORT_FEAT_C_OVER_CURRENT) {
+		unsigned long flags;
+
+		spin_lock_irqsave(&priv->overcurrent_lock, flags);
+		priv->overcurrent_changed = false;
+		spin_unlock_irqrestore(&priv->overcurrent_lock, flags);
+		return 0;
+	}
+
+	if (typeReq != GetPortStatus || wIndex != 1)
+		return ret;
+
+	spin_lock_irqsave(&priv->overcurrent_lock, flags);
+	status = priv->overcurrent_status;
+	changed = priv->overcurrent_changed;
+	spin_unlock_irqrestore(&priv->overcurrent_lock, flags);
+
+	portstatus = (__le32 *)buf;
+	value = le32_to_cpu(*portstatus);
+
+	if (status)
+		value |= USB_PORT_STAT_OVERCURRENT;
+	else
+		value &= ~USB_PORT_STAT_OVERCURRENT;
+
+	if (changed)
+		value |= USB_PORT_STAT_C_OVERCURRENT;
+	else
+		value &= ~USB_PORT_STAT_C_OVERCURRENT;
+
+	*portstatus = cpu_to_le32(value);
+
+	return 0;
+}
+
 /*-------------------------------------------------------------------------*/
 
 /**
  * ohci_hcd_omap_probe - initialize OMAP-based HCDs
- * @pdev:	USB controller to probe
+ * @pdev: USB controller to probe
  *
  * Context: task context, might sleep
  *
@@ -196,50 +303,53 @@ static int ohci_omap_reset(struct usb_hcd *hcd)
 static int ohci_hcd_omap_probe(struct platform_device *pdev)
 {
 	int retval, irq;
-	struct usb_hcd *hcd = 0;
+	struct usb_hcd *hcd;
 	struct ohci_omap_priv *priv;
 
 	if (pdev->num_resources != 2) {
 		dev_err(&pdev->dev, "invalid num_resources: %i\n",
-		       pdev->num_resources);
+			pdev->num_resources);
 		return -ENODEV;
 	}
 
-	if (pdev->resource[0].flags != IORESOURCE_MEM
-			|| pdev->resource[1].flags != IORESOURCE_IRQ) {
+	if (pdev->resource[0].flags != IORESOURCE_MEM ||
+	    pdev->resource[1].flags != IORESOURCE_IRQ) {
 		dev_err(&pdev->dev, "invalid resource type\n");
 		return -ENODEV;
 	}
 
 	hcd = usb_create_hcd(&ohci_omap_hc_driver, &pdev->dev,
-			dev_name(&pdev->dev));
+			     dev_name(&pdev->dev));
 	if (!hcd)
 		return -ENOMEM;
 
 	hcd->rsrc_start = pdev->resource[0].start;
-	hcd->rsrc_len = pdev->resource[0].end - pdev->resource[0].start + 1;
+	hcd->rsrc_len = pdev->resource[0].end -
+			pdev->resource[0].start + 1;
 	priv = hcd_to_ohci_omap_priv(hcd);
 
-	/* Obtain two optional GPIO lines */
-	priv->power = devm_gpiod_get_optional(&pdev->dev, "power", GPIOD_ASIS);
+	spin_lock_init(&priv->overcurrent_lock);
+	priv->overcurrent_status = false;
+	priv->overcurrent_changed = false;
+	priv->overcurrent_irq = -1;
+
+	priv->power = devm_gpiod_get_optional(&pdev->dev, "power",
+					      GPIOD_ASIS);
 	if (IS_ERR(priv->power)) {
 		retval = PTR_ERR(priv->power);
 		goto err_put_hcd;
 	}
+
 	if (priv->power)
 		gpiod_set_consumer_name(priv->power, "OHCI power");
 
-	/*
-	 * This "overcurrent" GPIO line isn't really used in the code,
-	 * but has a designated hardware function.
-	 * TODO: implement proper overcurrent handling.
-	 */
-	priv->overcurrent = devm_gpiod_get_optional(&pdev->dev, "overcurrent",
-						    GPIOD_IN);
+	priv->overcurrent = devm_gpiod_get_optional(&pdev->dev,
+						    "overcurrent", GPIOD_IN);
 	if (IS_ERR(priv->overcurrent)) {
 		retval = PTR_ERR(priv->overcurrent);
 		goto err_put_hcd;
 	}
+
 	if (priv->overcurrent)
 		gpiod_set_consumer_name(priv->overcurrent, "OHCI overcurrent");
 
@@ -277,23 +387,77 @@ static int ohci_hcd_omap_probe(struct platform_device *pdev)
 	if (!hcd->regs) {
 		dev_err(&pdev->dev, "can't ioremap OHCI HCD\n");
 		retval = -ENOMEM;
-		goto err2;
+		goto err_release_mem;
 	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		retval = irq;
-		goto err3;
+		goto err_iounmap;
 	}
+
 	retval = usb_add_hcd(hcd, irq, 0);
 	if (retval)
-		goto err3;
+		goto err_iounmap;
+
+	if (priv->overcurrent) {
+		int status;
+		unsigned long flags;
+
+		priv->overcurrent_irq = gpiod_to_irq(priv->overcurrent);
+		if (priv->overcurrent_irq < 0) {
+			retval = priv->overcurrent_irq;
+			goto err_remove_hcd;
+		}
+
+		retval = request_threaded_irq(priv->overcurrent_irq, NULL,
+					      ohci_omap_overcurrent_irq,
+					      IRQF_ONESHOT |
+					      IRQF_TRIGGER_RISING |
+					      IRQF_TRIGGER_FALLING,
+					      "ohci-omap-overcurrent", hcd);
+		if (retval) {
+			priv->overcurrent_irq = -1;
+			goto err_remove_hcd;
+		}
+
+		/*
+		 * Synchronize the initial GPIO sample with the threaded
+		 * handler so it cannot overwrite the sampled state.
+		 */
+		disable_irq(priv->overcurrent_irq);
+
+		status = gpiod_get_value_cansleep(priv->overcurrent);
+		if (status < 0) {
+			retval = status;
+			enable_irq(priv->overcurrent_irq);
+			goto err_remove_hcd;
+		}
+
+		spin_lock_irqsave(&priv->overcurrent_lock, flags);
+		priv->overcurrent_status = !!status;
+		priv->overcurrent_changed = true;
+		spin_unlock_irqrestore(&priv->overcurrent_lock, flags);
+
+		if (status && priv->power)
+			gpiod_set_value_cansleep(priv->power, 0);
+
+		enable_irq(priv->overcurrent_irq);
+		usb_hcd_poll_rh_status(hcd);
+	}
 
 	device_wakeup_enable(hcd->self.controller);
 	return 0;
-err3:
+
+err_remove_hcd:
+	if (priv->overcurrent_irq >= 0) {
+		free_irq(priv->overcurrent_irq, hcd);
+		priv->overcurrent_irq = -1;
+	}
+	usb_remove_hcd(hcd);
+err_iounmap:
 	iounmap(hcd->regs);
-err2:
+err_release_mem:
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
 err_unprepare_dc_ck:
 	clk_unprepare(priv->usb_dc_ck);
@@ -327,6 +491,10 @@ static void ohci_hcd_omap_remove(struct platform_device *pdev)
 	struct ohci_omap_priv *priv = hcd_to_ohci_omap_priv(hcd);
 
 	dev_dbg(hcd->self.controller, "stopping USB Controller\n");
+	if (priv->overcurrent_irq >= 0) {
+		free_irq(priv->overcurrent_irq, hcd);
+		priv->overcurrent_irq = -1;
+	}
 	usb_remove_hcd(hcd);
 	omap_ohci_clock_power(priv, 0);
 	if (!IS_ERR_OR_NULL(hcd->usb_phy)) {
@@ -413,6 +581,8 @@ static int __init ohci_omap_init(void)
 		return -ENODEV;
 
 	ohci_init_driver(&ohci_omap_hc_driver, &omap_overrides);
+	ohci_omap_hc_driver.hub_status_data = ohci_omap_hub_status_data;
+	ohci_omap_hc_driver.hub_control = ohci_omap_hub_control;
 	return platform_driver_register(&ohci_hcd_omap_driver);
 }
 module_init(ohci_omap_init);
-- 
2.55.0

