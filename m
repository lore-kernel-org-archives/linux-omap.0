Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABE14D797E
	for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2026 14:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161693; cv=none; b=AycJhgYrTy2OVFTd6uf9lSgfbYvlH8Go2zsutQG0rIGMKyBhxvCnLi8o3IEokgemcrjzVYzE4PKMmkno33fjEBIJy49jJQ5FMefM/fKgE9/vsBvQ+TncNEUsjmlAee8XzMKaSYtWMmASFzSt58xCx0wmSSMhyWf6M4hMyGDEhGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161693; c=relaxed/simple;
	bh=pDlen/zLNF5pSkc+7mpw0u61XUlwNOOWig4yKnoWWnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lof0GS3SWADF0/IS91zfBQY1T3LojlXzcJUHssw3EcHMxReBfwtTiydAeYeS+CfNKJHJWJU31MnQ/Ij8knA8vq42JhfHT/GjdusfkDCzStGv9B7uUb9bZp7ZWyk323CM5bfX3lyYHWn3dNbXLLu+Wr6qgT9xQepMYVWtodwmK4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u4EZn/3T; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u4EZn/3T"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a061a13884so99365e9.3
        for <linux-omap@vger.kernel.org>; Fri, 16 Oct 2026 07:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792161689; x=1792766489; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oTWugQ07RJZxi4zUckj+Gcw87y2zOdheX+TP0+T7qDM=;
        b=u4EZn/3T+UlQiiCm/lEbwiBMzJvK8oUXt6fBCy8fdc2M/fEQ9wESjhRf71Wm5NLtCc
         CYyriEqJFoGdoCvlFCmbcXCtDdg9X65/k4ex9UfFdGc4GwWu/U3tosXBDA48tdrXu80d
         vpU+5lrxRM0I+pIhpICx3oAygsVQFI27Ez+yF7zaOWSixY1NzZhb2ObvIFeNkDPuZnsI
         zDE5QOYN4risy2FaXDLLD1TBfYr16t/dCCMT+06CTL5HbgenlZrdCk7IMqYFQhzCoa+p
         UD2VCUkCXUR88Xh/WKjG7RQ9bKz0LUicFvtHlGwlWSV6ECWciSHYU4WFz6FluJl6oSzn
         rGkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792161689; x=1792766489;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oTWugQ07RJZxi4zUckj+Gcw87y2zOdheX+TP0+T7qDM=;
        b=foia3EfkUodhsPiBKnFNhqPdvsbfLVE6h6AT469iwecz1vFgLz5GY822Ytx7srEVPo
         mN2aKHR+q/ll0YfAyDw3QCD+ieq6iYW+qubmssGdIuGlsu8xep3XOhDumpmrOsIhFNy5
         g1n4poj9dtSj4jTHcgonELuysETqWXlevu85Lp4WfzbQcv9NUbgfb80q3Iyd/Tl36CAf
         7k43iEj+Ff9EpHxfuIXKsjG9cjLyedNUuu0ym3dnmniHv+iJX0MM7phJo32WFgQrelya
         kUC2RziNoCSiNmdyQvePCahLKw/5yWqGWiq5NsXTchPcVLU3a0dV0pHO+DHhrZblgzC+
         MzOg==
X-Gm-Message-State: AFq9FYIN8fJAU4eyu3y3E9gG8QfK8wJNeDSF94U4tqLtGXvQjoo6qws+
	qTKiljqZfj4Qd/DH2QJhV7j9meeDFI0s/98mCbj8dIbZolVbeMDoYG571YQwROFBgs8=
X-Gm-Gg: AYBFou3wrOnL2lW/NKDSnWsQM+6q8eGdRIozD/zXHbfu6I6lWFaFZhJFRpEMH0OVGDF
	wQ2uoAU2gofVcqwmw+fWbG++MH5RBp3lhUEypkpIt3ZU9UB3h3IxiRV1umg+i+FDbRxDFSempso
	ayM3Tv6jqXzLs5X6ZXFj4TJtKg8MmQxVtmaPcN2J7QEDh8YKB90lynlMD0NmVZ2hw0SPpjnWVgT
	qEBbsnlAyvQ42EqmQnQhv12aFsG8crBYVCFHyJSgzqM4gnjv27o793oLKmZxSSU3LE1lUbeMQsB
	2Ar1T4qXyHxDX/4mgpf7SMbnkXHDhtV2LsoRYvGwxDNBSjqi2OF+zXKSSzfzN1zJvC4nPOHFueB
	5Jh9y9gBzJM/igCwR+n5XHKK+NBni/llCf0o0NMk61CPNcgFQT6ynOx/8j1oZi+0WT62DBnhINf
	qncj0aaA1feFLst++qyOcUW1cAkuFldgcNdj84iTUy/PSQb3SFc7Q7RkwTbAde3lJyznm//Ag5u
	w85P/oqrUFV1UpbXywCAqol24RQNYbkf+6TaPyZti5hLKcrUzp5GG+VhS/VLqBNgWH3xI8KSdZV
	Iw0F
