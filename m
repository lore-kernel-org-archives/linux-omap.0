Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034863A0B38
	for <linux-omap@vger.kernel.org>; Sun, 18 Oct 2026 15:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792338864; cv=none; b=LbQ5iXGXn8oX+AHYyXeI55YTtgDP5deGaLHIsUf73PH6NOi3GHLcsWdHTgRbRqcgTTnYtfW+uHasixYfMvqgjOwqodefCRZ4K7f0PYWLv2tfwJRnBTuPv7ctpm67axPQwNK56/iUQkJVUAfH0fEVF/W/VKii33Eb93lf06qgzcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792338864; c=relaxed/simple;
	bh=SnlPRnWllIQVTXjmBHt0OAUIHaxSMpHeJ7Pe5+XFm/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e9txtU+HrYMZX5oCAkAiV0YX+Uy6JpTXlx0TiuFj9NxzOjq7qEXfOAJpx7Tmow1OkiD/5D6vJroG6IUsAA5azbBibkOtSFw5SlilmN7PTPrwSojsSqQUNn1iKioRIf95cMxqUH7USV4Gc6QOYP04SzUp/gYchwSb/E5SDn66IZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1PGebh6; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1PGebh6"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so17093325e9.0
        for <linux-omap@vger.kernel.org>; Sun, 18 Oct 2026 08:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792338859; x=1792943659; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b+1vYENA934EoybvaXO6mJGafGLHGKzpe67KBlcO0Gg=;
        b=S1PGebh6DyFurnDrv3UJdM63Cz3RnqhkcD+swmRYluvg/kIhjuPCWjxvU+vEnJnOdZ
         xIIMNsomsz2QZ7srP0uhH2ERUL1oEcBMIya2k9HWRV2Gi8zrMrJg0uPgdvE8WZPn79cg
         oirXrHRC7q3dDihdLE1Ut5b7MeslPOItvsBtNWSKtRoV8/x9vXY4fYZiQRJLJHm8GI9x
         AVyo61SabfZ/Q0x0TCvLfAv2i14gigdw27/gzfHNIoWm2evkSdQsi1U+hsjqt5/S8zaQ
         xPmxlG+AdTrFm1uoY3JwKgHctJ0hzROQbnL4LZo9+hWedBgFvoxA5QODKZGPnT/Gh3KB
         BZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792338859; x=1792943659;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b+1vYENA934EoybvaXO6mJGafGLHGKzpe67KBlcO0Gg=;
        b=u7jlE/jViLsyVhzVm6rK3T6PwD7HUA3JbTRfjyZGh4T0GkPhr2In6MfYJM2JxStnvN
         hhsuCoodAT71V/bgl3QE+MRj1+0+wBXIWwjlTJQaexUexvbteV0PqeUDFRVC1mNKe8Pn
         m9fN6utC3HLLI4ssMGSKAbRkWYBW4uhB4LY224zBAylHK8Dj10bE/j8ATZ8p4mXhAJue
         hqtzEaDj9IVgHE3UXcncpuPt46x5vPysQCPqxsFQq7RL6VK9B6+ljKBYwSO5unoPqIvf
         batIesezH7zxsgsCu8AXbgUH8UQu/OqAYHJ205NtfhY/ReTrMGYs57j2AOVJdCsIjEI/
         BflQ==
X-Forwarded-Encrypted: i=1; AKwUvBwwRp+aP2V2/VTvVbXIKNRX12hG71lvouQepSYq4qqlem+OuvM1QrN1RykgLSt/7X5Ybr6lVKOh9rSU@vger.kernel.org
X-Gm-Message-State: AFq9FYKizHt3HEcgpBbSuxQ+mP5ACnDRuvt0hUNQDJsgt+Dba2ALAnm2
	e8T4qQAGGq53IyZ9KugTsINKnOQOq+U7wt9WRWGZyIGtJxs4P7joKlav
