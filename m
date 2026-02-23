Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C86235045
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 13:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854592; cv=none; b=OcY9i+1G4VLA95G9TXzS94D4WKNhBqNxqVp+kUTwglKTCv8CdHUL9d8N+BN+ZvaPfEiPfnSLJtIL8kkkmNqRgR+/MkrBKx2cmZmL/aewkGGVVl2bY1dSMhfSyW8E+P3GLa7ICM/dyeYgw2MqYrdKcNcU4s50nGGwnw/A9qgp8uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854592; c=relaxed/simple;
	bh=QtehmTlxVE2ImMqTMUlN+wssHL5rLi9pMI7VHV6x+J0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMMwOpE44qbVWmAjlq03C3QP7DA2HOSEdXHQFdfu5oDgZkbZlmxq7akR5f5LhEWzwc/4i2mQwn8OPTnZDdUsqhTwoYWVQFUZuFasK5MxHYSJzQ6XWEgH+yR/gdR1WKqoTIgYjl1Tm+LPqfKfiFcysU2W8fRt0qilVXam1txYhtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0QWQBfU; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0QWQBfU"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8954a050c19so53868836d6.3
        for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 05:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771854590; x=1772459390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Hq1Jil93LKWD5SqiddgyBykMfT43TbOI7JPjGrETyE=;
        b=c0QWQBfUNBiM17Ru7Mdwxqltc/eWoW8/omuiz/ynwi7XTLZfOFrSMQrNtyCmINdEv0
         bLcVNHBwmk8s5J7HEXTrNpyc7PDt7GyLEVLAPiBT5+GEQNytmCTVGbTiL5U9kcPY3eBR
         SbPPocBSuA4DTwhoMMMJe8QL4DkWkpPa+FvbcFV/VChKq/uZ/dIK6i2G32dPTsYI9XTD
         bhUFrCQC9OzTJetXFBfYXOZ7AvzF8ptWPkoFnE5Mrj4ozDn1T38SJ+hIUvKOk9CujeP8
         Uy3wzyab1oCAxrWFNfyCQoYkcZ3gFkGsvwv+cE3faH9qUAlqBRnrLV6wQdi1MD7nCCqM
         ruzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771854590; x=1772459390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Hq1Jil93LKWD5SqiddgyBykMfT43TbOI7JPjGrETyE=;
        b=eOJsxBKuFJudsYOMbKY7rvy0/5WvuIKyZZrhzmjXRouiCT5dXSR2RrMVRB/eVdL1J8
         Ngio5ZcX0gfC1KfIY+yVZP4ItE46r3+eJ25G9CedTHhMqvqj1U3i45r82UobfrXAA/tA
         TwnyHexjl3oH0dH6QVAi0FbmHuXfS5qO1EDVTw1m4m5fcZF1rg8inWvJsMzeq33EH9Wu
         WgBOrSPNG/ovVvyeqFJDQQ/qjtZ+YREvkltVp0stuXCxRhtB7neI3ia5+YDdyBVy/hH+
         yiIvLRzneyQV08Z9SxfXJwYHZI+txTuLgpuhECYH9CjCMFeC20wwTVfU8HaBXmaUA6fj
         3Ayw==
X-Forwarded-Encrypted: i=1; AJvYcCUadKHpZQmFKD/Vyz7BlUHoVCyVOd+f0aZfGe/ZI64zroB2qaG/q4HDyqWOQGg6tfruqydZO3x+v6rd@vger.kernel.org
X-Gm-Message-State: AOJu0YxAFdIojbzuxa4fDGlysM9FW9RuTCMDctVsMaFIzQ+m/GE60DBa
	dH/1Rsc6z9SlLcOUi9ctFmXMnYwjDPDJRSXooV8PY+CjY4S5N8X4SGqR
X-Gm-Gg: ATEYQzxxHdr+e/bSgY+hP5JsgDdlttpNM2VY3heGv7WbU+wKWb1GuCoA5EHwAIOLzqs
	CT0j2Kv1OggaBiplUh66OOmqbIjRBF8EDFvEoTEmKApr6wZlv0aEs1/AT4gEFVtcd1S5y7jOZ+N
	RO8QePy04dxIkCu5S37tmRzwxCDUHf0ZNVq4SNuWEzLlo8raBV6GGsqNsNAZTtGaQ0OmpX7YW/t
	DpsLG0nYXJ9n+MhcetmTtUHI7ajRmpB6CPXk5e5XwZPH2ISbPc0nvXdDa29k44DBCkeTYyadEzz
	pyzSw+4eFDDqAC81Pcc+SNQRR+rKp0OzJTCV84D1eUDw3QcEbPcJT8P7qugS/ygQT2P1VF8YUVo
	q3THKQJ3B/SqvOTzxS3z0z7V0zKluAJCqCrTBsnnbwYW1qIOWWNxFsyvF+3Nafs51d+xlV0jeb1
	7zMWppn+TlJRosRX6FA7/15Lhzd/5jw4ZL1v5niMqESAdVwETOyX4wHDOUijgL07F4y6EsK9plr
	2Kvk9OPsODNsKwt1/JY5A==
X-Received: by 2002:a05:6214:416:b0:896:f73b:c887 with SMTP id 6a1803df08f44-89979e31ccemr123555016d6.4.1771854590226;
        Mon, 23 Feb 2026 05:49:50 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e62f453sm67954716d6.36.2026.02.23.05.49.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 05:49:49 -0800 (PST)
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
Subject: [PATCH v8 3/8] dt-bindings: display: bridge: lvds-codec: add doestek,dtc34lm85am
Date: Mon, 23 Feb 2026 08:49:35 -0500
Message-ID: <20260223134941.427-4-bavishimithil@gmail.com>
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

