Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795086060;
	b=lZ+QE5uRxDEJwXQEr+fT4tHO/GSRguS6hL7JvA5li62Zz6um0Lmi+Q9kw94++6LmGM+K
	 3GM71aHVX07xr52f80gpvR6kLa0786WOY8l5RuHhFYPM6awGwo0BNhwLHa3Tsk0/0P9E1
	 wTKa2IVT/y6liuArJHJnErGxCsGSlQccPxfkU65CGu6U82w5ws/FNAwMqf8Zr/3SFoqHA
	 2KZd+Dhagl+7SXpJlL5zNiNBF5v0B0W8oupmSgGA0O0Gc8cAP1LCzi4ILPmcm0HeHUUxj
	 1LWcTjH9ADXvMPvIVoIma0MQTy0nbnPtBDBbyHEfGIzuOD/j62+dWKQpW56tN0mNgbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795086060;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=eZ7TpthuV8NxvWtjX1I6039/M5HrbxLJ6NZYHgglK1k=;
	b=PCe1Xa+BL1jwjJNWzjZPhSC7oKcvzcifPwUD4JJapo4ecjhmRX4KUQoxr1jRtTvNESw+
	 AK19MB4plBXYKNUNPYUGWNNK7WPPJluvEZyB99kMc2u1pnC53pOLXTA05cCHYK+iXeGKp
	 iRG3jddjQnqvf8/uezZ/WpPXjSs4S9w1Rc/DssDSFMD743W5bmIzRyYBCf7rU8jjUMhQ5
	 0z3r1tRum4pKkW9K+zQI+2jIXYCHgl5PVClG0E+uhuYiU6lVm2ed8xnOQC3YvkUxvDksH
	 XBZMxhSzp0lbCb1scjvRz4jgXYSycZBfn38KVFP+pGuHEbM+kMTgisKQ2jxBBMXCvGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ElU+LS7w;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520D2606A32A;
	Thu, 19 Nov 2026 11:01:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 520D2606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ElU+LS7w
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 5ACF5C4CBEF;
	Thu, 19 Nov 2026 11:01:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2193A60237;
	Thu, 19 Nov 2026 11:00:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C118D11BC1135;
	Thu, 19 Nov 2026 12:00:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795086052; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=eZ7TpthuV8NxvWtjX1I6039/M5HrbxLJ6NZYHgglK1k=;
	b=ElU+LS7wNRfwzwd/Hx49B9FhgLaingBKi8axxvY4vqwusO+ia7JYN0B9E3a2zfZRdGefBP
	iyhF7zPwrUA1wUNt43OV1CQ0uqRaDkEMxyKMkjFRrM+jZERwH7cpywY+hl6coR/vGDjiOO
	VhrRoNp7h2nutwgZ6LL6aimmGlZWG5iHBkFcJxU5IlTkM2fRec9CWRG9FFQZwk+cIxc2+l
	tSv6foicVyUmJ9Gy/yL7mqYyUwG2xS2Wlmv8aITocgB8cnoQnzYzKeI6VueLMS//D1TuTh
	9tCaxxxqQC6A+nONztG/M1np+wc9HEgvMScjxf5p9yI+5KhearZJ1xih237WNQ==
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
Subject: [PATCH v10 5/5] bus: simple-pm-bus: Populate child nodes at probe
Date: Thu, 19 Nov 2026 12:00:11 +0100
Message-ID: <20261119110014.582363-6-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119110014.582363-1-herve.codina@bootlin.com>
References: <20261119110014.582363-1-herve.codina@bootlin.com>
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

Fixes: 628b8ca3e915 ("bus: simple-pm-bus: Remove child devices when the bus is unbound")
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

