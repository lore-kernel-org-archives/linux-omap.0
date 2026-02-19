Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655403254B1
	for <linux-omap@vger.kernel.org>; Thu, 19 Feb 2026 21:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771535066; cv=none; b=p1u0pqx6Xpi3tZnCq2Cu4KfJFarbq8lvbyj/E5dBOlMzX7S+5HwZtxXchYK3//VVx2VemDQ3u1eIZYWcWOky9eXElLgfaMSHVMTP8MGuCyT6ObOxkYPNLACRZhzR2rryXfXHlV3p10V5DUp/yjvg+BSS37yQ58azOUYXFyGZaFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771535066; c=relaxed/simple;
	bh=pi1fLBggw2w5nq+ku9XGxrPVz6Xc+gXO0i/5XkcUNq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbZSdy4h04lK3868XX235sv1GA5e+pmyeAD8mZxdz8VBm6aG9Igk1aTf30YMvQ3TfuvpSYKa0XAgtJDul9fAljgV0N8SWBl4AJknWpSXcwUfD/CNZ6fhxG/9FNnHrYbe8Twv+AyBi4OSHZLDOvrp5zFkeYbe12dAsDd4YXEoR9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/lXx4U5; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/lXx4U5"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-506aa685d62so7570451cf.0
        for <linux-omap@vger.kernel.org>; Thu, 19 Feb 2026 13:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771535062; x=1772139862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gnop4z34aVye00gIQguUoewYT5lM9SytbUgSGtePF4w=;
        b=Q/lXx4U5Jm0EPamJb0hescTCYgC8eMtNhM3GnPwyJrtBObkBbWwD7WfCuY2as90OYm
         HqghXxuHPxfvXJJIpgA95CHrAYkXvVOSfIjiQOc4NDbR9JFJz0JvwExxwFHtvr4MLDw7
         r6JS8qIErG12I0+jGWzZnlyXhwUOX1p4yd2SexLRn+OVcY9Z2nDgDfAhY17FK+A9kQBx
         iIRHTIoGg+tpSJJiMwZhH1KRzY34lBJo/ugphsMeIf4PQ8BWuqOzKsA/O0UH2TsMT8th
         hXYW1YBW9qcQR+EfmiyRdDct4DWVk7Gt+kwZV+Dk/Ws/NgS23TZHy1vWnsrcn4Tv81Jh
         fN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771535062; x=1772139862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gnop4z34aVye00gIQguUoewYT5lM9SytbUgSGtePF4w=;
        b=UhVRqflitgJu1pbUXUC5fkar2sQt/VNrd9mwYBX/sOEE/Ps0HNzyoNok2J5CJHm8Oy
         2L23PbuS9MsMw0tLVzuuDaAQFELf/DFyGc/T9XLSnUWrb8wp4cMTTyZzfQR9zRFPAJ6C
         KnjMEzBF7M00pcY0xbNHj3UTVqLpFor6y7ywwRx+ZStdPOQhfwBtof+DLj4pQcIN3kVW
         nYc0NdnpHS17CKBhtXASfh7uqLO4zFL+LtPPHYF/ShYQQmeZEe5kunVlwOBF1GKoKIiA
         BjPpgyRKB5/B71i7brmdSCN4dMr2MxO+QIzjcBT0soiOXMNxpQ1J3CQ/vxCLRxCiLFk2
         VDfg==
X-Forwarded-Encrypted: i=1; AJvYcCVHo1tc/MsJX/gSJr1DtOu5RWUSLJ/6T1EFIflOHDWDTUFxla+sJXT9RTSBUZDRvnvODGXhAqbTWfEd@vger.kernel.org
X-Gm-Message-State: AOJu0YxHW6UT1t3DkNmCdI2rlOJR+USEl9KsoSXeUlt61P2FLzEAX8la
	8vXzvF1M4obr09SKqJeEv6qD5Hdy8zjaknoZWe42x74OCwQ/ZzAsWnXi
X-Gm-Gg: AZuq6aKOsxLY2USBOAn34ScQcIKsKre2uc31xfBk/cjvbQ6k1hwTJIv2PSccNYYezyO
	zch/tuyhgYpZlQ7nxxAsmvekxt4LH2QYCnljuRd1zL3wYYCUpA8x+EiB00OgqndtVdvOmgbtpqe
	xGjdGpcd56qNymhC1iMTxXhZlRwFk0YOuEWMZ4p9Wz84yIpIcs9Q+tvD/zSrVXoM/0j782HDM8t
	fugX3kF+K5+MDB1HBomgZEGReIR/t9nwPwLC37/MHCOjHEdQfFk7CVXKTFMrOuVd91HFIeXStKd
	QactYHHUJmLhMgMwMrRsz6DvrRUXzxLbwBHno3qbCR5uN4zFifuZQjGjPgvArZCysJ2YvIj+8DE
	xosvgTk90FodNV7GZGFB5cddLRlTntQDdUp18xJWgpKbILcqTZVRHSD5ELd4L+0007tvNO6bscf
	Hmm+cojEVu7ekIzHmjsGPlQxU2nj9W1cf63GO1noQ82mJfw5TmO16zVN4T9ddQb1xe77lmQmIj0
	WBbTh6G7XE=
X-Received: by 2002:ac8:7d55:0:b0:502:9e5b:2d83 with SMTP id d75a77b69052e-506e9264731mr79699451cf.75.1771535062155;
        Thu, 19 Feb 2026 13:04:22 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506b275d59fsm153971511cf.32.2026.02.19.13.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 13:04:21 -0800 (PST)
From: Mithil Bavishi <bavishimithil@gmail.com>
To: aaro.koskinen@iki.fi,
	airlied@gmail.com,
	andreas@kemnade.info,
	conor+dt@kernel.org,
	jernej.skrabec@gmail.com,
	jonas@kwiboo.se,
	khilman@baylibre.com,
	krzk+dt@kernel.org,
	laurent.pinchart@ideasonboard.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	jesszhan0024@gmail.com,
	rfoss@kernel.org,
	robh@kernel.org,
	rogerq@kernel.org,
	simona@ffwll.ch,
	thierry.reding@gmail.com,
	tony@atomide.com,
	tzimmermann@suse.de,
	andrzej.hajda@intel.com,
	bavishimithil@gmail.com
Cc: devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v6 2/8] dt-bindings: vendor-prefixes: Add Doestek
Date: Thu, 19 Feb 2026 16:04:01 -0500
Message-ID: <20260219210408.5451-3-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219210408.5451-1-bavishimithil@gmail.com>
References: <20260219210408.5451-1-bavishimithil@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add vendor prefix for Doestek Co., Ltd.
Link: http://www.doestek.co.kr/

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index c7591b2ae..70a195fc6 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -437,6 +437,8 @@ patternProperties:
     description: D-Link Corporation
   "^dmo,.*":
     description: Data Modul AG
+  "^doestek,.*":
+    description: Doestek Co., Ltd.
   "^domintech,.*":
     description: Domintech Co., Ltd.
   "^dongwoon,.*":
-- 
2.43.0

