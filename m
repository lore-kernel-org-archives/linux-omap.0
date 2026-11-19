Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795088318;
	b=IKkqSZtx36WoQry/CEyhV2n6ZWEOO25RAeXGMc8J2iusOn4HZhyG1Sd8Jbp7u1PwS5Cq
	 LEaHFJkFJQAF8+fswsKorrE/FEN5Hz+TeVP0Mb87z9SNub8GnEZn7D8nte1K37yurok99
	 yjKq3tddFCZ28PIz7MkzrYqYVYk1y6sc/1NbcG6zMYvqPXNkGFu4NzqKy/7XZL60WaiH+
	 CLL6sQGa6V6k4vcJa+mtfG9gUWAA0yRvLWxAI0brImlrIDR7GgPKkRomCMh8x8mj7XRr4
	 d2Y8Cj5U03x7Ss4YYZwrKMMzvOMVadxOqWi9TTTNgTp8fa8ZTJsIzCz1w+IV5RQW6RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088318;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=L1YcTl/uYfFtLb4iHc/VuFExeEr6pRbLZWly8UMoO5U=;
	b=XPnevhLW6tpBCsuSSL8FntSE0ZCFX+UZX/uXZ9QbLeF4KmpfcdKY472IBKI7rDUqM/7E
	 F28WSZMhoNgO+1yzmGVp067qshiQ8Kw1OZC6UAgzLYFraGVOTHuTB6ka/LNENSJqO3mRF
	 3TeBH8ktIIEShqvQBDvUpBG00OhVDDa/EUcOuVrR7gHXpxqFVpcZlbEgueC/cE5zlpDe1
	 A1l4a3/VR+O7+D6xkUYac9O149llsZLhztyCB/pS+mIyUYpxrxeV7DpuikUmsOxxIBUHG
	 CzwuR9D3tBsSK7MVi8C7QBNZieVqdFEprlRZ0YkxZoTa7KjTbJcnHn2gDJ9+MlwnM/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=GjGO65NN;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED76F606A335
	for <linux-omap@vger.kernel.org>; Thu, 19 Nov 2026 11:38:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED76F606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=GjGO65NN
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B6E3A1A170C;
	Thu, 19 Nov 2026 11:38:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8AF8C60237;
	Thu, 19 Nov 2026 11:38:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BD25A11BC1249;
	Thu, 19 Nov 2026 12:38:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795088311; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=L1YcTl/uYfFtLb4iHc/VuFExeEr6pRbLZWly8UMoO5U=;
	b=GjGO65NNOSB8ZEHNPWdX+QLZsp0hZ4Zz5l6LH58sZhhekddhSKLcZtO6Eex5P+uASB5uqs
	noI88Ek4b6WI+9qE8JCCXfCapMCJPynJJ0rCjute/GeoQqDetQq+UsbBJwQSIG4P7dWsqg
	VdD2hwj4h3akOVu9hme8a8O67I6CpqBzjZZ/thquyJzUVKfcaKRJNIB4L3ybgwoLbp602M
	VYZ1CqGM86fe4Cdff798vqdKasVkoGFq+nCI2wz6/vMRcoZoSaE7RqhweuhFepV3CLKLbB
	w1JA0ycEe6u6hSq0zDsYTBmK17aDHY8W6v4Dgq7PPed5S5gvhtfBprQZb2hrBQ==
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
	Herve Codina <herve.codina@bootlin.com>
Subject: [PATCH v11 3/5] bus: simple-pm-bus: Remove child devices when the bus is unbound
Date: Thu, 19 Nov 2026 12:37:54 +0100
Message-ID: <20261119113758.603074-4-herve.codina@bootlin.com>
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

During its probe, the simple-pm-bus driver (simple-pm-bus compatible
variant) populates its child devices but it doesn't touch them during
its removal.

This leads to bus child devices present and bound to drivers whereas the
bus itself is unbound.

Be consistent and remove child devices when the bus itself is unbound.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/bus/simple-pm-bus.c | 45 +++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
index e45700156732..23ac18551fd9 100644
--- a/drivers/bus/simple-pm-bus.c
+++ b/drivers/bus/simple-pm-bus.c
@@ -22,6 +22,46 @@ struct simple_pm_bus {
 	int num_clks;
 };
 
+static void simple_pm_bus_depopulate(void *data)
+{
+	struct device *dev = data;
+
+	/*
+	 * Bus stays on for children
+	 * This ensure that the bus will not be put in idle asynchronously when
+	 * all its children are removed.
+	 */
+	pm_runtime_get_sync(dev);
+
+	/* Let remove children */
+	of_platform_depopulate(dev);
+
+	/*
+	 * Lets runtime_suspend() calls simple_pm_bus_runtime_suspend() in a
+	 * synchronous way before disabling runtime pm.
+	 *
+	 * This guarantee that clocks are disabled and unprepared before the
+	 * bus is removed in all cases.
+	 */
+	pm_runtime_put_sync(dev);
+}
+
+static int simple_pm_bus_populate(struct device *dev,
+				  const struct of_dev_auxdata *lookup)
+{
+	struct device_node *np = dev->of_node;
+	int ret;
+
+	if (!np)
+		return 0;
+
+	ret = of_platform_populate(np, NULL, lookup, dev);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, simple_pm_bus_depopulate, dev);
+}
+
 static int simple_pm_bus_probe(struct platform_device *pdev)
 {
 	const struct device *dev = &pdev->dev;
@@ -71,8 +111,9 @@ static int simple_pm_bus_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "failed enable pm_runtime\n");
 
-	if (np)
-		of_platform_populate(np, NULL, lookup, &pdev->dev);
+	ret = simple_pm_bus_populate(&pdev->dev, lookup);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to populate\n");
 
 	return 0;
 }
-- 
2.56.0

