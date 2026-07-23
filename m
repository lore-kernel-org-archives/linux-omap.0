Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF53E4399C3
	for <linux-omap@vger.kernel.org>; Thu, 23 Jul 2026 10:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784801180; cv=none; b=mzprKH7tDbukXN6fQ7hb+SfgxUb8/llNRfwc8o3E6fqsAQPh2RHl75ug/jGBDupwTVRP0raKb66VnZQZ7XS+prJDBSk2Hh7P5+qFmpM3N3wdnWrCd5TaR6Wp+3f7GmSN0G6CKbLF1vLu35aWMcs76KyJR5hGs9aBAzh/ec57u2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784801180; c=relaxed/simple;
	bh=+Wyfo2vtIbswyXq9efM7rosBVsTJwzmKdaBzzC/aYRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ea3M+EOPB9kJqps2mZkcc07xcEbz81xyCktV6S4Pddf9UIJX07UAmhyvdOQ6lyIpxMsxKlUTd36yhafyi0/fLOA2I9O9Ca3+Ts36nWIumrFA2eGQHz1MzYcjvSagW27RJh91DN2m+y5zyhD7wXYuedPslG3Pf8KaCMPMoVcCaGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FXwYL5Cp; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXwYL5Cp"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49554ebb87dso5135235e9.3
        for <linux-omap@vger.kernel.org>; Thu, 23 Jul 2026 03:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784801176; x=1785405976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BcGqlv2rED4NMS/3uzjzLmpezgSMOIuZyea8FmG7iIE=;
        b=FXwYL5CpobBGYaEXcsi7sfU/6zrVN+9MWYNCWa0tCT18D4dDmbXrVK5NqH0gOsWfCe
         TrFl0WWlwGXcPvIK8yWyaUTM6alsB06ngOdyMJJYnhiybARvXq1MyS7QIXhveZPHIPCH
         SfPLk2lk2XWkzMq806Cru7wBi8yLywO+i+Crk5TwdRwRUPJ3jDTOKfUCe1tqEuCmIPcQ
         u53zSiyYtRvDPkwxUQ64OV6pjw2IedJVh5EZHucUAULDCYp0AKU94k0bq0xF1TYn5b14
         7r7wd+CMhTXXhJiXQV/KP0JFKzwRwg4eTflMaxb6p3WO6oTwu9kka5mdNgtqPURVXmV9
         6F1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784801176; x=1785405976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BcGqlv2rED4NMS/3uzjzLmpezgSMOIuZyea8FmG7iIE=;
        b=AuFv2jvoib19lDJP3M2143LwEUljkva7DkK35sqJwQ8lVK6N3l/pKVv3XJL4FgE7KD
         Yu1mvO00cB3NcWCUrOZS9TYRm3VZZ4WIAGbBv5UoPuuPH0bjfauavdkvAUkpDApbBuEe
         EfwPS20AtWJC2+cJdSCzh/r/xgSeFjETLYnNuw3MT2clxMdTIyvwN1PZ0IVUHmpFbzAp
         Ur9Jh+UBTStMOFyZ4sxMRLVRn0lR4gLBs8jMToQAhyvkDclnGKG+nSrun0xAXLrWa7K8
         z+ZAcxZnblG3fmiVPqH1HBrU82HisI9SUiruCLmYrHfH5BABtojemeQj5I943wQF7mTH
         8zlQ==
X-Forwarded-Encrypted: i=1; AHgh+RoAsA2SiEu5OgN+OM8DD8DPK7EiWpG/eY2xd2H6caa3WKaITWBw8I1nX4r+HjWSUQ7YpLdzOcguJ/3Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8EIf3IxYteclXCl4Fykij7WuGXoPey+4SujWFXWfQ/Y9cMiJI
	nYx2BiPKho9ynsfPXj2XFXhi2CdSv6sjMw8owXamhd9wn6BGS1d26A2F
