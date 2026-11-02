Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649218;
	b=LojMIgOscyzEfbJcnMFLadi6V+zU+XHDheqwuIdbHwHoDHLkbHx/eBuYakxZlOUGZAgW
	 TZavwboPFx7GZRnFR/kYBUfnBCY6Idiaj9TvLRbMUyJNGoIAbpOUex7IPOc6LblzYJQf6
	 HlIAs0KSKRr04wUK9zwUhBmu0oSO3xnKoauPClfQQXBKyhjKNdCfxJu6Bg2AwgjUJ9q+U
	 pY/s05QofYq5WL1enUdLRBb9k6N1jm7IhgBTuM0MO9DsDRvThJWv6/I4rZNkUXyfmtOdg
	 XTbhVMLWt/9n3n/CcmqvJYQBDobE2iSYl3UOw8/eLCCbWONPoQ3zFaYPW3hmTZ+D6FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649218;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=WgXqLTaB6oglxj40wRZgSM14LGgOyB0NNgDc9089WV0=;
	b=EeQAqA6HP2hFe93I1Z0ea0vQ+LqXHYLF3oW67t0uHdj1Q+JkmVNX+XjixOJebhz02Mhz
	 i1QUGGhXMLEd7ykUtgaqf+nAL5ej7V4vGTrxp1Shy/jumWpy3Mni3388/Jlhj19dy8q5o
	 nHfQoDFRRoz9pkevpSebdyZkb3peT7RMLq/D8AjO6NLmxGSukrNOopJd5nKKBhFB/eC5q
	 T83h+aScb+BUga8LSgrfDvyWbQin9gM6o1ne9ReZGKJdPKb9lhlvezkB91CMOji1V44So
	 sJohT4vFOYIuTBxZft9EpSpwrqQvD0CD91izTDDgHhI/XUyOQE3tC1NycgGC04EoUOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=MWbw5Usb;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AF8606EE99
	for <linux-omap@vger.kernel.org>; Mon,  2 Nov 2026 19:53:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42AF8606EE99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=MWbw5Usb
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a2084d62cdso30206975e9.1
        for <linux-omap@vger.kernel.org>; Mon, 02 Nov 2026 11:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793649217; x=1794254017; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WgXqLTaB6oglxj40wRZgSM14LGgOyB0NNgDc9089WV0=;
        b=MWbw5Usb0cbBGRLJ92ZAJTrt0QFWs5YZyCyeW437/ftTQrr8PtGiFmnH6ZDDDeRgK+
         wDuPaD5LbUuySlWSjcZCPbDWmXxbLaK5YMEQFj3iGBQIAlM9MK5/agI/Q2qKTV/ajFAa
         Wdx7yFaqiGmQgySrAFn78nj7xAzevwiHYL97Gm9f790QUlegSW5XHaG3RQoglML5uErR
         0bddC7twe9dOkG0IcwatIXRokwYaWpss8ebERcFu7LpsOPKtw2F85pH/ZEFBiY+VQY5i
         l+truFJzXk6kXZKZ8/M6if1xbVRKYJL6r7LwwewjlJ36+VIuwtzLdqXPmWDsXIvsDeP+
         BSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793649217; x=1794254017;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WgXqLTaB6oglxj40wRZgSM14LGgOyB0NNgDc9089WV0=;
        b=Uf0iPm9ZfK0vL7hm9j/0EdjAx+mI+gz6YtRDBJmPcqDOO2JLVnZcdBI0Vf/OI/hpdo
         218rzM3tXbc2kXkAMKSaImc4rmGC78WpDAiGAvokLD5qpH0a1I5O/k1PseYMIYambvT+
         v/nArH2TAZLcw6HsXXyy0gchVgRalRHb7hvIUC6drChF0aelNLw0VwXSyV5VgsfuQ+Mc
         NUxvqUQtE6rpf1xyg3QpOjCATegZb+GLFfk27Q9CDaHGjoNbVEc5QjeBaqFRhsb0xGl3
         a6Uu43/HIbW1vjGmO3Q8bjH52otjutwEtA2v9VxnsZakJr3E6aoQpz6/EGF5GebA/LHv
         2Oog==
X-Gm-Message-State: AFq9FYJS4TCof30ywhrCU+P4z7KVMN1v3JUsCWGFkzlyFSwAUJ30OO9U
	jxEIg8X7tjhc9RO4ryutDj4YVJnkPqIPqcyULgfewmIhp5TPg4vfS5dGxjH0pjmibdg=
