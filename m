Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D528435513;
	Mon, 10 Aug 2026 18:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786385175; cv=none; b=SxctdFGVzGyKIh41NYiToREiAe4JzzSdDweY9zLBKuxCFvg7Fcnmm2ThjXzMYz7asnsypFY1CCht9Jy0hINhx1Mpw1MfX4DBoSf9ysvp8Ao0Jt6BYJXcdZVeBbDlyiQaGFciIsp/itC2i4ZffHBmxFn9Uzx8tMpLGZXTZrRe6Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786385175; c=relaxed/simple;
	bh=O6IYkgILTbk8U0DnVQBlNG6+7hs+mkXbRpK79O/KzWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mpczmoZmIR7AhNYXk4PinaSppY61/vR2z8O4DOqazyEYscOJ9LDfN/Ti9oo4adMSfT3JiEDXLvAW7lLCgYXyNP8bZPN6cbp6Hjlq29EdT7yKF+KZ5KQaIJ+SKg4B4xHyQ9BV4pgpPoMowD72SxMkHbpHvGbnGM1fnr2Ptb1V2x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Lg8fI0vs; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Lg8fI0vs"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DA2BF12B2;
	Mon, 10 Aug 2026 20:04:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1786385096;
	bh=O6IYkgILTbk8U0DnVQBlNG6+7hs+mkXbRpK79O/KzWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lg8fI0vsNqdlIlZYsxZXfJQ0L0PjLePJfu2or9l6OU/ebiyd6XiTViy/c56N4SlvE
	 Kea+91P3klMCjD4+Yn4Gwe6by1asHV4+s9szoYKXaZQO9OMWH6MVQtAMPuOc6umhJh
	 cejS9OsOXey4xnrM3r97WJgDkxueMY/8AHsfezAE=
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@iki.fi>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	linux-omap@vger.kernel.org
Subject: [PATCH v3 3/7] ARM: dts: ti: omap3-n950: Replace clock-frequency in camera sensor node
Date: Mon, 10 Aug 2026 21:06:00 +0300
Message-ID: <20260810180604.3034255-4-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810180604.3034255-1-laurent.pinchart@ideasonboard.com>
References: <20260810180604.3034255-1-laurent.pinchart@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The clock-frequency for camera sensors has been deprecated in favour of
the assigned-clocks and assigned-clock-rates properties. Replace it in
the device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/boot/dts/ti/omap/omap3-n950.dts | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/omap3-n950.dts b/arch/arm/boot/dts/ti/omap/omap3-n950.dts
index b99f97880204..2864ed8dd6c3 100644
--- a/arch/arm/boot/dts/ti/omap/omap3-n950.dts
+++ b/arch/arm/boot/dts/ti/omap/omap3-n950.dts
@@ -74,8 +74,11 @@ smia_1: camera@10 {
 		reg = <0x10>;
 		/* No reset gpio */
 		vana-supply = <&vaux3>;
+
 		clocks = <&isp 0>;
-		clock-frequency = <9600000>;
+		assigned-clocks = <&isp 0>;
+		assigned-clock-rates = <9600000>;
+
 		flash-leds = <&as3645a_flash &as3645a_indicator>;
 		port {
 			smia_1_1: endpoint {
-- 
Regards,

Laurent Pinchart

