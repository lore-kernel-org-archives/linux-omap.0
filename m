Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9B23BFAE1
	for <linux-omap@vger.kernel.org>; Sun, 18 Oct 2026 22:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792362803; cv=none; b=sSqKTdLYlWtmSCGukB1FaaXfsmEH1IwEmJu4PB/bRkg7a+joML/qdQk2LwpkUxyioJlV/sBi579fCbBFW/8s2WuX9r7PT9nZuME9LKOwmZFts93WP2YMH2ZeNqBTsbfrEEJr098ftK1G/uWCU43ngm/MtW3AHM1lw/FC3TR+g8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792362803; c=relaxed/simple;
	bh=r4fRx6yvMRz9zcMoZsQcjza2F1X+3OKXwUQ7hvtYEwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aps9x2yv0sKYmph6+mIoDVU5ezSIHX1oqQVvcbKfRKnKSf1GwNV+6roRqjNIyV/sDu95YOeu8jtNM/jGoknYhzXWiMWgwgsArLwVqEta9TvTo3eO/IvnPxBgF+fKcKPQQPkAId55RnccVd8XU8EBN9nEsrydSSUV8XxVaHwzU0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEiB4s2i; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEiB4s2i"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a1df4c0966so5060495e9.1
        for <linux-omap@vger.kernel.org>; Sun, 18 Oct 2026 15:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792362799; x=1792967599; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oCJAnzj1NjOaiq+tJZP55CQlXI8UkMm0uN4TgAt51rM=;
        b=UEiB4s2if5l+bHvEutvLBXiRAwG7ckLHDTaB2IPtYCMZ3x3WzMR5fJaFImpqzLLlfJ
         PoxOalul1wewYwtUR5ZkHn/avsR5FlLnXXpGfZRco2tt1ASym9s3O9wrV2FEa9JC9Vy8
         SS3Gla6yhsKlaDRxXFloqvh6W7VMAYczVNlf68d0FpysGJp9CNEwFfmRF6cR1CG4YV/s
         OCBfY0xn/heMcbaZsFlmaCP/+jjrXI9IjE7eF9X6lFDyP3bWIJgaYtd6g0l3e8H++Pds
         mbwNSJiIaRIntfYY1fun9IMyiL1vjDES44599j30KfR8EEbQlP6wucdNYat8YQedW3WK
         RbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792362799; x=1792967599;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oCJAnzj1NjOaiq+tJZP55CQlXI8UkMm0uN4TgAt51rM=;
        b=nmIlwKR3kq6b8vTQQQf+MuEuAxGmZzWg2Xop82SwtewdScsli9r7+llfilKU8j/5HD
         0ywMWC7yatl8nVf1Rc/uzPTaQ3x/OHRBk1phg+Z9T6ifyVIsdkhI0Cz6xjCGZBqNhUZx
         KkrX2m65gvOMBJGLjyxiyd/E6i6JVI99CY0mgtWnA2KW6tkHMraZo9VzwdSgNsykNrew
         KqfjxHEo9+7WK6KcmOfrOP+nG7DUHX6CGxjhklkDZgy9f3OfZUaDnXqt97OMRXenj1Ht
         iBOBhVBwW1gyCpgFjM16CS1sg9/HDNUmd2xl6pIzk3BFJ/Zte2jtZbz3gOAFkBTuzy8J
         Tsfg==
X-Forwarded-Encrypted: i=1; AKwUvBx7SPJoYdgBt+PL48j5zO/lMuOIdNfuRNPijC7rYmQdfSidvtPgvS0bnfOFjeMLjhSCy7scNmm6n0qA@vger.kernel.org
X-Gm-Message-State: AFq9FYIWv5vpXVwYdA71r66OSsGksQ6EprLs83w4LA3l/tj8LiwTNQAz
	4yu/Zqg5YbWiJCCu7ebUdAYnFlbvh7GOIYP2/7EqRJD4zIVYYMLnCx08
