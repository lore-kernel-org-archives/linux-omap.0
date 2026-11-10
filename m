Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794340394;
	b=Nd89agZOZqGxTCwdcuU4P9fbONsJgmj4HsBVN6n/1Rlx6CSNLNeMh8y61eYcvv0WsEBn
	 O5VuX6t9fX5HUVSmDoxXuGpaBXs3g7kCR7ObNhGYAsOjmuyeiyhzaK1akdOr4MbnR4WJf
	 ScmWewg6eGSemXZ0iuVP9KTzf3GJgIr1jR5kaZpuaXuF6J9DqaE1C9KjpakWJJqjdjdjQ
	 aKwY7o96dowqyVZvf0LYUeCq6pxCuiVe4jvCzNgk+LNk5r/hftV1CHZx+jBOu702hokrL
	 GopxhFugm1UnfzKvgrJJizfWvtlDXHtw1al0I6usFdja/iuvGsLfBwxnBnhcXe2nHiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794340394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=WL9SHgfJTRGu/WBkYdNm7G/jAeYVCea7hdaqofQfU7g=;
	b=ckzILCeBJqi0vbRHfmzBcf40Ii3eI838pcV5RmBkefxlFOvpxO6P9J/fJkwbtHwKKyc2
	 hRlqhD7EsvKnPngyv+GxzXQW8HEVHBlLgkIQV/UpzK4Y2YeQ7BhXBzzpbGJzCUgJD1Gbz
	 bcplWbId0cyvBL4A7TUWLywRjhR5De9vbBgK6InHwO47q60tZaEnosB5Q5xEMEcdVNUyY
	 PbqzXeB1xryuaFHGq/XuzYv9d5X7VFuj8XWpWcFDwvw69vRGgRg7X2I2J6dAwe0F1JWGn
	 jeISQDqDT4y8CvignmNrj4a+Rqy2oWvkVNrCuPnlRk75FHqYtZxD1hFWfjcGKYChEVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RjJdQ4P0;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A63606A33A
	for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2026 19:53:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6A63606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RjJdQ4P0
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b09cc7ed1aso297815a91.2
        for <linux-omap@vger.kernel.org>; Tue, 10 Nov 2026 11:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794340393; x=1794945193; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WL9SHgfJTRGu/WBkYdNm7G/jAeYVCea7hdaqofQfU7g=;
        b=RjJdQ4P0TaxJRvRooZd1WV+O6P7NwLQnlInIdiOq9sDBKpRL5JMAJOHc57dvfPSCqA
         F0lcUbi0N8b3V6wddGJbLnWQ+CrqAnzoHBcxgSWkE7/RwgCLDoSRDGfwSN3t+h8vLADY
         t9m2mLl3w3K4OGN0zmD6qLafSjcx/13gHSXwb1zZNh2PFy3C25IChklwawBI3QN3Lm4q
         3l5VovYBJ4mRPYwXWilE4joz/BbiAj0jQdztGoU43KFkeEnvrEFNQniNlMFQk8o7Btss
         0tsYzCEaU+gbvVt21/RK6Bx/c3Gj/Ru46jKDVFqcv17WJtFPaYkP5Tf8gL8wsZbDoBz4
         kYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794340393; x=1794945193;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WL9SHgfJTRGu/WBkYdNm7G/jAeYVCea7hdaqofQfU7g=;
        b=BVkoUjDIPeDXDIqtRb0WpLXc4rvL1hncFGCHsVf5Bw9okopDEb18Rm470gRU5rK8Yw
         y9+odUDZKV4fQ9LixW31h0Jw8CbPnuD9LQuhPMHZeBVVTcBowuVa8KOXi6vZoI2xk3aV
         POdM6OUICJLlApto07VWdshH+yo472OtgfQOhKuKxDFmgyCQVEROkJoS1KAZ1gFgJWzl
         82tC2A/bWw8hV4G1ztyrl7jMauj5jTWePK1D2qeBfY5hi1wkgr5jdlCNLmrsvbGEUoR8
         ZMdT4eIY7W+1OVfLC88Q2RAPZpY9a43aJFTYTB82AXpeX4jQ6oFfgpsb7HNXtJ91aBR5
         WgDg==
X-Forwarded-Encrypted: i=1; AL+hErG/tPBCUGx6+lm/gxWf/Rejs+WmPZcH8nJ6R+Y+Ta5Zj/vJSfZXKNdrzMYQtM8qTaQrZE27Y92Fw9A3@vger.kernel.org
X-Gm-Message-State: APuU4Z8vJ3ls7oenHAVvTyk/6P+gzJPcTcjGpc4Ff/OCjQuWHyf0I7iC
	wo8sCzcfrmoPVK4KNJIStlNClcRNbhqboxK4lJmnTqfjrn6T8N053tnS
