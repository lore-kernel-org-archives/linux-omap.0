From: Aneesh V <aneesh@ti.com>
Subject: [RFC v4 PATCH 0/4] dt: device tree support for TI EMIF driver
Date: Sat,  4 Feb 2012 18:12:05 +0530
Message-ID: <1328359329-685-1-git-send-email-aneesh@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:35746 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752828Ab2BDMmS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Feb 2012 07:42:18 -0500
Received: by mail-tul01m020-f173.google.com with SMTP id up16so7230261obb.18
        for <linux-omap@vger.kernel.org>; Sat, 04 Feb 2012 04:42:18 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Aneesh V <aneesh@ti.com>

This series adds device tree support for TI EMIF SDRAM controller
driver. For this, a binding has been added for representing AC timing
parameters and other details of LPDDR2 memories.

This series depends on the series for adding EMIF driver [1]

Changes in RFC v3:
* Removed support for DDR3
* Incorporated review comments from Olof

Changes from RFC v3 to RFC v4:
* Added a new patch to add DT support in the EMIF driver

[1] http://marc.info/?l=linux-omap&m=132835811606125&w=2

Aneesh V (4):
  dt: device tree bindings for LPDDR2 memories
  dt: emif: device tree bindings for TI's EMIF sdram controller
  arm: dts: EMIF and LPDDR2 device tree data for OMAP4 boards
  misc: emif: add device tree support to emif driver

 .../devicetree/bindings/lpddr2/lpddr2-timings.txt  |   54 ++++
 .../devicetree/bindings/lpddr2/lpddr2.txt          |  102 +++++++
 .../bindings/memory-controllers/ti/emif.txt        |   55 ++++
 arch/arm/boot/dts/elpida_ecb240abacn.dtsi          |   71 +++++
 arch/arm/boot/dts/omap4-panda.dts                  |   13 +
 arch/arm/boot/dts/omap4-sdp.dts                    |   13 +
 arch/arm/boot/dts/omap4.dtsi                       |   18 ++
 drivers/misc/emif.c                                |  281 +++++++++++++++++++-
 8 files changed, 606 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/lpddr2/lpddr2-timings.txt
 create mode 100644 Documentation/devicetree/bindings/lpddr2/lpddr2.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
 create mode 100644 arch/arm/boot/dts/elpida_ecb240abacn.dtsi

