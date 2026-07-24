Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4209530E84D
	for <linux-omap@vger.kernel.org>; Fri, 24 Jul 2026 09:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784884584; cv=none; b=Sx3XxxZU+MIFOCdJV3zzHM4r4Ld6TsOdTnectEh0LddgHdT4ZCDS0JPcm1qkvflaU2T9BUKppJ8wS8p4HbnwmU/gRuWvijd9BrhzhKlClTzgiJtY/VXQycvNP5rCq7MCGKc3k3wgBRKAyv8o0TMffG/G0qW3RDuf6lXVVwXtySc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784884584; c=relaxed/simple;
	bh=teMAPguyylPaCMYb5vDXceBt5uTOrTz7cewNFhv91cI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=t/8VhfyuN65fZUtAzfklp8OWM25u9rsGi+hloRCEoi0dV+s4J+yI2e2uGUEWS76mjeRGX/2AscH2dylvADSLxeJuZatkULwVanp9Z6M1+hU/ZWbEienwLU8h0LDNwuUjD1FtLaHknYf1QTdL/DlhcIIgyxom4rucUO7BASh5cvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0RXY89s; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0RXY89s"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cf110997efso556375ad.2
        for <linux-omap@vger.kernel.org>; Fri, 24 Jul 2026 02:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784884582; x=1785489382; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SlKvVsAZdZyNcMm228zHcviyjmOcHXNmz+JngmFmwiE=;
        b=X0RXY89sHfMshCrLv/pEb7lHmfhU83DxfdOY6kDu0EL+Nj7N5vgaRGWsZ6pmatxwsu
         KC9eBDy5Z8BE9tDTDeDTpR0GqVEs/FJeWUK611ood5aX02eKSRXwqu/iOHn7FakeIJqo
         vySSxo3173kKrJPzjrd/mY9M+cIMSH7Nf7u0OrP/VCEWXQ0upszCj5tyEMNhH7jdxcNV
         rdkYL+cqA149CUJrl4zLf+7UciEkb0twzdlvWwKj1AfvWZjiR2icGy/lFNMVc9sv42ye
         Gej8j8rRLkwLmKAGD/szAmD3JJGjY4xpCQlPY2SxdkYwrdq2s5HgtP65h9JhirIc5Imm
         hxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784884582; x=1785489382;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SlKvVsAZdZyNcMm228zHcviyjmOcHXNmz+JngmFmwiE=;
        b=Bp97P/0Gt2uriWuj1UZzhzDbBvrnqrYUwpsBz5nh9AHyX18JWsTZBlLVVgm9CNPU1b
         ZhcsGNkwpSrbNthxaykiovtrHKB2xDEvcB9fbUAJ0E2a89TMjVQ0MSNnB79eUvvziJZP
         pfefu3gabMl0Ygo1YTXHR26vS6VS/NVHr+atK2xWhlKTg8JS/2vzdlLFFHtvn9SWYeF+
         5PB2YUcXXxYU0Pf0S58vlYIPIWU1RuChWyYsE+J0x6D/kL7SYo/PB408DyyML/ER1kjf
         mNX0rysFMH9yU3J0P2ebsDNLn8IdPGzhxF5P5NH7yV86xmT9evPmF4HjdMRKVDp15t3O
         apuA==
X-Gm-Message-State: AOJu0Yyb0JZ5bsLTixrJ0VhzKZ6aG0dygCBiaoUM+FWZQ2f8ON0WjwHH
	fFwiYKaYB1tO/+uXGY63bwwzFmBQ3glweUdjo5KhdViIj7J+/rivQp7Q
