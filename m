From: Aneesh V <aneesh@ti.com>
Subject: [PATCH 0/4] dt: device tree support for TI EMIF driver
Date: Thu,  8 Mar 2012 22:03:53 +0530
Message-ID: <1331224437-4808-1-git-send-email-aneesh@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:37617 "HELO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753603Ab2CHQeH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 11:34:07 -0500
Received: by mail-gy0-f177.google.com with SMTP id f11so419712ghb.22
        for <linux-omap@vger.kernel.org>; Thu, 08 Mar 2012 08:34:05 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Aneesh V <aneesh@ti.com>

This series adds device tree support for TI EMIF SDRAM controller
driver. For this, a binding has been added for representing AC timing
parameters and other details of LPDDR2 memories.

This series depends my series for adding EMIF driver [1]

[1] http://marc.info/?l=linux-omap&m=133122243430942&w=2

Aneesh V (4):
  dt: device tree bindings for LPDDR2 memories
  dt: emif: device tree bindings for TI's EMIF sdram controller
  arm: dts: EMIF and LPDDR2 device tree data for OMAP4 boards
  misc: emif: add device tree support to emif driver

 .../devicetree/bindings/lpddr2/lpddr2-timings.txt  |   52 ++++
 .../devicetree/bindings/lpddr2/lpddr2.txt          |  102 +++++++
 .../bindings/memory-controllers/ti/emif.txt        |   55 ++++
 arch/arm/boot/dts/elpida_ecb240abacn.dtsi          |   67 +++++
 arch/arm/boot/dts/omap4-panda.dts                  |   13 +
 arch/arm/boot/dts/omap4-sdp.dts                    |   13 +
 arch/arm/boot/dts/omap4.dtsi                       |   18 ++
 drivers/misc/emif.c                                |  289 +++++++++++++++++++-
 8 files changed, 608 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/lpddr2/lpddr2-timings.txt
 create mode 100644 Documentation/devicetree/bindings/lpddr2/lpddr2.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
 create mode 100644 arch/arm/boot/dts/elpida_ecb240abacn.dtsi

