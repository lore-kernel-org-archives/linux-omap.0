Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B87274FD0;
	Wed, 16 Sep 2026 02:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789524012; cv=none; b=nPMeJnLiITZUM3C4V0bJFrCULBgckefL06DIG2464nWDDHgnrz63a2gP9q1yTPtWAIaxlhMGKXP5XjJaI6gDQs8BYY/3hwIIx/hOMDObiGBDpMtljiOOs51OB40JlOVZV7v+/PS9i2EX3tR8LulvNO2MXToFvHTAwV08bNJWv4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789524012; c=relaxed/simple;
	bh=zQ3b5kmw5JLRcmxAp1CI6DpkzUliEk0UL28aRYEPkN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LCLEK8u6S//FVxbwWI09XRh5E5KE3X/C8EK3q5KTT6LpnDGtet8j99BvRy+2e7aLxrhuFlRiOF6Ua1hpiaXQzp+YPmTG/BmQZOj8IWV0UxEO7aS6UVuDkYgYL1O4yvhVn2BZcZtF2rWhCHGGMdBmPCQot21BykUK6zWVoGcIsfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BUTxWAZV; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BUTxWAZV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=BW
	0xL9oOuUagOkBoGGchsZiOagcsUoaE1mg2KKNypGU=; b=BUTxWAZVv8VfMEM9g0
	O4NME5qvxfFwE0rGzUx6Dgw3iGb8N+iqvIyC8LSpHYiAEkVFAufZGDhkHV3tmp/5
	G553oHJnO+/pVoppHGVLIlvgundWPbmdNpk4Ek0Env0/DjkTEyxIhkwl8AtGinE/
	TAJRgNvo29dYFeiJJu4mkz0fg=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCHlXrK96lqbYrfAw--.61328S3;
	Wed, 16 Sep 2026 09:58:37 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-omap@vger.kernel.org,
	quchaosheng000406@163.com
Subject: [PATCH v2 2/2] ARM: dts: ti/omap: drop unit-address from tpd12s015 endpoints
Date: Wed, 16 Sep 2026 09:58:33 +0800
Message-ID: <20260916015833.112753-2-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916015833.112753-1-quchaosheng000406@163.com>
References: <20260915120327.47114-1-quchaosheng000406@163.com>
 <20260916015833.112753-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHlXrK96lqbYrfAw--.61328S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr48Xry8uw43ZFy5Gr1UAwb_yoW8Ww45p3
	s2vFs7tan7WF10kr4DAw1qkF1qkF4DuF1akF1UWryUCa13Xw1rJF1xtwn2kr1UCa4fZw4j
	9rs5WasFqw1DWF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pirHUDUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbDAA02q2qp983XgAAA3+

ARM: dts: ti/omap: drop unit-address from tpd12s015 endpoints

The endpoint nodes of the tpd12s015 encoder on the am5729-beagleboneai and
the am57xx-idk carry a unit-address without a matching reg property, which
the device tree specification does not allow.

Drop the unit-address so the nodes are named "endpoint".

No functional change.

Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
---

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

-- 
2.43.0

