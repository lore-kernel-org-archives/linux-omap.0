Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8335422578A;
	Thu, 12 Feb 2026 15:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770910092; cv=none; b=dFT2IdEJ6TyKQQsguCR7T1M/ntuuy8RjJdOgLGCZgMcquv5gF/zGiVGDWUdhWn9uBrJV1X5DpKtSeIKG4slAQ/v6QVaZYhVV33R89CyqG9Jmsg5UdbtypLS0tabfYfSQC2IcXc7uoBBL4s0IhwE5XPtUzvMZQS9rCKJqgBObCLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770910092; c=relaxed/simple;
	bh=I71qNTMzvMzAwNtlXCyxYnMHiDKBIu/HYDIf1798M9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lvy7MqiuQCPNIDdcVmNIuWBjzlhjhYTiBHv+ZqC/NFvAGwfyylSmkIzxtEFHA0aGpcy8aWPGz4C2heTFuo7W1NsBhNhbwEm4iYIEMz2NSRJto1VGCfVUQb4RNHmrszGVC1iTG87VWbONj1/Znu4mln9n4Aivmbn2Le6CYlzthA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PjV4fCcN; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PjV4fCcN"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 305834E40CE3;
	Thu, 12 Feb 2026 15:28:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 05323606CD;
	Thu, 12 Feb 2026 15:28:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5200511971B11;
	Thu, 12 Feb 2026 16:28:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770910088; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ek7OISNeQ+OcU+2gcXbX00XP+56retPqfH6Ygv5ZL0M=;
	b=PjV4fCcN2ZEOm4pvvdXsZyDrZs8FlK52ow42015KdXgtJVVmPq6MYI472D6gkxR4fo8szG
	Pav91Ud2lOZsEWKWJ4BMB6qwltYb7ruGGFWKbgvxOARtrbO9/Of82Z7eDjQswhjvK6/M+r
	m3gMjDIgG7WyE0ZoAY0pASab7kF4yf2CqLzay45CyOnF2Cqva40AHkX/drwTKN8CuMCs8P
	x04do6G2t9l/Zc6zLaIq78oLJ8qH6E3sWoK0M0bD+nfOiSaDi57Stcca86j6cQ9wB5d5/8
	Wxv3rJ0zcw9ky8cpYbkgJPRB4lCmEEzh5yXsO8Kuufkb1dQ0OpL5ZAsUxisctw==
From: "Kory Maincent (TI)" <kory.maincent@bootlin.com>
Date: Thu, 12 Feb 2026 16:26:17 +0100
Subject: [PATCH 3/5] ARM: omap2plus_defconfig: Enable ITE IT66121 driver
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260212-feature_bbge-v1-3-29014a212f35@bootlin.com>
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
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 4e53c331cd841..cdf69ac2e5126 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -486,6 +486,7 @@ CONFIG_VIDEO_OMAP3=m
 CONFIG_VIDEO_MT9P031=m
 CONFIG_VIDEO_TVP5150=m
 CONFIG_DRM=m
+CONFIG_DRM_ITE_IT66121=m
 CONFIG_DRM_OMAP=m
 CONFIG_OMAP5_DSS_HDMI=y
 CONFIG_OMAP2_DSS_SDI=y

-- 
2.43.0