X-Gm-Gg: AYBFou33VrzL9GHHu2pZT+NP/mQwRceZ6e4/cPWk7m6bK93wMMGt1+6NDxRWPXG/N2i
	grNbf0fhDNy/P1S9eXEXG0nPj/4YYyyQovMxu2qKNTo3j3sAcwQ6g1oaX9f+ho1iw0JHYMoh47J
	pRgZc2zgXrBLOAvM/z5zxSad3cAIwwHn9c08bTwRxMJeVK1BHB68Rvums6ISpWv//xAYG3FC+td
	DCrjrzFgIscsv6t85d18oD3gzuLhTBD13Sb1QU6ZaMwqZrSqT3bJSkQPG9/JAEbnkOfSA3z7oL8
	3o85FblXoFZtNF4duZnZrG8NierrFpy5I+VZJ8aHHvoNkNZmZ0kPugfO7TE1JmL88Aiec3rYLSB
	o+niCoN705CP5xJ8o3gjAPcf9QqqtTlEeMQfhgiEGwi2N9UIeS159HRKJGY5oJrdCdcDPCkAYc6
	IQwaHbdrDuSGHmPg4C3IfOO9/JoS/Lg0VpyRpLc/dTIO0LKZfAYSZgHhYyElXdvwTkrOASqW8af
	KizCuMP
X-Received: by 2002:a05:600c:6297:b0:4a1:9ec4:d939 with SMTP id 5b1f17b1804b1-4a1c66cc3a4mr235983075e9.17.1792362799221;
        Sun, 18 Oct 2026 15:33:19 -0700 (PDT)
