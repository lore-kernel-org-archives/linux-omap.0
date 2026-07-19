Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB0220C029
	for <linux-omap@vger.kernel.org>; Sun, 19 Jul 2026 13:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784468282; cv=none; b=l01PApL3mPMy8Ir5rtYZmfjlRQh7cZAza5KRibgjZYQRrUrXdZ5Ukspoewx9bEOlIWYLdZm5rpO5u6nsVN2tOJKF8qt1bg2PaTd+pGYkHtWTXza43fwBmeX9erFdqX7ps7K3qX+b9Ska8Y0bT1GJfg/ilxg4yKpD47N92XpuWx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784468282; c=relaxed/simple;
	bh=V7cQtYXT1oLCrxYl9d+RloU5vz4sOIsuAqfNBNM2KV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cYFPa3T9qRUO2+qwGLCCioj930i1k1o2iCTbFm0xH/VG/wQoSwrgIeA6YTosrKk2jX9XWNCXKtWGRsqcasvcLKkuj4OjL4ZXkHOhYbIFLaNfQoXK39PKpEFYTRzEE6y0TMG024Le19ortAswBoGr4V+YXwUCL3O5QnJXxZkHwW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTMzCwCt; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTMzCwCt"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49558ce01afso3795675e9.1
        for <linux-omap@vger.kernel.org>; Sun, 19 Jul 2026 06:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784468279; x=1785073079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=T8M2tiw5eOuKti96JSxIGvzIRa/bxVJzwY8EbOmcsNo=;
        b=eTMzCwCtgF9/h2/FlyExr5UYUbp5NnPMkR485TxUTkdS7FdGYY4A8O/bTQ31EKJWF+
         JziCB/7Jk2JDYa5Ya1E01kL8l3FHaydlPuguW8VO4oikLGmr9omdhJWqUyo7+xol7rpJ
         9Bu9KjNmkNAw7l7duQinyIA/hXrnUQ1r4imwYMVCnnpOojMlPTqioh2YFZMAFAjio0Ga
         f4SjWMQ3g8Y4dB77P2Sfmxw+50xqTee/OfGcdrxPEKGvqpaAdoFv+ZbDxsf0yxtnG6EE
         PSTM/Gq3w2bVsWNLVfugksnNVlgBtzTbp3TX5NkZY+eTRJOZyC3EdxoIShxGThTJCJuB
         zgBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784468279; x=1785073079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T8M2tiw5eOuKti96JSxIGvzIRa/bxVJzwY8EbOmcsNo=;
        b=WbkeOsyJAj/uPEQW8A8zhpVcBBo8oWG/Rx9P5SCsyGYMAaJcays4V0B4YgE8a9xyLF
         dJlhQCcl4Rrqrn4kUnii5bssa6MGsNo1/kQBAIqTS74ly+3Iwxf5Yh1FrpCbKOxydXBX
         x7dfRT5YyOGYgG2OPVgtd86+3nWPml2aIlA9zKyI5uVrRxLqnLGVH4eGJM2wXD5HAz6l
         Hq9D8StH0uzfi7vqnapeJkDkZ4DFFL2NyZ2l5tfkvt9MB8mAVWn5c7ldKfHTK/IczjU2
         d+qDF/uK2HwBqSDlSFwqBK1yhS9Y6ixX2Yft+956yRVOAST08T+3bx4d161J/e4BPZHk
         SY3Q==
X-Forwarded-Encrypted: i=1; AHgh+Rqw+smCNo3dBI4QUSyoMu1vS4Q8gkcR7CJmWFUcdYUuYQYbE373ijEb8CGMzcAhLgymEYcWc5iBqdu6@vger.kernel.org
X-Gm-Message-State: AOJu0YyvNCWQyWKy0T39X8YaDYyiWBD9qZ4Qm/wrEyF1H2ACG6oo+Mbh
	aDS7hE+yrRdy2w0NAT8ijUEbIOTgBpSeRDDVVTEqZ/FW8H3U6k294VSl
