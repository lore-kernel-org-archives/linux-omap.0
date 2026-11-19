Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795088321;
	b=YbhUc+P/XPtYCixIB6SYyNqZ82y9paZJGZ5HuNxUqI8Fu6Mfdt1r4Y4EBrqmsKZtsL6v
	 w5CGbmsfuqJ62farD/yDD/BL2BYZJcm43txc4VF+0r+vniTh/A4G5pH9Y1BHF+tzV7zpQ
	 k/Ae/oewKdCalBrXcEYSy3Nmic5uSHpCL98wBdAcg3l5gk1/rLxot69z8qtE7Mxs6pEP5
	 3yofKj2foTLwOSaUDjQj6ZBUm37l7PgNMJSD4EwA2IWAhpIDJ11IcHKHZGrzU+KKks/dX
	 VbpMaZG5BpaQKQIewu8gqEqPXzguqAA9jSvjHZHiuLxfr5qjpkmejPJOzZTmx8mj74w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088321;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=sfUMDLC0E22rep4FDmPzBeyywhsxbumM+Fv7jNI+gdQ=;
	b=Aml2iip2aj39LKsJA2rZgiPAeTzcvO7VZZESYOXlwynpBYdnlWvfdXYkpnGj6ytfTZIH
	 MABMCC936EVTterQgc7tByfwiDwxBsEh8wikpOseYTvRObw+E3qaE0qEejks/DDIZsUaW
	 bdX5fLnEACbpWhYPqTmGGeA/aFJ8giIn0tjN/LkYId5Qn2DeH2uDSyEEbaMediA5FGbbK
	 ZYmY8L3N00YI5UbtLB4tUoMJ7qQcO5uiNsYG9GjzpMYf28wCNU3kesrmtC3fJmfZ+hJM5
	 i3tdNOCjBufOo9Cczi9SvbEPDnf0gYvl1NgLuJPrZFS4/J19/vJOEBo6dV0cETKXOXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=vH62IJSf;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30E9606A33A;
	Thu, 19 Nov 2026 11:38:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E30E9606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=vH62IJSf
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C2D40C4CBF1;
	Thu, 19 Nov 2026 11:38:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8A23260237;
	Thu, 19 Nov 2026 11:38:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9B62511BC1049;
	Thu, 19 Nov 2026 12:38:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795088318; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=sfUMDLC0E22rep4FDmPzBeyywhsxbumM+Fv7jNI+gdQ=;
	b=vH62IJSfk2XQNAcZcOawsmDUuKG1V6DF1t78czfPI/wXjtAyyxmZ5g0DsFDmpPai74l5FX
	xwPr1af83Q2hl7omU7WEDzYUp/lcehTfdJ8QfEZWjVbGfJxDgZtjvw83uPVIPmt6YPg2Gt
	c8paOuDl5DewOPhtXLTwSJIvD6WKli62bvgXTrVWLpRzuqnuhN8PvHqo8CMgVzhEt16Qaq
	nKIFrH9nlKTEYyadNR4jw6uVMve1UM9XrODKurMtoh7l9e9xcpVtP+Rw8qvx1Q+qB3dAY0
	goEfv6piXKEx7Hl3V7uXl7B863e4urBnLgUS0BLYNR8TIVK/We89KMDDKgFtZA==
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
Subject: [PATCH v11 4/5] ARM: OMAP2+: pdata-quirks: Pass auxdata for simple-bus devices
Date: Thu, 19 Nov 2026 12:37:55 +0100
Message-ID: <20261119113758.603074-5-herve.codina@bootlin.com>
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

