Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5022F24BBF4
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 13:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854597; cv=none; b=MPovgp+L+nWqqjMQyE2mGlAJ44cGmzV1XKb9wYT5I3oUTTLSSmoI71jG4KeEsX7IdgZ4NfA+Tux5qHk0L9tlx5+3Maqsscrx5HldOyMHZzbaKNov6xtjV0x5fYTbeInOV4NKpdI4xVW+1BizXZlTuWZU1Y2T51YYvdv9rMb7QAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854597; c=relaxed/simple;
	bh=trpX+5UlMTYq/zyHhxfWvjqST/R/uh9a912a+PSUHVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7Wqb+8z8fAM/3iya5iuBEsgP+oxhktj6vWrDghd+KPbCXq4zE+lkPWvZIM+167Bb1fYYOXF1PHBDHAWSpKgY4i8AZfvo3dSysnT+cLdmoc7WcLwgQ8gCX7PGTi90lVK2L3/LIcAEA68DUwYJREPAa8VRekYM1ydCTJoHiTQH28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PL3D8SkK; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PL3D8SkK"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cb3dfb3461so445360185a.3
        for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 05:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771854595; x=1772459395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oNC2r/k4VYyNvAPrupzATpkdJnOwaq0ecIMgKhToJ2I=;
        b=PL3D8SkKMbydZq2yMpcZzWQNIKRL8atl0U9oQST7VMzSYKfg2vhfeS1rRdA3mv0B5L
         SZgGS+AdUVsReT9z1Z/JC3wXwt5Zvn/wnGxmrU71U3bw7+3yTNeNKlDMWZTSVTgM/l7N
         YmQJ8Ffbosvmd0wCX2BzuUqsnSQ3ki0HFBe8y5ope5iRm3RTaGAFG+4tpOXNsBKeDjS5
         ZB1Vx+chYl+99GNe5hM6rRCGcNYPEpyXPn0Sw0cIzjEnQkzO44EjF+Yvp10q8kPoKx1/
         lWBHYxpXvXD4uyei8/olGL5mYiZrq3lHwmiUSoCRfY2stUd+p43WT5x3l+i/7BObE3eb
         XkIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771854595; x=1772459395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oNC2r/k4VYyNvAPrupzATpkdJnOwaq0ecIMgKhToJ2I=;
        b=NFN7gnzKK4inahGuhEpZdpQijVEFXTDlXht3iveDoEhMnGzJCm9a6dAteuQF5uY1bp
         xTo6+OnrxIsMgt0PFwib2aXO2ST16vVj5LuvNGSyF1DvkxspQl3LZYikPkTnOGPsryzP
         A8zCahEnXj2Hrff8CxSHa3DGrBexYyM0vo+H8XCLRUkRqg6y1lNOHCSTioEKyDUc18dR
         6sJSjQ1RPvK7359MG1r4XxHLpDFqPnpRT9Fv7T+gX+HIZmlUiBMpqYraBkujTqKH6QQO
         ZH1YrbzHz2se6y4n/OMJEfFckfdsnS2J3dTEMkZg4QEO/m+lq7ze3tigSEyzJDorB2BW
         AO0g==
X-Forwarded-Encrypted: i=1; AJvYcCUxDjw4W352KBnjjIUy0LPFYzx3ulmtGGBJ28gVBUAXCUztF/8EcbLvyyD5ZWui1rM70ozBlQFjY+L4@vger.kernel.org
X-Gm-Message-State: AOJu0Yyir+JA4T/QWKDy0Mso0SaZ9aRfMMfivu8bXFKoTmgvHstTaXzR
	zaRoRVZkV76CKkjgmhjWmo8ztJEeNOIh9LiBQFw6+3dkCu2isDqwFl8J
X-Gm-Gg: AZuq6aJ7ZtRHKTNomUtihjCIhwpr+HXsTxeDimdhcq9VdWyueqi7VI7g6JBr8po2Yo9
	UyIHGd13JtmmIB45OHlW8kQmnAg2+QDvmWMkDeU3uKyHRIDPiuus44/QW6B6/hyVnFTdPLHqx6N
	7+a8+tQqZlTu7lLs33udV7P0IqlMAuCAIXcp2DXMvEbARrPmC40eOebHfq1HrNaxbj34l2iHBLn
	HuZc4b7LVFKWIbCRGMFImYDM6YZife/LAJPfpzfNaIxhFaJogge/qYU62SE8/ff4I0TA7kIf8MU
	926rVX+ZvmdAjT5hcqhMbQyYrEZlrX4DqzKtxxo81Z/+hwHhW7A6Ps2wtjiol8cHfGZCcpuGU5l
	RP2aLyF6S1Q6H7vaLd+U1QRGOQ1D/9JGdUeYkQUQd+lMoGlUhDEAXUxUAEq6T2kL4fzccJV7f2A
	ghTZQlLmp/Vaa55yVRSBXNB7zR3oIG6FZASuIuX4t/TR2lmeM/r9E7u0C3O/Fo/xvk60hfIj90F
	x8GpqG48NKWxSkhVTn78Q==
X-Received: by 2002:a05:620a:44ca:b0:8b2:dabe:de32 with SMTP id af79cd13be357-8cb8ca63e8emr1114618485a.42.1771854595143;
        Mon, 23 Feb 2026 05:49:55 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e62f453sm67954716d6.36.2026.02.23.05.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 05:49:54 -0800 (PST)
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
Subject: [PATCH v8 6/8] dt-bindings: omap: Add Samsung Galaxy Tab 2 7.0 and 10.1
Date: Mon, 23 Feb 2026 08:49:38 -0500
Message-ID: <20260223134941.427-7-bavishimithil@gmail.com>
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

