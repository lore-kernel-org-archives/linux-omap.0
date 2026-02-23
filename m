Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B5B28C869
	for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 15:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771860387; cv=none; b=ONoNpX3oMbkggme4GbxTk92Eq+hFH2TbTuGMbCJJQig4JM9eIKB55mDQbnPbuDyRxjwg0MjjY6Wq+9g27gbKVX6rUepJYs0ZTI+KfPzNjKT6nLKnN0XMfSFWK270oXKb+tXH/uppdJNBJdG7uga0VTkUN5WNjtBBjAiJRqAT4P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771860387; c=relaxed/simple;
	bh=mQ3MQMilzw20LjUCns41Lku0TPq9ZMFc4qfQF8+Vt2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZMsQY9IQ29WR8OjLWPosN5iyl8Fe8HJ2o+MwrSC8HZ+iqZ0YhrVle7h5JoIXbNthZc3V5jEVE26OGC7kA4A/VYWeGGC1EvuGSEKXYcwXvn901CuQNc+UUaPCPAjyMVcv8n2O205WBMI3DLeEygc/PbcrfGvSwpUAUcRZJo7D2Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dOzIcJ7d; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOzIcJ7d"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5662c2937fdso3995365e0c.0
        for <linux-omap@vger.kernel.org>; Mon, 23 Feb 2026 07:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771860385; x=1772465185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/aUtuOEkRmi402+kxGGUvbzHIC7w7l1S49zZW1GH148=;
        b=dOzIcJ7dUluVjTt8ZMdjfR5wcjGvYhXoyCE2fZyaP21N2c6zgVAajD6G4bB6QFhUf6
         C2kigqDl3f04rPnDYHwM65bfoOFW5Sky2bTHP7nl/sQrdCyS9vVQoPRai3H8m/srQkC+
         K0JU0Nf0LewZNIx53BqvBZFmq9yE54AwPLWuBc+HenBZb/Qgp9fJqPX8xZ8whHuM84aq
         YdH587MBd8zvMVHDWsD7aZvi3ZicU2Mu4ds3tTbjCQfJ9ndsFqxIEx9xwTAauZ10FBfD
         OYvakgRDbWCBJp3FGOknStgd1KMwC7VRlrP4qzqXVboHDNBwTgoeu2zA65aWrXBupshQ
         0dcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771860385; x=1772465185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/aUtuOEkRmi402+kxGGUvbzHIC7w7l1S49zZW1GH148=;
        b=Ly0QwUOofX8lmN/vnJHoIwhoTOGKKqMRGnYi0mConjituEzXeNfXQlFA3DrAS+HNMX
         wjSEy1ZoWg4qKuwuj55HitEW8HnA/UVQY9o89tIWYOoyYZPay3yn7cSlFVnQQ6omxHf7
         A4fRvkrOwFqloFp/X3XN3Hb2gitRx8vYKZcy+TBRgTaK7RTKFC4IIiQxDAcWAZkx2/eD
         58oHCMRmuEjur3jHqrYL0FSrtbs6I9y4GcMmQVOXQUaHThSnpe0JykViwy394VAruPyx
         OrQIHkwhwHclTz112hIEhvszkkDQqBmgjS1j6Mf4gY6BsoXELaLzibSlJhJuYoqIUvTb
         hhEg==
X-Forwarded-Encrypted: i=1; AJvYcCXe6HP8pw2oGzIwKntxdTiXOeA8OXYwUpbyZExkD7v9ADoiWAfxhWTRYr8EDnN4hfEhXgW/1vm77sKj@vger.kernel.org
X-Gm-Message-State: AOJu0YwCiAcmmhAba8ZQi6rYY2BIZGt4RK4iW2ug1BFQeUEeooThJlZH
	kqv77hpY9B8dE4SHpwQtJm27K7CdzeaeWbS6KkDVh+Hxsueri5n2o4a1zwZzDKVn
X-Gm-Gg: AZuq6aIyqyUeHi+r9FO/N/TXTv+Y3EYilyMrhzioK/+C0CvfNNKs4svJRxdYMYVcA2x
	NTf7UvOuP26o0Qx7wGLSWd33lIaiDe0U8uvH7VgFRZ6HmWga+cZrRwavB4QKKrSVxpjcxLl5ioX
	4+DLgEJRSnFVxtaot2axjCtF2sD1wpEog1Dt/LFZdjuAbZGTyVqEMIUn2k4H/1UZKAdolev0XTH
	VBz4Q06hlbkrJ8OlsN+Ces6K1FLk23/2HalFWHc9YekvUzPjXK73+lMfaajC9C4B+VVFetsAGbu
	NC9djXQlhiL1JqX/ogq7kv6zrs6bjV980NzTM2eWQZLmPE4BGzeznQsa0Da4K+xzLNk+WnQ3rFO
	vicWT+q8QbgmmgeHnueikQGHNHHQdMbebxXtqYcsTzzQYpJl/OOclRPoYuoRB3aA5dYIjwQeSyn
	A3yvftI5+ObakyGF/Qg0fUjxEd77rKhIilPpR4SgfIb9ysfJlMJZF6pnU+TkvvG94W5sNGUt/8k
	5ZPozqPfLw=
X-Received: by 2002:a05:622a:150:b0:506:a394:ca64 with SMTP id d75a77b69052e-506f30beef1mr188405381cf.16.1771854584689;
        Mon, 23 Feb 2026 05:49:44 -0800 (PST)
