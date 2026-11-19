Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795088325;
	b=SUCMtfXAdhpuGGojWV0oC6WlX5HXkWRD0ztEPfTt9jsrmfFuyFqJ2gw/9irbhqaX2fCR
	 DbjLGvpASpqa3PAzpN00Lr/3qpCdRzHgFb/NVupNvbicBv8gFXNC+AHgVyVmCCMkkEqq1
	 vKdwuDwT2mwHhPBURstdHTIbbZyjEl9uLYxa9usa1vrHjczfdp4ug0AnLTO30/SDjfumw
	 U/ZBuzOkFwIOeaEn56zpOCBihC+LM5U+4uAiV//You+vmdIImGu8Sw/JTlvoFZSrf6I+e
	 1ssOXf1p7OQGeKDa/inAE4jRCfDMG2UkPfxyHtbUXsn+WpauBv8Obk1FuHMceVrYJ0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088325;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=VDLNZ1lzQBUvJntHvmHdJqoj25UewCrSctNLy9rd7c4=;
	b=GGwWLT4Sh5YNNoy4EQEzYSTDWFECg8CRUCkFAk0/HhvllOpeaD9o4CVF4SZO8eY4/hak
	 u9CYJWmDmJMYj8FQp3OcfZOTEmdJuzEiCmXglgqLkRRkcUs0+XF3S83i3rUHGuanzbHd0
	 JhdiEw3mKhAsi0RdfcVgL/Y6mO376d6DbLLGqKaBsYWODeG+DXT7JDxf6oACQqjeg+AOO
	 tDUtKyufwpst8qaUb25tJDlbBf2Rkrx3FNAUOFqtGs73cehK7GLm4/aPsiyfq244Ye/jV
	 K//1ZXVAQ7BZ4AElteOJHVbBm2id0LthJvmRBsxnsHmaYaToDLmDeLkUUIk47XpAp4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=WrJUavH2;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32B8606A325
	for <linux-omap@vger.kernel.org>; Thu, 19 Nov 2026 11:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F32B8606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=WrJUavH2
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D90ADC4CBF1;
	Thu, 19 Nov 2026 11:38:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A08C060237;
	Thu, 19 Nov 2026 11:38:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8F77911BC1D43;
	Thu, 19 Nov 2026 12:38:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795088321; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=VDLNZ1lzQBUvJntHvmHdJqoj25UewCrSctNLy9rd7c4=;
	b=WrJUavH28sMiZLpONfRALyvhkxBgfdkZDagrrl3sQR421xc+a2cXpQmS30WYWKs7fiWnJL
	3CpDo3Em1QUuGkdxbX/W8bG4DzXHXYAgtoeycsrIaEP1uc8HgWvSDr0BNbduhU1giQtFq4
	H0U4H7MOdaYmxh5vTpJD7jFsUCHDz/O111NsF8OY0/wuDlIAwBzjVMl7Tvmbxj8YP/No6Q
	rz3g1t9GTYqAZvgSsQoF4ZYGVEaLb5QqcP8hFdEh9WNkIxfd7NB7+Y924C40zi5zv8V80h
	wq2Ae5yzNTvq/TwPAKJBYYpOvBBM/PMUMuDmZJMP5gQWx+qeCUKUJFT1ye658w==
From: Herve Codina <herve.codina@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Kalle Niemi <kaleposti@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>
Cc: linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	driver-core@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	stable+noautosel@kernel.org
Subject: [PATCH v11 5/5] bus: simple-pm-bus: Populate child nodes at probe
Date: Thu, 19 Nov 2026 12:37:56 +0100
Message-ID: <20261119113758.603074-6-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119113758.603074-1-herve.codina@bootlin.com>
References: <20261119113758.603074-1-herve.codina@bootlin.com>
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The simple-pm-bus driver handles several simple busses. When it is used
with busses other than a compatible "simple-pm-bus", it doesn't populate
its child devices during its probe.

This confuses fw_devlink and results in wrong or missing devlinks.

