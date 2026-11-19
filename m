Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795088311;
	b=soh/jtd1kOZcym0K2Rvj0tzIpjNF3dnaVUWKdR5u9grstpv7QWeIOPmMNIQ4WW7nhs5k
	 OVTFLrZoJDRXqVi559+q10dVT+bzz8uT9jD5csCbaP2/rvXNHUVQe9wOOHvPAPY6BkA6Z
	 zfl8oEQZmjRgCW9mF4+F5Lu6U3noD3bygt73mIbKc/PcnxqgLC/HiF1Mq/9foNHfB/BPG
	 d3djZgvEQ2I9aRTXOVNRlgM0NiZQGfGa67j1aXe2nsXvOXecyH+XPQPVYMl958F5Ud6wz
	 1ACkNn5iQy4h2pV2IXJDRrsYVHF+aWhkCxlwtmpBHjxDIXzkkAy3D4LgqLyxTGTAopQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088311;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=SnpBpONi2hKsnLkH7ie4ozWlmqX6tUPpRN0WLEqSj5E=;
	b=HRrDUqGLd+yUuuiP2U+wGFIpPpC86W02v4ljOw3pwsduzTKwUkxZColpWfgkbu8qxO/4
	 4/5TYXYSSrlpNmWGWxTzIoh2rnO9awzHbZVUECxBhCgmPKYtPuT5QgEIoswsjjkBkqwvS
	 FLER1b6HVuBHbW6y32hYdm/z2vSPhn+aR5yekgOy5dAyQ8Ubf/4ZE7f5cF7si9AGiIFsI
	 t+9tlSbouQQBB6J1GHZHjCbhpfTrQ6eG3SNSY/1yNueEDjLN6oomqltIzkiwbxg8l/fNE
	 tt6m9Ymk1Q9kjiZcEygUJo2iNh2hGgwDON52XKbrKuyjRzQz1Hfn2D7q139mEA3x0Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=1YXEjZt4;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03E1606A330;
	Thu, 19 Nov 2026 11:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D03E1606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=1YXEjZt4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6C6AD4E41665;
	Thu, 19 Nov 2026 11:38:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 332DA60237;
	Thu, 19 Nov 2026 11:38:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D718F11BC1F34;
	Thu, 19 Nov 2026 12:38:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795088303; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=SnpBpONi2hKsnLkH7ie4ozWlmqX6tUPpRN0WLEqSj5E=;
	b=1YXEjZt4qlKrQHOgJzkexU+Iou77czT1vkN8RWuUpEhhYJUcs5+bVi7DhX18y3pTMRv4Bs
	Xy72gd685wBvNy+uL8t8mKgqLZ7efT46u3iEoqAn70cLhNI10wBllevR2D0PPBo4xeI5Ro
	S0l4qpp+ci5Bb0UkBiRwOg1xcxQScyJt1N0qaUn/3CwZ22efPrV3mW7RLOWQnB/sglx81J
	mBAdTTTTuK3utJlkEB8T/wXrZB+V3YyrE+BqrYNI+B4u4CavTNdKmgURAycnjp2cOJoT97
	a8tjBDwBS4cFou9WBIBdyExxCeLN/k4VTY7mZvp5HXulN2s6gmJ/0yhdvPodxQ==
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
Subject: [PATCH v11 2/5] bus: simple-pm-bus: Remove the remove() function
Date: Thu, 19 Nov 2026 12:37:53 +0100
Message-ID: <20261119113758.603074-3-herve.codina@bootlin.com>
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

Due to recent modification, the driver remove() function is almost
empty. It only performs a dev_dbg() call.

Having this remove() function is no more needed. Remove it.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/bus/simple-pm-bus.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/bus/simple-pm-bus.c b/drivers/bus/simple-pm-bus.c
index 4322a778e801..e45700156732 100644
--- a/drivers/bus/simple-pm-bus.c
+++ b/drivers/bus/simple-pm-bus.c
@@ -77,11 +77,6 @@ static int simple_pm_bus_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void simple_pm_bus_remove(struct platform_device *pdev)
-{
-	dev_dbg(&pdev->dev, "%s\n", __func__);
-}
-
 static int simple_pm_bus_runtime_suspend(struct device *dev)
 {
 	struct simple_pm_bus *bus = dev_get_drvdata(dev);
@@ -150,7 +145,6 @@ MODULE_DEVICE_TABLE(of, simple_pm_bus_of_match);
 
 static struct platform_driver simple_pm_bus_driver = {
 	.probe = simple_pm_bus_probe,
-	.remove = simple_pm_bus_remove,
 	.driver = {
 		.name = "simple-pm-bus",
 		.of_match_table = simple_pm_bus_of_match,
-- 
2.56.0

