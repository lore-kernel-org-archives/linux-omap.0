Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B678D27A123;
	Fri, 23 Jan 2026 16:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769184759; cv=none; b=QvyGtmZ+BNaLmqCYqsKXSqruLpAwfe4AONnGeKJ7pDdNfUWTIXcKQFRHeBb85AApYZgoatAyxlZGm6Rv1/MNRmf6htT4vNlWJZ9Z0WyrWp5aX9miu2k7dZIifWDi/mnJP8TX6PfYSS25p6zZVPPUqcaoiQ7i7HE4aTjM5CTcA+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769184759; c=relaxed/simple;
	bh=8QediZ3dzquk9JlHWoZkXYCXhK1Eua6fI37+M5HfTk4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U+GQ7nJbuks3q9tBN60eQh1DSP+5JOXncb+Tu2Z29pXLMnMw8MtwkbcT2bX63BixagYGzwkDAEix8W8rqP2fe27lYZGTqBeTxyV1uYbHTYgbzsYOkI1iDRjSFKOIxCc/gbGWbYKYOTyLx+LDF75JQsda8TADjpv366LlF1WOnlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KL8KaoLE; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KL8KaoLE"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 34BB9C20308;
	Fri, 23 Jan 2026 16:12:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B54DE6070A;
	Fri, 23 Jan 2026 16:12:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DBF33119A87A7;
	Fri, 23 Jan 2026 17:12:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769184754; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=Zz9tOwE8YXJFkhUKv/SREBAFzg3OcfCRy/XQlSA2sB4=;
	b=KL8KaoLE2xMoa9LKb2a2KfoWrUhaAGZIwlYs3ScimMu5cQCOliuLaI1oWVcDeTHv76fyJL
	sZDM2ViCxVI5u+KrEQNqsJhFNQ389EymZ4OgMliui0dE/oeoKPLBuYux2vW177e5CiHloD
	beewARNzo+YL/hnC2juoePilrEdwV+NKMyQn8pwm3p4kP9tpidqjvszBFdZpcnJ1302m0I
	U3Von6dFsU/3VSb34q9BxXWyoqOB6W/ZLeJrDjlin8K6KDU7u3BGyW7zx2FOZUBxogR5Rr
	stwpZLMGolXmkf3tMSObeHV+L9aacFYa3J0UROEqTVkrb6dHughJ46DEbuEoiw==
From: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>
Subject: [PATCH v5 00/25] Clean and update tilcdc driver to support
 DRM_BRIDGE_ATTACH_NO_CONNECTOR
Date: Fri, 23 Jan 2026 17:12:18 +0100
Message-Id: <20260123-feature_tilcdc-v5-0-5a44d2aa3f6f@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-omap@vger.kernel.org
List-Id: <linux-omap.vger.kernel.org>
List-Subscribe: <mailto:linux-omap+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-omap+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOKdc2kC/2XO3UoDMRCG4VspOTaSmUx3G4+8DxFJJhMbqBvJr
 otS9t5NK+JPDt8P5mHOapaaZVZ3u7OqsuY5l6nF/man+OinZ9E5tlZocA8GSCfxy1uVpyWfOLI
 eHUdyMowhOdWOXquk/H4FHx5bH/O8lPpx9Ve4rF8U4PCfWkEbTS44SSjWe3MfSllOebrl8qIu2
 Io/AAJ0ADYg0SF4thytlR6w38BgwPQf2Aa44KNJIyEM1AP0C4AeoAYgAyMCWXMY/wLbtn0COmI
 RNnEBAAA=
X-Change-ID: 20251014-feature_tilcdc-79cd49e67bf9
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Tony Lindgren <tony@atomide.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, 
 Bajjuri Praneeth <praneeth@ti.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Miguel Gazquez <miguel.gazquez@bootlin.com>, 
 Herve Codina <herve.codina@bootlin.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Last-TLS-Session-Version: TLSv1.3

The starting point for this work was adding support for the HDMI cape:
https://www.seeedstudio.com/Seeed-Studio-BeagleBone-Green-HDMI-Cape.html
This will be sent in a later series.

Initially, Miguel proposed modifying the ite-it66121 bridge to support
the legacy behavior without the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag:
https://lore.kernel.org/lkml/20250909-it66121-fix-v1-1-bc79ca83df17@bootlin.com/
This patch was NAK'd as we don't want to add more legacy code. Maxime
requested that the tilcdc driver be updated to use
DRM_BRIDGE_ATTACH_NO_CONNECTOR instead.

While working on this update, I discovered that the tilcdc driver
contained significant amounts of legacy code that needed cleaning.
Since this driver was developed alongside the tda998x driver for
several AM335x boards, the tda998x driver also required cleanup and
support for the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag.

A new tilcdc_panel_legacy driver replaces the old tilcdc_panel driver.
It modifies the devicetree at boot time to properly bind the tilcdc driver
with the standard panel-simple driver.

This series is based on the tilcdc fix sent to mainline:
https://lore.kernel.org/lkml/20251125090546.137193-1-kory.maincent@bootlin.com/

This series has been tested on:
- BeagleBone Black (tilcdc + tda998x bridge)
- BeagleBone Black with LCD cape (tilcdc + ti,tilcdc,panel binding)
- BeagleBone Green Eco with HDMI cape (tilcdc + it66121 bridge)

The following mainline devicetrees still use ti,tilcdc,panel binding.
I believe this series maintains compatibility, but I cannot test without
hardware:
- da850-evm.dts
- am335x-guardian.dts
- am335x-pdu001.dts
- am335x-pepper.dts
- am335x-sbc-t335.dts
- am335x-sl50.dts

Patches 1-2: Convert tilcdc binding to YAML and set the ti,tilcdc,panel
	     sub-binding as legacy.
