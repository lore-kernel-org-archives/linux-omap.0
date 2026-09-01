Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769253BB131
	for <linux-omap@vger.kernel.org>; Tue,  1 Sep 2026 21:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788298955; cv=none; b=QKwkfQGo4p7uiOM+2Eh0uJCnnvXjZzNn9W0lPTCN4lRAXDgeYKiAsoRH1RMWv18y/zyJYYdXmbhdc5wWTAHwDqH/NMEF+XIpJvva0y1HCJn9BDC41YTuMzoBsMn0VvN9dQ1BH0DS3QaszDShmnmNFRsgjQtt2tZxxvP9XutXJuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788298955; c=relaxed/simple;
	bh=JPUA3viflQ2v9uEzqZ95Rm337zpwh6hXrUk2Yg+PzV8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NqbZrxtVV03psFXrLWRciWMlDmLMXzkPdGJO0c8PpjArRrISZu5gBIn48EvfP4TIyhaU3ydUxvKn5fo7owC6NrgluP7LYsoqOcgMN/3SprnHG4542EZUUzHqJ9iZ8XnakApI2IgGSXZlKEdaM3kFnr8XT7jCfnaAjuWqFoVXyPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P02ltant; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P02ltant"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-46ad7304688so1684070fac.0
        for <linux-omap@vger.kernel.org>; Tue, 01 Sep 2026 14:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788298953; x=1788903753; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F+NmUzFRKeuEQ7M+1ibV0+Pzn+8gHlXWcUZ2COu4Ht4=;
        b=P02ltantu8oshKZx4o9a1xUnDYuKblvHDHy+YNGvhEPpwpmIO9JaWHP2XDXpg8QpAx
         Kmg6Zo9rO1JeLJfEltpVgzrJSU58i6DjzOnWg4sp1Wuoo48K82TI3+3JIWQU5zDz8rIU
         j+wXa4awoJHrC1xqRbTPVDMjTnB4EbKyIzX0Ar/u5evhkTFePKY8/2fUuN7UMuTb4CMO
         T3jDgt1zMw2j6qk8jOtfVPIXvwR0MyrE9DBcVovjIM8Tj1LkJ1G+DbyV1aEWLXJtq7Hm
         YMHIylHtwTp49IsQxtQ3JxYQO7Nl8gJIb/AZDNn2pBKPAD6YC7RAftFqaK+fq1LN9b22
         qAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788298953; x=1788903753;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F+NmUzFRKeuEQ7M+1ibV0+Pzn+8gHlXWcUZ2COu4Ht4=;
        b=se7LCHNMUhTpeOo6dJrBrP4BjDtEKM6bhz2m3oNMmiDUTTpUdDZqpsNxRagacgFKI+
         lr2CiqMPgk21aau2ZYurk2RiK8Y3auSEQWFBfd9Sfs1EHSwk1lGh65EHdfoAlqp4EimX
         QkRCX19KH6WECqK2tPI+O34HeGBckh5qPPxygWTsvp/xwc6fiH88jnpT2admZov5jUyQ
         GL4m05QCq7FmiV9Mw2j5TX/3w/fS7R0CrQVhmGjuAtXRntXcJrQcy58nTh9NbPnLhUBR
         kkPQGQRAU3N3jYsr5cP9eVP9l2tTHHfplhjs2MsQYZeEQv1e6srly78Alju5Produ5l+
         +4SA==
X-Gm-Message-State: AFuF++kTWCVGMU759HbCPpuvRu6Crf/2L5AaoXq08lyijL4u28IrYF+w
	HIs5FzHRQKSlTqJXEAI7R3KvBKOyO1a1yLbIru7GutvbNdd/iVgyvtu8
X-Gm-Gg: AR+sD13tQEjyRo22ooEiY3yNg3Y/KypP5N2goX9OTiHnFbjRDlJwN8gsOjt0PpuSnuk
	plEP+t0Bjl7uzGdzH4l9oWXz7gc7u8BeouuMoY/PdJRPOeDptxfeJ6ArMGl6kg4av2iBNOIRCgf
	cylRdIpXSPAC7oByr2fwXThHK4ABJCxnFxD/5qxMgyuiiwZ0t4k0tVyDdAGC/oXqzz+m39wtkyl
	YD7Qq18SPVXKnK/+v9oirtweClj8BbbxaNfiNUrxP6qjKmqtSReSXcZ00raSrJAfVnrwyXzZ1nY
	Y8SidTs9lB35iHwDBjSPtKAZdi16QN5lM5te9BxeaM2XsfrmwoDDjDJkOol3WyW3GRrixmiC8s+
	E2DG0Y9FDxkdYV46M57ir84KoWASkf4xqruWP79uQx7XY9WYDVc85zq2r/9FHmVappMIF5dwgKa
	jY1Ln9D7tzkrMaokQ+WNm//lqA3SbMcONYxmkGcP9H+lQUWuF8REXwbiXXSKVbHByVOFA39SIL2
	E3PhbV6WD2nYEyD8a+eVNdkRja6WdoFrVqIoSCA1H208xU/JdujjMWt0ygOJruQH4d+2kSgWPfi
	hm7TEH8DsJJ7N0PvGdUU8/Glc08NU6XEe8vqQBahFpm+NQ==
X-Received: by 2002:a05:6820:f012:b0:6b1:a812:988a with SMTP id 006d021491bc7-6b4716950fdmr99940eaf.6.1788298953204;
        Tue, 01 Sep 2026 14:42:33 -0700 (PDT)
Received: from [127.0.1.1] (140-186-136-19-dynamic.midco.net. [140.186.136.19])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b40ba648f6sm1094703eaf.2.2026.09.01.14.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 14:42:32 -0700 (PDT)
From: Robert Nelson <robertcnelson@gmail.com>
Date: Tue, 01 Sep 2026 16:42:21 -0500
Subject: [PATCH 1/3] dt-bindings: omap: Add BeagleBone Black RevD
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-v7-3-rc1-beaglebone-black-revd-v1-1-f521950b777a@gmail.com>
References: <20260901-v7-3-rc1-beaglebone-black-revd-v1-0-f521950b777a@gmail.com>
In-Reply-To: <20260901-v7-3-rc1-beaglebone-black-revd-v1-0-f521950b777a@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jason Kridner <jkridner@beagleboard.org>, 
 Deepak Khatri <lorforlinux@beagleboard.org>, 
 Ayush Singh <ayush@beagleboard.org>, 
 Robert Nelson <robertcnelson@gmail.com>
X-Mailer: b4 0.15.2

Document the beagle,am335x-bone-black-revd compatible string in the
appropriate place within the omap family binding file.

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
---
 Documentation/devicetree/bindings/arm/ti/omap.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/ti/omap.yaml b/Documentation/devicetree/bindings/arm/ti/omap.yaml
index f694dcbf2348..9666c455628d 100644
--- a/Documentation/devicetree/bindings/arm/ti/omap.yaml
+++ b/Documentation/devicetree/bindings/arm/ti/omap.yaml
@@ -104,6 +104,7 @@ properties:
       - description: TI AM33 based platform
         items:
           - enum:
+              - beagle,am335x-bone-black-revd
               - compulab,cm-t335
               - moxa,uc-8100-me-t
               - novatech,am335x-lxm

-- 
2.55.0

