Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41188371CEC
	for <linux-omap@vger.kernel.org>; Tue,  3 Mar 2026 20:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772569834; cv=none; b=Wew7wlHjn39b0LhCCdhpcAZpesE79H94BILc8xLJdWoPbVzvn0MhwUcEHxZHtHB2Ch/GmzYNK5cFExrQrP8tCBP2gKveypB3w/Wi8eDAffhAZvzLke0A0FXcIyvCgZMKLAsXUKU7n7MB4NkzInxNqTAoOzyG6uwg4h9aAYlm/wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772569834; c=relaxed/simple;
	bh=spKaTaRAyEFBjHN3O+FzQ0d1t72031D7XZdd8u1NUjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EU6qC5csxeDwB0JNik4UL3s4ppDs53fe+GF/R8/ga8M0dX+ZIFQ56+3Y50AnpWR8iqaOwvD+nU+hQwrYn0/D2CuKDpcfgJteyKWsi02ZWbtQ+eGF95PeaBKv7bszZBSd1HEjYM0NHbSdsZQ3/H1NEhgBJHmZOeFwHekK23ZeVGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KR/3gsR1; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KR/3gsR1"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-899d6b7b073so57664456d6.2
        for <linux-omap@vger.kernel.org>; Tue, 03 Mar 2026 12:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772569831; x=1773174631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TQOnOVlc3pYD0aAOF8E7RKpLdhabU91Eut/dNYt+XQA=;
        b=KR/3gsR1+h69HmSJ3jbSF9lj6bAZG2MkJopRvt2Fxntaz9SeeLVCnARvlcNYevTfbM
         KNlXJvjGOsI/UXCzkRsQNBoXwZRhIGJsDWn4qetyaLUO3ZxOetljkb/Kqk1qCgdzGRbo
         pWCajb5tGzjNA1Tf/Vfohj5Njob1TFITQOe0uRgInyyQ9XVqZ/DVQWeAkYWBibaq4UWv
         5EyiHY9Oxgdp4q9hZPc1wlEwcMcTIuqjYcGHMM1+P9OQhrpm6eQaxmpsuUO4AJEGv7y1
         mezVPYVtCI9fa4Y+1ARVbdgzXjPSEFXtGscnZ++iVmQ57VovDRuU7RpZFJazExq11W5F
         5g8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772569831; x=1773174631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TQOnOVlc3pYD0aAOF8E7RKpLdhabU91Eut/dNYt+XQA=;
        b=UFeVWHp0k3NG4CjWzivEYSVBtnbc6rKFCBqUZU/dXUjiCLxlJHx5CLedrZxvt6jdBB
         zWrE1xgrxygs8MBD2gh/7quv1DvASOs3eTIi3Ati1JK/XQp5NC+CgNpdqoSIvUFBvtMz
         Wv3kvBiv7O4F5qUB1gyLDpdhiVn2TTcqlbedcOMXCNmUiJNH/VXGQC7YxfmkXj5kOD15
         DyQxPQuq1hPqH+Q+Hg03v2+EENCUDcMaSw9YeKKNsxDDrVXqlJ2ONdTl3FBaJ6Bd0/vj
         Og1YYWBUCPpR+3RIlmB68sSCdH1Ij58r9jmxm4f4Gz2hVEicexTqs40+0ZHwx9BR0ZpT
         iJ1g==
X-Forwarded-Encrypted: i=1; AJvYcCXnKxPz7O0ZBLLk3obebbMzLgzYPRlWfWpzEDu4SD6M3kbwDtVMIBY0vHIIde1s1YL7qdrzwleOjFwh@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyx+XJmLWBK8TYg11GOdNCJ8bZNJfS5R8WWpdjAbCAR+7CgjD4
	dJIbFEeJcMt3QfGm3vGj5TDeSAYbEom+j1fqk/2a91xIMHFx2p58CW5T
X-Gm-Gg: ATEYQzxEUPjaqm8kLOxZjVfCWuR87BfkdouBrV3l7GHT1I+CU4KV6XJo2D+T6Nptqgz
	YSxrHEXj/LQFNx4kOn/xAIF38JKuTV7ZD8Th1y2pZlBi9PzlxqOVBV3xOigFnPMMqk/ioifcngD
	x1UDfssryZobnjlWGP+t+qCag7psTshuDFGahrPbv9fyxYO4uHs/2b1UyxuoRGXuVwjdQ5YzGIK
	87x5X8sn6vUXudzkHdVnP64AOd0aQtGGLRhPiin0/c8H9xngCcjFhjclDvaNQD0fCTbCQ4rzQP8
	yCv+jQ7pmoRduyHG3pGnEqQXMf5+C1I6ttgHMpXgjTc2HapVlBNIqHnAWLz/umf3lXgFxg+uK9t
	ejdg9odLvQZQoVDIXHEAhg4Lrp07sL05Jo2Q9p7zSwOCFjVcK9t7ssBGKibjJFhZp8CkqqrAlv9
	IzzlH8wOFBTsqXZAzZN4N+HsLD+z07f4FR2SWBIQk6nwnpfPfb+2r7YosU3B9umhgzU1otOBTFK
	dFa8a/11/I=
X-Received: by 2002:a05:6214:17c5:b0:89a:9b1:a21a with SMTP id 6a1803df08f44-89a09b1a2edmr39390026d6.25.1772569831011;
        Tue, 03 Mar 2026 12:30:31 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf564c27sm1465032085a.0.2026.03.03.12.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 12:30:30 -0800 (PST)
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
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v9 3/8] dt-bindings: display: bridge: lvds-codec: add doestek,dtc34lm85am
Date: Tue,  3 Mar 2026 15:30:12 -0500
Message-ID: <20260303203017.511-4-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303203017.511-1-bavishimithil@gmail.com>
References: <20260303203017.511-1-bavishimithil@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible strings for the Doestek DTC34LM85AM Flat Panel Display
Transmitter

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml b/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
index 4f52e35d0..7586d681b 100644
--- a/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
@@ -33,6 +33,7 @@ properties:
     oneOf:
       - items:
           - enum:
+              - doestek,dtc34lm85am # For the Doestek DTC34LM85AM Flat Panel Display (FPD) Transmitter
               - onnn,fin3385  # OnSemi FIN3385
               - ti,ds90c185   # For the TI DS90C185 FPD-Link Serializer
               - ti,ds90c187   # For the TI DS90C187 FPD-Link Serializer
-- 
2.43.0

