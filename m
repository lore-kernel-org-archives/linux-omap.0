Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF9748CD6D
	for <linux-omap@vger.kernel.org>; Tue,  4 Aug 2026 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863161; cv=none; b=JSWxs53HNYRR2cYULGlp3V2xwEFLSmF2JBT4AJ55i2E561WfwKmlxACj9qRWgWS6futQhQ0zjQGInBxfFJxJP5hVow3mOogdcx27k5wmKWmFjEJAiJCC06ygvkazmg3YW0VM2s1m0qq8QDJn++F4/9UwAVnz6GqJ9zRGZOUBrp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863161; c=relaxed/simple;
	bh=BP5isHWJVSgsQc7eHb27miIKkXny1ILGVxUFS9gjsgw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g8yh8VMC8WfqVMeJeeez4SrLr2NaZZwHHS36NcyBde3oyg4zHgVV31DT5am4D8KG2O1qjbA5wcL5BfwKaoe3cslYQ6l46rvg3kmW4uPoAIVyJK7KkUPXNMrwS4ufFwWmJ/4oJq1kvhmXY/e0oxRayF2IgAAId3xPIGgw2TC6U7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5E/1iZF; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5E/1iZF"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-37f9e2642deso8142a91.1
        for <linux-omap@vger.kernel.org>; Tue, 04 Aug 2026 10:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785863149; x=1786467949; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VjB+Pa1McUr4XyZZTJgTh82TNmXCDaoM/UdBX+H7SC8=;
        b=h5E/1iZF9Tmx3U8tEzCB1W5zRqZHVkBs6YsyqX9jlRoPI4Vsq4OO6bAtA7D/4V3puS
         9n6WidwKBLsKG8K87/us1CZBIgqiLxApVjHzHXqWy8PRJxu1rcVf9VvgSbdQI7pCEDBo
         RlTA9YqAUya8mLjkV92IvVOSYy/goOTn8D+b6iuxiNhtj4xvxd1nQ/fsKWebrmr3/H4B
         TGEwPmO0uGFd20V34TyvHLz0YE7NIH7kgG7FfyrfZyAYuQPLFbN67Q2LDqTceP3z/DSd
         T8zdtk+8KvlWK1bcV/ppnGFyZMopIo/D1QxKg4bCWSt+Mxw/50hGAIIOMLzKvGLbdbNR
         jWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785863149; x=1786467949;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VjB+Pa1McUr4XyZZTJgTh82TNmXCDaoM/UdBX+H7SC8=;
        b=dHqZJI56KOIwWptiXMFglYaOwr8zfj4kZmDWGzH9VArSlE3om8hxEoSUkhD2LL6+TA
         YdFx5001oqHieFCyqv2389946nEyd1pK7qV4/Hvq/GXdRHgx7/h9AONJOU/Sfsabl4Rr
         w+m5XJJU5fB/eWZx+nZBao7g6zB1xrPDBLb+cXxdb7elP1ivvn5XxaSVrjaNdT3gvVHl
         Bz5bAzFC3L0k5qCdALv0bfCkTetG8CgUhZR492yi1aLkrFYUcdVg609xY98TDT6/JAGo
         vdXp6zUOVbCQ1ZPNNztkuQfDrEO0RRifnL8KqB3twuwRT6Y14GEaV7CysUAUDyXN5fb8
         ZjzQ==
X-Gm-Message-State: AOJu0Yw2bvktgH2ftzqj8ePDuU3kwZdPHGXV2vXr0ur8iS/b1x1OqWSE
	soRP5qux7Sl8zloGpQNXW7n2O7RmLwyAYNjdOwWHOZMzTwlmOpxjnBR1
X-Gm-Gg: AR+sD12H0TfdJpq7BfOO1bGuR2idlvclR3GBS255A++gZ5hkjDd+PobRSnn0rro8zNV
	6P2Vb30mvED6AStFNQR4oWGXCHiDKnQqzX85fy8wT+BFCdQxSqiFRa67n+8DHrW4VrZsRJIT+Zm
	X9VOk4EIs2uyXPBitz67+a3JdRKFotTXrVh3m/92AItt4+Lk8CqUo+a0p88AxqrwAZWLz6vFQxP
	JZr/S5avbNioafgUtJ85QCZB9wOSE8R/5GE+GSba6uio6jrdg2DBCa3WZr4SAwC6SLLsIslufd3
	1PlBB59mFM9w5MM7UmjcYJF4SVvLjZHuVyUQUDyRS4FRcttB4f3TBb+WppLmhMn1Nn8glPg+UNo
	7zwz3fIGaq5BESY8d16YkPA1K0xooCZ1t/yiN/202lw5Jt1hJ7Xp7nc9dLO/2DacSf7TF2nQtfX
	Wkdth6urzys3CMWED3GlsMQwxQiVA2+awDdDwC/yzm/QZaYGJ7nvfCtaiRKCZeHYmvocvGTds=
X-Received: by 2002:a17:90b:264b:b0:381:bcfb:e710 with SMTP id 98e67ed59e1d1-3903c64c81cmr451371a91.3.1785863149041;
        Tue, 04 Aug 2026 10:05:49 -0700 (PDT)
Received: from [10.15.72.252] ([2409:40c2:5423:e712:2aaf:ae79:67c5:476d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca52d329sm5147124c88.4.2026.08.04.10.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 10:05:48 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Tue, 04 Aug 2026 22:35:05 +0530
Subject: [PATCH v3 1/4] ARM: dts: ti: am57xx-idk-common: Remove unused
 ext-clk-src property
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-ti-omap-rtc-v3-1-ba3bbd8af570@gmail.com>
References: <20260804-ti-omap-rtc-v3-0-ba3bbd8af570@gmail.com>
In-Reply-To: <20260804-ti-omap-rtc-v3-0-ba3bbd8af570@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Keerthy <j-keerthy@ti.com>, Afzal Mohammed <afzal@ti.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com, 
 simona.toaca@nxp.com, j.bhargav.u@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785863118; l=818;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=BP5isHWJVSgsQc7eHb27miIKkXny1ILGVxUFS9gjsgw=;
 b=AglLCpt0Ow4mCeWLX0NY9rtIDhK/08WmnqunooL/nv6BacQqxByO9/HQvU1mtVT1ZJN8n7QoA
 FKb0J8AydZ9DB4o0MwIVRocvKlO/ncX/sFRjei1eYxdCCcuUFKTEKfM
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

The 'ext-clk-src' property is a legacy, undocumented boolean property
that is entirely unhandled by the rtc-omap driver. The driver instead
determines the clock source natively by checking the presence of the
"ext-clk" clock via devm_clk_get().

Remove this unnecessary property.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
 arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi b/arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi
index 43e3623f079c..ef4bd554e92b 100644
--- a/arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi
@@ -445,7 +445,6 @@ &uart3 {
 
 &rtc {
 	status = "okay";
-	ext-clk-src;
 };
 
 &mac_sw {

-- 
2.55.0