X-Gm-Gg: AYBFou3T2HivvSbkzYSY27URaRokXfxp+XXIA730tnpoHZSRUskH3gxxQnEfmd2kTWm
	IF/21eLb9bcWrLhEDjRJsxytl35kTuLG2XIHVFIxi/+p56kd7V3nFAIjPFkUyTrtbwzGVyEnG7r
	rBwr9dMGSMb1F8KDsSIoUuQ3h9ISPZhy2mwnNh39AMFm/lwzJsCEE0jBKJzUJFO6/FTHIDIEmA8
	oTVc7NdNNE0evSvPOY00kh0ucUiUlLA6YOkrT+vj3kfCLudROiVPUI03ZVQgbvH2VQupYwXb5rU
	lZWlepbYpQmrgv3BP+JFHaGDQv8h/4I1fnpIbIlZQPoHGSuomfludNq5pHpALiLa9yhLvGbfSFz
	jYeCbtgqGQRUYmZmy44ILvmrfXalZ6791oP/tOIf3WZ/eyT/qGcka+ykJGdViIEXRIy/UWdcVIE
	iY9pD6/glrvDF5EBVi5XJAWhJuxqyzZBrmxHdF7yshIh9DU+FI8C6lNkVLe5hlAkMEJ54q7c1np
	UJWF9pT7FHQbCJFm+gfOcUKq+bweOnAsE5JAoxctVwNqbKbvchql13FFuDCCz3j1rXSdoA0RoPN
	4YHwFY471sIVvcIsppFWH2xwLgrBXmAExEcHI38=
X-Received: by 2002:a17:90b:28c3:b0:3a0:c1b1:45fb with SMTP id 98e67ed59e1d1-3b182d34513mr149153a91.0.1794340393165;
        Tue, 10 Nov 2026 11:53:13 -0800 (PST)
Received: from [192.168.1.11] ([2401:4900:881f:d9bc:11f3:620a:3333:518d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3752060899asm8834225eec.11.2026.11.10.11.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 11:53:12 -0800 (PST)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Date: Wed, 11 Nov 2026 01:22:36 +0530
Subject: [PATCH 6/7] ARM: dts: ti: omap: omap4-panda-es: drop redundant
 fallback compatibles
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
Message-Id: <20261111-ti-omap-dts-fix-v1-6-19022d1ff4b4@gmail.com>
References: <20261111-ti-omap-dts-fix-v1-0-19022d1ff4b4@gmail.com>
In-Reply-To: <20261111-ti-omap-dts-fix-v1-0-19022d1ff4b4@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Mark Jackson <mpfj@newflow.co.uk>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-omap@vger.kernel.org, Bhargav Joshi <j.bhargav.u@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794340358; l=897;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=BRnkJw3cHyRHMzMZ0B/KYf4+f70CIw00mFhCF3duqu0=;
 b=aVlp7YfQ2U/wkPFkov8Zzk2jzrkg3QeNdbU342SFwuZTRBt8/vXz25600TLPBSI0VqH0tZZIw
 RjBAOTuggEbDyDKDbUeKrSEyKVEqf1WKVm311zOyYsANoKEGaCEL/FI
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

PandaBoard-ES uses the OMAP4460 SoC rather than OMAP4430, and no driver
matches "ti,omap4-panda". Drop both redundant strings to match omap.yaml
binding.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
 arch/arm/boot/dts/ti/omap/omap4-panda-es.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ti/omap/omap4-panda-es.dts b/arch/arm/boot/dts/ti/omap/omap4-panda-es.dts
index 70c609811d119..2c7de0bb02d55 100644
--- a/arch/arm/boot/dts/ti/omap/omap4-panda-es.dts
+++ b/arch/arm/boot/dts/ti/omap/omap4-panda-es.dts
@@ -9,7 +9,7 @@
 
 / {
 	model = "TI OMAP4 PandaBoard-ES";
-	compatible = "ti,omap4-panda-es", "ti,omap4-panda", "ti,omap4460", "ti,omap4430", "ti,omap4";
+	compatible = "ti,omap4-panda-es", "ti,omap4460", "ti,omap4";
 };
 
 /* Audio routing is different between PandaBoard4430 and PandaBoardES */

-- 
2.56.0