X-Received: by 2002:a05:600c:3f06:b0:49f:ce78:356f with SMTP id 5b1f17b1804b1-4a18e4ca2acmr446522045e9.32.1792161689564;
        Fri, 16 Oct 2026 07:41:29 -0700 (PDT)
Received: from z13-ek5.local ([151.41.28.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4ecac3sm5949648f8f.27.2026.10.16.07.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:41:29 -0700 (PDT)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Date: Fri, 16 Oct 2026 16:41:21 +0200
Subject: [PATCH 06/10] ARM: dts: omap: dm816x: Update USB node
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-patch-ektor5-dm8168-dts-v1-6-b4ce30217028@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792161680; l=2792;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=yeoQMJZLdXTsEHqsBY6ksgO6GV/Huaox9D+QkSIjjJY=;
 b=hUsC6e73gt93LP3x/KbW6rl4RE1LBMRpaoGxAroE+S6HI6fgnl9crEsTbyV+xHq8m7uXraUxO
 l/v11BMwtZwCUNC481i6cYxwKSFdFrUcMGh2iu44yYm72A4iIqYpC2T
X-Developer-Key: i=ettore.chimenti@linaro.org; a=ed25519;
 pk=wCaUblFVaqhuBTQt/hAtysafsAaEsqj/yOD9SPlz6NM=

From: Andrew Goodbody <andrew.goodbody@linaro.org>

USB node was not working correctly with DMA enabled as the supporting
code had been updated without updating this SoC's device tree. Bring the
device tree more up to date so that it works with DMA enabled.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
---
 arch/arm/boot/dts/ti/omap/dm816x.dtsi | 41 +++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/dm816x.dtsi b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
index 7f3ef3a00ab8..5be9efc60785 100644
--- a/arch/arm/boot/dts/ti/omap/dm816x.dtsi
+++ b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
@@ -574,18 +574,27 @@ uart3: serial@48024000 {
 		};
 
 		/* NOTE: USB needs a transceiver driver for phys to work */
-		usb: usb_otg_hs@47401000 {
-			compatible = "ti,am33xx-usb";
-			reg = <0x47401000 0x400000>;
-			ranges;
+		usb: target-module@47400000 {
+			compatible = "ti,sysc-omap4", "ti,sysc";
+			ti,hwmods = "usb_otg_hs";
+			reg = <0x47400000 0x4>,
+			      <0x47400010 0x4>;
+			reg-names = "rev", "sysc";
+			ti,sysc-mask = <SYSC_OMAP4_SOFTRESET>;
+			ti,sysc-midle = <SYSC_IDLE_FORCE>,
+					<SYSC_IDLE_SMART>;
+			ti,sysc-sidle = <SYSC_IDLE_SMART>;
+			ti,sysc-delay-us = <2>;
+			clocks = <&default_clkctrl DM816_USB_OTG_HS_CLKCTRL 0>;
+			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ti,hwmods = "usb_otg_hs";
+			ranges = <0x0 0x47400000 0x8000>;
 
-			usb0: usb@47401000 {
+			usb0: usb@1000 {
 				compatible = "ti,musb-dm816";
-				reg = <0x47401400 0x400
-				       0x47401000 0x200>;
+				reg = <0x1400 0x400>,
+				      <0x1000 0x200>;
 				reg-names = "mc", "control";
 				interrupts = <18>;
 				interrupt-names = "mc";
@@ -622,10 +631,10 @@ &cppi41dma 11 1 &cppi41dma 12 1
 					"tx14", "tx15";
 			};
 
-			usb1: usb@47401800 {
+			usb1: usb@1800 {
 				compatible = "ti,musb-dm816";
-				reg = <0x47401c00 0x400
-				       0x47401800 0x200>;
+				reg = <0x1c00 0x400>,
+				      <0x1800 0x200>;
 				reg-names = "mc", "control";
 				interrupts = <19>;
 				interrupt-names = "mc";
@@ -662,12 +671,12 @@ &cppi41dma 26 1 &cppi41dma 27 1
 					"tx14", "tx15";
 			};
 
-			cppi41dma: dma-controller@47402000 {
+			cppi41dma: dma-controller@2000 {
 				compatible = "ti,am3359-cppi41";
-				reg = <0x47400000 0x1000>,
-				      <0x47402000 0x1000>,
-				      <0x47403000 0x1000>,
-				      <0x47404000 0x4000>;
+				reg =  <0x0000 0x1000>,
+				       <0x2000 0x1000>,
+				       <0x3000 0x1000>,
+				       <0x4000 0x4000>;
 				reg-names = "glue", "controller", "scheduler", "queuemgr";
 				interrupts = <17>;
 				interrupt-names = "glue";

-- 
2.56.0

