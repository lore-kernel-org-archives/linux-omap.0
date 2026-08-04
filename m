Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC33E4772AD
	for <linux-omap@vger.kernel.org>; Tue,  4 Aug 2026 17:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863189; cv=none; b=BlYc8UudDNqKNpVXHGO33p1EOmhrry2VXjF3FIuA8K6GEosFJq/7neeE74gqFNhYmqqynDCKr76bTO9cCalwTAGWw+s3nvDj9RyTR5pP45+7FXYye66G8Eedkyj47dcfYvJnpv2+yu3Ze9B5FvkQ+4vC7mRK1omhLe9DtAhuG70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863189; c=relaxed/simple;
	bh=rlYXKYm7bxRlc5nv82AOtjM/efwnX96ZRyu8nzXNm1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TDHdxwK6IFJvxq/xFwpky+xtc3dTQdB5rixPN6maGvb2clGu6YEfzhvTuqI6ZBcf4eIls8QHnMcBKP6PA4CdOae5Wlz4Oo7DykgAz0c3FjGv9xuQ3j0gwEp/azTaSNkngm60QentLYA6bPF5j32rWWQe3+jL63Z79gX9EmYGOww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKMxun8Y; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKMxun8Y"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-384422b05b5so7201a91.2
        for <linux-omap@vger.kernel.org>; Tue, 04 Aug 2026 10:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785863178; x=1786467978; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MCa01TPtHivagUzVUSgUMDIazwCfZxCbMPkVHrUWfAA=;
        b=SKMxun8YCSIwBYepjKfc73k5bQ4TGAGk0+rL/0I2W3mRgR6jEoNciW49c3r/ARL3HZ
         xqCQRH+Ia5s1YFxRYHiDVfnl69O09mYehEUCflSmePeJkSA+n23O6ECn6sEaVKsrEdlZ
         FBRQgrmnre4crpxeMKtdAY5uznFk/vvGbuA/rDtXJXDjl9BSRmDZGHFHRNzYhnU5v2nQ
         JaxwQhYYGcEkyVc3OfpWUIILG8K9Bcyxrf3PskcGXbEBd6EednN8t8MD4Yvw0vkCyhC3
         KehR+2O7YmpvYiqZKaW4ZrFHGO4doHchbl32RPVHdCWxbiAxRevs3+lcTx1JoWJS3RTj
         BaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785863178; x=1786467978;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MCa01TPtHivagUzVUSgUMDIazwCfZxCbMPkVHrUWfAA=;
        b=Uyq94aTuT0MR4mYOgoJODDrxSx3iaAHNXaM4nIYrID1HNnMePCjmPKpT7KJoRMs8/6
         QJkykTn39CPrF4q8whIpO7yBwAUa0g6wgBtXoEe+cAq73Z9ESrYWDkfJT+ret+bhdzFa
         83tDhliBL2VHZs8A7L8rUn2X8DJEl9DOEXTQXwov/J1myRc94VlPc+U4Q1edqX7ZgWPK
         AbX1wUtWT3hUvXlRzuU+XpMRrSMK3X0np+Lmxqr8Jb7VY5FJEyOJ4VIOL6e3SXK+Mv6F
         uVh935EtYQneekcT1rXFYM7aUJNUGjqvCBWS1Fzx5aCOaEt1bssw/AH4V0WbomDMFQbT
         merg==
X-Gm-Message-State: AOJu0Yw3ZXPLJSllusiJy/KTDbO/BZZheE1Lt+t2Zp5xccfor3HLbreA
	8rYDIotoujwaWO5Gd/6o4+DxnSx5XXkBPaFMsdVlc6JvoF0jjTEo/sh3
X-Gm-Gg: AR+sD131odWquX2p0Kp063Ojdy6HL8WBAcY1zCDeiAhgF/2xjU1AVJwxJO2q8NDdpqJ
	LxdBRRXXvTbsYHbjlO4wsfYAsvMNWHhF2BO22iFy/u9PQuxUU11AGtvnegAF2P56a0BbNyH+sdu
	7f9F+S6FigacWv8xMFU9sxUb5+9YTozkXzyQt4FCXoDLi/5QBNF6d6p0/YlCHMXzYg2jUPwQZXi
	oH7NIBQ/tCVVCVux+GRmXnygo3ZKMzx5S6+c7wpMz+dtEvK/YTNfZRXeQ7EF+fNESC1VLmxGO6N
	/c+NF5ahYazClyyleOOYe4aE3/UTIAABIfUnD+Q4cHN6vgppuMF7s2jCbUckACgC3q1yTWtyF4h
	+6tbtW9lNdr1d6Ks/TY99lZQkzi+lRKybN/kBgKVaom1Zs0fT9aS9YqDzdvrI8QGdf5y/3rRUSs
	XViLv2KhRreHOI4Bcnu3L/mW8RcxRZyncOnYswzjsMPC6ZMiYmkxrYf3jTjavhTcvjbd8IMIE=
X-Received: by 2002:a17:90b:264c:b0:38d:90c1:2400 with SMTP id 98e67ed59e1d1-3903c6d434dmr472337a91.2.1785863177983;
        Tue, 04 Aug 2026 10:06:17 -0700 (PDT)
Received: from [10.15.72.252] ([2409:40c2:5423:e712:2aaf:ae79:67c5:476d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca52d329sm5147124c88.4.2026.08.04.10.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 10:06:17 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Tue, 04 Aug 2026 22:35:07 +0530
Subject: [PATCH v3 3/4] ARM: dts: omap: dra7: add da830 fallback to am3352
 rtc compatible string
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-ti-omap-rtc-v3-3-ba3bbd8af570@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785863118; l=939;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=rlYXKYm7bxRlc5nv82AOtjM/efwnX96ZRyu8nzXNm1w=;
 b=jRaD22MIYUlWYtJnE09LRZECtM9x23ueO9p7GAh/xAN4sHi7zwJ8+VFGp8hdOvWk7/EHjCRK9
 1vYWS0vz4qBACdUS0ueiRmyY0HGdOW06i1cXXM0Jz34WVwuJjLnUEV9
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

The AM3352 RTC is compatible with the DA830 RTC. Update the compatible
string to include the ti,da830-rtc fallback to align with the device
tree bindings and other board files.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
 arch/arm/boot/dts/ti/omap/dra7-l4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi b/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi
index c8d325b0f57b..9e9609cf3188 100644
--- a/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/ti/omap/dra7-l4.dtsi
@@ -3556,7 +3556,7 @@ rtctarget: target-module@38000 {			/* 0x48838000, ap 29 12.0 */
 			ranges = <0x0 0x38000 0x1000>;
 
 			rtc: rtc@0 {
-				compatible = "ti,am3352-rtc";
+				compatible = "ti,am3352-rtc", "ti,da830-rtc";
 				reg = <0x0 0x100>;
 				interrupts = <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
 					     <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>;

-- 
2.55.0

