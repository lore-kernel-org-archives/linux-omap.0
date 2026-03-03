Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F954349B0A
	for <linux-omap@vger.kernel.org>; Tue,  3 Mar 2026 20:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772569835; cv=none; b=qJwRCzUomezd7FfizwkZUgvSZ/ldCp1XFgdJafRfT7G/xQDFik42+tnumwlBEZLB4UBFkOucvB7klB7usFQwHOwN8f0J9IqSM4KZgmjBhtWYwHTYvEYUXePHH61rdNKUOgI90+aEmBh+LiDo9oIMGkvaA0NkUEFZ3b6u/exyjkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772569835; c=relaxed/simple;
	bh=cihNYnflN3AVGRiDEm19DGgGttXrkIyvwuts3JIQy3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RiaMPvkLApMc0FZdELh/0/96s8XdbJ4oD1ODPpR8++irrQs44IsCSBYJcwdYXas70B2FYxsXVqqK+8VEunfXCSrnQa9cD6vOclIUdvU9jSfXV4/kOKHbMYg4rIMXS2xxyD4jLRnKl4Cusw9vIstVHmBgMyo3eAM3AkTFeR4OmQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bB40iSUd; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bB40iSUd"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cb38e6d164so791084685a.3
        for <linux-omap@vger.kernel.org>; Tue, 03 Mar 2026 12:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772569833; x=1773174633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IVPvbiKHqb1wJCwFPWETEeAl2aF1oAt9knBh3vkK+g=;
        b=bB40iSUd2YYMnEc1artiZlkJMWDwELXDwaLYUxSoHXRYm4MiBCp0/8596DzGPH6HoB
         qDLUWMqGHCRgbXbeP3V3oxu3Wzgr2LS3Uv0A53d8OXTjQO1m/1sEi6ivvBiaJodoi8za
         xy2wvg3NBSrrsDbWmJ3vGb3tPcds+Sav03NPgh2ta9J6i7VJZwG2wvi0q9UC2jumBJdT
         B+VsHS42nXXG477uoiIwRQepK3DI0fztZIKE7xAKqyNr0Q5HnIpT2eJpDf+fp2rL4MDd
         KOYzIWV32fmhMqY5pmKnhG9efafPeVH1G+Mo3n14zSYHRE0lauWXL+XtUSfh4ix4eQC8
         YChw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772569833; x=1773174633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1IVPvbiKHqb1wJCwFPWETEeAl2aF1oAt9knBh3vkK+g=;
        b=E/NqL0G+Vc2StRl6pM1jfP7sJbV1Je35ucb7ZaYeUjESmCEw3gNblvu0YrYrvT0sc+
         ozz93XAloi3QVMZk6i6mikS2x9wD1odP447QuH7IZPd6naxvu5o8nkMJXAI1Ab/6i4m8
         QTdBWKtALMhzeB1FYd4ijhiqmURLcUgDM+NbfmJGXib6MtaVy3K71SK4Z2V1ApKakbYR
         JB7JT5enPGlBWa7dYSnf3Ee4GeaEvnk/OwDNxzh90s2di09LqzX578DEwCssuFvitxk1
         qhMk2XFNRIlyi0AxJJzs9krQVG/zMZbYhYJ/knva5B0nWgOKO+QNbZ8mGFPa2XrrFC06
         AJxw==
X-Forwarded-Encrypted: i=1; AJvYcCWfSgho22+VqH0jyz49RRLUY2CsOCNU4ll3ffsAmI8+0xrLUyRRBqNK+WpXb6UMLG5xi2HJrGYXeJMv@vger.kernel.org
X-Gm-Message-State: AOJu0YxDZ0Efs7uzpNr7KdYGlKVYpMkOkbo9uN0vmo7UpVYhbtBf5Onx
	jRBFekEMLjMdFnAXQq52Rdo27jVPfeBu4sDvZfwT2etgrPGyxLJtG8Zf
X-Gm-Gg: ATEYQzyedQ96W9LGyY2R4UHAKPUqXZxEpR0J/MPe4SCDjwDo0MjFc7mcewt9yWR1NtA
	Y/n1RlteI1uT4F98drvn7MgAyncg64hpFtmLE1JbIH63jBYhzXF0YA1aL5EMhGqpeywDIPOLgLY
	J+SbzZie95MC42TNrwBoWtrvA9rfg/D1/oX4q/91T3U7s/nEtFy1IGeP93YvYh52T7RTtxmz6/A
	o+fLQgw3CB2eTMr8WYUBtKP/TH6pYywkyuA0KkJrUQmhtGPnrFndlKCz+/q+7/pm19JuZJFHg+S
	LAYzfIOsJevdC24nW4yBTcH/yJhr3wDH+I8uKCYSpAT7TvDlR6hldyFI0thRn4waqW8ZhjmbhCE
	DOdxQhcFrCAjg9aDLjyt3X2BB0TE0p4YyT6lf92pZqKaU7devt2Hb+eM2Uw1jGXyuRRHQS1VUmu
	xB0SovkzPlHYobBE7FNPuF82XxYT4W3/qGB0g9joFM2oNCsdgr7bDORHRpPGD7i35kzHPGu3RjU
	RA7zMk0nqw=
X-Received: by 2002:a05:620a:444f:b0:8cb:c043:4592 with SMTP id af79cd13be357-8cbc8e91d2fmr2385763185a.74.1772569833106;
        Tue, 03 Mar 2026 12:30:33 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf564c27sm1465032085a.0.2026.03.03.12.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 12:30:32 -0800 (PST)
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
Subject: [PATCH v9 4/8] dt-bindings: display: panel-lvds: Add compatibles for Samsung LTN070NL01 and LTN101AL03 panels
Date: Tue,  3 Mar 2026 15:30:13 -0500
Message-ID: <20260303203017.511-5-bavishimithil@gmail.com>
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

The LTN070NL01 is a 7.0 inch 1024x600, 24 bit, VESA Compatible, TFT
display panel
The LTN101AL03 is a 10.1 inch 800x1280, 24 bit, VESA Compatible, TFT
display panel

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/display/panel/panel-lvds.yaml         | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
index dbc01e640..b31c67bab 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
@@ -58,6 +58,10 @@ properties:
           - hydis,hv070wx2-1e0
           # Jenson Display BL-JT60050-01A 7" WSVGA (1024x600) color TFT LCD LVDS panel
           - jenson,bl-jt60050-01a
+          # Samsung LTN070NL01 7.0" WSVGA (1024x600) TFT LCD LVDS panel
+          - samsung,ltn070nl01
+          # Samsung LTN101AL03 10.1" WXGA (800x1280) TFT LCD LVDS panel
+          - samsung,ltn101al03
           - tbs,a711-panel
           # Winstar WF70A8SYJHLNGA 7" WSVGA (1024x600) color TFT LCD LVDS panel
           - winstar,wf70a8syjhlnga
-- 
2.43.0

