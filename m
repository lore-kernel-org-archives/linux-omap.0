Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC00435513;
	Mon, 10 Aug 2026 18:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786385178; cv=none; b=ttS8nz97wonBPLGMnwxA20m35F6IM0a7DbU8jbtvEWWltTXXNOMMgV3UxhFhXMZQ+rI2pL9IGkCRUMTrDoSyLHl798XYAJm+MsjJOSVJXuJVUC9JJtGw66e43qdV8fefQU4NEkMl9viccoxDm5kO6hpRsdWXE/+p9MaCxMOsLOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786385178; c=relaxed/simple;
	bh=xjNm2BWeE00PHyvJRjfE7hktMpltcv0ocuIcwkJfQJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hAUY0QjDmIBfmR4HE3TfVEBIpJYv25tMTGUvvCYlypKlRsBLQCyT++eli0zi6P3Xm/dRJkGP6GcFZFBBF2oyCKaWg6JEifS3p6JRYO/c0TYnVpXXVo5duEhCDNxNwI8d4VAIQLE64rS5qy/z8HSJxiRBeqMtQQg0isce/lI1FgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=aQng3Lkf; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="aQng3Lkf"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2485513D3;
	Mon, 10 Aug 2026 20:04:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1786385097;
	bh=xjNm2BWeE00PHyvJRjfE7hktMpltcv0ocuIcwkJfQJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aQng3LkfQTQUC6EkoO1aiIjPag6z/HA/K+k+kGC8wG0gOa7ObxGMmbKqAQT+wSzLJ
	 AgaZAJA+edwyUKHk4Ku9YZNQdz8fMRxsLrZlCvB9ApD4nKxRH/hO3oKu587IzKhn2+
	 uoeFsBMpy/FVTOhDxC83Zb7yu7IB4IJnO1urWBq8=
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
Subject: [PATCH v3 4/7] ARM: dts: ti: omap3-n9: Replace clock-frequency in camera sensor node
Date: Mon, 10 Aug 2026 21:06:01 +0300
Message-ID: <20260810180604.3034255-5-laurent.pinchart@ideasonboard.com>
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
 arch/arm/boot/dts/ti/omap/omap3-n9.dts | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/omap3-n9.dts b/arch/arm/boot/dts/ti/omap/omap3-n9.dts
index a3cf3f443785..2edc1933449b 100644
--- a/arch/arm/boot/dts/ti/omap/omap3-n9.dts
+++ b/arch/arm/boot/dts/ti/omap/omap3-n9.dts
@@ -21,8 +21,11 @@ smia_1: camera@10 {
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

