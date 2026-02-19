Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9822F39BE
	for <linux-omap@vger.kernel.org>; Thu, 19 Feb 2026 21:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771535069; cv=none; b=V4LN5U08wtyeDcndGSXHGubF97oucau8Nqy2Kuxxf/N0OssBMJZmMqvjFgMO4rLCEuu7IBedtHcDwZGCI3nvIx0Bt2f/4bBoyYqhXPeue07Tyl+puaxuMSulk6d5arHEF/16VRitffB1xrxQVhiiqwaA3pjUywTn2D0+a/WudjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771535069; c=relaxed/simple;
	bh=cihNYnflN3AVGRiDEm19DGgGttXrkIyvwuts3JIQy3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ccFPvzVc5+QsTZ7jUeMGhPg2QmMVZneoj1+pAa2m2mRdAXy9/VwAphFrpjvo8NURwrX7tY6v+OC4ijYSIOETX+vMHx7MD2tiCP5yUWKXDhmUQPCUan2oMdNEDrs3A8QXMQ/YP5m3ltRCEROPjmnDYn/HO6vGf1Gg/pWTKo3rmoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfSimVnI; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfSimVnI"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5033387c80aso31750201cf.0
        for <linux-omap@vger.kernel.org>; Thu, 19 Feb 2026 13:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771535067; x=1772139867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1IVPvbiKHqb1wJCwFPWETEeAl2aF1oAt9knBh3vkK+g=;
        b=cfSimVnIii2NY1xFmu//9td3JZfRJAlRxKqnD7WefLPNawtsnq/R/9MURk2AVPhRKN
         YATPlNtz9DMTrKcZDZTkhO104AQfsHtiEmTBwEBHP2FIKzTuPc5IcVYqPhTRTkhP9eTD
         +OjpmqSdqHoOyGy/lwRsXYDjM/eojEsmD80Eo0bqY7Gk8ynzaAv9C4e5HvNkAiRpjrMJ
         68Hxjk0cWkmvYAcRmbxRXXmwZBRyDrwVD82rPxaLTk0QYtDmCJybnPbs4ZJz7d9C4Y28
         qdS+aT/0ZTR13GOZ0Ord2RdyMQ5CKwxD5p6QtdS1lxdRPfQmRqaBkW4j1QDXpb2vVRy7
         JK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771535067; x=1772139867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1IVPvbiKHqb1wJCwFPWETEeAl2aF1oAt9knBh3vkK+g=;
        b=fA2phPDmR5t1bZpsbCKAO3Ir75B4DtDGrT8gaGbeHRNBxaeQDNFxtS+H6mZ6NypuEr
         XxNqUs8ea5zbJvZVEgBUsro041dnFhQZKdd/ubOt5S5KBJjfquO/9ak3NknKyI1I9nrV
         8070XIkMTy6KGMln+XfG41QFiP3CNY+53jteG+tZjLKzs1fri4FnvHXXECMizjEB5Y6Y
         /z0yUc0CNp1cHLa5SLSWeedHvzrpg2JjD4ZT1IXgBdmDneTzymx643iw7lShQygIZbom
         0c8+YE2tVrTs2ZkUhUuWqHHT4TnN+6qLXkl3jltpRb7b5UZxlBqv+GcDaPy/D9H6pjFJ
         PfGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU94uhqQRr6ZC72izv9bzRKfo+mcevv/WDwGN8imqI+ELeDQMFDL/hRLLdVRbkhCVDFhj7mQIvYFjPx@vger.kernel.org
X-Gm-Message-State: AOJu0YwsdyKRmabGy8bHvmgPgeug7Dy6F7CkN+Qzd/A1/XaAGl+8UlZ2
	se+i7JygxhabqTHtIo5Byl9Vb5LV8Sw3B2pPjn8qoaLiTTt/jwS4M2Jm
X-Gm-Gg: AZuq6aINxnIHvGr1akismJZaiIc3+1Ibrb3hrjIAIYHQCZxyjblcUSziGkSGQ+Eqf/K
	jPRWL3KPKxrE89UKG3G0lRTkY/FtXHA7nTc/8QXtbZUji0VJbnv31dF5i4F4NEu/OAbd1dkJiwM
	dak8SUPVr6BDy0lPSAVeMvT9lW6MT45odOqnU77Pof5jRlUELMr8mGiREKejoT+Z7amGJU+U8oM
	tBMU+1r360lFONd7U3iPs32BG+nWagS8MZefwMUYh6QobpTninejbYfGEleBSOnafDRx+Lj7ybB
	rS3zMDN1rveKP/N5CzLOlAZ1Ieumq0IpyNa6TpH3AcbR74EaKNipAbXnsjEuFx5vEej60AJPmgd
	vgvRpFekXHWFAjmYYkONgF5YtIPOiSuuDHN1rotjD2ByJhzbR6i1mHst0GKKP1eVN0nLPppMyUX
	WO1euriMaiCUMe6TNrq1m+IhEpQHBOMuYKfCuWokjZUKDjFh5SGw79Auu12vyWcS5PjdtfPNvul
	J8hTfCERNc=
X-Received: by 2002:a05:622a:178c:b0:506:6d1b:6e88 with SMTP id d75a77b69052e-506f33a6063mr38588531cf.27.1771535066815;
        Thu, 19 Feb 2026 13:04:26 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506b275d59fsm153971511cf.32.2026.02.19.13.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 13:04:26 -0800 (PST)
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
Subject: [PATCH v6 4/8] dt-bindings: display: panel-lvds: Add compatibles for Samsung LTN070NL01 and LTN101AL03 panels
Date: Thu, 19 Feb 2026 16:04:03 -0500
Message-ID: <20260219210408.5451-5-bavishimithil@gmail.com>
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