X-Gm-Gg: AYBFou3BwNZE9gelrzPs/jxfTbheAAVTASH4xtYmbfGjAgvTgibla04R8O+gxE1pUHz
	P80E4gDWrR6/nG6pKshEEJjIlEjLeD7ckub7QRH993p3f6hm5Crp2KYusyopXzoSAm0LoR7Wi1t
	RhXUDDI8tW73ILBFiVjTmchQgo58jK3eE3pcny/pV/tvCbYDt6/mHCLKGnYP9L02ywe7slwE/X3
	ONF0YwoF6oK9kxiuiOeTrhH5Ocqxsm1Gld7M98UzYb4YewswUK6ycnDtd3a0mEWbiHmOoKGCImG
	wU4sLw3dJONSjz+NCaZKGwPUYIk+/24upMVhIkikfC71NkB83vgnkFAPgnLvmqegspd09fTQr5c
	sC695Dn1nGGoiZAtIgxR6q+f8U64FE4K3cB5jBgZLaFN0PVNzLLmtYnLDOyrCnnHpfQfoPbq1JK
	8/yWi+oLnw++e6Yh+nYeULglc0JWcQPgKKDFIVMvgJxTgf3u1KNqB8Nyehgo5A/EBb2vrg+4yvp
	O0pidKU3RqRpQ5ik0Y22RtgqzBvch/c8S96TcvXM1HWbbOtC7lIlEZpzDqNJ2YpEsJ//cK3FaA9
	myH8sFfFLZgplQj1cuGMpBHY7QVrlAGT1dEuyX7iRydoj/hcLQtwiQDUi1AZ2f9GKrbDDhXPnxm
	3fpv5MrKifIE7ykC+7fh4WDObOLWxliwx0blz2BjwHyGFVPU=
X-Received: by 2002:a05:600c:848c:b0:4a6:42cc:bf65 with SMTP id 5b1f17b1804b1-4ac1709b206mr271307785e9.17.1793649216650;
        Mon, 02 Nov 2026 11:53:36 -0800 (PST)
Received: from z13-ek5.local ([151.40.161.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d3cesm24039784f8f.7.2026.11.02.11.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 11:53:36 -0800 (PST)
From: Ettore Chimenti <ettore.chimenti@linaro.org>
Date: Mon, 02 Nov 2026 20:52:52 +0100
Subject: [PATCH v3 6/9] ARM: dts: omap: dm816x: Update USB node
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Post: <mailto:linux-omap@vger.kernel.org>
List-Help: <mailto:linux-omap+help@vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-omap+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-patch-ektor5-dm8168-dts-v3-6-9bd6d1d128f2@linaro.org>
References: <20261102-patch-ektor5-dm8168-dts-v3-0-9bd6d1d128f2@linaro.org>
In-Reply-To: <20261102-patch-ektor5-dm8168-dts-v3-0-9bd6d1d128f2@linaro.org>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Christopher Obbard <chris.obbard@oss.qualcomm.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Paul Walmsley <paul@pwsan.com>, Russell King <linux@armlinux.org.uk>, 
 Rouven Czerwinski <rouven.czerwinski@linaro.org>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Ettore Chimenti <ettore.chimenti@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793649208; l=2863;
 i=ettore.chimenti@linaro.org; s=20261014; h=from:subject:message-id;
 bh=EJnKkiuemSceXMhSCbPdhy5GFuqZDHKo16lb5OWeVfM=;
 b=ESCjvnfz5BaaRmtGIY0BXm6cWwwqwJZz//AnUTjaN8AjdB+wYwYVBSVpHdY1qsQm/aRw6J459
 nTfcAhJhQm5APUGdpa6Zx677/Klogwl+XT/qmDwr+30RfMu+RVgFJIi
X-Developer-Key: i=ettore.chimenti@linaro.org; a=ed25519;
 pk=wCaUblFVaqhuBTQt/hAtysafsAaEsqj/yOD9SPlz6NM=

From: Andrew Goodbody <andrew.goodbody@linaro.org>

USB node was not working correctly with DMA enabled as the supporting
code had been updated without updating this SoC's device tree. Bring the
device tree more up to date so that it works with DMA enabled.
Removing deprecated usb_otg_hs `ti,hwmods` property in DT node in favour
of ti-sysc implementation.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
Signed-off-by: Ettore Chimenti <ettore.chimenti@linaro.org>
---
 arch/arm/boot/dts/ti/omap/dm816x.dtsi | 40 +++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/dm816x.dtsi b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
index 1e8d225dfb2c..314e5e580c8b 100644
--- a/arch/arm/boot/dts/ti/omap/dm816x.dtsi
+++ b/arch/arm/boot/dts/ti/omap/dm816x.dtsi
@@ -573,18 +573,26 @@ uart3: serial@48024000 {
 		};
 
 		/* NOTE: USB needs a transceiver driver for phys to work */
-		usb: usb_otg_hs@47401000 {
-			compatible = "ti,am33xx-usb";
-			reg = <0x47401000 0x400000>;
-			ranges;
+		usb: target-module@47400000 {
+			compatible = "ti,sysc-omap4", "ti,sysc";
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
+			usb0: usb@1400 {
 				compatible = "ti,musb-dm816";
-				reg = <0x47401400 0x400
-				       0x47401000 0x200>;
+				reg = <0x1400 0x400>,
+				      <0x1000 0x200>;
 				reg-names = "mc", "control";
 				interrupts = <18>;
 				interrupt-names = "mc";
@@ -621,10 +629,10 @@ &cppi41dma 11 1 &cppi41dma 12 1
 					"tx14", "tx15";
 			};
 
-			usb1: usb@47401800 {
+			usb1: usb@1c00 {
 				compatible = "ti,musb-dm816";
-				reg = <0x47401c00 0x400
-				       0x47401800 0x200>;
+				reg = <0x1c00 0x400>,
+				      <0x1800 0x200>;
 				reg-names = "mc", "control";
 				interrupts = <19>;
 				interrupt-names = "mc";
@@ -661,12 +669,12 @@ &cppi41dma 26 1 &cppi41dma 27 1
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

