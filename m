Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A16375AD3
	for <linux-omap@vger.kernel.org>; Tue,  3 Mar 2026 20:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772569833; cv=none; b=rzuWHJ+aYZQgHL+xKshMEaU19Pw3zWIxZa8/15PgcbsdAT7Y1ogslHPwHyMktPs3SOqeE8z+2IMYT+UJxAqluFrMW13CX4JivchlwT0FeuF9+74btDNcsEeQan7i3HSTg1UoKIGp7VscD58mvmyE2kWoCe3IjT3jQmGmc+Tj2ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772569833; c=relaxed/simple;
	bh=RuZaljSVXskqPJY8r+YAxpcHHlm/dbEQcU9B3NPU7t4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=odJCezsFNXDE+VfOmrp3wkGgLD4c2y2v2qcnOOx7O2NPQ7EBt9TgJlQfUe6zqnsjgevD1AFp1FFmdHAxL61JzUm9oMZ3XAG/JCKEXpGUN2vxLmkkPuHzGtUQIk02FeGgGxI8I1/LKFLust7CBrOrjULo3jRtOwUfNd9Axmfei4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZuyDt/4; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZuyDt/4"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cb420f7500so582694085a.2
        for <linux-omap@vger.kernel.org>; Tue, 03 Mar 2026 12:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772569829; x=1773174629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWVCPo/EwWX5nyfgCTVstrGnhkLqhyh/3/ZgqXOIZ6A=;
        b=mZuyDt/4qjbhf6cyP2YPayWqBC7bFx7i+iRsd+qQIgVngaEh9bjCMeE0EYea2MR6Jf
         UnT7kQL8ywZXxsmNqIovDVUIpvwum5rc+mv/Zt3tPVuqn2Razb5M1ax2YczFVEDkO6c2
         aALnBdliAPJU76bxEglcvd1/jtwS3FdynK28kQ9LH2PFxO28GQ4KCFXbAxLajH9rfjv7
         BjBc3kJR9EtVc8vWt61KD3zfCRlHiE9eygOo1E/1UYs8sasvkaXujK6sbMsHF9ugKJHX
         f4wUOyi4F4CVjCcF6tJC7Pj4I6I2p8Ttlls6cAAHuEm9QJHzRfJTSxetUwtaW1hXwQ/O
         bOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772569829; x=1773174629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FWVCPo/EwWX5nyfgCTVstrGnhkLqhyh/3/ZgqXOIZ6A=;
        b=SB0ID+ae2OeloYxAr65qwje0GH8s2aSLhzSvBTU2IoJVfJf0R5YyAysP6/nbAJPljv
         ZI3fHl23UmJreO8/ECcsmFx97jCgrOWcCFhafDa7QrgOcVr+lPVFS6PLDx3q6WuRd5St
         FHDW6XV1/qXA5ThzjwOBPdXgxdUOD/+virKmLxkykr55NaeYyvxdryqXl22xYKrw07To
         XhdzvIZWWcui7Xc6HWyZ7tp5iTLj2gJ5EYQcldS/B8BeLK9EyknzKQDyJ/04zwq652KR
         1Y3I/9r/Ydy0zl8i9rIx6+neDm+ITvS7fEYvXA8YwJU069WuIU/TR5iiJcW0tx3Z8Fs7
         /EVA==
X-Forwarded-Encrypted: i=1; AJvYcCV+kPWwOEtS9eo0Boiko3Pp3/32lHg7Kh1Zv07xM3CJikgyIkwKGzEm4V1LLmMOpWFxQHgv17kG9Abi@vger.kernel.org
X-Gm-Message-State: AOJu0YxwVFtlvYJQvhYwjYaSNE9EQcKp2CWHq+jL0F/vr4MTXokZGE3v
	Mq9TN6mu3rEUksj7ch1I3/Lhf9kjf3iNOk6xfbC9sNy6Io4dXJ3Y8a3i
X-Gm-Gg: ATEYQzw+YsCJwHtdXphT9Cx/7FAXHw8RZQC5Y/CNYP4WRVIdoCk5wMEqoxnh/KmRUTc
	dJcfEdbZsq2aiMqDyIOh4of9QPQXu5uO3YKrKymlKdtjw29dfA8qfpHSgAkm+MMQzngw2RvIuPv
	KsqS3VeQ/ZYtoXiJ/hKqchl8vVx4HhoADAhMqtjb/jhqKS9XQ4bZ1EiMpiNIWU3IvNE3uKzpio2
	w8y9qCkzT0CmW4skX1SErPU/BliwuPl9EKiSEDo5oPFRPrlrQnj2zhNFJAsjTLgutlqGa/M+Wud
	2jfZxkJCED7ZScM0DW+rhRgD5C/w49iiSsEK+0tFgWp4Udp07uBrhmZnqA5+UGnJDhs3ERi356Z
	kGXdswNF0fv/2wFQn4lAzR3uMkWW/S7VNlrWZiCNfVg1VFC8TgzvBHbp1EzebXi0nvVOuu0ki+5
	pxfohVr4upf/Vfx8LSrwNn2b5BJGJuKMfbmK7gX63mz31e2Bm4k7wpH15KJD6Ir4cyjTEpjJHuv
	Wtb4PcVKKY=
X-Received: by 2002:a05:620a:489a:b0:8cb:9fd4:2ecb with SMTP id af79cd13be357-8cbc8e081ecmr2045708785a.54.1772569829106;
        Tue, 03 Mar 2026 12:30:29 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf564c27sm1465032085a.0.2026.03.03.12.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 12:30:28 -0800 (PST)
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
Subject: [PATCH v9 2/8] dt-bindings: vendor-prefixes: Add Doestek
Date: Tue,  3 Mar 2026 15:30:11 -0500
Message-ID: <20260303203017.511-3-bavishimithil@gmail.com>
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

Add vendor prefix for Doestek Co., Ltd.
Link: http://www.doestek.co.kr/

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ee7fd3cfe..5cc05d518 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -441,6 +441,8 @@ patternProperties:
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

