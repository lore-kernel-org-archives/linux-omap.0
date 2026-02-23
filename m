Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D26285068
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771860496; cv=none; b=erICGE5x05T0nLqSqGWMKFQM3xis+VZE+31tEDeKJDpanB45/1U028CrHtjgOvVxMkDsOw8MJsjbOXd51tLHC/K7Wp6SLOEuo9/pBLO+llzkRFOSoYowdTDTlHU/mLb0Xe20UHmu0SDch4Tp/5VF2OvCOGtMTeAs0WtXagjRDpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771860496; c=relaxed/simple;
	bh=pi1fLBggw2w5nq+ku9XGxrPVz6Xc+gXO0i/5XkcUNq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H88ekp/LbZ/uYyzxUdvZvhcFDtKEnsw2JmE/i4+/VcuXOZYApFcjDH/EILGxtrwiz6oIyRGzsUHR2qr9qLKsTE/77RPyjAOZqjLYaWjDLsBUt10r3QSuXLF/5fGEtpiBklH2Rda6wnDvu6TU7gtON2d0GEJqUDTt3+g0/gXlvR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmYlYiKw; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmYlYiKw"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-56739adfa1aso3261904e0c.0
        for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 07:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771860494; x=1772465294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gnop4z34aVye00gIQguUoewYT5lM9SytbUgSGtePF4w=;
        b=XmYlYiKwqEZhy5etSnweumjQO0iakUj8t5rt4XS6Fb3wWGEqWsEEAtzFAyEwLgz/5v
         wEKMU8QKslD+ajZ6w4ocAK6cJIicsGQ23ca0rjiOO5mPpRKwO6/Y88yI4eS7Pxna0gmw
         8cnSuU1SK4maTMRf09SCMYwhhI47zniO42BRbwjatXHX4OQpW0H7pdSlDwZxvxze3pzp
         vc/4tV4XmXPj/lzZqa1vpc57Di/DuZHblzTTJ9i7uOMThBz2QsiCDVKWS/jETmbS3ni6
         PWVzDqxPLc0H6LB1Nou597pyfostyzCXn84FUF7v1sudPXuEYo3fRjlYFGRA35rjJFSM
         7TGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771860494; x=1772465294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Gnop4z34aVye00gIQguUoewYT5lM9SytbUgSGtePF4w=;
        b=PUD0uUY1p8XNSNQga4F94PwzganmEPdbotEVnGhDYCqe63nG2MMBjhQvRIwxwUb2BZ
         7YZT/slmYd0PtLK0f2CEp+NwZDBMociqSXYz0MGEEK0WpSkR+EuSKvxkICM3zPUt81Me
         IE7iMCJgpmpzNkwwC/MFJmcqX6CUQ0ga/+/b285+EGHh0PrLx6mhtOlcSj05nr/FiOki
         ldOtmlIKppqwAm08lno/FKxGtwSB7QkFXNfq3iJWTFXbam4HVQq5YUdXrrHl1mQqeyRr
         +KXgeOGQJr3RqYVSSIXN0KyQpHnvM5vCf5MX1BAzLHODaE8Z/RFgcnwzVzxddbtoP3Zb
         yfVg==
X-Forwarded-Encrypted: i=1; AJvYcCWk5uuOjZHCQGpuB6PweeE2JLO1qU9tcUj89/9DOsaTKUSrNxXWbedgkQDl2WwUvoXGqDrIJKYqSLkR@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+OzNP5EzlL9rZ3M+hxmHRNy2GES0Og1Ym8jvQitTfe7V7jHcy
	iSD5gL47bJYJ67wWxPAQb8mi87H1ii4WgMSx/aPOg1WT6f4ovrRLArC/EWQJbZZH
X-Gm-Gg: AZuq6aLpemLtJIfqNr/KHZfZbTPckbZOkloKsbdfzFK6Ywbo0X2yLMXvxB1C2P0D24O
	fYk7wPBrPl4Ihtmfo8nLsKV9UKzB8xBEOpej/b4xXV9xk2MFD0TkHHEQaUxxey7J2qzxzo4zJkT
	/94cmUyYm345ZrQGB3BQQxa7D+w40HorANzB4eH+LxsNMlC6EF0y33iZHJAjkABzrm1U4gqyB5C
	42EWLaM4QwRLmkKDrPEMs2EYVrssbTWRF3otl0y26YG9YFew+vZ6Vm7v9Y7rHQk4BTKKDBLSj9H
	PTUml0P3jhU/+BKcCJjBoFelLX10w6LllEbj2mZpOIqGC+07I9X9val0oMTnbQZhkBb3fD4hro8
	YhXbfD9mFEQARb5z6PPksDLzZW/CYT2r/S4AwKpPV8GEuPhIoW7ztVFoSfJCQdOl/laDQOn7ARQ
	wFL4R/z77SIq4ZG4z/lF2HfhyDhocXu6kKR24L4XJ/ZxVsmKmsBJVzF+iqP5ykpulZgxoP9as3r
	/libSekVQ8=
X-Received: by 2002:a05:622a:249:b0:501:45c5:935e with SMTP id d75a77b69052e-5070bb81b0fmr101683041cf.7.1771854588482;
        Mon, 23 Feb 2026 05:49:48 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e62f453sm67954716d6.36.2026.02.23.05.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 05:49:48 -0800 (PST)
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
Subject: [PATCH v8 2/8] dt-bindings: vendor-prefixes: Add Doestek
Date: Mon, 23 Feb 2026 08:49:34 -0500
Message-ID: <20260223134941.427-3-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223134941.427-1-bavishimithil@gmail.com>
References: <20260223134941.427-1-bavishimithil@gmail.com>
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

