Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8C1379971
	for <linux-omap@vger.kernel.org>; Thu, 29 Jan 2026 07:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769671981; cv=none; b=hjzyXvh6nekP4/31g6b9RzTB1za17ntlzCHR2rFKIC/y6cxcXSDpmUDzxkcLA4kegU3qMvWcPTI4WCSd+YM4mtMNw+0fS3fnogCJyHRqVWNMarjTBr3kil7Iv+hhVoWn3/t3CZ5Vc28Xx80ycqOKF1aCpIXN0RQJed9W1Uvg/GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769671981; c=relaxed/simple;
	bh=pi1fLBggw2w5nq+ku9XGxrPVz6Xc+gXO0i/5XkcUNq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9tWHs9Fb8u+qslP7Y95Mcpii2eWqFWZgmNmG0Wy0sy5otSxiRq10ixGgzBvKJ56jzkKOBkZjVNR3MrFn91LncKLFLflj4YXTd/eiyHa7qmPqid6TuEFlsSMrPKlvK02a9hSot+JvvpBaFxX1pAf50VQs13LqlVtA4JnelcXGeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+z+lwkH; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+z+lwkH"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-45f171cb842so456331b6e.1
        for <linux-omap@vger.kernel.org>; Wed, 28 Jan 2026 23:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769671979; x=1770276779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gnop4z34aVye00gIQguUoewYT5lM9SytbUgSGtePF4w=;
        b=Y+z+lwkHxsUlLPK0LMIsmTDXlLVUtvD1h8BQ4X1pyfKzjnf04D4TMLpa6+L/8nP6xC
         7gLrlinxNkkq3+DmBTOoGvxAXdf4vk6J52UdgCE7Fc8uwSmE2te4sCu/mSZSLu94BpqO
         zfJhhSsRs8v6w3MoyYTlmslL4osBlX5OwmdcgTf19ubc4Fb0xYH0hKj5pYI/fCVOafDe
         XwhfO9KtO1EGfU2Sbpi+JvEdZjCDJTghHr5COkC83sufslBUcqcuICjSHxFOIbEtUAMH
         2h0OKmdb1vASrNd+T56FvLjproWt/QGj9CBDHPYEcBSefQ2dnXbDwgyjGBFCLPLr2v4t
         ma0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769671979; x=1770276779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gnop4z34aVye00gIQguUoewYT5lM9SytbUgSGtePF4w=;
        b=uBZFnobaWGPr3IIJbJrUZjkKubYgR6AvXMC3AWlwngG6w4v7k2E4B0WP1UL0z33Kol
         cn9QRN3x9i2x/rPN83mUFNs9DBR5Z7nhoxCF2Ho8QbKdLgyGg8VxtzIzbkaD99z8Mixr
         oOVvPMwKr6UMOPscRNUIQ1lN/+pa+0izq0XfHuYCT81VxUWNZgxNso/7hDOPU6rI/T9x
         Fzl/wc4Os1uLwNFkpeiYO/oE2h1Kh5A37PdQKIwfNqTnrdjhiBviGJv/Tr1oTDRV7SL2
         6a58xmIuU3LoX9noIaOYZysR2lf5h3YUINBHY3xWIBGeJPgGzXaGzfhdEenU8yyDMLEu
         Jx1g==
X-Forwarded-Encrypted: i=1; AJvYcCV2w42IeHsgBFEEmTVWIbdfL/80j5EAAl/RvCklwal63Xr85h9tbKVrqCE+SyI3gylA2BzndpF32uN8@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu65o1PFYcdguQPOJnss/LDYI/Yb5zlZ4EfF+mKdkcVH0GYvJ7
	x/Z2jZgT4mFMbHhCucEvgnVKtas43tcUytMqEjWfRY6sqLaUWzfiE0QYsqBnC54J
X-Gm-Gg: AZuq6aJ4+c2WGASjc4N+Vf8fHA4fCEuYJo3HA2wojQNhtbH36fHwvXAvqVyWBUSf4p8
	T/c7cotBJSnOWMs3zFTZXFlOtB4b4sE4LI/lzg96665mK8hveMSITtnlVVDvb6h1ab4cLIkEgoK
	7mSBDGSq0e8Ia9F2UCYO1s1aCr3SiSOC/2QBDbgE3WABOVt/MLxz+StMuxoCtbg2dKyppCuHtGU
	/X2cP/WDj0X4JZ9DzRoG2nekGlY3AuhjwGKUIc3d1d2/0bCAeQiATv9sUpEoTkXZ6qnKj8GcKHW
	ANDrKtwK01JSjIRC2e63IU3eshSc8MqHQtQIMWfrPK9X2GCn6AtQgVmIN/8B4qOuTyFrzCHehWi
	64G1M7fSfsHhslc2iI/cPdJuEQPu+MxzpQz5bF2embpClBnBxEffqp7SiZbWhiDOd2+xrdwbHep
	zxCJGGQD+UBnTTaE2S32BTqrsjaoOjhL/vIp8zLUKaycu8p1hSeIYSVYg/ExwVqAMPONfDGgQ=
X-Received: by 2002:a05:620a:1997:b0:8c6:a5ae:e9cc with SMTP id af79cd13be357-8c728acf291mr254438385a.14.1769665665773;
        Wed, 28 Jan 2026 21:47:45 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36dd1cfsm30903216d6.25.2026.01.28.21.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 21:47:45 -0800 (PST)
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
Subject: [PATCH v5 2/8] dt-bindings: vendor-prefixes: Add Doestek
Date: Thu, 29 Jan 2026 00:47:03 -0500
Message-ID: <20260129054709.3878-3-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129054709.3878-1-bavishimithil@gmail.com>
References: <20260129054709.3878-1-bavishimithil@gmail.com>
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

