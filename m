From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/4] SiI9022 HDMI encoder for AM4xxx boards
Date: Thu, 3 Jul 2014 16:39:56 +0300
Message-ID: <1404394800-18138-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38625 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751937AbaGCNkg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jul 2014 09:40:36 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

This series adds a driver for SiI9022 HDMI encoder, which is used on AM437x GP
and AM43x EPOS boards.

The series is based on the OMAPDSS HDMI infoframe series sent earlier, as the
SiI9022 driver uses the new infoframe support.

 Tomi

Tomi Valkeinen (4):
  OMAPDSS: add SiI9022 encoder driver
  Doc/DT: Add SiI9022 binding documentation
  arm/dts: am43x EPOS HDMI support
  arm/dts: am437x GP HDMI support

 .../devicetree/bindings/video/sil,sii9022.txt      |  53 ++
 arch/arm/boot/dts/Makefile                         |   4 +-
 arch/arm/boot/dts/am437x-gp-evm-hdmi.dts           |  70 ++
 arch/arm/boot/dts/am43x-epos-evm-hdmi.dts          |  83 ++
 drivers/video/fbdev/omap2/displays-new/Kconfig     |   8 +
 drivers/video/fbdev/omap2/displays-new/Makefile    |   1 +
 .../fbdev/omap2/displays-new/encoder-sii9022.c     | 966 +++++++++++++++++++++
 .../fbdev/omap2/displays-new/encoder-sii9022.h     |  58 ++
 8 files changed, 1242 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/video/sil,sii9022.txt
 create mode 100644 arch/arm/boot/dts/am437x-gp-evm-hdmi.dts
 create mode 100644 arch/arm/boot/dts/am43x-epos-evm-hdmi.dts
 create mode 100644 drivers/video/fbdev/omap2/displays-new/encoder-sii9022.c
 create mode 100644 drivers/video/fbdev/omap2/displays-new/encoder-sii9022.h

-- 
1.9.1

