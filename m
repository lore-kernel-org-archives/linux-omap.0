Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90FE301460
	for <linux-omap@vger.kernel.org>; Thu, 29 Jan 2026 05:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769665678; cv=none; b=qWvMZnBWwBNREy2c21yZG4CYLfOsKPa7CM1uhu/qImKWyJV0NU4pOc9MAnDssuAIyvwIcVT7D7lXTit1CimUu6ZWpFq3quAw4qWpOWOC3JFf9pvi3O3sjweVIRRhj4udwv+y7NMJIu+rN4B+fbqz6OjECd+wFBwSTTHsI/cPtX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769665678; c=relaxed/simple;
	bh=trpX+5UlMTYq/zyHhxfWvjqST/R/uh9a912a+PSUHVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NlrTJzc8qYEcS7X6ODKJlvHdiu0IyRSVlTkj9smO1m7p3sZJsot2Z92dxYzGOWJanZXiepyhXycUb9KlI0seXbsL9hz6hXs7g2vnswNcq9QuOhCgln8IxQfQNxaNQLXmKh9sx+9MVPAdi1/HlyXr7/9Ak+yojLhvAo969yF9pxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+kYTNqg; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+kYTNqg"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-89478e429afso5739126d6.1
        for <linux-omap@vger.kernel.org>; Wed, 28 Jan 2026 21:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769665676; x=1770270476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNC2r/k4VYyNvAPrupzATpkdJnOwaq0ecIMgKhToJ2I=;
        b=c+kYTNqga6swhpMIqY8wSD54APXKrGvW6MesLlHFj+Uw4ihagAYOlrDC0rcak2XLxh
         HoJIkjcxQSXlHYtfEaaYs/GQZ9xiJpoiQ1Dxc3YItIYACIJLiKuCOPCvfYWNCa3a9OtM
         nFWiC6L/oO7aXYlWKzfjqxpZRdRdeud7cfhzW3u/NZQ5GwJkEOM+X2mN380FN29uO1tV
         E++37W9SOHh3rhTyJBecGzB/OLj7LK6KnbBVW+19NXnTQm8UDghp99zoENMa/7SyDHpV
         InTJus8NC6T6GQlUroVDeQnj9UEoNDITxLY79Yv4/KWRgI6Zg8RC7AQWH5mRzFckVKeB
         gcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769665676; x=1770270476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oNC2r/k4VYyNvAPrupzATpkdJnOwaq0ecIMgKhToJ2I=;
        b=ce1aFaJL8Kyy7qKixdGk4nO1/37o1mM7biDWgHh2dWA9B7dBilW65ghA2k+2ZFlwbb
         oQZDTF0UP769cEN6IJpE2xwQlHkMu67HNEjnknjBnREXb0a0yf4+kr3rH6G86o+4mzrt
         /ZbcnTByrG+q1M7MoJUukmFR9NpKTnrNPIixiUVS3GG2zxf37aKy/GGn5i9uyEm0ENUl
         9nWkn7Ojom9hmYnjSbacnasAHUSfO8609ZlxQR4f6hWYc0qfDVkruEcIK6lcGEQyOaDv
         cTlnRjUdf4mSRCutZegGi3mmHmzkTBW/i+aFAlilKZpYRaKJkaqMfWqEu+Q2iDUzd4zX
         UQkw==
X-Forwarded-Encrypted: i=1; AJvYcCXz2cEQdawdbmyOyH3M/mmZ8z2ozc1TKdFYcRNZEud5zvB+oVHmMAxlWMB3CMwCXWQ+7AxSugRS3hsp@vger.kernel.org
X-Gm-Message-State: AOJu0YxepVbB3t8/qe7G8ktRCvSPDxs7p6xdsdPV6MMVm5BKJbstTE9a
	MhuBWFauYXnWdz/AxKFn8jCx6xPmyff+HqwGNFliT3O6wrN+hbXelKk8
X-Gm-Gg: AZuq6aIyI+oyR7MaZ2AnPO80vVsugjU1+nV8fNKpVp8y/rUu6lu0wxYcSRbzqvl6Msa
	db0WIb6bGwAh3mh9lhBECpsc+eTNgeBvVkKdGeIqtVrmQf7O6BORZUQe48QQ5wi9sbOPOVu74gp
	7KBqV06NZK9K3/f7/dUoorJvPaPrLaMbqIKjznQK/F8gu2kh5khjqqQeG3JrEwL1vBuIsH12Vav
	qgLwl4yxgOVgloT74QFb7JKdicuf0duU9jicVK6j48RDfyh71Gu6l00OVUDw37ajtjP1csTew5H
	naJ9+Ox9So/sRSoih5GFCpUc+XnvIoqwBz+6z2Ac8gkDrwDhGfBw5igL5ckqxrsmqo3i/9d/O97
	W3yzxtjmz837NDR0OGpMNYExcOTH9HYwZr7M6aBy3e+u0eP6Lc/GO+y1TnvoGvWBSjZxRhjuBUV
	oZiVgLGIak43pLhxAp1quIfvc64f9mdWNoyc78btWObSJhN2d/X6QYdKhbS9xPy+vM2qeYWRk=
X-Received: by 2002:ad4:5ce9:0:b0:894:6494:ab63 with SMTP id 6a1803df08f44-894cc7cecb9mr104550696d6.4.1769665675887;
        Wed, 28 Jan 2026 21:47:55 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36dd1cfsm30903216d6.25.2026.01.28.21.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 21:47:55 -0800 (PST)
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
Subject: [PATCH v5 6/8] dt-bindings: omap: Add Samsung Galaxy Tab 2 7.0 and 10.1
Date: Thu, 29 Jan 2026 00:47:07 -0500
Message-ID: <20260129054709.3878-7-bavishimithil@gmail.com>
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

