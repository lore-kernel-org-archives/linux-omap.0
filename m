Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6402737EE;
	Mon, 23 Mar 2026 15:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278188; cv=none; b=YVXspUSaPReidYCCsuCXAUDHLDceVfTE7O/dqEPnVbh1LGPsFcDGNONfvDRo4OtmPMPUgnU07WjzoqvJp4N/axL1WwT684gyFsG0f5KsjRhm3WwfsCvHq2RUpYVYlZM4Q3hpzSfqogQM2/4dFqj7UbMFTd4kJrZPqpcdK5SHV14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278188; c=relaxed/simple;
	bh=p3ek0DJZ6dB5BRbHVbnnupyq4AxNJh+QqudvnzMubQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ToQpN9nu6qrcjFhI2YZPxB4Q6Lf+xAw3V3N9rfW82YY3j8WV5fXtcnmElCbHbwFzGrTfgyHqkVGqwS9XYeitBv6utrfFyHIAf/J1/8YwU64OUVUJA2VvH1jQ52/v35vMNAyrqDQ5GKU6P7IuYYyuDIk8pdMsVxaq4uDAZRGkSRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CA0W/K+7; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CA0W/K+7"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C08A11A2FA6;
	Mon, 23 Mar 2026 15:03:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 93BCC5FEF6;
	Mon, 23 Mar 2026 15:03:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1B05F10450FFB;
	Mon, 23 Mar 2026 16:03:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774278184; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=VQsfiU7pydAF8i4b/kHlBnS6SzX1tiqz2w4BnOsq9ws=;
	b=CA0W/K+72mkvKUBbOXbiX9FmqZuYVoK9tqAQnq5zCjgQzp62OyT6mT83di687D4StxIgkV
	ZeSLaBtLuRS/EUVunxh6qfST89sZRXB08mM4DeCld4dF0wBVGo+PBfI5k7pzGZPKxXeSWK
	86KlXJz2MI0fsd8uuXYBlTPWB0YjKU8X4uCqk1TME6XjT4quZnkpYZsr+XpH7TFOKjG0PA
	46STu/qKf6FmRzz5fCJ21wJlmmGj7DbvvwP49AH851tWp4xXrMPdAgvtmFGLWDL/WTzg1c
	RZpFczHjjbaSZ3lj4UCTvhx7yXfTV1cgh48hoSEMUkbxQyoKVvVy+gL+FtMiHQ==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Mon, 23 Mar 2026 16:02:48 +0100
Subject: [PATCH 7/8] mfd: omap-usb-host: Add pbias regulator support
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-omap4-fix-usb-support-v1-7-b668132124ac@bootlin.com>
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

Add pbias regulator support to enable SIM_VDDS supply and unlock USB I/O
cell. Previously, this was handled by the bootloader, now the kernel can
take responsibility for managing the PBIAS regulator, ensuring correct
operation regardless of the bootloader.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 drivers/mfd/omap-usb-host.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index ac974285be341fa579ef198d1893b77af428b5f8..9e254e00183e940b775d5bde6e891f0d26af27b0 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -15,6 +15,9 @@
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/regulator/consumer.h>
+#include <linux/string_choices.h>
+
 
 #include "omap-usb.h"
 
@@ -95,6 +98,8 @@ struct usbhs_hcd_omap {
 	struct usbhs_omap_platform_data	*pdata;
 
 	u32				usbhs_rev;
+
+	struct regulator		*pbias;
 };
 /*-------------------------------------------------------------------------*/
 
@@ -270,6 +275,25 @@ static bool is_ohci_port(enum usbhs_omap_port_mode pmode)
 	}
 }
 
+static int omap_usbhs_set_pbias(struct device *dev, bool power_on)
+{
+	struct usbhs_hcd_omap *omap = dev_get_drvdata(dev);
+	int ret;
+
+	if (!omap->pbias)
+		return 0;
+
+	if (power_on)
+		ret = regulator_enable(omap->pbias);
+	else
+		ret = regulator_disable(omap->pbias);
+
+	if (ret)
+		dev_err(dev, "pbias reg %s failed\n", str_enable_disable(power_on));
+
+	return ret;
+}
+
 static int usbhs_runtime_resume(struct device *dev)
 {
 	struct usbhs_hcd_omap		*omap = dev_get_drvdata(dev);
@@ -278,6 +302,10 @@ static int usbhs_runtime_resume(struct device *dev)
 
 	dev_dbg(dev, "usbhs_runtime_resume\n");
 
+	r = omap_usbhs_set_pbias(dev, true);
+	if (r)
+		return r;
+
 	omap_tll_enable(pdata);
 
 	if (!IS_ERR(omap->ehci_logic_fck))
@@ -355,7 +383,7 @@ static int usbhs_runtime_suspend(struct device *dev)
 
 	omap_tll_disable(pdata);
 
-	return 0;
+	return omap_usbhs_set_pbias(dev, false);
 }
 
 static unsigned omap_usbhs_rev1_hostconfig(struct usbhs_hcd_omap *omap,
@@ -564,6 +592,11 @@ static int usbhs_omap_probe(struct platform_device *pdev)
 
 	omap->pdata = pdata;
 
+	omap->pbias = devm_regulator_get_optional(dev, "pbias");
+	if (IS_ERR(omap->pbias))
+		return dev_err_probe(dev, PTR_ERR(omap->pbias),
+				     "unable to get pbias regulator\n");
+
 	/* Initialize the TLL subsystem */
 	omap_tll_init(pdata);
 
@@ -759,6 +792,10 @@ static int usbhs_omap_probe(struct platform_device *pdev)
 	}
 
 initialize:
+	ret = omap_usbhs_set_pbias(dev, true);
+	if (ret)
+		goto err_mem;
+
 	omap_usbhs_init(dev);
 
 	if (dev->of_node) {
@@ -806,6 +843,8 @@ static void usbhs_omap_remove(struct platform_device *pdev)
 		of_platform_depopulate(&pdev->dev);
 	else
 		device_for_each_child(&pdev->dev, NULL, usbhs_omap_remove_child);
+
+	omap_usbhs_set_pbias(&pdev->dev, false);
 }
 
 static const struct dev_pm_ops usbhsomap_dev_pm_ops = {

-- 
2.53.0

