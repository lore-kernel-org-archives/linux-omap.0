Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1BF2FE59A
	for <linux-omap@vger.kernel.org>; Fri, 23 Jan 2026 16:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769184766; cv=none; b=FX4CdmkxnGQ+IYrRuekZCCI9W2CrvOBTr1rUGfdkoZsMU1SDkIqA7QqzbzUKx0LgdjIMtTsGkfl7aAVTj502LJNfOS3/rKMiUNyr5l+KI7pIbP4TAxqXO+uIXqV0TWbMoSKuuGl+44WLsHGEajdFWd6VxEUj2Sp1RT4d/BhmD8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769184766; c=relaxed/simple;
	bh=yGejKaZh5ByrBfXLcr2NmrBBEetDse4CwlTbHeXyB7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FFPyA4a6TmUjZ67/JuHDmSjB1ml+NlftNzEJ07bLYLc2kvEdx/8rYhLfFfMHOvwyxoC/+PR+O2vud2qXXhOodtFN69vHo/Ox75bmYn7MvVIhGu387vO9NrtrnUe347J7Gl7+3Ws6bZhqFSrcb8FWnjywFacbIXmFoWVU2DAQsOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AN7MdFMl; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AN7MdFMl"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id F03631A2A46;
	Fri, 23 Jan 2026 16:12:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C3A1D6070A;
	Fri, 23 Jan 2026 16:12:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 63782119A87A7;
	Fri, 23 Jan 2026 17:12:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769184761; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9pRdDo0hFTS055NfI0T4ilJaSpXgnD1Q6tcrd1hCPuE=;
	b=AN7MdFMlbp5FJEZoN2mi0kvDp8vZlv9JdtgkIeBUDR/DWaiOg0D81F1XIu3lU4j/zFPSaP
	9KtvghPVLbiUDAnaToy4poSDDba/4DouOVkl3w6X7vANZubSyEvmyrrrx7TN59pUdVIeWr
	a4cxy2ef4Ne1d7yaYYZwM6TqFq/o9o8bQsIm9uycNrfc3h9AgVyh4OAmVKmF/0jrngw9WH
	NlPm3DHQIjtoOD/TuBVMcRZZ+m5aph1Ef0eU091IPyj1z5crzszAGTjz7zV/+N/P/DpfL6
	VS0qoqj93y5l5A1uRf1TUCPwDUsa4EQAVI1r176mAZyWxYWeGB+OQ/FLYw0p5w==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Date: Fri, 23 Jan 2026 17:12:20 +0100
Subject: [PATCH v5 02/25] dt-bindings: display: tilcdc: Mark panel binding
 as deprecated
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260123-feature_tilcdc-v5-2-5a44d2aa3f6f@bootlin.com>
References: <20260123-feature_tilcdc-v5-0-5a44d2aa3f6f@bootlin.com>
In-Reply-To: <20260123-feature_tilcdc-v5-0-5a44d2aa3f6f@bootlin.com>
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Tony Lindgren <tony@atomide.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, 
 Bajjuri Praneeth <praneeth@ti.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miguel Gazquez <miguel.gazquez@bootlin.com>, 
 Herve Codina <herve.codina@bootlin.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Last-TLS-Session-Version: TLSv1.3

Mark the ti,tilcdc,panel binding as deprecated in the documentation.
This legacy binding should no longer be used for new designs. Users
should migrate to the standard DRM panel bindings instead.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
---

Change in v2:
- New patch
---
 Documentation/devicetree/bindings/display/tilcdc/panel.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/tilcdc/panel.txt b/Documentation/devicetree/bindings/display/tilcdc/panel.txt
index 808216310ea27..b973174d704ed 100644
--- a/Documentation/devicetree/bindings/display/tilcdc/panel.txt
+++ b/Documentation/devicetree/bindings/display/tilcdc/panel.txt
@@ -1,4 +1,5 @@
 Device-Tree bindings for tilcdc DRM generic panel output driver
+This binding is deprecated and should not be used.
 
 Required properties:
  - compatible: value should be "ti,tilcdc,panel".

-- 
2.43.0