X-Gm-Gg: AYBFou2nlaAIpBBMr1sFK/7khcmup4Lp6/7iuxBUnqfrcZy4xCOimlWDt7agOI1uyxY
	5nhEOhO9aH5Ao7GXy2S1/NRtIheoeWGyOFu5fbHvK7w13cSE53Iu0zB/71aP4eTlaTTueqIIxcv
	mQFEAHZ0ma0RfEYZMwzA7st0s90JvgsaFq8OLfPHAbeykqq/RRhmNyqNlvyaHTMsZpzd2S/HrQy
	sRZYxe4v+UbOlSfc5l5oComTy1cPqaMhF+j625Ny4YveMJzTA6JAKpKROHqYV0bKbsTmfpiW813
	IQ1PYAREKPY8yx39DuP7X50mkxqjXjdTMsQD4u2PuScpB5oX9Zu6plQd8rFi+QVZZ0unMxx7wtQ
	Uj7P3pUXPTWE4eUr1HaJXwY7Yh65qg7jjzgopJ/9FGWyKBUE4sCgU5w1rLNGQKNo26NujAp7l+y
	Gp/NvTXIGFwXJnJwWOJ7Wyo/25HZhBO6eWsmcc4IOZ9HX4Bri0XWe6nL8r8ux/368s/6U=
X-Received: by 2002:a05:600c:34cc:b0:4a1:dec1:4e1 with SMTP id 5b1f17b1804b1-4a1dec1097amr81156865e9.22.1792338858922;
        Sun, 18 Oct 2026 08:54:18 -0700 (PDT)
Received: from fedora ([2a02:4540:50c3:8cc5:3974:c325:365c:5580])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1cdf2f0d1sm121534115e9.2.2026.10.18.08.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 08:54:18 -0700 (PDT)
From: Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>
Subject: [PATCH v3] usb: ohci-omap: handle root hub overcurrent via GPIO
Date: Sun, 18 Oct 2026 19:23:24 +0330
Message-ID: <20261018155355.116290-1-ampr.mhd@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Implement proper overcurrent handling for the OMAP OHCI root hub using
the optional overcurrent GPIO line that was previously unused.

When an overcurrent condition is detected via GPIO interrupt, the driver
now disables VBUS power through the power GPIO, records the overcurrent
status, and reports it through the root hub port status callbacks so the
USB hub core can react appropriately.

The hub_control override also handles SetPortFeature/ClearPortFeature
for USB_PORT_FEAT_POWER to drive the VBUS power GPIO alongside the OHCI
hardware register, since on boards like the OMAP1 OSK the OHCI PPS bit
does not control the real power switch.

Signed-off-by: Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>
---
v3:
  - Fix power GPIO polarity: 1 = VBUS off, 0 = VBUS on
  - Fix wPortChange bit: shift USB_PORT_STAT_C_OVERCURRENT by 16
  - Add clock and PHY cleanup to probe error path
  - Use IRQF_NO_AUTOEN to close race window during probe
  - Only set overcurrent_changed at probe when overcurrent is active
  - Guard hub_status_data and hub_control behind priv->overcurrent
  - Handle SetPortFeature/ClearPortFeature(POWER) for VBUS GPIO
  - Remove shadowed flags variable in hub_control
  - Add comment documenting overcurrent_lock

v2:
  - Use real name in From: and Signed-off-by: lines
---
 drivers/usb/host/ohci-omap.c | 249 ++++++++++++++++++++++++++++++++---
 1 file changed, 228 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index f6e56c4b9914..a3ff50c70d41 100644
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
+	spinlock_t overcurrent_lock;	/* protects overcurrent_status and overcurrent_changed */
+	bool overcurrent_status;
+	bool overcurrent_changed;
+	int overcurrent_irq;
 };
 
 static const char hcd_name[] = "ohci-omap";
