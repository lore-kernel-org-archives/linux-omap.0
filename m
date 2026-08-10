Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C28D4322FF;
	Mon, 10 Aug 2026 18:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786385178; cv=none; b=aUe37ne/H5fLG58IqitCt7ZI+oZ7kuvqdEAOzCgs0Z0SgAW9GMHZ4HjWz7+1sFcrpYEqM6MxcGm8WmJcJEn9a3CknrUwXfOoliDTMbkpEChTE0KD0jBwk01XjwzWvoY7mDtFIqA183YT/aXrAa3UhvH+pi0huyjfQHc0pIhxab0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786385178; c=relaxed/simple;
	bh=ZeScdb4oJF+A/LIMfSApO6l8o7YsUnzDtpfrJMZIsfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VaX66d6SgS8JP4RpDcp7ToTpsfw/QgCzMIK624kQww1C3kMNYX3LhQ5xgNT55xXCIcVFqHbwLEjCjgVq7dnMVCs/rncrQExzc36iezYENikPN1RA6a+kJX8kx3ZRHbiGerNar6Okh7oVprgRuTfh8YwvSxlB6tgZPjsQgFTOrFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=TWVXW+0m; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="TWVXW+0m"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 63FDB22EC;
	Mon, 10 Aug 2026 20:04:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1786385098;
	bh=ZeScdb4oJF+A/LIMfSApO6l8o7YsUnzDtpfrJMZIsfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TWVXW+0mvz0DAJ8T2TY/29+FAN8UJO/qLp49r49jtAs7G8drk3cUt1ttW9/9DXoKh
	 znYfYM+yCM44YSRp92NIrD7tfn1do8TP9Vnx3ItBs4PiQABg6Q3n/35K2m0YJXTc0z
	 LqHkPHxUezB332V4HQhWRMUpUd5g4pZvTaa7HvvI=
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
Subject: [PATCH v3 5/7] ARM: dts: ti: omap3-n900: Replace clock-frequency in camera sensor node
Date: Mon, 10 Aug 2026 21:06:02 +0300
Message-ID: <20260810180604.3034255-6-laurent.pinchart@ideasonboard.com>
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
 arch/arm/boot/dts/ti/omap/omap3-n900.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/omap3-n900.dts b/arch/arm/boot/dts/ti/omap/omap3-n900.dts
index 7db73d9bed9e..97e9eae2b60e 100644
--- a/arch/arm/boot/dts/ti/omap/omap3-n900.dts
+++ b/arch/arm/boot/dts/ti/omap/omap3-n900.dts
@@ -792,7 +792,8 @@ cam1: camera@3e {
 
 		clocks = <&isp 0>;
 		clock-names = "extclk";
-		clock-frequency = <9600000>;
+		assigned-clocks = <&isp 0>;
+		assigned-clock-rates = <9600000>;
 
 		reset-gpio = <&gpio4 6 GPIO_ACTIVE_HIGH>; /* 102 */
 
-- 
Regards,

Laurent Pinchart