Received: from mighty.stonybrook.edu (nat-130-245-192-1.resnet.stonybrook.edu. [130.245.192.1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e62f453sm67954716d6.36.2026.02.23.05.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 05:49:44 -0800 (PST)
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
	linux-omap@vger.kernel.org
Subject: 
Date: Mon, 23 Feb 2026 08:49:32 -0500
Message-ID: <20260223134941.427-1-bavishimithil@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subject: [PATCH v7 0/8] Initial support for Samsung Galaxy Tab 2 series

This series adds initial support for the Samsung Galaxy Tab 2
(samsung-espresso7/10) series of devices. It adds support for 6 variants
(P3100, P3110, P3113, P5100, P5110, P5113). Downstream categorised them
based on 3G and WiFi, but since they use different panel, touch
controllers, batteries, I decided to categorise them based on screen
size as espresso7 and espresso10.

It adds basic functionality for both the models including panel, drm,
sdcard, touchscreen, mmc, wifi, bluetooth, keys, battery, fuel gauge,
pmic, sensors.

Signed-off-by: Mithil Bavishi <bavishimithil@gmail.com>
---
Changes in v8
- Remove WAKEUP_EN from omap4_pmx_wkup
- Link to v7: https://lore.kernel.org/linux-omap/20260223055113.1288-1-bavishimithil@gmail.com/ 
Changes in v7
- Removed prox_irq
- Changed commit message
- Link to v6: https://lore.kernel.org/linux-omap/20260219210408.5451-1-bavishimithil@gmail.com/
Changes in v6
- Remove references to WAKEUP_EN (drivers dont support interrupts-extended)
- Remove gp2a_irq, it was for bh1721fvc not gp2a
- Remove mount-matrix
- Link to v5: https://lore.kernel.org/linux-omap/20260129054709.3878-1-bavishimithil@gmail.com/
Changes in v5
- Commit message length < 75
- Squash commits
- Link to v4: https://lore.kernel.org/linux-omap/20260119033035.57538-1-bavishimithil@gmail.com/
Changes in v4
- Fixed syntax in doestek vendor
- Changed - to _ in node names
- Removed address/size-cells in chosen
- Added pinmux for i2c-gpio5,6,7, irled
- Allow sdcard to poweroff (reg_espresso_external)
- Changed power to key-power
- Order alphabetically in omap4_pmx_wkup and omap4_pmx_core
- Use generic node names
- Added TODO for future nodes
- Fix touchscreen values in espresso7 and espresso10
- Add dts to Makefile
- Commit message length under 75
- Link to v3: https://lore.kernel.org/linux-omap/20241108200440.7562-1-bavishimithil@gmail.com/
Changes in v3
- Use device tree from the correct branch
- Fix commit subjects to matching the subsystem
- Add Doestek vendor
- Add compatible for LVDS encoder
- Add compatibles for 7 and 10 inch panels
- Clean up device tree using "make CHECK_DTBS=y"
- Link to v2: https://lore.kernel.org/all/20241030211215.347710-1-bavishimithil@gmail.com/
Changes in v2
- Fix node names in common dtsi to have - instead of _
- Removed import for twl6030.dtsi
- Edited dts to completely use twl6032 nodes
- Fixed typo ldosb -> ldousb
- Link to v1: https://lore.kernel.org/all/20241030194136.297648-1-bavishimithil@gmail.com/
--

Mithil Bavishi (8):
  ARM: dts: twl6032: Add DTS file for TWL6032 PMIC
  dt-bindings: vendor-prefixes: Add Doestek
  dt-bindings: display: bridge: lvds-codec: add doestek,dtc34lm85am
  dt-bindings: display: panel-lvds: Add compatibles for Samsung
    LTN070NL01 and LTN101AL03 panels
  ARM: dts: ti: omap: espresso-common: Add common device tree for
    Samsung Galaxy Tab 2 series
  dt-bindings: omap: Add Samsung Galaxy Tab 2 7.0 and 10.1
  ARM: dts: ti: omap: samsung-espresso7: Add initial support for Galaxy
    Tab 2 7.0
  ARM: dts: ti: omap: samsung-espresso10: Add initial support for Galaxy
    Tab 2 10.1

 .../devicetree/bindings/arm/ti/omap.yaml      |   2 +
 .../bindings/display/bridge/lvds-codec.yaml   |   1 +
 .../bindings/display/panel/panel-lvds.yaml    |   4 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/ti/omap/Makefile            |   2 +
 .../omap/omap4-samsung-espresso-common.dtsi   | 744 ++++++++++++++++++
 .../dts/ti/omap/omap4-samsung-espresso10.dts  | 104 +++
 .../dts/ti/omap/omap4-samsung-espresso7.dts   |  70 ++
 arch/arm/boot/dts/ti/omap/twl6032.dtsi        |  77 ++
 9 files changed, 1006 insertions(+)
 create mode 100644 arch/arm/boot/dts/ti/omap/omap4-samsung-espresso-common.dtsi
 create mode 100644 arch/arm/boot/dts/ti/omap/omap4-samsung-espresso10.dts
 create mode 100644 arch/arm/boot/dts/ti/omap/omap4-samsung-espresso7.dts
 create mode 100644 arch/arm/boot/dts/ti/omap/twl6032.dtsi

-- 
2.43.0

