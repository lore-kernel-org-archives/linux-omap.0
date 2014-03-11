From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 0/3] ARM: dts: overo: Add graphics output
Date: Tue, 11 Mar 2014 13:34:14 +0100
Message-ID: <1394541257-25605-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:56974 "EHLO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755238AbaCKMe3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Mar 2014 08:34:29 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Ash Charles <ash@gumstix.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

This series enables the DVI / LCD graphics present on some of
the Overo expansion boards.

DVI output:
- Tobi
- Summit

LCD (3.5''):
- Alto35

LCD (4.3''):
- Chestnut43
- Palo43
- Gallop43

I tested on Tobi, Alto35 and Gallop43 using both OMAP35xx and OMAP36xx
Overo boards.

This series depends on Tomi's DSS patches [1] that are not yet merged.
It also depends on previous Overo series [2] and [3] that are under
review. A complete testing tree is available [4].

Regards,
Florian

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/295881
[2] http://thread.gmane.org/gmane.linux.ports.arm.omap/111558
[3] http://thread.gmane.org/gmane.linux.ports.arm.omap/111689
[4] https://github.com/vaussard/linux.git (overo/for-3.15/review1)

Florian Vaussard (3):
  ARM: dts: overo: Add support for DVI output
  ARM: dts: overo: Add support for 4.3'' LCD output
  ARM: dts: overo: Add support for 3.5'' LCD output

 arch/arm/boot/dts/omap3-overo-alto35-common.dtsi   |   1 +
 .../boot/dts/omap3-overo-chestnut43-common.dtsi    |   1 +
 arch/arm/boot/dts/omap3-overo-common-dvi.dtsi      | 109 +++++++++++++++
 arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi    | 145 ++++++++++++++++++++
 arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi    | 146 +++++++++++++++++++++
 arch/arm/boot/dts/omap3-overo-gallop43-common.dtsi |   1 +
 arch/arm/boot/dts/omap3-overo-palo43-common.dtsi   |   1 +
 arch/arm/boot/dts/omap3-overo-summit-common.dtsi   |   1 +
 arch/arm/boot/dts/omap3-overo-tobi-common.dtsi     |   1 +
 9 files changed, 406 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap3-overo-common-dvi.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi

-- 
1.8.3.2

