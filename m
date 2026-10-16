Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084AE4A4853
	for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2026 14:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161690; cv=none; b=Mq/kZmx+J328XZJG7Bt0hPrjxck77B/zqxMpBtJIi7uaflLWirywK22Fjay4/A7JojP8L1kanbI7wWApE0ljcvYb0Q23E3fT8MuM4dxuRqLqMruxMbKVIJNdtZaN5JUUbQ221zKWVGgaXoI+xfCM/dlYkyYYELv+lTd3mXM8NjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161690; c=relaxed/simple;
	bh=Ypdv4ck2LmDWhfMcxtTVZOnd/mxsjho3hvj/YRy/7wE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mIpDGUuxHss5jiClJ6vBBPdDZyIn+OBREUuo0k02VvRtnO40mg1XU3y5aNpoU21wWsUdhRr9lOyVfe3LZVFb/H4iUpRLJA+ZWGbFE2VnxiAhk/nf0k1BhilXZ0vufwKoLXdMhR5cirrzofG6UXiqQ+LSHr2Nzsrh+WKtXMcQ7v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TjqKy8/T; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TjqKy8/T"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48c45111bebso4198850f8f.0
        for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2026 07:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792161687; x=1792766487; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I93wz8CKpgQy+526q8lOXNd9GCplSJUpEI+oY95QMxs=;
        b=TjqKy8/TTa1ZXXbMDqtp/8nZuESfGIdb+kkj2J/BGHjMgPGZYcYzL42RTZmthue+Qt
         Uj1lA8aBQjgAjzMaU2alYMy6puB63Ik//XCmEHIOlk3vdnq4zQNU9AFWWW4BiwW1/iZ3
         2VxWgB5qJntN9gDb/ZyXMdrcLb860FAvWBmNG09Ewh3HNzsOv5ltcJ6XdmgphyDkydXy
         dlsur8cVljCZlNhf+ecl2wG4QuPzhq2essp5ov3Yonz466d0dHcqv3f0BcnqmGPsCEA3
         tm50lDxOWUt2Xq3ceRqxVGutKJxFiKisn5YpmqqxWV55RDt6cJoY9SwDjRh52cQ+hZZd
         gGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792161687; x=1792766487;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I93wz8CKpgQy+526q8lOXNd9GCplSJUpEI+oY95QMxs=;
        b=jJTBjVr/qDyQXw+hq8j6k8d1yxHi/Bv+USdr2S6/2SitKnaRsWTY4Wln+2eWoBcaSC
         qCV40PXjzid10dFNIJJDjIwpWY0+W5rKHaTm5X/lAcHQ+tvIgN2jSlt6RRzanDuthcH7
         jFC/g3wsp/n6YbZqZlGCpFQV/XOiDvMWEAe5l1dDVY2sXrwoU1zvvu164IOiDs2pnLNB
         NsiVWaAeep0DkzRc9vvV34xTngfDYzGe8kx0Z0XPJED4un6ds6qZYjL7sw3BBMcuK3nq
         J1hgbpKStBdwaRZwp4PtBuLv0SItGShT1R5AMTrSuZMBEo6/2hyvihY2tokXt5k1ayrw
         p/3g==
X-Gm-Message-State: AFq9FYJqiLdGUcz1KgE/Q8ed125LKCq5fIX6Cwd6E2GIJAe2L99jrK/7
	Qz52xY5nDfKDDFkuy3DHRZUi932TM4pBuHH0AKAkWLZp3rMItCYmaCqNr0/aWsdb/JA=
X-Gm-Gg: AYBFou3qDwnF3GCAGuIXhOKvfX5RVlxKKw5nnR5+j3t2dmjXxSOSn8rKzrY4ySQzkD9
	ot/QqVd/W5uwHjqRxRppS7vDc74eNLHFjksXUXGjYuwiY6JmhUNfu9U/FV1QacEjWjhJGJvrPWa
	l7ApZbvF5SUw+Mvk2CZFywUhb6F4HRwlUzbmYTowCeAbUT9di7pqsVaMX28sNGWS2ZQwK3sMdmb
	A32yHZ8lqflklpxlFFJfpoU8AfnmmqkDb2Y78TzPASIWyyy7yrdk5MzMR4rl2O9BXqaoeeGxb3L
	nsmjCElUjt2uAFYLffONWuXRyk1rqZV3f5Vi24zliHwgTURsWokKXo6VGbEoSo0WggiUsct5zbh
	VglFqTbn9LFjC9vboODCPTgN1uhVbjVa7minf4egoaYMfPGPFSB8y+QaQiOYOAnW/CxQYF/CcU/
	cEBVpd9HA+UtqHQmeN8W8oe/KGqQ051E4p2sp+epUzja4MkGemiWrlSnNgxFs8vt8Av5WgpSe2o
	NOb+IWW2s1V+YIm1qDOLbciCTcjicwokWKhGXvUZkPZOcFCaJKtk/UTssGaqm8lVx2zqPPKKrc2
	uk+I