Once a driver is bound to a device and the probe() has been called,
device_links_driver_bound() is called.

This function performs operation based on the following assumption:
    If a child firmware node of the bound device is not added as a
    device, it will never be added.

Among operations done on fw_devlinks of those "never be added" devices,
device_links_driver_bound() changes their supplier.

With devices attached to a simple-bus compatible device, this change
leads to wrong devlinks where supplier of devices points to the device
parent (i.e. simple-bus compatible device) instead of the device itself
(i.e. simple-bus child).

When the device attached to the simple-bus is removed, because devlinks
are not correct, its consumers are not removed first.

In order to have correct devlinks created, make the simple-pm-bus driver
compliant with the devlink assumption and create its child devices
during its probe.

Fixes: 3a2dbc510c43 ("driver core: fw_devlink: Don't purge child fwnode's consumer links")
Cc: <stable+noautosel@kernel.org> # Need more devices described in LAN966x PCI dtso
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/bus/simple-pm-bus.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
index 23ac18551fd9..6afc992a750f 100644
--- a/drivers/bus/simple-pm-bus.c
+++ b/drivers/bus/simple-pm-bus.c
@@ -26,6 +26,12 @@ static void simple_pm_bus_depopulate(void *data)
 {
 	struct device *dev = data;
 
+	if (!pm_runtime_enabled(dev)) {
+		/* No PM runtime, we can directly depopulate */
+		of_platform_depopulate(dev);
+		return;
+	}
+
 	/*
 	 * Bus stays on for children
 	 * This ensure that the bus will not be put in idle asynchronously when
@@ -46,7 +52,7 @@ static void simple_pm_bus_depopulate(void *data)
 	pm_runtime_put_sync(dev);
 }
 
-static int simple_pm_bus_populate(struct device *dev,
+static int simple_pm_bus_populate(struct device *dev, bool default_populate,
 				  const struct of_dev_auxdata *lookup)
 {
 	struct device_node *np = dev->of_node;
@@ -55,7 +61,9 @@ static int simple_pm_bus_populate(struct device *dev,
 	if (!np)
 		return 0;
 
-	ret = of_platform_populate(np, NULL, lookup, dev);
+	ret = default_populate ?
+		of_platform_default_populate(np, lookup, dev) :
+		of_platform_populate(np, NULL, lookup, dev);
 	if (ret)
 		return ret;
 
@@ -83,16 +91,23 @@ static int simple_pm_bus_probe(struct platform_device *pdev)
 	match = of_match_device(dev->driver->of_match_table, dev);
 	/*
 	 * These are transparent bus devices (not simple-pm-bus matches) that
-	 * have their child nodes populated automatically.  So, don't need to
-	 * do anything more. We only match with the device if this driver is
-	 * the most specific match because we don't want to incorrectly bind to
-	 * a device that has a more specific driver.
+	 * need to have their child nodes populated. So, don't need to do
+	 * anything more except populate child nodes during this probe(). We
+	 * only match with the device if this driver is the most specific match
+	 * because we don't want to incorrectly bind to a device that has a more
+	 * specific driver.
 	 */
 	if (match && match->data) {
-		if (of_property_match_string(np, "compatible", match->compatible) == 0)
-			return 0;
-		else
+		if (of_property_match_string(np, "compatible", match->compatible))
 			return -ENODEV;
+
+		dev_dbg(&pdev->dev, "%s: populate only\n", __func__);
+
+		ret = simple_pm_bus_populate(&pdev->dev, true, lookup);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret, "failed to populate\n");
+
+		return 0;
 	}
 
 	bus = devm_kzalloc(&pdev->dev, sizeof(*bus), GFP_KERNEL);
@@ -111,7 +126,7 @@ static int simple_pm_bus_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "failed enable pm_runtime\n");
 
-	ret = simple_pm_bus_populate(&pdev->dev, lookup);
+	ret = simple_pm_bus_populate(&pdev->dev, false, lookup);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "failed to populate\n");
 
-- 
2.56.0