@@ -181,11 +189,148 @@ static int ohci_omap_reset(struct usb_hcd *hcd)
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
+		gpiod_set_value_cansleep(priv->power, 1);
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
+	if (!priv->overcurrent)
+		return length;
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
+	int ret;
+
+	/*
+	 * Drive the VBUS power GPIO alongside the OHCI hardware register.
+	 * On boards like the OSK, the OHCI PPS bit does not control the
+	 * real power switch — the GPIO does.
+	 */
+	if (priv->power && wIndex == 1) {
+		if (typeReq == SetPortFeature &&
+		    wValue == USB_PORT_FEAT_POWER) {
+			ret = ohci_hub_control(hcd, typeReq, wValue,
+					       wIndex, buf, wLength);
+			if (!ret) {
+				spin_lock_irqsave(&priv->overcurrent_lock,
+						  flags);
+				if (!priv->overcurrent_status)
+					gpiod_set_value_cansleep(priv->power,
+								 0);
+				spin_unlock_irqrestore(&priv->overcurrent_lock,
+						       flags);
+			}
+			return ret;
+		}
+		if (typeReq == ClearPortFeature &&
+		    wValue == USB_PORT_FEAT_POWER) {
+			ret = ohci_hub_control(hcd, typeReq, wValue,
+					       wIndex, buf, wLength);
+			if (!ret && priv->power)
+				gpiod_set_value_cansleep(priv->power, 1);
+			return ret;
+		}
+	}
+
+	ret = ohci_hub_control(hcd, typeReq, wValue, wIndex, buf, wLength);
+	if (ret)
+		return ret;
+
+	if (!priv->overcurrent)
+		return ret;
+
+	if (typeReq == ClearPortFeature && wIndex == 1 &&
+	    wValue == USB_PORT_FEAT_C_OVER_CURRENT) {
+		spin_lock_irqsave(&priv->overcurrent_lock, flags);
+		priv->overcurrent_changed = false;
+		spin_unlock_irqrestore(&priv->overcurrent_lock, flags);
+		return 0;
+	}
+
+	if (typeReq != GetPortStatus || wIndex != 1)
+		return ret;
+
+	{
+		bool status, changed;
+		__le32 *portstatus;
+		u32 value;
+
+		spin_lock_irqsave(&priv->overcurrent_lock, flags);
+		status = priv->overcurrent_status;
+		changed = priv->overcurrent_changed;
+		spin_unlock_irqrestore(&priv->overcurrent_lock, flags);
+
+		portstatus = (__le32 *)buf;
+		value = le32_to_cpu(*portstatus);
+
+		if (status)
+			value |= USB_PORT_STAT_OVERCURRENT;
+		else
+			value &= ~USB_PORT_STAT_OVERCURRENT;
+
+		if (changed)
+			value |= (USB_PORT_STAT_C_OVERCURRENT << 16);
+		else
+			value &= ~(USB_PORT_STAT_C_OVERCURRENT << 16);
+
+		*portstatus = cpu_to_le32(value);
+	}
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
@@ -196,50 +341,53 @@ static int ohci_omap_reset(struct usb_hcd *hcd)
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
 
@@ -277,23 +425,76 @@ static int ohci_hcd_omap_probe(struct platform_device *pdev)
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
+					      IRQF_ONESHOT | IRQF_NO_AUTOEN |
+					      IRQF_TRIGGER_RISING |
+					      IRQF_TRIGGER_FALLING,
+					      "ohci-omap-overcurrent", hcd);
+		if (retval) {
+			priv->overcurrent_irq = -1;
+			goto err_remove_hcd;
+		}
+
+		status = gpiod_get_value_cansleep(priv->overcurrent);
+		if (status < 0) {
+			retval = status;
+			goto err_remove_hcd;
+		}
+
+		spin_lock_irqsave(&priv->overcurrent_lock, flags);
+		priv->overcurrent_status = !!status;
+		priv->overcurrent_changed = !!status;
+		spin_unlock_irqrestore(&priv->overcurrent_lock, flags);
+
+		if (status && priv->power)
+			gpiod_set_value_cansleep(priv->power, 1);
+
+		enable_irq(priv->overcurrent_irq);
+		if (status)
+			usb_hcd_poll_rh_status(hcd);
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
+	omap_ohci_clock_power(priv, 0);
+	if (!IS_ERR_OR_NULL(hcd->usb_phy)) {
+		(void)otg_set_host(hcd->usb_phy->otg, NULL);
+		usb_put_phy(hcd->usb_phy);
+	}
+err_iounmap:
 	iounmap(hcd->regs);
-err2:
+err_release_mem:
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
 err_unprepare_dc_ck:
 	clk_unprepare(priv->usb_dc_ck);
@@ -327,6 +528,10 @@ static void ohci_hcd_omap_remove(struct platform_device *pdev)
 	struct ohci_omap_priv *priv = hcd_to_ohci_omap_priv(hcd);
 
 	dev_dbg(hcd->self.controller, "stopping USB Controller\n");
+	if (priv->overcurrent_irq >= 0) {
+		free_irq(priv->overcurrent_irq, hcd);
+		priv->overcurrent_irq = -1;
+	}
 	usb_remove_hcd(hcd);
 	omap_ohci_clock_power(priv, 0);
 	if (!IS_ERR_OR_NULL(hcd->usb_phy)) {
@@ -413,6 +618,8 @@ static int __init ohci_omap_init(void)
 		return -ENODEV;
 
 	ohci_init_driver(&ohci_omap_hc_driver, &omap_overrides);
+	ohci_omap_hc_driver.hub_status_data = ohci_omap_hub_status_data;
+	ohci_omap_hc_driver.hub_control = ohci_omap_hub_control;
 	return platform_driver_register(&ohci_hcd_omap_driver);
 }
 module_init(ohci_omap_init);
-- 
2.55.0

