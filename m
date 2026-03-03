Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C51370D5C
	for <linux-omap@vger.kernel.org>; Tue,  3 Mar 2026 20:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772569843; cv=none; b=Wn+9sF2VKuEV9HahwEEoIZYiMykLzITmtx3RaZB6QpaAtHu1lnESR+p5RYZARvpJTIw3EuOrsB0FiBp+oHJK4o0mYIDOPCngPLw+BzdTnGDKGW2SaXpij0A+STUeRjwWEvwCHZo6bsUbhaNeG+ML6rMoLYp2CdXPUX/HbLUvT0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772569843; c=relaxed/simple;
	bh=trpX+5UlMTYq/zyHhxfWvjqST/R/uh9a912a+PSUHVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=krsqlER15FRMZtK+2SmJ5FbHR7S3yRrNelWi8/2qRmHPq5zRgNm5Aufd/NDK2zvCP0PI0o5CQqebFV7V05LJTUKPff/lWJzQ2VPyQ/8unkuPT1q/Zh0ZLnGktVy1wxBpK22tFc8hNre/0EF/kawxsLmOGWbd2dEaEnXzbFYyhBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OpjFMsHL; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpjFMsHL"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cb3bae8d3eso559976685a.1
        for <linux-omap@vger.kernel.org>; Tue, 03 Mar 2026 12:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772569837; x=1773174637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNC2r/k4VYyNvAPrupzATpkdJnOwaq0ecIMgKhToJ2I=;
        b=OpjFMsHLFvebYM8bZtVYwLuGVIIpFaRaWPKLnHYVzNiV+PzPIeiiBDIpd3y+zy55z0
         5KVLKbwaS508/Ac0LfBGUifjMop89oIFLQZQC6DN21b/MNk2rNecqynf30HMpFOtdnmw
         sOsWVdEajojs4DHyDv/+1emJWeqPL2VCExAhWw+GwxnvEfuh7hOEWQ60EtfgPA8JpSYj
         JhN+XF3IViQpDaqLdy/pPTgAbrK14ZRyrgIzsMn5bRegySyaMmlplAoa5HXLOY3BlwCC
         9Zs2HgCYzLZ2Wc8+x3XyhmmKrrCtM3PEF0K/Ho/vxMJBCoczxRyKr56U2yDTBHUU4UOE
         1KVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772569837; x=1773174637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oNC2r/k4VYyNvAPrupzATpkdJnOwaq0ecIMgKhToJ2I=;
        b=iXij0q6Q6U9/TXlcr8UM8pmtTqGwNMszCgLceWB4gitXbcVtUrMFCggHsmLkDIgjv5
         FZwq+TRPYvN6k/kWSnNTaUSR+4eTnnjxH/2KksJqNuDiMj5g2gomX2CH6KfDJWhAHDbt
         cL61QAHiJCSr8rlcdZ9tQpjZbdrAep8BEMTzEaVzEHpW8n3h4Y/2/s+mSx71/vLwt77g
         Ul8bd4gAERCMQAUb0FSmjH+/jkFfrPpSGRKOPnEXnTQxUpyEYZC3iwMgb84W1HtTqjDt
         4NCGZQpAtSRtjiq6glmgmmzS//YfkU7rEA/JsHYRy0qV9RjGEWK9fHWvx/00DUHdyOUa
         EPUA==
X-Forwarded-Encrypted: i=1; AJvYcCVi3QNYiaMaAiW84SQIUhiL709QlH1G3C7RItMvC9imfIm+tpel04EDzpCem+gMwmFZ+1QNuIe89iJL@vger.kernel.org
X-Gm-Message-State: AOJu0YxNcJNISiSArz1mipQ57IBXqvZpv7QNeeyNFvpYjdOPrZiTal7A
	SV5E8qv0hYOx9VFnui1kEgnzB3CwfK9WWzbeU/yHsGbRAHAM+M5XOASM
X-Gm-Gg: ATEYQzxxe5lGJTG+PcuIiOO5nSOwh0xlMxQPird4Veyau/le9IDQuSHNoi75c7FPniS
	HEfP5mAecGb64wmTEe8inKliECLbX/6c4pExxhRHRliU0K28v9rENvfLdjucOoH8gMGG1T+ZrYA
	jFaAqhMV/tJWYxGQZM0TacuXh+D6SKp2qRSLBVs+uV47uedDh01YBCK5nZ/HQNbEikUYegb7Mis
	Y3ephuwyh68MP/WUvI7kHCFR++KkQry9THuq+piE7zVwhLmeN+av6J7EwUjS98EOa4h1u7jWYrb
	A7VhKQ3cj5OMQbvXIrkYr3f6VCHJep0aEwMtd/z53wVQ1mPKNRpE17ChhTp/RLfLjy9kzIUTuUv
	i3SEi6orH5Dy4M4OXS8HohB+TX6ln3LIBCA0ll04vLlBeajMNedbg65rCMOVtBhqoi3VINdc6Gs
	4tr6iwDE6th20++CVXDkTtwLbmjVZfX2i9YnJOVbQZndgi/TIyg7VdXTdpNDeIZ7ZjD/4O9lTfx
	P/xbUBgnJM=
X-Received: by 2002:a05:620a:1903:b0:8bb:a037:fd94 with SMTP id af79cd13be357-8cbc8df6fc0mr2124060285a.38.1772569837021;
        Tue, 03 Mar 2026 12:30:37 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf564c27sm1465032085a.0.2026.03.03.12.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 12:30:36 -0800 (PST)
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
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v9 6/8] dt-bindings: omap: Add Samsung Galaxy Tab 2 7.0 and 10.1
Date: Tue,  3 Mar 2026 15:30:15 -0500
Message-ID: <20260303203017.511-7-bavishimithil@gmail.com>
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

Add samsung-espresso7 codename for the 7 inch variant
Add samsung-espresso10 codename for the 10 inch variant

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/ti/omap.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/omap.yaml b/Documentation/devicetree/bindings/arm/ti/omap.yaml
index 14f1b9d8f..f694dcbf2 100644
--- a/Documentation/devicetree/bindings/arm/ti/omap.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/omap.yaml
@@ -144,6 +144,8 @@ properties:
               - motorola,droid-bionic   # Motorola Droid Bionic XT875
               - motorola,xyboard-mz609
               - motorola,xyboard-mz617
+              - samsung,espresso7
+              - samsung,espresso10
               - ti,omap4-panda
               - ti,omap4-sdp
           - const: ti,omap4430
-- 
2.43.0

