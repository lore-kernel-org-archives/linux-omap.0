Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB3F345CAB
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 05:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771825892; cv=none; b=PjvXhSDDY7wz/d2ltNVbogLf9CEoU/qeVrShfIGH77+yoSgy1XiHP7PGkfZoZC9iiPIUa6Bkvg1mZg/ufNrHbZKQwRf2I9fzLYlJI7+UiYfOEYFI5nFLQovoS5s5zdUEyrDHScz0xDk+5723c9nOgeadNYOlm6xb6/Q16uYhA7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771825892; c=relaxed/simple;
	bh=trpX+5UlMTYq/zyHhxfWvjqST/R/uh9a912a+PSUHVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UrOU6II+OCz5aI3UoFNZ7IwPohCrCoesDs96KLOJr7TkY45HQDaQoAWUsWwiKcWsaMro2u8PtyNd+KinzFOy9OVEJ5yKQFk9RSXmmTV9bMCrtVpuUy/Qxr5HoEEZIltZvmOHT9hJAT+kNqfdpzctIXYXK8mEuT2VnERrF3Uwlv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQqUxBX4; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQqUxBX4"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5033387c80aso66226641cf.0
        for <linux-omap@vger.kernel.org>; Sun, 22 Feb 2026 21:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771825890; x=1772430690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNC2r/k4VYyNvAPrupzATpkdJnOwaq0ecIMgKhToJ2I=;
        b=KQqUxBX4bHx3/Et1DCLo2Qv53nafyzb7gYtm0Hwk9MFMz+jetpVEiQn/ylVBTX3cZm
         ugNahshd66tj12fOTjrIBhLeZ49FRIf1oTseShT+T1xd4XqiPNcwlKY99WYWf6/B0ywp
         a4DYi7HXCOjR/9i4U8JhmVKk2PzUD85yx5PA83xywLuqzTZX/vpcH//sFSPXRRcVfFw+
         JXL+pixSY4JONb9pqL5+S60qiDHZ3ORPWimAzn9nB2qFXAolRcx++SDV07jynohq4OoW
         uU4EnxfLhJaYp97RXVYFd5Ltx6y+s7vnUzgb+ZeSYocivke9aB7SuB1ZrVG+1V0HVlGH
         bZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771825890; x=1772430690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oNC2r/k4VYyNvAPrupzATpkdJnOwaq0ecIMgKhToJ2I=;
        b=DuHuurUl4y7MYwhpaeBvekJNhkX2DnWfc88pgh3xsUWzNdaC5GxzmyjwhXE5YB+x65
         xrJSsMBZrzKCm4piW+rG0G9iz8x98xkeX4T0I3kV3RYLnxSPO0s43269yB0kbG1Jnal+
         9CBjSLljlkjUfMm1zOvNPK4cyP4yhzLHGFYGUVR0Szsp+QMrRxOymp7DnP80XNTiYu7L
         IFTYiykBJXvQ2rHG5Q+0akYqpsmKEk9pj0Ex2sqCUiTbls+rM3uVqSf0t4nxGm12liUt
         dVEqzENa5vwZacq4av2u1yEo4FMkUSxyjJQc0m6BWFxG8XhI7Pg/ok2FLYlzxx5zglE7
         nG4w==
X-Forwarded-Encrypted: i=1; AJvYcCUwW/e9mgi577/Q30nLNH5E8ytdjXnpSjKJaZgz9DaAzJM2ND1Wu1MMD4K4QPmcXQ9R7MFNhbu1RTMa@vger.kernel.org
X-Gm-Message-State: AOJu0YwYE4vEAo984mlX4G7z7N64bgWUUJli0kQ+1VBGeMKrR5aC+tHd
	jxkb4rCR36bj8vzOnTVmSi8ueSj1f02Hr0DciGn6OpiNdXJnUTLtcof0
X-Gm-Gg: AZuq6aJXtnj5jMZCwv1wDRfrUwc0oloKRpk01y+SA+PFKlFgEb8DimKQ8v9jiMaEb14
	ZfLGdjDzxdlycp4ui3tNJIu/Ugq5MkHRA4X2dRNrp4G/ZjWKqxRNlCfOJemf6Jwi0glySHFYvtt
	wjBswo4IZdP0awKQ2NIQ6OOigOzXv/9PcM5Yt4xutH2p9T/2WVq8Zdk35ueEBQkK4cbgXrZMnK2
	+rIMWBtS2+MtcVAAs6ETxFDcGW5qx4yaNT+PDfQCXe3ETz6jy3Ml4XitvVJz18Bd1lHKmhCzdpW
	+MR/SVoTQqlhvHXN/muCH2ZxHIozOb4BjutAhaDfQkEFnObmo7wg5HIYMNlLrxTmJNPLrKsVjPd
	IxZkBeS0TCVNpWRSMvCZrSt75pYoeo6/0JupzypspmriihbqJ4qxsnu/n2/AQag3YoslLs2tOSv
	1uNhXUkTKGS+7QBejRbPFuCQ9TCL3DCVYd+ro2QsHyceejV5WHMHq2roRwfwYXuJmRzdSxWgubv
	J0grcInk08=
X-Received: by 2002:a05:622a:120d:b0:502:ec9e:ded6 with SMTP id d75a77b69052e-506f317f931mr169944791cf.38.1771825890175;
        Sun, 22 Feb 2026 21:51:30 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e62f453sm59459096d6.36.2026.02.22.21.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 21:51:29 -0800 (PST)
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
Subject: [PATCH v7 6/8] dt-bindings: omap: Add Samsung Galaxy Tab 2 7.0 and 10.1
Date: Mon, 23 Feb 2026 00:51:11 -0500
Message-ID: <20260223055113.1288-7-bavishimithil@gmail.com>
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

