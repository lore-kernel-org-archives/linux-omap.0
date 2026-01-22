Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECD7366071
	for <linux-omap@vger.kernel.org>; Thu, 22 Jan 2026 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769104481; cv=none; b=tglnk25oe5+IgESEXBjpVaQQ7tPdws3fZuxKEo/MJcLVkqzGEOM1mrQaZ3cScifHfZPmYVVIrm/RAjASM80zgq+b0cx9YnEhx/OvPKis9F9skr1PtCX05doLVcG7kQQDjx5+W5vavnmK93uwBBOqKGN2wkdTU+vpdEqf8K2p60g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769104481; c=relaxed/simple;
	bh=0crRmPwSiMEOVOi28jVt9hbp1foFHnuqbD2Zs4kEBXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hgl68bbnpxnInwVbSI/WX8QhYw0jRnHWP90cNPIAWvptt3Q5HeHb6JUVRW5yHA5RbXPBGbyNlc/0GM7+QkW1vBDMMk/7Ahuz+FWpfD+ZfK0l64nxBSmIEgiRV0S0nTJ8Zt92hTI9ZCXtrM7o8CCvdt/labcYdLYeYZ6c+YTmtqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B6SbVQ+k; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6SbVQ+k"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a09d981507so8810005ad.1
        for <linux-omap@vger.kernel.org>; Thu, 22 Jan 2026 09:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769104467; x=1769709267; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PcWylPv8TJyXsVhSrUUC23A8HhbSPg4cc6ltX4FBb+c=;
        b=B6SbVQ+kdpCkVJSdX3CI2LKDrP0so+a4UxoSQiTx9fWnizFXHgFOWfH+HLePWx39ax
         qRehUHtGl4E1o1QJAPNilAvRYFxbqF2Xfoe+nfFeFMJZEgAtdQjqEtKDgeZ37bFkKo9D
         TUo5yKDjDZjarBM1TqnBeO+6PBpc7Hk/3p0h7hHGDplNHVPWMKfsiwgiCzyVo9qEwAdi
         v8slS2wVcMvSbhQ6AArFla0YYF6c/cJ2GvPvRUKrbmAEPPuaEfh15FRZo+BoeDUGi9mT
         Sxz8YfAvxj4GFrVhsdEIElbA7a7REv/OtTI5QaJx6JsUZ5t89mt7ewS9hpzRPf5lRTZy
         1PIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769104467; x=1769709267;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PcWylPv8TJyXsVhSrUUC23A8HhbSPg4cc6ltX4FBb+c=;
        b=tGqI06pPlWoF0yfiOtkK5p5FVq0TnJRUljOugvSROhRGg1ubTTukiNpkfKNjVTI42M
         hFyBaFdnN4hWvCJEa0C3dSvoyVFsuv77xuIw7YFoNahZrZXMMJzqMgOct+TQbqdvq/kl
         5yXc2pyHtq7U7rAfpeFutXW9ea/l3vFwdC6U0TswvziuFN3yNSbFFcGIXmdLAjFLARAJ
         2BWkoB7GlOR4yj3t/Ddq61F0kd7aCrA+9IygOs+GFdMDKD6iwboOzSUz5QMek8aqR0b3
         gRMuOnqmbK8+uLuAiTvbEAlIuVcYo0rhjbSOP+q3mnftSAGs0x751wtgO9aAolUsix+B
         wySw==
X-Forwarded-Encrypted: i=1; AJvYcCX1acrJxNcIb0bTlavyz/Q42XlQf14f4O27Gwo/az6lGkMZsIhZUGQAMDoFJD0iCBPEjJ+QkAfEeRf9@vger.kernel.org
X-Gm-Message-State: AOJu0YzIqP4A+CbumQ0OlCQpKqkVw22mY6OM/iPVOHJLT4qb28FOGDAv
	pf73+ag0ak+/hWKlTAG8PFo/Ez+Kb5ub5U+rBj9Uv4zJ1wLTuIyshbmn