X-Gm-Gg: AfdE7clBwCY1XHQK8DkMZC1jJBtm5vo//1ciOaeN/asMQvc63TSDHPMVFmeYWBuQNRo
	NJ6ikEusCDI4nVNxFoU5sy4rn62lGoy9cQXMrhvnwwY/+qnMQXHnK048+xBsbORNQvqBtIighi7
	Obf5FbcEmAqujEngsC6BxHsywSsVrE7d7+FxqC2/+H6x+GZWu9udc/PnI2qcp42ahxl8WlcVP2h
	fDTgjxOoHrERPQ1MgSmkPCJtDzMvvCEjCpzsZSPhpuD/YIdOurg4PmZmX/MNoVc/r2GEScVclm6
	T7B69Jm2lHizyGPSgxCWgcSGP6HMJ8j2u0gsixvEpbTy75+ERfknn8+ngBa14DvhtNsaE7QO4FY
	dFJrSi2vW0Fmq2uZHvbrR47qd0SFXZyEt03+ZADvO/lgKEuUfy0ryGG8Up4V9LIpCvphPM3FLQz
	SvO0sL5T/WrwBNawCyvUShC9u4UOt/Jj3X+mmG9dy8ARk2
X-Received: by 2002:a05:600c:48aa:b0:492:6efc:7c60 with SMTP id 5b1f17b1804b1-4954a516183mr75623815e9.28.1784468278420;
        Sun, 19 Jul 2026 06:37:58 -0700 (PDT)
Received: from localhost.localdomain ([188.26.50.240])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-47f63edda9bsm21807179f8f.31.2026.07.19.06.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 06:37:57 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Eduard Bostina <egbostina@gmail.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Roger Quadros <rogerq@kernel.org>,
	Tony Lindgren <tony@atomide.com>
Cc: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	goledhruva@gmail.com,
	m-chawdhry@ti.com
Subject: [PATCH v2 0/2] dt-bindings: input: Convert TI Keypad Controller to DT schema
Date: Sun, 19 Jul 2026 13:37:28 +0000
Message-ID: <20260719133730.3551691-1-egbostina@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch converts the TI Keypad Controller binding to DT schema.
The second patch updates the OMAP4 and OMAP5 device trees, which is
needed because the schema requires the matrix properties.

Changes in v2:
- Added 'interrupts', 'keypad,num-rows', 'keypad,num-columns' and
  'linux,keymap' to the required list.
- Dropped the '|' from the description.
- Added the DTS patch, so the OMAP4 and OMAP5 boards still pass
  dtbs_check with the required properties in place.

v1:
https://lore.kernel.org/all/20260708123252.1768355-1-egbostina@gmail.com/

Eduard Bostina (2):
  dt-bindings: input: Convert TI Keypad Controller to DT schema
  ARM: dts: ti: omap: Disable keypad and enable it on the boards that
    use it

 .../devicetree/bindings/input/omap-keypad.txt | 28 ---------
 .../bindings/input/ti,omap4-keypad.yaml       | 63 +++++++++++++++++++
 .../omap/motorola-mapphone-mz607-mz617.dtsi   |  2 +
 .../dts/ti/omap/omap4-droid-bionic-xt875.dts  |  2 +
 .../boot/dts/ti/omap/omap4-droid4-xt894.dts   |  2 +
 .../boot/dts/ti/omap/omap4-epson-embt2ws.dts  |  2 +
 arch/arm/boot/dts/ti/omap/omap4-l4.dtsi       |  1 +
 arch/arm/boot/dts/ti/omap/omap4-sdp.dts       |  2 +
 arch/arm/boot/dts/ti/omap/omap5-l4.dtsi       |  1 +
 9 files changed, 75 insertions(+), 28 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/omap-keypad.txt
 create mode 100644 Documentation/devicetree/bindings/input/ti,omap4-keypad.yaml


base-commit: 0718283ab28bc3907e10b61a6b4be6fefa1cbb2f
-- 
2.43.0

