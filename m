From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/5] Enable pinctrl-single for omap2/3/4
Date: Thu, 06 Sep 2012 11:58:18 -0700
Message-ID: <20120906185615.1172.23588.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:58907 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759449Ab2IFS6V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 14:58:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Now that pinctrl-single driver is merged, this series enables
pinctrl for omap2/3/4.

Regards,

Tony

---

AnilKumar Ch (1):
      ARM: OMAP2+: select PINCTRL in Kconfig

Tony Lindgren (4):
      arm/dts: Add omap36xx.dtsi file and rename omap3-beagle to omap3-beagle-xm
      arm/dts: Add pinctrl driver entries for omap2/3/4
      arm/dts: Mux uart pins for omap4-sdp
      omap-serial: Request pins using pinctrl framework


 arch/arm/boot/dts/omap2420-h4.dts             |    2 +
 arch/arm/boot/dts/omap2420.dtsi               |   22 +++++++++++++
 arch/arm/boot/dts/omap2430.dtsi               |   22 +++++++++++++
 arch/arm/boot/dts/omap3-beagle-xm.dts         |    6 ++--
 arch/arm/boot/dts/omap3.dtsi                  |   25 +++++++++++----
 arch/arm/boot/dts/omap36xx.dtsi               |   25 +++++++++++++++
 arch/arm/boot/dts/omap4-sdp.dts               |   42 +++++++++++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi                  |   17 ++++++++++
 arch/arm/configs/omap2plus_defconfig          |    1 +
 arch/arm/mach-omap2/Kconfig                   |    1 +
 arch/arm/mach-omap2/Makefile.boot             |    2 +
 arch/arm/plat-omap/include/plat/omap-serial.h |    1 +
 drivers/tty/serial/omap-serial.c              |   10 ++++++
 13 files changed, 164 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap2420.dtsi
 create mode 100644 arch/arm/boot/dts/omap2430.dtsi
 rename arch/arm/boot/dts/{omap3-beagle.dts => omap3-beagle-xm.dts} (89%)
 create mode 100644 arch/arm/boot/dts/omap36xx.dtsi

-- 
Signature