X-Gm-Gg: AR+sD13qmqx7kiMK1+QaTCs0KdozHHuoUdpNCx9RyDDHJIbnjqg7If9twiC+xeBly/m
	PtBpcItz7uQ9KtDqQIbwozS3EiC2u/MnJa3V38TuuEE6lmugreZJFYll84YfLzRJDlZCwGw4ThU
	I4dvPRHaALs5XR/oBc48ouZkiD2H5gyWAYJlk3Ivgr9yGzAnHDF00DawrfBHG09Hpx3c+CBtD8l
	RY2v8BCRT9hvVaFqpYn5mixZGN3r/tjIwLeTSr3Yay/WgVrrhhcbRqiJ5yjgZyEatwSue0WTdK7
	chcbjzX9nwU2rYt/xvnycnaXePPjhCRZwOXlIp0NsWYDJyhSJCWg+novdCiJqa8Gf3bM04gG9af
	yim9kx83r0VZJPNlG0LjP3rdXOfRMN/E4dHJ0CeSsOx39KuUgKUpaHX+gJv7qjNo6Lc053784by
	Npd5mF5S5CIf3ac1k=
X-Received: by 2002:a17:903:124c:b0:2cc:e648:7e0c with SMTP id d9443c01a7336-2cfa6f8c2ffmr56582265ad.7.1784884581649;
        Fri, 24 Jul 2026 02:16:21 -0700 (PDT)
Received: from [172.28.140.252] ([2409:40c2:5420:f772:24a9:f23f:ed43:a5ce])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147df097e0sm29005610eec.17.2026.07.24.02.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 02:16:21 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Subject: [PATCH 0/3] dt-bindings: rtc: ti,omap-rtc: Convert to DT schema
 and cleanups
Date: Fri, 24 Jul 2026 14:45:51 +0530
Message-Id: <20260724-ti-omap-rtc-v1-0-ffef78853cd6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw5AMBBA0V+RWZuEejV+RSyqBiPxSFsiafy7Y
 nkW93qwZJgs1JEHQydb3taANI5AT2odCbkPBpGIMqlEjo5xW9SOxmksVaELKSVVlEEodkMDX9+
 taX/bo5tJu3cB9/0ATNBdZm8AAAA=
X-Change-ID: 20260724-ti-omap-rtc-6a5c5888e7e3
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Keerthy <j-keerthy@ti.com>, Afzal Mohammed <afzal@ti.com>
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org, 
 goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com, 
 simona.toaca@nxp.com, j.bhargav.u@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784884567; l=1158;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=teMAPguyylPaCMYb5vDXceBt5uTOrTz7cewNFhv91cI=;
 b=MMq2SQq5KqAySM9j+WVtWXO35EXoE6FO1+qCVrYPLqIIoIh4B3/LC/xsN+5ZBGr/Ye2/oz9HS
 P5j/Y60+jAACNo5A8ruD3h8NYzbLjfk2tGzbZFltntTSL8rBncXjAgA
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

This series converts the Texas Instruments OMAP Real Time Clock (RTC) 
binding from the legacy format to dt-schema.

During the conversion process, two legacy, undocumented properties 
were discovered in the upstream device trees:
 - 'ext-clk-src' in am57xx-idk-common.dtsi
 - 'ti,no-init' in am335x-shc.dts

Both properties are completely unhandled by the rtc-omap driver. Patches
1 and 2 remove them from the device trees. Patch 3 then introduces the
new YAML schema.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
Bhargav Joshi (3):
      ARM: dts: ti: am57xx-idk-common: Remove unused ext-clk-src property
      ARM: dts: ti: am335x-shc: Remove unused ti,no-init property
      dt-bindings: rtc: ti,omap-rtc: Convert to DT schema

 .../devicetree/bindings/rtc/ti,omap-rtc.yaml       | 129 +++++++++++++++++++++
 arch/arm/boot/dts/ti/omap/am335x-shc.dts           |   4 -
 arch/arm/boot/dts/ti/omap/am57xx-idk-common.dtsi   |   1 -
 3 files changed, 129 insertions(+), 5 deletions(-)
---
base-commit: 48a5a7ab8d6ab7090564339e039c421f315de912
change-id: 20260724-ti-omap-rtc-6a5c5888e7e3

Best regards,
-- 
Bhargav

