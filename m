From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 0/3] ARM: dts: Fixes for Overo/Tobi against 3.14-rc1
Date: Thu,  6 Feb 2014 10:10:15 +0100
Message-ID: <1391677818-21154-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:51834 "EHLO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932244AbaBFJKl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Feb 2014 04:10:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: Tero Kristo <t-kristo@ti.com>, Kevin Hilman <khilman@linaro.org>, Mike Turquette <mturquette@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

OMAP36xx-based Overo (Storm and alike) are now failing to boot with 3.14-rc1 [1].
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

[1] http://thread.gmane.org/gmane.linux.ports.arm.omap/110006


Florian Vaussard (3):
  ARM: dts: omap3-tobi: Fix boot with OMAP36xx-based Overo
  ARM: dts: omap3-tobi: Use the correct vendor prefix
  ARM: dts: Add support for both OMAP35xx and OMAP36xx Overo/Tobi

 arch/arm/boot/dts/Makefile                         |  3 ++-
 arch/arm/boot/dts/omap3-overo-storm-tobi.dts       | 22 ++++++++++++++++++++++
 ...omap3-tobi.dts => omap3-overo-tobi-common.dtsi} |  3 ---
 arch/arm/boot/dts/omap3-overo-tobi.dts             | 22 ++++++++++++++++++++++
 arch/arm/boot/dts/omap3-overo.dtsi                 |  3 ---
 5 files changed, 46 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-overo-storm-tobi.dts
 rename arch/arm/boot/dts/{omap3-tobi.dts => omap3-overo-tobi-common.dtsi} (94%)
 create mode 100644 arch/arm/boot/dts/omap3-overo-tobi.dts

-- 
1.8.1.2

