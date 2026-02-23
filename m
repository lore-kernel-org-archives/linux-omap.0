Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709593451C8
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 05:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771825886; cv=none; b=Zr47mwZX+OokQmjWf0X8J5vpuA9ecEMPXoNw0zdHa0UH2T5aTUMX4hbPdmw/QeRVyGgzDyFLHoShEEZboL1qrIJXJxqXiqxNnPIohk55eLJdoLB9o73iohIzbvQUr8nf8+TuAX/90Y0dAxw9xEiO2cVuBKGMFL3TfCGtA7lIyL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771825886; c=relaxed/simple;
	bh=QtehmTlxVE2ImMqTMUlN+wssHL5rLi9pMI7VHV6x+J0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EfiUajdii/YSDibCHvNejYkh7iUzP6K9ks0dNPQYJCoEaE5OUkry/mz13QAaG07sYEIHD/v7GKJjckwaEYv6kEJMJgOzHnMRzg3RyS4HymIXT37N0EgyCFYbLdw/WvzJsortIqFtEAY7TP4pdDA4Fqbn9N65XfBSNPlpltmJUW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aP7iuv4V; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aP7iuv4V"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-896f4627dffso54729486d6.0
        for <linux-omap@vger.kernel.org>; Sun, 22 Feb 2026 21:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771825884; x=1772430684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Hq1Jil93LKWD5SqiddgyBykMfT43TbOI7JPjGrETyE=;
        b=aP7iuv4VoYZ4GB4Gl2SYGyj04DZIW44DbSKynX2bNuOPsZFs7KucUCFbCMvYLwbulk
         v/JU/hELniL+vKX/rKVdSevFlwHEUEMxZY+V5MwV3LOr//XKBtp27Lt1/z/6w5n7a+KL
         omcYsDiVqDubmKja7YY8KOEuNCvU1rycH4jYndXYYrS1fRm3Qf+N2Gk6XpZZzLpBt9lt
         5T8ZxDqGRGvXxCZTxeL6RdJYZxUnH/fnWNIzp+mc4NY0fbDc7QaaTo/IGc9ylR6X8wcS
         UrP6O1gXy5RzT9MYTXwbNxKs/nPHFz3ROXAuVSD1GyPoTPhPMa0CQlfEJ7llRVzQASdf
         4UPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771825884; x=1772430684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Hq1Jil93LKWD5SqiddgyBykMfT43TbOI7JPjGrETyE=;
        b=sbih5rGhZJkHDuxcCNePT0dja4WV5pWDyj4qtAAlARy+HONzQJuhHBwRq814hiY+f0
         MKeoh8ENzf01fAi5DVait7P4RFX2e3tqVB4PNWXJQ9q5GgHBd4JMLrVb7toS4fDlywUC
         LpiXWkvZNMqOkDVCIJyzYeIyHZVLmQDm/9ngWmS6hT0Kb4u8YB4XZfzaGrrESQ/ZxKL1
         RW6GPOeGhq5jEWcnLxXiN56FuUxNg7Cjx8ksuJ6jdN+biH1B5/WJAPyp+K5Sfl27rv7b
         ZxDEtjo4ThIrdAFOM3s1t5M7riFGwf1rkHafF/fQn0OaSpODWOxIqTfkbKxsVU+RFiCC
         2Kow==
X-Forwarded-Encrypted: i=1; AJvYcCWMLdb/VojGJGhB8ubMOkQQyUkbn6rL1rdjfIIg1lZa2jNrc0Vro4V0kg1BeEWFPH+W/2BHKZd6M09y@vger.kernel.org
X-Gm-Message-State: AOJu0YwaBuyn+HB2KcTWrYFbGRz7SlIhe5wPXuvKxlhLiWw9X0K3Y+Km
	Y8ymEFaIEsRBIwBtCctpB/ZxCMlz1ZpsaXl1GAn7Tlq7F+mBigDGYO2j
X-Gm-Gg: AZuq6aLQZLL59IW5Afwnrz02cWnAjs8C3am/h2+T5okxyUL93fEsbYdalXCxYTVfSU7
	XtNDoL+EhGWwTr5uf0Wov4ea4EsVtZCB+YOJGKmPVTg6xnbxfAfW4vUNaFOKNvNXsWwUYNahypU
	TwOw866Hn1A+7DD2HLM94P8b/t2crm+9x/cUqEokJ/5ioWtemVhtbFGGOLYDOwiGOzIF/6wFAG3
	7ObC/StBMHUQvr3qJKZAixPfg/qYLtz3pwUnqcFpHPt2CW7z09oc1iaxTSTu+cjzauJFnc0cS97
	IFRYU1gerqKKnFjxBsT47cpuC/tqiaqtrN55Z6OPKJUsOYlVQdT01+XYj/Rx1+ZLwo/xZ7bgz+2
	eS7dc3Z78E5wkHZI3F/sgvlBuVS3hna3kpnmz3ULqtDQMf+xWACjON2GDIg4pg0fFxn92N7AeK+
	nBB6BgVY8W7TU8pNc9oT6Q4HY9A7SYzaBQ5hmPPVoUYF2gXLAbfeHA81ZDF8lVrelWUiwrHfYIi
	6gxXNNz760=
X-Received: by 2002:a05:6214:1c0b:b0:897:277:d03e with SMTP id 6a1803df08f44-89979d74b41mr116677656d6.58.1771825884353;
        Sun, 22 Feb 2026 21:51:24 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e62f453sm59459096d6.36.2026.02.22.21.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 21:51:24 -0800 (PST)
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
Subject: [PATCH v7 3/8] dt-bindings: display: bridge: lvds-codec: add doestek,dtc34lm85am
Date: Mon, 23 Feb 2026 00:51:08 -0500
Message-ID: <20260223055113.1288-4-bavishimithil@gmail.com>
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