X-Gm-Gg: AZuq6aIerbo6OeeB3MWJ+aPpWtMvN8C6Cj9SSk57Tnk2DaToZLhTyOkD5yIIqX2IKK8
	ULZa+G3egmYXv8nYlKjeEdMlogtGPCVeJlrDPKcx6wBoE/dyfGaoGRG0ZXNPkcJMzJR9CZyNpFO
	ZcIihFqhNQuQjZOzv/IO2G2TBsCVUHK4ZeJlUJ5RUuA7+ZTCqe0WfVjljiSeht/6Iunh+2ENvmr
	tN51lr7rnqguFmJgI1INZdfugvQqhbB5Eedj8lTl4l4QcmQnYmFuHv4Ol22Ah9ypuZru4Adj2Py
	irksNaR7Luim9Jbu0H0jkkPekOPI5nHiolaOLs7CCTQm8rhHqYu8BQTdrhXSVFLGibofN2yBtSr
	l0y/POOR7WLjrndXGWLfAycckuEJ1dtBT5hylRS6QUA6nBWcYBJtcSKy/VrcBtArUT982Re3VF7
	RAaRWXvQyZc0qaNcmxthB9M+hn3hmozNobhQ==
X-Received: by 2002:a17:902:f641:b0:295:28a4:f0c6 with SMTP id d9443c01a7336-2a7fe41e16emr2855545ad.0.1769104467221;
        Thu, 22 Jan 2026 09:54:27 -0800 (PST)
Received: from Black-Pearl.localdomain ([115.99.251.203])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2a7190eee4fsm187745195ad.42.2026.01.22.09.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 09:54:26 -0800 (PST)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Date: Thu, 22 Jan 2026 17:52:57 +0000
Subject: [PATCH v3 1/3] arm: dts: ti: omap: align node patterns with
 established convention
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-ti-phy-v3-1-751619729433@gmail.com>
References: <20260122-ti-phy-v3-0-751619729433@gmail.com>
In-Reply-To: <20260122-ti-phy-v3-0-751619729433@gmail.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Roger Quadros <rogerq@ti.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 Charan Pedumuru <charan.pedumuru@gmail.com>
X-Mailer: b4 0.14.3

Update OMAP DTS node patterns to match established conventions.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
 arch/arm/boot/dts/ti/omap/dra7-l4.dtsi  | 4 ++--
 arch/arm/boot/dts/ti/omap/omap4-l4.dtsi | 4 ++--
 arch/arm/boot/dts/ti/omap/omap5-l4.dtsi | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi b/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi
index c9282f57ffa5..ed206eb84d02 100644
--- a/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi
@@ -328,7 +328,7 @@ ocp2scp@0 {
 				ranges = <0 0 0x8000>;
 				reg = <0x0 0x20>;
 
-				pcie1_phy: pciephy@4000 {
+				pcie1_phy: pcie-phy@4000 {
 					compatible = "ti,phy-pipe3-pcie";
 					reg = <0x4000 0x80>, /* phy_rx */
 					      <0x4400 0x64>; /* phy_tx */
@@ -348,7 +348,7 @@ pcie1_phy: pciephy@4000 {
 					#phy-cells = <0>;
 				};
 
-				pcie2_phy: pciephy@5000 {
+				pcie2_phy: pcie-phy@5000 {
 					compatible = "ti,phy-pipe3-pcie";
 					reg = <0x5000 0x80>, /* phy_rx */
 					      <0x5400 0x64>; /* phy_tx */
diff --git a/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi b/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
index 4ee53dfb71b4..d8b16cbe6c35 100644
--- a/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap4-l4.dtsi
@@ -72,13 +72,13 @@ scm_conf: scm_conf@0 {
 					#size-cells = <1>;
 				};
 
-				omap_control_usb2phy: control-phy@300 {
+				omap_control_usb2phy: phy@300 {
 					compatible = "ti,control-phy-usb2";
 					reg = <0x300 0x4>;
 					reg-names = "power";
 				};
 
-				omap_control_usbotg: control-phy@33c {
+				omap_control_usbotg: phy@33c {
 					compatible = "ti,control-phy-otghs";
 					reg = <0x33c 0x4>;
 					reg-names = "otghs_control";
diff --git a/arch/arm/boot/dts/ti/omap/omap5-l4.dtsi b/arch/arm/boot/dts/ti/omap/omap5-l4.dtsi
index 9f6100c7c34d..5c94db589dd1 100644
--- a/arch/arm/boot/dts/ti/omap/omap5-l4.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap5-l4.dtsi
@@ -472,7 +472,7 @@ usb2_phy: usb2phy@4000 {
 				#phy-cells = <0>;
 			};
 
-			usb3_phy: usb3phy@4400 {
+			usb3_phy: usb3-phy@4400 {
 				compatible = "ti,omap-usb3";
 				reg = <0x4400 0x80>,
 				<0x4800 0x64>,

-- 
2.52.0

