Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CDA326932
	for <linux-omap@vger.kernel.org>; Thu, 19 Feb 2026 21:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771535083; cv=none; b=Dpmbw4vN4hq6jXQtNy+9SkuRzIdQbK3LH/gAIwqliDfIaMwm79CDRUauwGZNUyuAcKhQtzUdxirfYuzXnJQU5MrZTMRngYvX7G24QKlWSMUnblGeeO7NiO5lhudM/Ox/1ieCdg5qCEqOiagZ/PA14XTZajDwNRQAPGxQF0RiTA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771535083; c=relaxed/simple;
	bh=trpX+5UlMTYq/zyHhxfWvjqST/R/uh9a912a+PSUHVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BR8cficWRQ+AWtK3q/6Djlp80FYzQud1K4DVGzWYvOryJe0KCRDg44cOFNqYMxIy5fLp3O1mfIYW9eqsaVPcljF7rdzbsSkDZllNRwdgfKnAXr5SJwLCnikMdNefV6jDqgOrlCggedHNd+jvsVjUI8iQZkMBr8hFZ8no/IOaPTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jb5sG45G; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jb5sG45G"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-506a6cf8242so11478041cf.1
        for <linux-omap@vger.kernel.org>; Thu, 19 Feb 2026 13:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771535071; x=1772139871; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNC2r/k4VYyNvAPrupzATpkdJnOwaq0ecIMgKhToJ2I=;
        b=Jb5sG45GvLhD9Iytl52WK9Hl4bkVsXOteJatuURFsrBstgk1Y98us21jE3gZ9B8wSy
         9CQHTePULBw5ShXVMHdP9I1Ncj57N439fLSFrPWdoQan42lFRBaMG/UWqCEuiS4tJgWb
         0Jn7hrUdeKydjUFYps1YdgmYfA9hU7GEGeRk4iGyJNBaKxZEidWvD/W/wzhhISmjw8n9
         hu6tVTjWHk9uVCQkti/tMMOED/UvAfAmKF4RiCGC+1vyqnk76yP+NgUx0sUoGaQUWOzX
         1rDtM5FCxFzvfJu6O0IrDm4nAACJMwCJxD/O2Qj6zNSRBIC2ak0HjHvdqgV1gzscarX0
         szYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771535071; x=1772139871;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oNC2r/k4VYyNvAPrupzATpkdJnOwaq0ecIMgKhToJ2I=;
        b=GpXobnutX9dDyqnPPj6+MX4+NNR0MrQZ6S1l2LEByF/Wb0DIbDSx/8A2QhDbnhwHzn
         kzobH+zSree6p4c19lsC4yqLAsHIuYsoocy6XKTUmKWWFfsXNx5WHBcZ0qg8UliMfU0F
         dU5Uh1pdjLfhkMk3Xf/lyxhUjdLmyrW3kl3BWQQj4L1yxHs7tm5CXzWbkI42AUPL+zll
         Sysmi7Dvkk4aKxD4IN6p/ffIxMbUxziCcm42whWyLSrEXFVj7irqQP+M5wmJWa7DYUcW
         ntghDx9Fjfze9uuDU6uJFDrKPaHU4wByLI+Xw8MQlfIJYjR9SVwRWTQt77bsEKBuxhe1
         Qa7A==
X-Forwarded-Encrypted: i=1; AJvYcCXmVcu+xO59/dtlmeI+ndAJ8w8hzphB1rAs5w4k5ZN3tDlyIuNECCfvtZtTgRNnliBxkkjfZd6qejtB@vger.kernel.org
X-Gm-Message-State: AOJu0Yzve3dNaHMW6ShQMZAyGVh5QYgTNmezgs/26oU+48BXNi8HMuK+
	9o9GkxB0UVDI6Rqajz0cCdp721XCK6wD3Dx3H6gnCqW+HIazmpSK+np5
X-Gm-Gg: AZuq6aJdqo325hBgEbBOdqW6Jexa24yR10yWZYaYedK2LYUd5my2b/dh6B6gn+xw1r1
	70xIDm7WoxVbt1SuT/IdbzbXzNp10zyy2rbTblM6lwgMHzLJ2ZlUIqK6CGBeAiwcwxrD08Ss4gr
	7xRcVzacEdNzrDKj+o18St+Ygpi3dnUOMgDNcAf3PEGtKBpEmfIMSYy/3qSIHe9FAyP5S1Bajj2
	6VcX/VkQUzIzy7rJP2RYAJu73MOC5IjThrAarxCCr28hYC+/xh2HrCtuXp+EDwAF5WppzPjCmvw
	y4Wf399QozLqqLbKF+E3R784ybvjRf4FcHiDuUeMEYrHXuOMM2VeOr0kLM8byiwGM4FNi8alrte
	l4MeC0sTdbm09UXECuc4zPtqsBb30K1y/WYktcKt0/s9EBxi0UVoKZWBVFVkkCVsZ2MKjFs7IRG
	7zUdUJn6yBLsNqi39wzbU9gNjAV4bkHBWoDyQWtdlH0e++J6Zj8inDxt3pLlm3gkxfx30k+ofnW
	MZXqe9Voyg=
X-Received: by 2002:a05:622a:113:b0:506:bd04:4a6f with SMTP id d75a77b69052e-506f05ee3admr62280481cf.12.1771535071374;
        Thu, 19 Feb 2026 13:04:31 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506b275d59fsm153971511cf.32.2026.02.19.13.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 13:04:31 -0800 (PST)
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
Subject: [PATCH v6 6/8] dt-bindings: omap: Add Samsung Galaxy Tab 2 7.0 and 10.1
Date: Thu, 19 Feb 2026 16:04:05 -0500
Message-ID: <20260219210408.5451-7-bavishimithil@gmail.com>
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