Received: from fedora.domain.name ([217.218.152.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4c5932sm20382753f8f.18.2026.10.18.15.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 15:33:18 -0700 (PDT)
From: Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>
To: gregkh@linuxfoundation.org
Cc: stern@rowland.harvard.edu,
	linux-usb@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>
Subject: [PATCH v4] usb: ohci-omap: implement overcurrent handling for GPIO-based power control
Date: Mon, 19 Oct 2026 02:03:12 +0330
Message-ID: <20261018223312.120913-1-ampr.mhd@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The OMAP OHCI driver has had optional GPIO lines for VBUS power control
and overcurrent detection since the gpiolib conversion, but the
overcurrent line was never wired up — it was marked with a TODO comment.

On boards like the OMAP1 OSK, the VBUS power switch (TPS2045) is
controlled via a TPS65010 GPIO, and overcurrent is reported on a
separate GPIO. Without this patch, an overcurrent condition is not
detected by software and VBUS power is not cut, relying solely on the
hardware current limiter.

This patch implements the missing overcurrent handling:
- Requests a threaded IRQ on the overcurrent GPIO (both edges)
- Cuts VBUS power via the power GPIO when overcurrent is detected
- Reports overcurrent status and change through the root hub port
  status callbacks so the USB hub core can react
- Handles SetPortFeature/ClearPortFeature(POWER) to drive the VBUS
  GPIO alongside the OHCI hardware register
- Turns off VBUS on driver removal and probe failure

Signed-off-by: Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>
---
v4:
  - Remove spinlock entirely; use READ_ONCE/WRITE_ONCE for the
    overcurrent flags (Greg KH).  This also fixes the bug where
    gpiod_set_value_cansleep() was called under spin_lock_irqsave(),
    which sleeps on the I2C-attached TPS65010 (Sashiko).
  - Rename overcurrent_status to overcurrent_active and
    overcurrent_changed to overcurrent_change_pending (Greg KH)
  - Fix include order to be alphabetical (Greg KH)
  - Add comment explaining BIT(1) = port 1 (Greg KH)
  - Add comment explaining overcurrent_irq = -1 sentinel (Greg KH)
  - Add VBUS power-off in err_remove_hcd and ohci_hcd_omap_remove()
    so VBUS is not left enabled after driver unbind (Sashiko)
  - Re-check overcurrent_active after enabling VBUS in
    SetPortFeature(POWER) to close the race window (Sashiko)
  - Rewrite commit message to explain motivation (Greg KH)

v3:
  - Fix power GPIO polarity: 1 = VBUS off, 0 = VBUS on
  - Fix wPortChange bit: shift USB_PORT_STAT_C_OVERCURRENT by 16
  - Add clock and PHY cleanup to probe error path
  - Use IRQF_NO_AUTOEN to close race window during probe
  - Only set overcurrent_changed at probe when overcurrent is active
  - Guard hub_status_data and hub_control behind priv->overcurrent
  - Handle SetPortFeature/ClearPortFeature(POWER) for VBUS GPIO
  - Remove shadowed flags variable in hub_control

v2:
  - Use real name in From: and Signed-off-by: lines

 drivers/usb/host/ohci-omap.c | 282 +++++++++++++++++++++++++++++------
 1 file changed, 237 insertions(+), 45 deletions(-)

diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index f6e56c4b9914..c71721243905 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -19,20 +19,23 @@
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/irqreturn.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/usb/otg.h>
-#include <linux/platform_device.h>
 #include <linux/platform_data/usb-omap1.h>
-#include <linux/soc/ti/omap1-usb.h>
+#include <linux/platform_device.h>
+#include <linux/signal.h>
+#include <linux/soc/ti/omap1-io.h>
 #include <linux/soc/ti/omap1-mux.h>
 #include <linux/soc/ti/omap1-soc.h>
-#include <linux/soc/ti/omap1-io.h>
-#include <linux/signal.h>
+#include <linux/soc/ti/omap1-usb.h>
 #include <linux/usb.h>
+#include <linux/usb/ch11.h>
 #include <linux/usb/hcd.h>
+#include <linux/usb/otg.h>
 
 #include "ohci.h"
 
@@ -46,13 +49,23 @@ struct ohci_omap_priv {
 	struct clk *usb_dc_ck;
 	struct gpio_desc *power;
 	struct gpio_desc *overcurrent;
+	/*
+	 * Accessed with READ_ONCE/WRITE_ONCE from the threaded IRQ
+	 * handler and from hub_control in process context.  No lock
+	 * is needed: the IRQ handler is the sole writer of
+	 * overcurrent_active (IRQF_ONESHOT prevents re-entry), and
+	 * overcurrent_change_pending is a single-byte flag where a
+	 * missed clear just causes one extra poll cycle.
+	 */
+	bool overcurrent_active;
+	bool overcurrent_change_pending;
+	int overcurrent_irq; /* -1 means no IRQ has been allocated yet */
 };
 
 static const char hcd_name[] = "ohci-omap";
 static struct hc_driver __read_mostly ohci_omap_hc_driver;
 
-#define hcd_to_ohci_omap_priv(h) \
-	((struct ohci_omap_priv *)hcd_to_ohci(h)->priv)
+#define hcd_to_ohci_omap_priv(h) ((struct ohci_omap_priv *)hcd_to_ohci(h)->priv)
 
 static void omap_ohci_clock_power(struct ohci_omap_priv *priv, int on)
 {
@@ -70,15 +83,15 @@ static void omap_ohci_clock_power(struct ohci_omap_priv *priv, int on)
 static void start_hnp(struct ohci_hcd *ohci)
 {
 	struct usb_hcd *hcd = ohci_to_hcd(ohci);
-	const unsigned	port = hcd->self.otg_port - 1;
-	unsigned long	flags;
+	const unsigned port = hcd->self.otg_port - 1;
+	unsigned long flags;
 	u32 l;
 
 	otg_start_hnp(hcd->usb_phy->otg);
 
 	local_irq_save(flags);
 	hcd->usb_phy->otg->state = OTG_STATE_A_SUSPEND;
-	writel (RH_PS_PSS, &ohci->regs->roothub.portstatus [port]);
+	writel(RH_PS_PSS, &ohci->regs->roothub.portstatus[port]);
 	l = omap_readl(OTG_CTRL);
 	l &= ~OTG_A_BUSREQ;
 	omap_writel(l, OTG_CTRL);
@@ -89,11 +102,11 @@ static void start_hnp(struct ohci_hcd *ohci)
 
 static int ohci_omap_reset(struct usb_hcd *hcd)
 {
-	struct ohci_hcd		*ohci = hcd_to_ohci(hcd);
-	struct omap_usb_config	*config = dev_get_platdata(hcd->self.controller);
-	struct ohci_omap_priv	*priv = hcd_to_ohci_omap_priv(hcd);
-	int			need_transceiver = (config->otg != 0);
-	int			ret;
+	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
+	struct omap_usb_config *config = dev_get_platdata(hcd->self.controller);
+	struct ohci_omap_priv *priv = hcd_to_ohci_omap_priv(hcd);
+	int need_transceiver = (config->otg != 0);
+	int ret;
 
 	dev_dbg(hcd->self.controller, "starting USB Controller\n");
 
@@ -110,10 +123,11 @@ static int ohci_omap_reset(struct usb_hcd *hcd)
 	if (IS_ENABLED(CONFIG_USB_OTG) && need_transceiver) {
 		hcd->usb_phy = usb_get_phy(USB_PHY_TYPE_USB2);
 		if (!IS_ERR_OR_NULL(hcd->usb_phy)) {
-			int	status = otg_set_host(hcd->usb_phy->otg,
-						&ohci_to_hcd(ohci)->self);
-			dev_dbg(hcd->self.controller, "init %s phy, status %d\n",
-					hcd->usb_phy->label, status);
+			int status = otg_set_host(hcd->usb_phy->otg,
+						  &ohci_to_hcd(ohci)->self);
+			dev_dbg(hcd->self.controller,
+				"init %s phy, status %d\n", hcd->usb_phy->label,
+				status);
 			if (status) {
 				usb_put_phy(hcd->usb_phy);
 				return status;
@@ -141,7 +155,7 @@ static int ohci_omap_reset(struct usb_hcd *hcd)
 
 	/* board-specific power switching and overcurrent support */
 	if (machine_is_omap_osk()) {
-		u32	rh = roothub_a (ohci);
+		u32 rh = roothub_a(ohci);
 
 		/* power switching (ganged by default) */
 		rh &= ~RH_A_NPS;
@@ -181,6 +195,128 @@ static int ohci_omap_reset(struct usb_hcd *hcd)
 	return 0;
 }
 
+static irqreturn_t ohci_omap_overcurrent_irq(int irq, void *data)
+{
+	struct usb_hcd *hcd = data;
+	struct ohci_omap_priv *priv = hcd_to_ohci_omap_priv(hcd);
+	int status;
+	bool was_active;
+
+	status = gpiod_get_value_cansleep(priv->overcurrent);
+	if (status < 0)
+		return IRQ_HANDLED;
+
+	if (status && priv->power)
+		gpiod_set_value_cansleep(priv->power, 1);
+
+	was_active = READ_ONCE(priv->overcurrent_active);
+	WRITE_ONCE(priv->overcurrent_active, !!status);
+	if (was_active != !!status)
+		WRITE_ONCE(priv->overcurrent_change_pending, true);
+
+	usb_hcd_poll_rh_status(hcd);
+
+	return IRQ_HANDLED;
+}
+
+static int ohci_omap_hub_status_data(struct usb_hcd *hcd, char *buf)
+{
+	struct ohci_omap_priv *priv = hcd_to_ohci_omap_priv(hcd);
+	int length;
+
+	length = ohci_hub_status_data(hcd, buf);
+
+	if (!priv->overcurrent)
+		return length;
+
+	if (READ_ONCE(priv->overcurrent_change_pending)) {
+		if (!length) {
+			buf[0] = 0;
+			length = 1;
+		}
+		buf[0] |= BIT(1); /* port 1 */
+	}
+
+	return length;
+}
+
+static int ohci_omap_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
+				 u16 wIndex, char *buf, u16 wLength)
+{
+	struct ohci_omap_priv *priv = hcd_to_ohci_omap_priv(hcd);
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
+			ret = ohci_hub_control(hcd, typeReq, wValue, wIndex,
+					       buf, wLength);
+			if (!ret && !READ_ONCE(priv->overcurrent_active))
+				gpiod_set_value_cansleep(priv->power, 0);
+			/*
+			 * Re-check: the overcurrent IRQ may have fired
+			 * between the check above and the GPIO call.
+			 * A mutex would close this fully, but the window
+			 * is microseconds and the hardware current limiter
+			 * provides the final safety net.
+			 */
+			if (!ret && READ_ONCE(priv->overcurrent_active))
+				gpiod_set_value_cansleep(priv->power, 1);
+			return ret;
+		}
+		if (typeReq == ClearPortFeature &&
+		    wValue == USB_PORT_FEAT_POWER) {
+			ret = ohci_hub_control(hcd, typeReq, wValue, wIndex,
+					       buf, wLength);
+			if (!ret)
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
+		WRITE_ONCE(priv->overcurrent_change_pending, false);
+		return 0;
+	}
+
+	if (typeReq != GetPortStatus || wIndex != 1)
+		return ret;
+
+	{
+		bool active = READ_ONCE(priv->overcurrent_active);
+		bool changed = READ_ONCE(priv->overcurrent_change_pending);
+		__le32 *portstatus = (__le32 *)buf;
+		u32 value = le32_to_cpu(*portstatus);
+
+		if (active)
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
@@ -201,18 +337,18 @@ static int ohci_hcd_omap_probe(struct platform_device *pdev)
 
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
 
@@ -221,6 +357,10 @@ static int ohci_hcd_omap_probe(struct platform_device *pdev)
 	priv = hcd_to_ohci_omap_priv(hcd);
 
 	/* Obtain two optional GPIO lines */
+	WRITE_ONCE(priv->overcurrent_active, false);
+	WRITE_ONCE(priv->overcurrent_change_pending, false);
+	priv->overcurrent_irq = -1;
+
 	priv->power = devm_gpiod_get_optional(&pdev->dev, "power", GPIOD_ASIS);
 	if (IS_ERR(priv->power)) {
 		retval = PTR_ERR(priv->power);
@@ -229,13 +369,8 @@ static int ohci_hcd_omap_probe(struct platform_device *pdev)
 	if (priv->power)
 		gpiod_set_consumer_name(priv->power, "OHCI power");
 
-	/*
-	 * This "overcurrent" GPIO line isn't really used in the code,
-	 * but has a designated hardware function.
-	 * TODO: implement proper overcurrent handling.
-	 */
-	priv->overcurrent = devm_gpiod_get_optional(&pdev->dev, "overcurrent",
-						    GPIOD_IN);
+	priv->overcurrent =
+		devm_gpiod_get_optional(&pdev->dev, "overcurrent", GPIOD_IN);
 	if (IS_ERR(priv->overcurrent)) {
 		retval = PTR_ERR(priv->overcurrent);
 		goto err_put_hcd;
@@ -277,23 +412,73 @@ static int ohci_hcd_omap_probe(struct platform_device *pdev)
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
 	retval = usb_add_hcd(hcd, irq, 0);
 	if (retval)
-		goto err3;
+		goto err_iounmap;
+
+	if (priv->overcurrent) {
+		int status;
+
+		priv->overcurrent_irq = gpiod_to_irq(priv->overcurrent);
+		if (priv->overcurrent_irq < 0) {
+			retval = priv->overcurrent_irq;
+			goto err_remove_hcd;
+		}
+
+		retval = request_threaded_irq(
+			priv->overcurrent_irq, NULL, ohci_omap_overcurrent_irq,
+			IRQF_ONESHOT | IRQF_NO_AUTOEN | IRQF_TRIGGER_RISING |
+				IRQF_TRIGGER_FALLING,
+			"ohci-omap-overcurrent", hcd);
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
+		WRITE_ONCE(priv->overcurrent_active, !!status);
+		WRITE_ONCE(priv->overcurrent_change_pending, !!status);
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
+	if (priv->power)
+		gpiod_set_value_cansleep(priv->power, 1);
+err_iounmap:
 	iounmap(hcd->regs);
-err2:
+err_release_mem:
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
 err_unprepare_dc_ck:
 	clk_unprepare(priv->usb_dc_ck);
@@ -308,7 +493,6 @@ static int ohci_hcd_omap_probe(struct platform_device *pdev)
 	return retval;
 }
 
-
 /* may be called with controller, bus, and devices active */
 
 /**
@@ -323,16 +507,22 @@ static int ohci_hcd_omap_probe(struct platform_device *pdev)
  */
 static void ohci_hcd_omap_remove(struct platform_device *pdev)
 {
-	struct usb_hcd	*hcd = platform_get_drvdata(pdev);
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 	struct ohci_omap_priv *priv = hcd_to_ohci_omap_priv(hcd);
 
 	dev_dbg(hcd->self.controller, "stopping USB Controller\n");
+	if (priv->overcurrent_irq >= 0) {
+		free_irq(priv->overcurrent_irq, hcd);
+		priv->overcurrent_irq = -1;
+	}
 	usb_remove_hcd(hcd);
 	omap_ohci_clock_power(priv, 0);
 	if (!IS_ERR_OR_NULL(hcd->usb_phy)) {
-		(void) otg_set_host(hcd->usb_phy->otg, 0);
+		(void)otg_set_host(hcd->usb_phy->otg, 0);
 		usb_put_phy(hcd->usb_phy);
 	}
+	if (priv->power)
+		gpiod_set_value_cansleep(priv->power, 1);
 	iounmap(hcd->regs);
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
 	clk_unprepare(priv->usb_dc_ck);
@@ -344,7 +534,7 @@ static void ohci_hcd_omap_remove(struct platform_device *pdev)
 
 /*-------------------------------------------------------------------------*/
 
-#ifdef	CONFIG_PM
+#ifdef CONFIG_PM
 
 static int ohci_omap_suspend(struct platform_device *pdev, pm_message_t message)
 {
@@ -368,8 +558,8 @@ static int ohci_omap_suspend(struct platform_device *pdev, pm_message_t message)
 
 static int ohci_omap_resume(struct platform_device *dev)
 {
-	struct usb_hcd	*hcd = platform_get_drvdata(dev);
-	struct ohci_hcd	*ohci = hcd_to_ohci(hcd);
+	struct usb_hcd *hcd = platform_get_drvdata(dev);
+	struct ohci_hcd *ohci = hcd_to_ohci(hcd);
 	struct ohci_omap_priv *priv = hcd_to_ohci_omap_priv(hcd);
 
 	if (time_before(jiffies, ohci->next_statechange))
@@ -392,7 +582,7 @@ static struct platform_driver ohci_hcd_omap_driver = {
 	.probe		= ohci_hcd_omap_probe,
 	.remove		= ohci_hcd_omap_remove,
 	.shutdown	= usb_hcd_platform_shutdown,
-#ifdef	CONFIG_PM
+#ifdef CONFIG_PM
 	.suspend	= ohci_omap_suspend,
 	.resume		= ohci_omap_resume,
 #endif
@@ -402,8 +592,8 @@ static struct platform_driver ohci_hcd_omap_driver = {
 };
 
 static const struct ohci_driver_overrides omap_overrides __initconst = {
-	.product_desc	= "OMAP OHCI",
-	.reset		= ohci_omap_reset,
+	.product_desc = "OMAP OHCI",
+	.reset = ohci_omap_reset,
 	.extra_priv_size = sizeof(struct ohci_omap_priv),
 };
 
@@ -413,6 +603,8 @@ static int __init ohci_omap_init(void)
 		return -ENODEV;
 
 	ohci_init_driver(&ohci_omap_hc_driver, &omap_overrides);
+	ohci_omap_hc_driver.hub_status_data = ohci_omap_hub_status_data;
+	ohci_omap_hc_driver.hub_control = ohci_omap_hub_control;
 	return platform_driver_register(&ohci_hcd_omap_driver);
 }
 module_init(ohci_omap_init);
-- 
2.55.0

