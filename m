Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60843A1A27;
	Wed, 16 Sep 2026 12:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789562024; cv=none; b=aFIPsnP8ZVROEoiA8Vmrq21fO6xj2OAeWBZFXWz1Ae+k+nTZwOQdLNTuCCV2jfCDaUxKy921gLnJic0nCSyudTUhMQ8n9pT1Vm3UVq3oL0sVCStfj1GzYWCUBS2Q1jahftuUF4MUykX9cQSJg8Xh9IqFNSV3jseJCVztUNHNgG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789562024; c=relaxed/simple;
	bh=qtcFxadVM0GQvkXe3v7puT3ZDqCDXy1QMHJnrRdbz+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJICUFz+olU3VQ+dTqGQAmY97bJ5ntU37XFhiKvoq5eoMJDGkO9LLc8WeoOecAWJVA/MobsQm75Dd546AkM8C1COg5zisTv80UiDRnwmcYR7v7I+2+F9o1sOueoOvPQALrj9cUVo7nGLwp6amJFj5Sx/oRYPOr1R0xiUKur4Yqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=FJZ+1v6q; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FJZ+1v6q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Yw
	thTuFCXwhCBJs5emd3GoGmBBNdx1niAg81qBqSATQ=; b=FJZ+1v6qf9fbgWzOIX
	S1A4zX3b77WP7sEBTYv9OSDrKoN0PUeBJuTmSRxLlLhRxTQJuAxPp70g5UU3OhYd
	bGhmomt0fOSK22Pch61DaAqtLoFEPtdnrGioRw4bM5mSCOs43vp4epTI+0DdlTt5
	pk/BvLimCSQzCPBl9il3dTjA4=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wA3JL1KjKpqEbZDBA--.13280S3;
	Wed, 16 Sep 2026 20:32:13 +0800 (CST)
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
Subject: [PATCH v3 2/2] ARM: dts: ti/omap: drop unit-address from tpd12s015 endpoints
Date: Wed, 16 Sep 2026 20:32:10 +0800
Message-ID: <20260916123210.107841-2-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916123210.107841-1-quchaosheng000406@163.com>
References: <20260916015833.112753-1-quchaosheng000406@163.com>
 <20260916123210.107841-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wA3JL1KjKpqEbZDBA--.13280S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr48Xry8uw43urWxCry8Xwb_yoW8Cr18p3
	s29F4ktws7GF109F4DZw1q9F1qkF4DuF1ayF4UWryUCa13Xw1rJF1xt3sakr1UCayfZw4j
	9rs5WasFqw1DWF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pisNVkUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbDAA178GqqjE15RQAA37

The endpoint nodes of the tpd12s015 encoder on the am5729-beagleboneai and
the am57xx-idk carry a unit-address without a matching reg property, which
the device tree specification does not allow.

Drop the unit-address so the nodes are named "endpoint".

No functional change.

Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
---
 arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts | 4 ++--
 arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts b/arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts
index 76bfb364777e..f40017a0e414 100644
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
index 5eccff3bb4b6..4e8a5820b05c 100644
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

