From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH v2 0/4] ARM: dts: Fixes for Overo/Tobi against 3.14-rc2
Date: Thu, 13 Feb 2014 11:25:12 +0100
Message-ID: <1392287116-4548-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:46914 "EHLO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751440AbaBMKZe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Feb 2014 05:25:34 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Kevin Hilman <khilman@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

OMAP36xx-based Overo (Storm and alike) are now failing to boot with 3.14-rc2 [1].
This series fixes this, by moving model-agnostic DT into a common dtsi file,
and creating model-specific DT files:

- omap3-overo-tobi.dts -> older OMAP35xx Overo
- omap3-overo-storm-tobi.dts -> newer OMAP36xx/AM37xx/DM37xx Overo

People will have to use the right Overo / expansion board combination.

(Patch 2 in an unrelated fix that was waiting in my queue.)

omap3-overo-tobi.dts tested with Overo Sand (OMAP3503) and omap3-overo-storm-tobi.dts
tested with Overo EarthStorm (AM3703). Both boot. With the Overo Sand, I cannot
mount the ext3 rootfs, but this seems unrelated to the current topic, maybe
a missing errata.

Regards,
Florian

Changes since v1:
- Add "ti,omap3430" as a compatible string for OMAP35xx-based Overo
- Update the DT documentation to silence out checkpatch warnings (patch 4)

[1] http://thread.gmane.org/gmane.linux.ports.arm.omap/110006

Florian Vaussard (4):
  ARM: dts: omap3-tobi: Fix boot with OMAP36xx-based Overo
  ARM: dts: omap3-tobi: Use the correct vendor prefix
  ARM: dts: Add support for both OMAP35xx and OMAP36xx Overo/Tobi
  Documentation: dt: OMAP: Update Overo/Tobi

 .../devicetree/bindings/arm/omap/omap.txt          |  2 +-
 arch/arm/boot/dts/Makefile                         |  3 ++-
 arch/arm/boot/dts/omap3-overo-storm-tobi.dts       | 22 ++++++++++++++++++++++
 ...omap3-tobi.dts => omap3-overo-tobi-common.dtsi} |  3 ---
 arch/arm/boot/dts/omap3-overo-tobi.dts             | 22 ++++++++++++++++++++++
 arch/arm/boot/dts/omap3-overo.dtsi                 |  3 ---
 6 files changed, 47 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-overo-storm-tobi.dts
 rename arch/arm/boot/dts/{omap3-tobi.dts => omap3-overo-tobi-common.dtsi} (94%)
 create mode 100644 arch/arm/boot/dts/omap3-overo-tobi.dts

-- 
1.8.1.2

