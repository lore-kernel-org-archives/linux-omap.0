From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 0/2] ARM: dts: OMAP4: Add support for DuoVero/Parlor
Date: Mon, 24 Feb 2014 18:07:47 +0100
Message-ID: <1393261669-32039-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:49266 "EHLO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752362AbaBXRIG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Feb 2014 12:08:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Ash Charles <ash@gumstix.com>, Florian Vaussard <florian.vaussard@epfl.ch>

Hi Benoit, Tony,

Here is a device tree to support the OMAP4430-based Gumstix DuoVero
with the Parlor expansion boards. All peripherals should be working
with current 3.14-rc4, except:

- GPMC ethernet (needs patches [1])
- TWL6040 init may fail (will send a bug report to ML)
- The HDMI output depends on Tomi's DSS series [2] (not yet merged)

I split the HDMI part into a second patch, so it can be merged with the DSS
series, even if the nodes could be merged independently.

Regards,
Florian

[1] http://thread.gmane.org/gmane.linux.ports.arm.omap/110662
[2] http://thread.gmane.org/gmane.linux.ports.arm.kernel/295881


Florian Vaussard (2):
  ARM: dts: Add support for OMAP4 Gumstix DuoVero/Parlor
  ARM: dts: duovero-parlor: Add HDMI output

 .../devicetree/bindings/arm/omap/omap.txt          |   3 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/omap4-duovero-parlor.dts         | 182 +++++++++++++++
 arch/arm/boot/dts/omap4-duovero.dtsi               | 252 +++++++++++++++++++++
 4 files changed, 438 insertions(+)
 create mode 100644 arch/arm/boot/dts/omap4-duovero-parlor.dts
 create mode 100644 arch/arm/boot/dts/omap4-duovero.dtsi

-- 
1.8.1.2

