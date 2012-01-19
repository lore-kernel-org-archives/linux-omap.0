From: Aneesh V <aneesh@ti.com>
Subject: [RFC v3 PATCH 0/3]  dt: device tree bindings and data for EMIF and DDR
Date: Thu, 19 Jan 2012 20:01:58 +0530
Message-ID: <1326983521-373-1-git-send-email-aneesh@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:52830 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751821Ab2ASOcL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Jan 2012 09:32:11 -0500
Received: by mail-yw0-f43.google.com with SMTP id n56so16316285yhn.30
        for <linux-omap@vger.kernel.org>; Thu, 19 Jan 2012 06:32:10 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Aneesh V <aneesh@ti.com>

This is an RFC to add new device tree bindings for DDR memories and
EMIF - TI's DDR SDRAM controller. 

The first patch adds bindings for LPDDR2 memories.

Second patch provides the bindings for the EMIF controller.

The final patch provides DT data for EMIF controller instances
in OMAP4 and LPDDR2 memories attached to them on various boards.

Thanks to Rajendra for answering my numerous queries on device tree.

Changes in RFC v3:
* Removed support for DDR3
* Incorporated review comments from Olof

Aneesh V (3):
  dt: device tree bindings for DDR memories
  dt: device tree bindings for TI's EMIF sdram controller
  arm/dts: EMIF and lpddr2 device tree data for OMAP4 boards

 .../devicetree/bindings/lpddr2/lpddr2-timings.txt  |   51 ++++++++++
 .../devicetree/bindings/lpddr2/lpddr2.txt          |  102 ++++++++++++++++++++
 .../bindings/memory-controllers/ti/emif.txt        |   49 ++++++++++
 arch/arm/boot/dts/elpida_ecb240abacn.dtsi          |   65 +++++++++++++
 arch/arm/boot/dts/omap4-panda.dts                  |   13 +++
 arch/arm/boot/dts/omap4-sdp.dts                    |   13 +++
 arch/arm/boot/dts/omap4.dtsi                       |   19 ++++
 7 files changed, 312 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/lpddr2/lpddr2-timings.txt
 create mode 100644 Documentation/devicetree/bindings/lpddr2/lpddr2.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
 create mode 100644 arch/arm/boot/dts/elpida_ecb240abacn.dtsi

