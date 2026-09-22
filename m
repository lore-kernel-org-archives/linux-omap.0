Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEE74C10C8;
	Tue, 22 Sep 2026 06:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790057867; cv=none; b=sU1eDJJar9lKmjOxLR+011RpvXvX1UllHhXMp8qV2oImdk/K79oEzYxwLsWygBi3ztaKic5s4AI4bkMHiwdjOq3WIbg8MJ7FQRBA38MbTZM/kQtc2PM3hP5tLG/fOQ73whmyE90od5WwBeIyn2j7FIkL8oLEwRARMLgesaeCxIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790057867; c=relaxed/simple;
	bh=mV1ffW5qREuPIii6GlOu11q/oHXgWJFzo/LvMNKCgQs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n2oKac+9cJvV07ktQYbQuKvzzmkFPT5VTl4OSAqfpRrtC2JHEDCF2nywupRAInbSMLcUECwFQIsep1bMt5MLtg4MUvwSNX6JA5a91bqrb+POoZ/EgkQGtHQ8xQTf70Alxa6JiFZoanAD/Dc2XszTlYawHhAaEXFd/VdzFd7gpcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=Pc06wxI8; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="Pc06wxI8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:To:In-Reply-To:References:Subject:From:
	Reply-To:Content-ID:Content-Description;
	bh=qi+MaOlSGpl/UUecjy/28ZAgDgwsiLraw70UPSo95Vg=; t=1790057865; x=1791267465; 
	b=Pc06wxI8Z05d97jwLQw+hV1C/95QzLmae4fqNriqMaR5J8G2V7BpeYtsKQzKfIasvGGiBRgi1y5
	bIw0ycP/VN0hyFO+qU5/sVGvRq89jwVJ1B+g7AfqzK5dpO3LTWpsX3oNvVeSq1SqjHJ9tJo++DUUg
	bR7Z4MeENQMUktAUgAmoo6HEHdBVu4c9GAENhaSSa/u+V1Wb3+jk4qKP+SNZMl/IPmsvRg8jpBrpP
	KHmSZuaYm6fyg0ntnJxrJYzJQ8/pVg66kcxksECz94MxAKzfIK/4rGs1PGPwqqGvB+/E6HMjnk/Zo
	36X5gmzNhqWpGDOWkO3GpXd7AB0uAok0xaLg==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Tue, 22 Sep 2026 08:17:06 +0200
Subject: [PATCH RFC 9/9] ARM: dts: ti/omap: omap4-embt2ws: Add displays
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-b2-panel-via-bridge-v1-9-45ff36b364cf@kemnade.info>
References: <20260922-b2-panel-via-bridge-v1-0-45ff36b364cf@kemnade.info>
In-Reply-To: <20260922-b2-panel-via-bridge-v1-0-45ff36b364cf@kemnade.info>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Marek Vasut <marex@denx.de>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 hns@goldelico.com
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.16.1-dev-53874
X-Developer-Signature: v=1; a=openpgp-sha256; l=3329; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=mV1ffW5qREuPIii6GlOu11q/oHXgWJFzo/LvMNKCgQs=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDFmbZBOn/WsLTWp0vhN8ask1Z5GVm2tKzih1n5vgy+41/
 abKlhNFHaUsDGJcDLJiiiy/rBXcPqk8yw2eGmEPM4eVCWQIAxenAExE9z0jw9N+vbKD1bwigr+f
 fzT8rl3yQbM9m9PQ7qv1vIafUwSOlDEynNFu8RNVvxVyX4vz2kEvtfUnuFdrZF6pT6qWnvCU6dt
 xNgA=
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

Add the displays. They are behind a DSI to DPI bridge. Specifying the
required clock needs some more thought to find a sane rate, so leave it
out for now. Also do not enable the shared reset line yet, to have some
more recovery chances in case of possible display initialisation problems.
There were situations in development where displays suddenly work in a
sane way after several resets.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts | 120 ++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts b/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts
index e11d1931c42a..856b92fb1866 100644
--- a/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts
+++ b/arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts
@@ -120,6 +120,12 @@ lb_v50: regulator-lb-v50 {
 		enable-active-high;
 	};
 
+	unknown_reg: regulator-unknown {
+		compatible = "regulator-fixed";
+		regulator-name = "unknown";
+		regulator-always-on;
+	};
+
 	wl12xx_pwrseq: wl12xx-pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		clocks = <&twl 1>;
@@ -140,6 +146,120 @@ wl12xx_vmmc: wl12xx-vmmc {
 	};
 };
 
+&dss {
+	status = "okay";
+};
+
+&dsi1 {
+	status = "okay";
+
+	bridge@0 {
+		compatible = "toshiba,tc358762";
+		dsi-lanes = <2>;
+		reg = <0>;
+		vddc-supply = <&unknown_reg>;
+		/* reset-gpios = <&gpio1 15 GPIO_ACTIVE_LOW>; */
+		toshiba,lptxtimecnt = <7>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				bridge_in_right: endpoint {
+					remote-endpoint = <&dsi_out_right>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				bridge_out_right: endpoint {
+					remote-endpoint = <&panel_in_right>;
+				};
+			};
+		};
+
+		spi {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			display@0 {
+				compatible = "epson,panel-bt200";
+				reg = <0>;
+
+				port {
+					panel_in_right: endpoint {
+						remote-endpoint = <&bridge_out_right>;
+					};
+				};
+			};
+		};
+	};
+
+	port {
+		dsi_out_right: endpoint {
+			remote-endpoint = <&bridge_in_right>;
+			lanes = <2 3 4 5 0 1>;
+		};
+	};
+};
+
+&dsi2 {
+	status = "okay";
+
+	bridge@0 {
+		compatible = "toshiba,tc358762";
+		reg = <0>;
+		dsi-lanes = <2>;
+		toshiba,lptxtimecnt = <7>;
+		vddc-supply = <&unknown_reg>;
+		/* reset-gpios = <&gpio1 15 GPIO_ACTIVE_LOW>; */
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				bridge_in_left: endpoint {
+					remote-endpoint = <&dsi_out_left>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				bridge_out_left: endpoint {
+					remote-endpoint = <&panel_in_left>;
+				};
+			};
+		};
+
+		spi {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			display@0 {
+				compatible = "epson,panel-bt200";
+				reg = <0>;
+
+				port {
+					panel_in_left: endpoint {
+						remote-endpoint = <&bridge_out_left>;
+					};
+				};
+			};
+		};
+	};
+
+	port {
+		dsi_out_left: endpoint {
+			remote-endpoint = <&bridge_in_left>;
+			lanes = <2 3 0 1 4 5>;
+		};
+	};
+};
+
 &gpio1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&gpio1_hog_pins &gpio1wk_hog_pins>;

-- 
2.47.3

