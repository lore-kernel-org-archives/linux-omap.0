From: Sebastian Reichel <sre@debian.org>
Subject: [PATCH 0/5] N900 DT support for N900 panel
Date: Sat, 23 Nov 2013 21:57:19 +0100
Message-ID: <1385240244-28629-1-git-send-email-sre@debian.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:56832 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755806Ab3KWU6G (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 23 Nov 2013 15:58:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@ring0.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Sebastian Reichel <sre@debian.org>

Hi,

This patchset adds DT support for the N900 panel. The panel bindings will be
extended once omapdss has DT support. Until then the panel driver defaults to
omapdss.sdi0 in DT mode.

-- Sebastian

Sebastian Reichel (5):
  OMAPDSS: ACX565AKM: Add basic DT support
  DTS: ARM: OMAP3-N900: Add vendor prefixes to SPI devices
  DTS: ARM: OMAP3-N900: Add reset gpio to lcd node
  OMAPDSS: SDI: Use V28 as regulator for N900
  Documentation: dt: Document ACX565AKM DT binding

 .../devicetree/bindings/video/sony,acx565akm.txt   | 22 ++++++++++++++++
 arch/arm/boot/dts/omap3-n900.dts                   |  7 ++++--
 .../omap2/displays-new/panel-sony-acx565akm.c      | 29 ++++++++++++++++++++++
 drivers/video/omap2/dss/sdi.c                      |  8 +++++-
 4 files changed, 63 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/sony,acx565akm.txt

-- 
1.8.4.3

