Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014524A8A16;
	Tue, 15 Sep 2026 12:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789473961; cv=none; b=sw1gPWUft/oKDF4Ydag0aBIojfLlxhxjgvYTcu3dAdpr1AsfVsU3be31EIANnQVwuwW3Gyj0x+cxUlXr1LJn4glo0G5VxJpYPXB3J7vYe4psWTULNEayvMwqOvMBZvp+4SPle4fgi27a8RLtblmnEqxmyRWvOwJ3JYgveaCsXN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789473961; c=relaxed/simple;
	bh=N5LBpQSIAUQ/HFSk4lckCaDRGxGChn1gurbecmVvuhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T0ozg0oCdmH2hdfAc/7xVuzNZczUMeCNOSpta7ODHG1lUvI5Q0e+poY9WMlhGneibFEKkRtFOp820ogtIvEGFoc6twhoi/LmEO7qaRcfLZUd7quTctuTRWfH4bVw2ZdGCsZSxL4DOnuD0symm6lDnyTI+HaaEjGTMe/G6EJb57w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bSWXWuXT; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bSWXWuXT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Vc
	gRva2rsU2gA85H2EBlIuCFGwCT8FrfLOtefzUc5O4=; b=bSWXWuXT5EooQanUd4
	Qm61z43ttG6Wv/+ULHaK2qg65StKxkgjClMxlPmsDJZVOXD4J6l7OdA8iLd//j1C
	jA41cnxScKOLDgsuJk72760wMy6szUz97z6m/OF1xznPF3ljPXP49qZqt4Zk+rJG
	siGoumUBcmR+AKPsRqpeJ8D1Y=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDnN_cQNKlq1ig+Aw--.34817S5;
	Tue, 15 Sep 2026 20:03:32 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Tony Lindgren <tony@atomide.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Quchaosheng <quchaosheng000406@163.com>
Subject: [PATCH 2/2] ARM: dts: ti/omap: drop unit-address from tpd12s015 endpoints
Date: Tue, 15 Sep 2026 20:03:27 +0800
Message-ID: <20260915120327.47114-2-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnN_cQNKlq1ig+Aw--.34817S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7ury5Zry5Aw18tr45Gry7GFg_yoW8Cry8p3
	s29F4ktws7GFyFkr4DZw1qgF1qkF4kuF1ayF4UWryUCa13Xw18JF1xtwnakr1UCayfZw4j
	9rs5WasFqw1DWF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_NtxAUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5BQXjGqpNBQeFQAA3D

Drop the unit-address from the endpoint nodes of the tpd12s015 encoder on
the am5729-beagleboneai and the am57xx-idk.

The nodes carry a unit-address without a matching reg property, which the
device tree specification does not allow. A plain endpoint name makes them
match the schema for this binding.

No functional change.

Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
---
 arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts | 4 ++--
 arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts b/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts
index 76bfb3647..f40017a0e 100644
--- a/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts
+++ b/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts
@@ -168,7 +168,7 @@ ports {
 			port@0 {
 				reg = <0x0>;
 
-				hdmi_encoder_in: endpoint@0 {
+				hdmi_encoder_in: endpoint {
 					remote-endpoint = <&hdmi_out>;
 				};
 			};
@@ -176,7 +176,7 @@ hdmi_encoder_in: endpoint@0 {
 			port@1 {
 				reg = <0x1>;
 
-				hdmi_encoder_out: endpoint@0 {
+				hdmi_encoder_out: endpoint {
 					remote-endpoint = <&hdmi_connector_in>;
 				};
 			};
diff --git a/arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi b/arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi
index 5eccff3bb..4e8a5820b 100644
--- a/arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi
@@ -135,7 +135,7 @@ ports {
 			port@0 {
 				reg = <0>;
 
-				tpd12s015_in: endpoint@0 {
+				tpd12s015_in: endpoint {
 					remote-endpoint = <&hdmi_out>;
 				};
 			};
@@ -143,7 +143,7 @@ tpd12s015_in: endpoint@0 {
 			port@1 {
 				reg = <1>;
 
-				tpd12s015_out: endpoint@0 {
+				tpd12s015_out: endpoint {
 					remote-endpoint = <&hdmi_connector_in>;
 				};
 			};

