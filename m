Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD19244684
	for <linux-omap@vger.kernel.org>; Mon, 16 Feb 2026 16:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771260982; cv=none; b=N/vA0Ie5kkcaCVb+t/EzroYYraO33pzf/F7VlFJ6bexqDZ9xegcWspU+kc3PJPVruxQmcrSgVof367l1//xXmfSO0AGvXAnjTrvlVqT8u+8ij50AwnyMsloB9AJWVZIS+SwiYABGxnlPsXd8YoKYvOHbWA8YIhMQ90SkF7neG3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771260982; c=relaxed/simple;
	bh=zN9QT8XAkb2Sgn0Z/CZ9IDUnnI+CfE2W98DRP7UuIjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lcvH+vrzFepLpx+M/srS2S5o0RHn1cpqraDKO5ugNVHUNhklDjWece9TqrPD0IZaOdtYUlmG99BVyeDSjI9Q/q35Cn4mvrICzDgQJJL5ddXmpY6NTgg6vmIYIZFA1oBhcL9YGq5eCvliQCS8JHEvvetaT1OWblbsKXcTmqWjRRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0t1mzztA; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0t1mzztA"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 79D8AC16A15;
	Mon, 16 Feb 2026 16:56:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 69AFD606CF;
	Mon, 16 Feb 2026 16:56:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C22F510368019;
	Mon, 16 Feb 2026 17:56:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771260978; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=sC4bAGIJDG3yyvTBBbsE91LqqXHjAZB97T8h25dY4js=;
	b=0t1mzztA+BNXLahIfAmH2E6QJ6kshnwGDk7Oiyf4VeQCNeKcb4ZMB6HyVFoJBCMBuRRnq/
	/jMlF/p4Ft7L+DeFei/7Phv4hs7XjpK36PbgiyohDEZskKvjI9zwq7Iy42w+k/tdFSnmEr
	0NskbHG+XwPELNyK6YYFVOPdQyyYyMEHdDI6CSl2FpjIFi5MCOM6PX9Aq9iwKbrCabwDxy
	ClxXe0XZX6R1LjUeQtzO7lvNCntk/rjIphQGGNz5gb9JfEPesGSbov/QwhAmvjKKeeUBFi
	eWuIAEbGxr5k5WZBonJn7I9K9MreBjMX/I1ySokQVkOLPOf4oNXnKwhRO9t+hw==
From: "Kory Maincent (TI)" <kory.maincent@bootlin.com>
Date: Mon, 16 Feb 2026 17:55:52 +0100
Subject: [PATCH v2 1/3] ARM: dts: ti: Enable overlays for am335x
 BeagleBoard devicetrees
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-feature_bbge-v2-1-22805cfdbf62@bootlin.com>
References: <20260216-feature_bbge-v2-0-22805cfdbf62@bootlin.com>
In-Reply-To: <20260216-feature_bbge-v2-0-22805cfdbf62@bootlin.com>
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

Allow overlays to be applied to am335x BeagleBoard boards. This adds
around ~40% to the total size of the DTB files on average.

Signed-off-by: Kory Maincent (TI) <kory.maincent@bootlin.com>
---

Changes in v2:
- Enable overlays only for am335x BeagleBoard boards.
---
 arch/arm/boot/dts/ti/omap/Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/Makefile b/arch/arm/boot/dts/ti/omap/Makefile
index 14e500846875e..dcc6d4422e411 100644
--- a/arch/arm/boot/dts/ti/omap/Makefile
+++ b/arch/arm/boot/dts/ti/omap/Makefile
@@ -175,3 +175,11 @@ dtb-$(CONFIG_SOC_TI81XX) += \
 	dm8148-t410.dtb \
 	dm8168-evm.dtb \
 	dra62x-j5eco-evm.dtb
+
+# Enable support for device-tree overlays
+DTC_FLAGS_am335x-bone += -@
+DTC_FLAGS_am335x-boneblack += -@
+DTC_FLAGS_am335x-boneblack-wireless += -@
+DTC_FLAGS_am335x-bonegreen += -@
+DTC_FLAGS_am335x-bonegreen-wireless += -@
+DTC_FLAGS_am335x-bonegreen-eco += -@

-- 
2.43.0

