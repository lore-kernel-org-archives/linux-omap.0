Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D777D3D902C
	for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2026 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774878277; cv=none; b=c3sOL6KZWHMOU2cZ5hut4wafhVzK3P1r6ziEtVqTntsNW6DttItf4XEJKbdYC3I3vnzBFFmpAxpaOr1s1okZ1qrSiQMUCZOAP0q3CZkM3rYv5tu/Bo0mfsvj+LfrVJj4bBrZ3SM/6D85iZMqzQagADBDE+jJ2/HX2t1CfpK2hpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774878277; c=relaxed/simple;
	bh=S3HZghcHxR8VTHdT4bKr6owjthUCOnQ0Mt38RYLJ8Mk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KY8/9nOzWmuMdz8R72sHo1EiUDYvuUAhnApoLfL+by2u2Qbso6EUN60tyiDbo6HIX3/R3p+Bou7RrzAJlzevDfusapCX0yZJKYlYDymlmhsWFmfV7kMp9XkBby2NdveUaOeqQKcOmyTiFiCvD1eWqKQer9e17Hmw5CgxPXhqslQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=D8hvphWD; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="D8hvphWD"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id DA79EC566B3;
	Mon, 30 Mar 2026 13:45:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C28EC5FFA8;
	Mon, 30 Mar 2026 13:44:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B11C610450627;
	Mon, 30 Mar 2026 15:44:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774878273; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=JxnHNmFgDEfC8ZkI4lufUhDnXylRO/9U59fNo706pDI=;
	b=D8hvphWDyZ/PgK6Sbj9zkalHlpyJ8ULGe/rFKUn1DHslWBqfvoqiOTQDF1t0AP9OtpoSoz
	UoeGu6PlsCsbmE5xDOW6KJhjhghw6zf44ElPWPYS9HuvVF9Z2zwXliPuXKhL5EwK0W+Bxf
	JKwUQNRhpRc1T4chk6n2u5s3Yj9xlMu3fP4xP3jQUGgFbOawD/NKUp0DrarjB8haEA3HlB
	O/mbugN3mhzUrw+QprobWKjRFcYsgZEv9UXgkPo/H4Ib1luiEVSHUcKsOlockB2QrnrCGV
	S7Lr1j95IfiDkDwxgMcpGvgvf0zw87cM8C98VCQ6X9rAF5RyapgzQXNb+91vKg==
From: Thomas Richard <thomas.richard@bootlin.com>
Date: Mon, 30 Mar 2026 15:44:07 +0200
Subject: [PATCH v2 10/11] mfd: omap-usb-host: Add pbias regulator support
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-omap4-fix-usb-support-v2-10-1c1e11b190dc@bootlin.com>
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

Add pbias regulator support to enable SIM_VDDS supply and unlock USB I/O
cell. Previously, this was handled by the bootloader, now the kernel can
take responsibility for managing the PBIAS regulator, ensuring correct
operation regardless of the bootloader.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 drivers/mfd/omap-usb-host.c | 55 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 17a54f0087c3..907fb614d464 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -15,6 +15,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <linux/regulator/consumer.h>
+#include <linux/string_choices.h>
 
 #include "omap-usb.h"
 
@@ -95,6 +97,8 @@ struct usbhs_hcd_omap {
 	struct usbhs_omap_platform_data	*pdata;
 
 	u32				usbhs_rev;
+
+	struct regulator		*pbias;
 };
 /*-------------------------------------------------------------------------*/
 
@@ -334,26 +338,60 @@ static int usbhs_clocks_enable(struct device *dev, bool enable)
 	return r;
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
 	struct usbhs_omap_platform_data	*pdata = omap->pdata;
+	int ret;
 
 	omap_tll_enable(pdata);
 
-	return usbhs_clocks_enable(dev, true);
+	ret = usbhs_clocks_enable(dev, true);
+	if (ret)
+		return ret;
+
+	return omap_usbhs_set_pbias(dev, true);
 }
 
 static int usbhs_runtime_suspend(struct device *dev)
 {
 	struct usbhs_hcd_omap		*omap = dev_get_drvdata(dev);
 	struct usbhs_omap_platform_data	*pdata = omap->pdata;
+	int ret;
 
 	usbhs_clocks_enable(dev, false);
 
 	omap_tll_disable(pdata);
 
+	ret = omap_usbhs_set_pbias(dev, false);
+	if (ret)
+		goto err;
+
 	return 0;
+
+err:
+	omap_tll_enable(pdata);
+	usbhs_clocks_enable(dev, true);
+	return ret;
 }
 
 static unsigned omap_usbhs_rev1_hostconfig(struct usbhs_hcd_omap *omap,
@@ -562,6 +600,15 @@ static int usbhs_omap_probe(struct platform_device *pdev)
 
 	omap->pdata = pdata;
 
+	omap->pbias = devm_regulator_get_optional(dev, "pbias");
+	if (IS_ERR(omap->pbias)) {
+		if (PTR_ERR(omap->pbias) == -ENODEV)
+			omap->pbias = NULL;
+		else
+			return dev_err_probe(dev, PTR_ERR(omap->pbias),
+					     "unable to get pbias regulator\n");
+	}
+
 	/* Initialize the TLL subsystem */
 	omap_tll_init(pdata);
 
@@ -757,6 +804,10 @@ static int usbhs_omap_probe(struct platform_device *pdev)
 	}
 
 initialize:
+	ret = omap_usbhs_set_pbias(dev, true);
+	if (ret)
+		goto err_mem;
+
 	omap_usbhs_init(dev);
 
 	if (dev->of_node) {
@@ -804,6 +855,8 @@ static void usbhs_omap_remove(struct platform_device *pdev)
 		of_platform_depopulate(&pdev->dev);
 	else
 		device_for_each_child(&pdev->dev, NULL, usbhs_omap_remove_child);
+
+	omap_usbhs_set_pbias(&pdev->dev, false);
 }
 
 static const struct dev_pm_ops usbhsomap_dev_pm_ops = {

-- 
2.53.0

