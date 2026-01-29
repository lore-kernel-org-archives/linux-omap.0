Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F23B3033CC
	for <linux-omap@vger.kernel.org>; Thu, 29 Jan 2026 05:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769665671; cv=none; b=MdAPHtymIUWPxcFMfJ85vkm/alGXHXN4wd/mDjYwHT46Kwza3xameiC6/iUb2Ro7hSlzJ3Y7AG6DNfqUpw2rsH0YMTkSajlVj6hxsWQq+SvP0umfeH6ChI4qkDKj6B2oaMkU+GXKWvSdWx2FiUXO4Uk8bPKSiHz6LlPfseXW4ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769665671; c=relaxed/simple;
	bh=QtehmTlxVE2ImMqTMUlN+wssHL5rLi9pMI7VHV6x+J0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sh48q+LefeRMPjBiqdvyMcKWuOFVq6/JvY/E+avrSxUbm1BeUdoOMo69Psk8nxOCdfWQJBhH+t0Ne8vvbTPsuy3D5mQQeoFPhtDJIQNencnbVmzQVfmFyVpoRegt8pbAKAhdE1y2gG2Pr3CoViNUJfLxcq11FEs0ht/0qzt2k4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7YGpAnI; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7YGpAnI"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-894703956b8so10729946d6.1
        for <linux-omap@vger.kernel.org>; Wed, 28 Jan 2026 21:47:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769665669; x=1770270469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Hq1Jil93LKWD5SqiddgyBykMfT43TbOI7JPjGrETyE=;
        b=E7YGpAnITfaGdRPQnhHVxzbW2Sn1oJiSNGuXfBMiwxfim2ExAGcKq9zXxpn7KWNz/0
         l8dXBsUjNmPElUBBBDarqfaQgaclljYSxh4p3zwiKoi6+LMG+cIKsD9el65FkE5puTxi
         Xfe7UxlnbC1DIvF+NxGShKRKM/BYfiB9HL1oEl+mI7WnQgHZs7y43Rd4IM03mDZUSDLQ
         uSor1P9HNlfTqLke/Jb37bwwqkRVe9a3w+ZPQDBZ7uL9+QPvq67+/Sjg6ZDXPiltSphl
         w0Q1UkmGC9uJ3C24Yu8uPdLtPdl4sLuo3abT1vyRLHE0uBAoJUutZgncz3SMFtV7WFW6
         OM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769665669; x=1770270469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Hq1Jil93LKWD5SqiddgyBykMfT43TbOI7JPjGrETyE=;
        b=lZDaLIq1w0+2elZWn+QFs2kCESB03hzsYcMzAxdrghL7Zlfc3047GYDcDu/GWyBxdI
         WCaK0oYZQM1OxjCfS5jVRpQGMXRlNNJ1r//2hJq12mTta1gx6kjt9Hvg3gEdSvIDc/b1
         Uv27j+/LtqrSEAhSq2QrxorO+n4zrWb8AzIfrAhRKQjEadVlNCZYz2L3/QdrEh+hB+Yf
         z8vAMhGlFZ82FDN9sDjhgJS3m7zhlSu1z7yqDRbDmNIH7DM+ZjppMKi2uUTZWH+QqdWy
         TS4sw6/4qxuqO8bpggKiqCGiLjGPUZ5UaPbCxIyBpKtMGjOiYRT8EV0l4Yk61QhV9quy
         2R0Q==
X-Forwarded-Encrypted: i=1; AJvYcCWuk1meS6rqPHFyqHYBJNe5Hb+LHg3dliYow28vMiUKJfG7BlUUqXPla7A1+hWIXzSnyhDwBQ0p+Fyg@vger.kernel.org
X-Gm-Message-State: AOJu0YwgcDuvGP/2ltscGqDkMcZQRnMP0dRu5LGwOS49ZpNJ8Hwi1kes
	mzk2fIWca/ycMnKR86GnBPP0LVWLkHgwMgrozxE99EvHGPA2BS74m48S
X-Gm-Gg: AZuq6aKKOfLuTXaMEx6eHOxo3nif6HqfniAKQB8W+oap8dQYAwKxxWJtv8Laoaspv18
	2+9EAe5Csuta+pjS2PfkfvRAeSIdeysQ3BDAh8qNE3wkakYetmoOb8EBS3Kt/BJWEcPlu94fivk
	ecZ5vuplhacVELHAV9lExggzpWI79jl1V6ceNtEfJ+/NacNWMThwnUz19jamNzpr3VsCG7LoIz2
	eVEibsS4PqZ8yoX7d2yTeaPfGQ2Ap0WfH7ZF5vjhBj7dhgpq9zDFq1Hc3GuIR6pCESQ3kXQ7TJw
	pvUJ8h3bvQhBsgx/EsuQufofpCTSvNXUToZ8MI8XCkk2j5GYnbXKUMI5mxPEJp1xCOcwmeMYkTl
	11ItHolLI5L7S+IqgX0X4JyDCaIautB3Ulp9hZdL+kEKuAoqtFo+qCm4xAljdDwMwURd/6cI3ui
	VaEXn+zXy60jR4kujPHrCnQUlC5+pQXFNlf19/s/TUCx3xe6exaXKNdWQiJE0lB/TP8+2edP9uT
	FE21tz1gQ==
X-Received: by 2002:a05:6214:410f:b0:894:7d78:9cf4 with SMTP id 6a1803df08f44-894cc7d012cmr118216296d6.13.1769665669193;
        Wed, 28 Jan 2026 21:47:49 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d36dd1cfsm30903216d6.25.2026.01.28.21.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 21:47:48 -0800 (PST)
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
Subject: [PATCH v5 3/8] dt-bindings: display: bridge: lvds-codec: add doestek,dtc34lm85am
Date: Thu, 29 Jan 2026 00:47:04 -0500
Message-ID: <20260129054709.3878-4-bavishimithil@gmail.com>
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

Add compatible strings for the Doestek DTC34LM85AM Flat Panel Display
Transmitter

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml b/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
index 4f7d3e9cf..3ad01645c 100644
--- a/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/lvds-codec.yaml
@@ -33,6 +33,7 @@ properties:
     oneOf:
       - items:
           - enum:
+              - doestek,dtc34lm85am # For the Doestek DTC34LM85AM Flat Panel Display (FPD) Transmitter
               - ti,ds90c185   # For the TI DS90C185 FPD-Link Serializer
               - ti,ds90c187   # For the TI DS90C187 FPD-Link Serializer
               - ti,sn75lvds83 # For the TI SN75LVDS83 FlatLink transmitter
-- 
2.43.0