X-Received: by 2002:a05:6000:400d:b0:48b:10c8:2183 with SMTP id ffacd0b85a97d-48dbacdd2afmr41397725f8f.32.1792161687267;
        Fri, 16 Oct 2026 07:41:27 -0700 (PDT)
Received: from z13-ek5.local ([151.41.28.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4ecac3sm5949648f8f.27.2026.10.16.07.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:41:27 -0700 (PDT)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Date: Fri, 16 Oct 2026 16:41:20 +0200
Subject: [PATCH 05/10] ARM: dts: omap: dm816x: refactor and align MMC node
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-patch-ektor5-dm8168-dts-v1-5-b4ce30217028@linaro.org>
References: <20261016-patch-ektor5-dm8168-dts-v1-0-b4ce30217028@linaro.org>
In-Reply-To: <20261016-patch-ektor5-dm8168-dts-v1-0-b4ce30217028@linaro.org>
To: Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Christopher Obbard <chris.obbard@oss.qualcomm.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Linus Walleij <linusw@kernel.org>, 
 Rouven Czerwinski <rouven.czerwinski@linaro.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Ettore Chimenti <ettore.chimenti@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792161680; l=1896;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=bQlaSmVrxWRh3eFexaKgbJh5U7ftQwzZnbqVJPILtpg=;
 b=GdQ58uqjcnmGPDtcijnfZlLk3LVb6f9YJJVOwK6BFvPD1G8Wv2rOQyByMakkeuOpx0A87+uRk
 rR2R/Cr5fBcA9PSdu0Th6HGErC8ZzGFOUPpHQrBKzemmH4cIfOEq2mP
X-Developer-Key: i=ettore.chimenti@linaro.org; a=ed25519;
 pk=wCaUblFVaqhuBTQt/hAtysafsAaEsqj/yOD9SPlz6NM=

From: Andrew Goodbody <andrew.goodbody@linaro.org>

Update the MMC node in the TI Sitara DM816x device tree to align with
the structure used in other similar SoCs. The changes include
refactoring the node to better describe the target module and its
sub-nodes.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
---
 arch/arm/boot/dts/ti/omap/dm816x.dtsi | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/dm816x.dtsi b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
index 9c9d5e296e90..7f3ef3a00ab8 100644
--- a/arch/arm/boot/dts/ti/omap/dm816x.dtsi
+++ b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
@@ -423,13 +423,34 @@ &edma 20 0 &edma 21 0
 				    "tx2", "rx2", "tx3", "rx3";
 		};
 
-		mmc1: mmc@48060000 {
-			compatible = "ti,omap4-hsmmc";
-			reg = <0x48060000 0x11000>;
+		mmc1_target: target-module@48060000 {
+			compatible = "ti,sysc-omap2", "ti,sysc";
 			ti,hwmods = "mmc1";
-			interrupts = <64>;
-			dmas = <&edma 24 0 &edma 25 0>;
-			dma-names = "tx", "rx";
+			reg = <0x48060000 0x4>,
+			      <0x48060110 0x4>,
+			      <0x48060114 0x4>;
+			reg-names = "rev", "sysc", "syss";
+			ti,sysc-mask = <(SYSC_OMAP2_CLOCKACTIVITY |
+					 SYSC_OMAP2_ENAWAKEUP |
+					 SYSC_OMAP2_SOFTRESET |
+					 SYSC_OMAP2_AUTOIDLE)>;
+			ti,sysc-sidle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_NO>,
+					<SYSC_IDLE_SMART>;
+			ti,syss-mask = <1>;
+			clocks = <&alwon_clkctrl DM816_MMC1_CLKCTRL 0>;
+			clock-names = "fck";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x48060000 0x11000>;
+
+			mmc1: mmc@0 {
+				compatible = "ti,omap4-hsmmc";
+				reg = <0x0 0x11000>;
+				interrupts = <64>;
+				dmas = <&edma 24 0 &edma 25 0>;
+				dma-names = "tx", "rx";
+			};
 		};
 
 		timer1_target: target-module@4802e000 {

-- 
2.56.0

