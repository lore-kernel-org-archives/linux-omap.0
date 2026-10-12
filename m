Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574993F8707;
	Mon, 12 Oct 2026 12:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791807015; cv=none; b=oqhhlGrHn8utd5zAbseZCeW42IVaykf+I56MGuzZkvpyrTBchTw1hxZUm/pIPBr1MiKJWIjsOdzet4TOvp3LUeBGzt17i+OS4rXR4oXg3sjwf0+aTCPntvtQmx+6skL89Dtn0JHg/HS/zNlPKa+TUE8tedLxCv34M6KiYveGgW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791807015; c=relaxed/simple;
	bh=Xkq59yTDevYV+t7jHNaIsaQCYCHstZQRVe6Isa3N+rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wp3HBg1OcIFnVRfVV5korKTujW+I7nmWinsFNgxVoJh1gntkBX0fC7+zlcAZgLQ4bUEwGXpOAix5XCwAFX7OQH2EFP2Gbf5gdLud3KXnrTWEn16fA538C2ZhDbyA6e8etxNGCwzWa+Ei3+DbRzhB7oHHompg1753bUkJvWbSJLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=eiDJn36J; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="eiDJn36J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=no
	1Td3tdmEW7G6ld8W+IQiOPMrAFQrOX8CNuntiDDkw=; b=eiDJn36JJDAYeoFxFn
	j/hsQH7XjgfeL7Qyfq4GLL0xlbpa4JyvYnIwtDAix7MQG/lA1pneHtqnLqL/m3N4
	pk9QB61SLqLoJap86xqsmk+b+Me3Qp/q4NCaBLfVEFSws9v7QZgYQ+EAiBcnyLa0
	w64bcV0GhH1OCthYKktBP2WaU=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3Nz_mzcxqHGNeDw--.1037S4;
	Mon, 12 Oct 2026 20:09:14 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chaosheng Qu <quchaosheng000406@163.com>
Subject: [PATCH v6 2/3] ARM: dts: ti/omap: drop the two unused gpios from the igep0050 hdmi encoder
Date: Mon, 12 Oct 2026 20:09:09 +0800
Message-ID: <20261012120910.506444-3-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012120910.506444-1-quchaosheng000406@163.com>
References: <20261012120910.506444-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3Nz_mzcxqHGNeDw--.1037S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7WryUWrWUKrWDCw18KF45Jrb_yoWktwcEqa
	s7Kw4Iqan3tr9Ik3Z5X3s8W34xu3Z8uws3Gr1kKr47K3ZxZF4kGFZ7tF93Gw45WrZrKrZ3
	GryrtF1qyw4avjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRHMKJUUUUUU==
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC4wp78GrMzep3pwAA3z

From: Chaosheng Qu <quchaosheng000406@163.com>

omap5-igep0050.dts gives the tpd12s015 node five gpios. The binding, the
DRM driver and the fbdev driver all describe three: CT CP HPD, LS OE and
HPD. Nothing in the file references the extra two, there is no pinctrl
group for them and no other consumer in the tree.

Drop them so the node matches what the hardware and the drivers actually
use.

Assisted-by: LLM
Signed-off-by: Chaosheng Qu <quchaosheng000406@163.com>
---
 arch/arm/boot/dts/ti/omap/omap5-igep0050.dts | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/omap5-igep0050.dts b/arch/arm/boot/dts/ti/omap/omap5-igep0050.dts
index 0368e32f67e7..8e8325936cda 100644
--- a/arch/arm/boot/dts/ti/omap/omap5-igep0050.dts
+++ b/arch/arm/boot/dts/ti/omap/omap5-igep0050.dts
@@ -102,9 +102,7 @@ OMAP5_IOPAD(0x086, PIN_INPUT | MUX_MODE6)	/* gpio4_118 */
 &tpd12s015 {
 	gpios = <&tca6416 11 0>,	/* TCA6416 P01, CT_CP_HDP */
 		<&tca6416 12 0>,	/* TCA6416 P00, LS_OE*/
-		<&gpio7 1 0>,		/* 193, HPD */
-		<&gpio7 2 0>,		/* 194, SCL */
-		<&gpio7 3 0>;		/* 195, SDA */
+		<&gpio7 1 0>;		/* 193, HPD */
 };
 
 &twl6040 {
-- 
2.43.0

