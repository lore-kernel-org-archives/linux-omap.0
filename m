From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH RFC 0/3] Make "ti,tilcdc,slave" DT binding more sensible
Date: Tue, 13 Jan 2015 19:12:25 +0200
Message-ID: <cover.1421167634.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45414 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753126AbbAMRMk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Jan 2015 12:12:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com
Cc: tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

These patches are needed for Beaglebone-back HDMI audio. There is no
direct dependency between these patches and the other (dts and ASoC)
changes needed for the HDMI audio so these changes can be merged
independently. I also feel that these changes make sense even without
the HDMI audio.

Best regards,
Jyri

Jyri Sarha (3):
  drm: encoder_slave: Add drm_i2c_encoder_attach()
  drm/tilcdc: slave: Add support for "i2c-slave" DT-parameter
  ARM: dts: am335x-boneblack: Use new binding in ti,tilcdc,slave node

 .../devicetree/bindings/drm/tilcdc/slave.txt       |    4 +-
 arch/arm/boot/dts/am335x-boneblack.dts             |    9 +++-
 drivers/gpu/drm/drm_encoder_slave.c                |   51 ++++++++++++++++++++
 drivers/gpu/drm/tilcdc/tilcdc_slave.c              |   50 +++++++++++--------
 include/drm/drm_encoder_slave.h                    |    3 ++
 5 files changed, 95 insertions(+), 22 deletions(-)

-- 
1.7.9.5

