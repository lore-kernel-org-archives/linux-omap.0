From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH v3 0/3] ARM: dts: overo: Add panel support
Date: Tue, 20 May 2014 15:58:54 +0200
Message-ID: <1400594337-5096-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:44466 "EHLO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753868AbaETN7L (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 May 2014 09:59:11 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Hi,

This series enables the DVI and LCD panels present on some of
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

I tested on Tobi, Alto35 and Gallop43.

This series depends on several patches from Tomi [1][2][3] targeting 3.16.

Regards,
Florian

Since v2:
- Use gpio-backlight
Since v1:
- Rebased on 3.15-rc4 + recent patches from Tomi

[1] http://thread.gmane.org/gmane.linux.ports.arm.omap/114572
[2] http://thread.gmane.org/gmane.linux.ports.arm.omap/114560
[3] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-January/227101.html

Florian Vaussard (3):
  ARM: dts: overo: Add support for DVI output
  ARM: dts: overo: Add support for 4.3'' LCD output
  ARM: dts: overo: Add support for 3.5'' LCD output

 arch/arm/boot/dts/omap3-overo-alto35-common.dtsi   |   1 +
 .../boot/dts/omap3-overo-chestnut43-common.dtsi    |   1 +
 arch/arm/boot/dts/omap3-overo-common-dvi.dtsi      | 111 +++++++++++++
 arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi    | 165 +++++++++++++++++++
 arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi    | 178 +++++++++++++++++++++
 arch/arm/boot/dts/omap3-overo-gallop43-common.dtsi |   1 +
 arch/arm/boot/dts/omap3-overo-palo43-common.dtsi   |   1 +
 arch/arm/boot/dts/omap3-overo-summit-common.dtsi   |   1 +
 arch/arm/boot/dts/omap3-overo-tobi-common.dtsi     |   1 +
 9 files changed, 460 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap3-overo-common-dvi.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi

-- 
1.8.3.2