X-Gm-Gg: AR+sD13LmTnns4tor6+DNpleQz44iSKMWEMs+m5IP0vu30cVgnWCcNjXv6cngcM3zdx
	tPldUF2UYx0qArbDKzMxhN6Ehi5PO93lKyP4lxGUNwm+AKwtRD2OljvEvTigle+uP7H96pk1Ah3
	FbhlgHId9Rnx9mAWaHs9ll4953TOf5+vGlYTuEz/UfdsuR7Fy8HTPClfAhrjAa7ihH/9TGcSS38
	eptIPfXyfDbTyc9p2lrk7k5/QjIfTe395m3rd4sKYxI9UXkiJWWm5rS607U0fbFAhdV9SXuHn5o
	YcfG9DmUxHSAeg3oRW+wszAQCjnf9DoG7LHIco/yoT4QTaaYFqMueCIXhKVpQqHHTGlkWKqgfAW
	qP0RB0WinjS417LaKSTAfdGSqS26s3YpxZ6aWgHkAgBfas1QnIm4wjvZKw8zJMtMVyVu/KavcOA
	YDpWmPhmcD2cCkXW9HCbuczSnxBUQdSDBYI+i28kXaVv1P
X-Received: by 2002:a05:600c:1914:b0:495:4d00:2fc0 with SMTP id 5b1f17b1804b1-49573ccb598mr27399575e9.12.1784801175908;
        Thu, 23 Jul 2026 03:06:15 -0700 (PDT)
Received: from localhost.localdomain ([86.126.27.145])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47f85b9a60asm14212163f8f.3.2026.07.23.03.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 03:06:15 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	devicetree@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	dri-devel@lists.freedesktop.org,
	Eduard Bostina <egbostina@gmail.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	Mark Jackson <mpfj@newflow.co.uk>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>
Cc: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	goledhruva@gmail.com,
	m-chawdhry@ti.com
Subject: [PATCH v4 0/4] dt-bindings: Convert TI TPS65217 to DT schema
Date: Thu, 23 Jul 2026 10:05:58 +0000
Message-ID: <20260723100605.628882-1-egbostina@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series converts the Texas Instruments TPS65217 PMIC bindings to DT
schema.

Changes in v4:
- Removed the regulator/tps65217.txt binding. It documented the same
  'ti,tps65217' compatible and is now fully covered by the new schema.

Link to v3:
https://lore.kernel.org/all/20260721112133.70382-1-egbostina@gmail.com/

The binding covers the whole PMIC, so leds/backlight/ may not be the best
location. I can move it to mfd/ or regulator/ if preferred.

Eduard Bostina (4):
  ARM: dts: ti: am335x-guardian: Drop unused isink-en property
  ARM: dts: Rename the TPS65217 regulator nodes
  dt-bindings: input: Convert TI TPS65217 power button to DT schema
  dt-bindings: leds: backlight: Convert TPS65217 to DT schema

 .../bindings/input/ti,tps65217-pwrbutton.yaml |  42 +++++
 .../bindings/input/tps65218-pwrbutton.txt     |  30 ----
 .../bindings/leds/backlight/ti,tps65217.yaml  | 170 ++++++++++++++++++
 .../leds/backlight/tps65217-backlight.txt     |  27 ---
 .../bindings/regulator/tps65217.txt           |  78 --------
 .../boot/dts/ti/omap/am335x-bone-common.dtsi  |  14 +-
 .../arm/boot/dts/ti/omap/am335x-chilisom.dtsi |  14 +-
 arch/arm/boot/dts/ti/omap/am335x-guardian.dts |  17 +-
 arch/arm/boot/dts/ti/omap/am335x-nano.dts     |  14 +-
 .../dts/ti/omap/am335x-osd335x-common.dtsi    |  14 +-
 arch/arm/boot/dts/ti/omap/am335x-pepper.dts   |  14 +-
 arch/arm/boot/dts/ti/omap/am335x-shc.dts      |  31 +---
 arch/arm/boot/dts/ti/omap/am335x-sl50.dts     |  14 +-
 arch/arm/boot/dts/tps65217.dtsi               |  31 +---
 14 files changed, 275 insertions(+), 235 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/ti,tps65217-pwrbutton.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti,tps65217.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/backlight/tps65217-backlight.txt
 delete mode 100644 Documentation/devicetree/bindings/regulator/tps65217.txt

-- 
2.43.0

