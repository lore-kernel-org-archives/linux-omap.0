Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035BA2405E1
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 05:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771825885; cv=none; b=XGpTtPF/wCYc53oXgQVcYYmukNW1uHa5qy2htlWdvmHdUElucbXNPUcmk/C571I3FPTlr3Y8tm7qBNgIOZiVRGuFe1XJy+PdJJ3Kx2PGyQXJmdpJ6VqqeuffMMTcpq/D9ijBndvJD1P7pYHE0hRvgI+bAB++Eeg1SjN/H/St4iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771825885; c=relaxed/simple;
	bh=pi1fLBggw2w5nq+ku9XGxrPVz6Xc+gXO0i/5XkcUNq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFu8gmKXbXpMYtEaXMgAyoCmIFy+iotUgcMD27ZcAC1q6rE8IAU0jXe7Ug0zEz8N9801WgKKLI6ms2rJSX+W29/zCcVXy6TOkOTlLLXFx1TraUCz77/fTMYFwvrjHvzDCEilshliXGJpWBQZvUg10NljZwg6js9baTQMvYAB/k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNKHW424; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNKHW424"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c710439535so277924185a.1
        for <linux-omap@vger.kernel.org>; Sun, 22 Feb 2026 21:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771825882; x=1772430682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gnop4z34aVye00gIQguUoewYT5lM9SytbUgSGtePF4w=;
        b=nNKHW424jIQN2Us2yNrUB5DxRmcjrwlw4kb/TGOtlXbuiS3GJyzveLFwgdKRHREh9X
         OgPkX7NFOsrul2HIgMlBaW19U1VBVuCaJIow69+m9OpL/g5z+OToB7lDG0DsXW7mnMEr
         vFi1gMveYy6V8ozbHBXZy3um1BXPCqkckUXu95RWeBBA3YaqFxc/z/g98nWbmmxgJosH
         2Nsip6Wnl7LcxXisCqvficy6ZNGHzkSoskvfVVl3iX6NMY6dViXSJu8iUYt9ZnX4NOPb
         5hj4vJsMl7niVxuTigOD1l2Z5S8gJiuTIE1uuteog4Hcr6Lrc+ofaXfAemzZExcicXzi
         r6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771825882; x=1772430682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gnop4z34aVye00gIQguUoewYT5lM9SytbUgSGtePF4w=;
        b=lIVupbZtxyB4bSSCwt+qiB7H5UYnP4Lqvod5vrDjL+AhA05ZDWhJcVFewtFFP3OoxI
         SBBbtYnljnaNMkJN2zdWhQeLBzBrIBT3fphi/JS3piNUz0tey1UAq9urvxLhPjNk//u2
         C8+f5anizras6Shy1CcUbId1Oh/3haGeFL7ZttB9flr1rx/vq9sh0J9MY8wIIhIUGXUh
         CRw5pcmTeLb6F6dXrlEm1bFf5DJ+Wv4OxC/OSdNgdaJdiYJ9krLFMbf1yO+epg0g+j6c
         F+f1Yvclns19arJv0R7P4zFyJlcAfNZwKsdemJWpoi2QJQIaJhFDYBkjUR6IViX/nV2R
         SXyA==
X-Forwarded-Encrypted: i=1; AJvYcCUzMCE9Yi3bjwEDn4pbbByH5LRjVglA3voyqJQvZwSD3X10d/FU5JCy/rka83wh6SBARVjcz8dJwFtm@vger.kernel.org
X-Gm-Message-State: AOJu0YzwyDLcr1X5gFdklBDch24or/VKb6toqrk6CkADYsV+GIXIN/Kn
	9p66yOcGBhZJ1QohZpcdclkds2t/HNwYlOrSxtRx7IUKibuLFnRazdu2
X-Gm-Gg: AZuq6aJ1IOaeyI+0TLQ3Puo8hVBEbrhWg5nMQJEkWY2Y71Na9JnQE7IiWyz43iohpei
	n/tXp/B7Zt65GWos3o+YQLtfFbAAA+J9mJv1G4OnSfF0PzzhV24CPQ7R3uHTgTdlbW4KcpilX81
	rgxJU6ugLR/7blHy1BZH7eL39dtrEOq85D9gYoIej+gVqkp6MbmWTZH2LMuSr9Oxw9NU9a50B4x
	ctbYmJLpaCCThZeKrtNReUFktWmuKkGDqbjsLnTcu+sDlanm11mVet0Pj8wXIpAnDVXNVOj8mC/
	8K+SclF+XH4mnbs/q2IZ1G9aHF6ZqVUwI2mzMe3w9WLORcUn9AhsnwS+MoiN60+lT5AwXHnGYhx
	BekYvtO8qSj3s9pM2AmkpqAZ5kjHZRUp0jYAov3fdQSqaaUw0H3kR/pzLTbF/QKID6eerS9CCRV
	fJPGfPzzb2ZRxKrDbJG90xh95Sw+eA0hl4qSy+KIthJiJX/ZLxFKz6kvNr15zHN7zcQ7Wxna11X
	CYwI1v568ey3/pyb8VN7g==
X-Received: by 2002:a05:620a:4610:b0:8c5:38c3:7cca with SMTP id af79cd13be357-8cb8ca03109mr1014138385a.31.1771825881899;
        Sun, 22 Feb 2026 21:51:21 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e62f453sm59459096d6.36.2026.02.22.21.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 21:51:21 -0800 (PST)
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
Subject: [PATCH v7 2/8] dt-bindings: vendor-prefixes: Add Doestek
Date: Mon, 23 Feb 2026 00:51:07 -0500
Message-ID: <20260223055113.1288-3-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223055113.1288-1-bavishimithil@gmail.com>
References: <20260223055113.1288-1-bavishimithil@gmail.com>
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

