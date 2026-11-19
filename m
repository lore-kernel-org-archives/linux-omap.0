Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795086047;
	b=5WtPNSs6K2bbFmb/TGoQ82/lRKi2gKYAsX0qhIRFrtP5bp7JQ3MNjQIP/hoym/OK4XgY
	 t7VR5SX3Rjne2y6CWq2m1Cm6mIBrMr+Hxi8Uo9b8uh3eG1o8eSt5OS5VLVLdLCjN6jq67
	 96JJBqS9Dk7P8vD8lCZn/tHpe7T25qYhX5+yr+4wxb1bAPzpzMg56XN6br9o7OqWjEDP2
	 JprnuzHsNaMPr+wjJDBcNe9LQsAdSTOOTgPcbdxPfNV3TgJZXiXa/hfBik+Goz0HVCeoz
	 c/F4MMXRaHVmM5NcaE6+oxm28oNODnH+EoiLJjeiUzncGvxw4n0txh1GrrlSlXqExwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795086047;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=L1YcTl/uYfFtLb4iHc/VuFExeEr6pRbLZWly8UMoO5U=;
	b=xyKQtjGtss4IBIGyPfb/SHRespthj7+oAkD/OVN1h1cwgeMsqCy6ibS1EJpUqpPhmul4
	 bz7QKcVsSLZ4RqZDPXfX9n2XVibCXx5GKzv5ZlxXZVJTxbcRUeI1c8nOc3rEMiwn1VZz/
	 RN4JwOnu43X6P/J2bC/iHHOZ/PU4SRDgRfp5Q5ZWx5B+s7vC/O3LNgFlQ/JCUaMCPMIR9
	 I8FoBNIW5aWoZKXuBaDaXxWE65h0Tyh976/LW0+/XcB2bW4XyGWBJ1KRismQRuGiPBK3P
	 Dk2wZcqNDLr3VXckY7e8ouVC5l4kYRR0bVmtX5Sn7tcVJEYOxQNo2dZi8p9M9gL7ssw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=HSjafekj;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34AF606A325
	for <linux-omap@vger.kernel.org>; Thu, 19 Nov 2026 11:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C34AF606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=HSjafekj
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5CFF04E41663;
	Thu, 19 Nov 2026 11:00:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 286FD60237;
	Thu, 19 Nov 2026 11:00:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3CB4211BC0CEC;
	Thu, 19 Nov 2026 12:00:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795086043; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=L1YcTl/uYfFtLb4iHc/VuFExeEr6pRbLZWly8UMoO5U=;
	b=HSjafekjddeaYVUifFSFc5T5ypeW7/EBd6uqpPFrocF2jq3K+kAc9a4q8HVkqzILmc9LxN
	EjMYyBHAaNHnZz9kj+IZaVZwKpcWMGhxa55fnABASK7/kqDUWINUZ0/ZQ8yAVlGozm/Vl2
	gVs92Hg1htoEP9bDqv+6FHss0vBMIHCdsK/rQ+69Vzd1umOvXoZBd2AkFnb2B8Y36/6YLU
	l4+ZPr9WhFYOqcpm4DT6KSHcrlHT/6VolYpUJhi8uI6qMgWuhOGXzvKvIKSsN1t5SHKJSN
	ycTyybIE8wP8a2p2Nn8KFXkNFgMKLF9r7ahcuvO7tmMtQr2T7BKA7NQ7yxOVCg==
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
Subject: [PATCH v10 3/5] bus: simple-pm-bus: Remove child devices when the bus is unbound
Date: Thu, 19 Nov 2026 12:00:09 +0100
Message-ID: <20261119110014.582363-4-herve.codina@bootlin.com>
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

