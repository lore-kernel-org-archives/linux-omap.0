Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795086052;
	b=cXuohoh8Gy15/g1zkKwFp7HBbCMGdDAxQAzNA1aoAGpkypRrDH0xJlMEFLo22sTqNBMA
	 WqVN1gCtfkudHBcgBP9BPXhNqaAqAkIG+mFtG3xUD0HrlqmLDd3pz4yFxOp/kHy9QsXXe
	 BStJJ4yWhjSzqDi6vbvQ7FCh/qC6rI+4cGJjE/2kZ6wAmUrxmxy9P5ZMDxo933e5/RkMZ
	 8SJiEhq8JsOWYrC1Qqd0FV7D2xDWsFp7pTFKBDzlgR6H8bHGpJw5OhpqNX0msZZoKJgoq
	 rXIBttrPe0xgPhMwOvl2xJtEXw8Or2SuB78pXRliq9kjbo6MKZP/aNZjb0r2Wc+ZVIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795086052;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=sfUMDLC0E22rep4FDmPzBeyywhsxbumM+Fv7jNI+gdQ=;
	b=G5Jc8Ro8At11JrrBd9exqvohYpIQ+ZDAMCYf8lco6c8gi01B3xTQnm/yqLFvW1dnRvkP
	 poEOglTpr+nqEfH+sHU/YXhnFGC1ggxo5A3SMuZkmI8JfIGdJXGDQ1Ky7JhzKUx22U5o5
	 HAXovZFzFSfCR9hRg/xKZGOMk4JRkZi2IXR3Ay6j8jA/gjowGGIDVUVWJtCB7T/yGoYUt
	 SgvwEdclwf/IIKfyKlG8PPSu2O9TmiCLP6JjHZPw8eXaoh/Of/lTcumbWBK8fEpu4Cyi8
	 PgvCCbLycwtSFHad5GI+rC3Ja8qntLZueJ4xwmNozG3q/2/R2jI84530PDB5yagjfPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=v5Am7MQb;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F00606A32A;
	Thu, 19 Nov 2026 11:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7F00606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=v5Am7MQb
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 90EE3C4CBF3;
	Thu, 19 Nov 2026 11:00:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5A3ED60237;
	Thu, 19 Nov 2026 11:00:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D512A11BC0ED5;
	Thu, 19 Nov 2026 12:00:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795086048; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=sfUMDLC0E22rep4FDmPzBeyywhsxbumM+Fv7jNI+gdQ=;
	b=v5Am7MQb5ExI0e4Fs0d026Nwlwk2VYY594seRtZCGf9OMSiq5Ui++9aseq7iT1o9X8q3+c
	glDFhs/xYYvnYUpUCP86QZoex8z8iWe18xlQY8Z/3JV+wo9eKUaIcDHwL91EzyOhITicnG
	JdAteBNP7tzIEKUPsXW3jYcu0UKYwex4qOGMTRe+XX+kr4qcc+3cSKUiIfxVrOjBy4F/xr
	b36tiXcs8Ga3aNnBvy+BSt9Wk1DLghucOdF8eG61OKcERXzpsaZoImFceyYjWCdD9p1Pa4
	HysBthyJawd6Wv5Dp76ndggyJKoU0O/RJjpOGNUWKfurr1f+qPHqrsIwiWwBQA==
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
Subject: [PATCH v10 4/5] ARM: OMAP2+: pdata-quirks: Pass auxdata for simple-bus devices
Date: Thu, 19 Nov 2026 12:00:10 +0100
Message-ID: <20261119110014.582363-5-herve.codina@bootlin.com>
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

The simple-pm-bus driver takes the of_dev_auxdata lookup table from the
platform data of the bus device, following the convention introduced for
"simple-pm-bus" by commit eda080eabf5b ("drivers: bus: simple-pm-bus:
Fix compatibility with simple-bus for auxdata").

omap_auxdata_lookup only has an entry for the "simple-pm-bus"
compatible, so a simple-bus node created by of_platform_populate() with
this lookup table has no platform data, and the lookup table is not
available to the driver for that bus.

As a prerequisite for introducing platform device population for
bus-only devices in the simple-pm-bus driver, the lookup table must also
be available on simple-bus devices. When the driver populates the
children of such a bus from its probe(), it takes the lookup table from
the platform data of the bus device; otherwise those children are created
without the bus_id and platform_data overrides.

Add the corresponding "simple-bus" entry, mapping it to the same table
as the "simple-pm-bus" one.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 arch/arm/mach-omap2/pdata-quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index b947bacf23a3..f591a94d9c73 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -491,6 +491,7 @@ static struct of_dev_auxdata omap_auxdata_lookup[] = {
 #endif
 	/* Common auxdata */
 	OF_DEV_AUXDATA("simple-pm-bus", 0, NULL, omap_auxdata_lookup),
+	OF_DEV_AUXDATA("simple-bus", 0, NULL, omap_auxdata_lookup),
 	OF_DEV_AUXDATA("ti,sysc", 0, NULL, &ti_sysc_pdata),
 	OF_DEV_AUXDATA("pinctrl-single", 0, NULL, &pcs_pdata),
 	OF_DEV_AUXDATA("ti,omap-prm-inst", 0, NULL, &ti_prm_pdata),
-- 
2.56.0

