Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21152BE053
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2026 15:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770910095; cv=none; b=aThmXTGn9h9fg84A21q22vCoej+udBubVcVHtLobfiE5yd271RBQDv+WakibSjqKpVoou17Z8WCuWkWW2QX3gWjGHoP0YKUnUW2OqffZXYMU7BxC9hAZiXyH2Q8cor7bPfeBuWzH2Q8NmWr/CU2Bkz24QqIIVB0TYAOSP6ezsJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770910095; c=relaxed/simple;
	bh=lZwX1MQ89Zic7bb9qtCCxBRAn1AF48HZWuSNigfSQHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZH1l8Ts0JB5jpjccFSgoowo/oqL1MyyV5V42jSWyZOyAa6U3fwDtPRjLbA35/xtYH82GjtzYbGU3pY5JTAfEmXvFtZWGpG0GCTyVGM789Qf79cTl0yzvq5hKZ3DZlI9Lnr4sk+QiVt9V0wr0LGLO0j69RSxoaVy3ce/w+mEZeiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aVG3NlYR; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aVG3NlYR"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A3A7B1A0E5D;
	Thu, 12 Feb 2026 15:28:13 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 78636606CE;
	Thu, 12 Feb 2026 15:28:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2378411971B05;
	Thu, 12 Feb 2026 16:28:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770910091; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UYzg7H8r28NuknnaHMhGKeY25Sfx8KUmF5qRI7gC69A=;
	b=aVG3NlYRlV0UEBW+qN0P3U0+aqIMVCKcvcl/zWf7zV+6RUAhKpJujdxe88CtuvANV++96n
	O4fU4uQ85lmrNh72DjeDDMOezvMjpGr18OZ+cACRGiwirFwViEnULg/WSyNXxIxywEahM3
	uRe2WQLZRmkfP8C3v504Zz+1WlHRLvtKoHo/RSHpchq+pQl4icJBoZcXR8x+xg6qwpsVI3
	BhhcVprWBxyWNJclEBKU+tAyD61OanHsAD6x7//XhqfcjhQinUCivuuPGRA9Ea2XBfn9dk
	vuiFIrCOI23s0lXiBbyeJ/5h7rrw2S4FMVPiTCY2Rwx+UHDCEWnDcXuTD4zuSg==
From: "Kory Maincent (TI)" <kory.maincent@bootlin.com>
Date: Thu, 12 Feb 2026 16:26:18 +0100
Subject: [PATCH 4/5] ARM: multi_v7_defconfig: Enable ITE IT66121 driver
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260212-feature_bbge-v1-4-29014a212f35@bootlin.com>
References: <20260212-feature_bbge-v1-0-29014a212f35@bootlin.com>
In-Reply-To: <20260212-feature_bbge-v1-0-29014a212f35@bootlin.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 dri-devel@lists.freedesktop.org, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Bajjuri Praneeth <praneeth@ti.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 "Kory Maincent (TI)" <kory.maincent@bootlin.com>
X-Mailer: b4 0.14-dev-d4707
X-Last-TLS-Session-Version: TLSv1.3

Enable the ITE IT66121 HDMI bridge driver to support HDMI output on
the BeagleBone Green with the Seeed Studio HDMI cape.

Signed-off-by: Kory Maincent (TI) <kory.maincent@bootlin.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 196b6872ca463..2c9587855f044 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -751,6 +751,7 @@ CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=m
 CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=m
 CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=m
 CONFIG_DRM_DISPLAY_CONNECTOR=m
+CONFIG_DRM_ITE_IT66121=m
 CONFIG_DRM_LVDS_CODEC=m
 CONFIG_DRM_NXP_PTN3460=m
 CONFIG_DRM_PARADE_PS8622=m

-- 
2.43.0

