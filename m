From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/4] OMAPDSS: sharp-ls037v7dw01 DT support
Date: Fri, 16 May 2014 10:29:58 +0300
Message-ID: <1400225402-18274-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34584 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751956AbaEPHaz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 May 2014 03:30:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

These are slightly reworked versions of the patches Tony sent:

* Split the DT doc into separate patch
* Handle errors from gpio functions
* Remove QVGA support
* Removed the change to arch/arm/mach-omap2/display.c. I'll add that to my
  patch which moves the conversion code to omapdss. Note that if you test this
  version, you need to add the panel name to the conversion list for now.
* Set MO gpio GPIO_ACTIVE_HIGH in omap3-evm-common.dtsi
* Set the GPIO default values the same way for DT and non-DT versions.

Tony, I removed the QVGA support as it was a new feature, not supported by the
non-DT version. Also, I don't think it should be done as you had implemented
it, but rather either have a flag in the DT data in case the pin is hardwired
in the hardware, or let the user select the mode at runtime.

Also, I didn't quite understand the implementation. You had set initial values
in the driver for MO and RESB differently than on the non-DT version. Was that
on purpose?

You said in a comment: "The LCD is sideways, so we want the VGA mode instead of
QVGA mode.". Why is that? How does the resolution affect the orientation?

With my version, the panel (should) always be in VGA mode, like the non-DT
version does.

Only compile tested, I don't have boards with the panel.

 Tomi

Tony Lindgren (4):
  OMAPDSS: panel-sharp-ls037v7dw01: update to use gpiod
  OMAPDSS: panel sharp-ls037v7dw01 DT support
  Doc/DT: Add DT binding documentation for SHARP LS037V7DW01
  ARM: dts: Add LCD panel sharp ls037v7dw01 support for omap3-evm and
    ldp

 .../bindings/video/sharp,ls037v7dw01.txt           |  43 +++++
 arch/arm/boot/dts/omap3-evm-37xx.dts               |  50 +++++
 arch/arm/boot/dts/omap3-evm-common.dtsi            |  26 +++
 arch/arm/boot/dts/omap3-ldp.dts                    |  29 ++-
 .../boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi    |  67 +++++++
 .../omap2/displays-new/panel-sharp-ls037v7dw01.c   | 210 +++++++++++++++------
 6 files changed, 363 insertions(+), 62 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/video/sharp,ls037v7dw01.txt
 create mode 100644 arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi

-- 
1.9.1