Patches 3-6: Replace tilcdc_panel driver to the new tilcdc_panel_legacy
	     driver which is tweaking the devicetree at boot time.
Patches 7-20: Clean up tilcdc driver.
Patches 21-23: Clean up tda998x driver.
Patch 24: Add DRM_BRIDGE_ATTACH_NO_CONNECTOR support for tda998x driver.
Patch 25: Add DRM_BRIDGE_ATTACH_NO_CONNECTOR support for tilcdc driver.

Changes in v5:
- Fix a missing cleanup path.
- Link to v4: https://lore.kernel.org/r/20260116-feature_tilcdc-v4-0-2c1c22143087@bootlin.com

Changes in v4:
- Use device_get_match_data instead of of_match_node.
- Convert the driver to use DRM managed resources to avoid lifetime
  resources issue.
- Add a patch to convert to drm_device-based logging helpers.
- Replace drm_of_find_panel_or_bridge() with the newer
  devm_drm_of_get_bridge() helper.
- Link to v3: https://lore.kernel.org/r/20260106-feature_tilcdc-v3-0-9bad0f742164@bootlin.com

Changes in v3:
- Split patch 13 and patch 14 into two for better readability and git
  history clarity.
- Update patch 5 to use OF changeset and __free() macro. Made also few
  small improvements as requested by Luca.
- Rename binding file to ti,am33xx-tilcdc.yaml, use generic node name and
  drop unused label.
- Link to v2: https://lore.kernel.org/r/20251211-feature_tilcdc-v2-0-f48bac3cd33e@bootlin.com

Changes in v2:
- Remove patch 2 that add fifo-threshold property. Use FIFO threshold
  value from SoC id instead.
- Remove the part that breaks DTB compatibility.
- Add tilcdc_panel_legacy to modify the devicetree at boot time to properly
  bind the tilcdc driver with the standard panel-simple driver.
- Link to v1: https://lore.kernel.org/r/20251126-feature_tilcdc-v1-0-49b9ef2e3aa0@bootlin.com

Signed-off-by: Kory Maincent (TI.com) <kory.maincent@bootlin.com>
---
Kory Maincent (TI.com) (25):
      dt-bindings: display: tilcdc: Convert to DT schema
      dt-bindings: display: tilcdc: Mark panel binding as deprecated
      drm/tilcdc: Remove simulate_vesa_sync flag
      drm/tilcdc: Add support for DRM bus flags and simplify panel config
      drm/tilcdc: Convert legacy panel binding via DT overlay at boot time
      drm/tilcdc: Remove tilcdc panel driver
      drm/tilcdc: Remove component framework support
      drm/tilcdc: Remove tilcdc_panel_info structure
      drm/tilcdc: Remove redundant #endif/#ifdef in debugfs code
      drm/tilcdc: Remove unused encoder and connector tracking arrays
      drm/tilcdc: Rename external_encoder and external_connector to encoder and connector
      drm/tilcdc: Rename tilcdc_external to tilcdc_encoder
      drm/tilcdc: Remove the useless module list support
      drm/tilcdc: Use drm_module_platform_driver() helper
      drm/tilcdc: Move tilcdc_init/fini closer to probe/remove
      drm/tilcdc: Modernize driver initialization and cleanup paths
      drm/tilcdc: Remove the use of drm_device private_data
      drm/tilcdc: Convert to DRM managed resources
      drm/tilcdc: Convert to drm_device-based logging helpers
      drm/tilcdc: Use devm_drm_of_get_bridge() helper
      drm/bridge: tda998x: Remove component support
      drm/bridge: tda998x: Move tda998x_create/destroy into probe and remove
      drm/bridge: tda998x: Remove useless tda998x_connector_destroy wrapper
      drm/bridge: tda998x: Add support for DRM_BRIDGE_ATTACH_NO_CONNECTOR
      drm/tilcdc: Add support for DRM_BRIDGE_ATTACH_NO_CONNECTOR

 .../devicetree/bindings/display/tilcdc/panel.txt   |   1 +
 .../bindings/display/tilcdc/ti,am33xx-tilcdc.yaml  | 100 +++++
 .../devicetree/bindings/display/tilcdc/tilcdc.txt  |  82 ----
 drivers/gpu/drm/bridge/tda998x_drv.c               | 251 +++++------
 drivers/gpu/drm/tilcdc/Kconfig                     |  18 +
 drivers/gpu/drm/tilcdc/Makefile                    |   5 +-
 drivers/gpu/drm/tilcdc/tilcdc_crtc.c               | 192 +++-----
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                | 486 ++++++++-------------
 drivers/gpu/drm/tilcdc/tilcdc_drv.h                |  99 +----
 drivers/gpu/drm/tilcdc/tilcdc_encoder.c            |  69 +++
 .../tilcdc/{tilcdc_external.h => tilcdc_encoder.h} |   5 +-
 drivers/gpu/drm/tilcdc/tilcdc_external.c           | 179 --------
 drivers/gpu/drm/tilcdc/tilcdc_panel.c              | 408 -----------------
 drivers/gpu/drm/tilcdc/tilcdc_panel.h              |  15 -
 drivers/gpu/drm/tilcdc/tilcdc_panel_legacy.c       | 185 ++++++++
 drivers/gpu/drm/tilcdc/tilcdc_panel_legacy.dtso    |  29 ++
 drivers/gpu/drm/tilcdc/tilcdc_plane.c              |  37 +-
 drivers/gpu/drm/tilcdc/tilcdc_regs.h               |   8 +-
 18 files changed, 812 insertions(+), 1357 deletions(-)
---
base-commit: a3158f3710111bbd4bfba3bc0883449efde10a0b
change-id: 20251014-feature_tilcdc-79cd49e67bf9

Best regards,
--  
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

