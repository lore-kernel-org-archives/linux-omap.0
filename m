Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B724286D60
	for <linux-omap@vger.kernel.org>; Thu, 12 Feb 2026 15:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770910096; cv=none; b=CQDNswA0TAbk9ZqqxlBH/n/GjWH7AZnMOq18904H9VyLjbKlzuGAP41wejl49qq8FBENWSBjv0NLWkkuC4PYKqeTH9ahK79WO1ps3CkFvjmkel8Ks7tmx8fH4lE69pPvqJZ2xO59DN5Yj8G1zpKVWTblkGZH4/vUyLS1MVjefSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770910096; c=relaxed/simple;
	bh=kAg7GnuZyI5ZzTuZI204r7cRM7u3uXOT4+LAvG87HQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RxWHiRF/Hdzv8AfUkmioBllBcYelwiGvHi2LVTHGrtfBdQvTLueACCqBRztTiniCWrpgct7zGBHGBRfwbE9mFBRFoCfVka6A2qI2z0tqiuRfGMQtMKla2pUiWzGPw826YJh2XjaRVwXrjVrqo+MJDqo8KrThavJTDaOsOwOXU+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=v9+M6EXS; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="v9+M6EXS"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 41C651A0E60;
	Thu, 12 Feb 2026 15:28:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1799D606CA;
	Thu, 12 Feb 2026 15:28:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3788111971B05;
	Thu, 12 Feb 2026 16:28:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770910084; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=thbPNnRijTLf9gzZkZqQPZn2GPekIDtSoeywreYAt34=;
	b=v9+M6EXS3+KSQIsQQmNwLg6DbjW0+wRqi7o6sBQLkugxgmlxHiRjyjMZnQfsGKVFsch8gq
	xrsyBnl3hIiRFDhaffNj48tX7Zn13JLAWPhGwpOKZOLz9F5qk5RAmDzJZ9fEYbaR867j/Y
	CTgGtnfUXfNvy0H/CXjRqFKiIufEzQeQAoGdyz1kJBvEP7C/BaDm1PPStw5g2P6+Qbx+m0
	1j7tT8+XaZ8QlaETs6XZtAu96wivAvVy5dxnHAZCxPgRujZ+GPYiBqTwgwYsf/Z0j6fH6y
	hsn6povRGcFrpw0/oR9y1IMsO5xBeNQOEpDwL/QR3ViSXx9yNlxc+dDvslrXSg==
From: "Kory Maincent (TI)" <kory.maincent@bootlin.com>
Date: Thu, 12 Feb 2026 16:26:16 +0100
Subject: [PATCH 2/5] ARM: multi_v7_defconfig: Enable TILCDC DRM driver
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260212-feature_bbge-v1-2-29014a212f35@bootlin.com>
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

Enable CONFIG_DRM_TILCDC as a module to provide display support for
TI AM335x-based SoCs in the multi_v7 kernel configuration.

Signed-off-by: Kory Maincent (TI) <kory.maincent@bootlin.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 7f1fa9dd88c92..196b6872ca463 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -735,6 +735,7 @@ CONFIG_DRM_RCAR_DU=m
 CONFIG_DRM_SUN4I=m
 CONFIG_DRM_OMAP=m
 CONFIG_OMAP5_DSS_HDMI=y
+CONFIG_DRM_TILCDC=m
 CONFIG_DRM_MSM=m
 CONFIG_DRM_FSL_DCU=m
 CONFIG_DRM_TEGRA=y

-- 
2.43.0

