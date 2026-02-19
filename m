Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E8D32695A
	for <linux-omap@vger.kernel.org>; Thu, 19 Feb 2026 21:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771535067; cv=none; b=OBrmoVC7S69PPA+4DGXvqQLQ4+Xf4usvnE5cQvcDd5vtPNHVJhAlm+tbSbAFilMMyEuyGBNUSvwvxp7TMZNssRecqFAO5AtAwVfIUxFQHVfuINJhvNPfymIsX2VvPIiCYDX4qJ3a3YdodtYEmCfUIDsudedoA6nL0yqo27EtGPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771535067; c=relaxed/simple;
	bh=QtehmTlxVE2ImMqTMUlN+wssHL5rLi9pMI7VHV6x+J0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CkKLhwP5OsrxOAtNss3Hceyzrp60S4yTPfIqujQdqHsO+HPBnP/QWta/S8tLTcgKP4aopyDjoYmYBYkYfWKAEESpkgyE4sAcGX6USfyOrzPstKfm9OZIJ66ihjOK5SUKtPSk6NCvAO7a27VrNLNW+MbKh1Q2o3yt8biRJ2qP9RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsNzkL+m; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsNzkL+m"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8cb3e0093e3so137365685a.0
        for <linux-omap@vger.kernel.org>; Thu, 19 Feb 2026 13:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771535065; x=1772139865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Hq1Jil93LKWD5SqiddgyBykMfT43TbOI7JPjGrETyE=;
        b=NsNzkL+mkKIug3+K4wHB5sTZBSr4Cz7Xew/VM1A/rD2k4GnJhAPaZZI6wvUDp15IwO
         7/Pcx2hXlUvHXLPNZXPtB+hzZAjvapQVVgO+RvThji9VcoMtFd3TdEVnfXxu6cGnxuQD
         DYAHFmOzgXuwlzDpZic6tGTY7Nz4pIi746b7fSfbIWISCRT6I3eKF1ARhReQVTzTqhwz
         vbqXNv6EZrCKAJoMw4pl/RkqcayBrVB/WQzIcdsuwl0AO73HVbXJhbz1Od6NOH/gqBCi
         /Fil17M4OOF3Y/+a4+sUFRtn0nM9uXBVBn4Rql6YYO8mw9hNhO6fVoz1Tvr9A9B/OHcB
         blNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771535065; x=1772139865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Hq1Jil93LKWD5SqiddgyBykMfT43TbOI7JPjGrETyE=;
        b=KltpJf4mze0vmOPJUWDPS5T5d3sb/TaO1krnlPmYY1ErVrWE/0bv7p2Ludgm+8f+wq
         aEqlO2m4JZkySvTUf+95bi2PUKBtRaQOZx7BEig45QcZpiHf+HiJEEq0rhNEtFcCwX6V
         QfonpENJ8Qz0zM/IPjzN/DaOxWc7yU7/AuVVwao0hOqkNVY0XWVn7GfMN3jl2DZ4uwE9
         3PrpR5qfYqkwcrhHU3yRAlGuo+NpmpqWEReAuPmsqtr6ucFvZr3JMhhKUOcy2FNF5M0w
         blLOol3yF2llN9FzGoeAM2ohks6ND9PcarpZS31x5Ecb6/RxnoDcXwxa1Ucb/lUs3aVS
         v8AQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2mIDAPmknxdMhvzbhLgVMf64nhFnfRW4f4PiIDmqU4o8cNWhbwZ+xxHTEzQJPHKu4C7FcUUZI4brD@vger.kernel.org
X-Gm-Message-State: AOJu0YzLKdRg+16WnzJNxMidwzqHWfMrGGAFsiK3+73I4cfyYAtTZtfU
	DTT85so5ruK4EyGxX/PpzysXVrZ7P5jWlsHfpMSq7+nHTdx9RvwPQ5JOcKX5n0H4
X-Gm-Gg: AZuq6aJroaedC76D4GXlQjNFJNCXwAm6mhxUABhUvTsz9Nwfc6SkoO7XwQPWHTYgWI+
	FXuonK1Wuz6NOV4BmbjTSqS8L/vtW12bCc9JdNnJ1PFT//CtCX4g76FTifJCC085+4zAGMl/736
	j+IsBww4a0SxuxT6AEXWuB2G/sr8GSvO0FUiMJFp2YFp2WX//uH1JwL+aK9yI/99VWDAk/UsWe1
	SpUhoHxbKyUclXGtmTYIAmv+q66FtGCnwvStc5GifI1sd2v6a98wU4ZPMlloATPyNUsHOt40plJ
	EVF/ca5aeds6staGhB7vvjr6p2dQh+s1fsA64eyAsOmF6C3Z7MywtVoPd/GFEJ4fRMVOrw48Kut
	hs89xNhnfLFKxJHTHIzyMnq/ShlVp4/BAi1Xy97Tfxg5OhBcppvx1aXkbwgmy9MA50j5c2ytdre
	3Zf/H+2CssU97F9FauLDdGLYH5UaQfOHRiR876v8K1nqsuvPiRJnaXM+kYLvkcCFWIzAljOp/X9
	9LjCqGUIkQ=
X-Received: by 2002:a05:622a:19aa:b0:4f4:c7c0:bd15 with SMTP id d75a77b69052e-506a82613f6mr301054061cf.12.1771535064428;
        Thu, 19 Feb 2026 13:04:24 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-506b275d59fsm153971511cf.32.2026.02.19.13.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 13:04:24 -0800 (PST)
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
Subject: [PATCH v6 3/8] dt-bindings: display: bridge: lvds-codec: add doestek,dtc34lm85am
Date: Thu, 19 Feb 2026 16:04:02 -0500
Message-ID: <20260219210408.5451-4-bavishimithil@gmail.com>
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

