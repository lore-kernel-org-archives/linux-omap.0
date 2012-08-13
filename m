From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 0/5] ARM: OMAP: Few device tree patches for 3.7
Date: Mon, 13 Aug 2012 16:30:18 +0530
Message-ID: <1344855623-14879-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56217 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751463Ab2HMLAc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Aug 2012 07:00:32 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.or, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

These are the few device tree related patches which has been posted and
reviewed on the list. They are intended for 3.7 merge window but I am
posting them early enough to get into linux-next and linux-omap for testing. 

The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:

  Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)

are available in the git repository at:

  git://github.com/SantoshShilimkar/linux.git for_3.7/omap_dt

for you to fetch changes up to bedee5fcb18062dfc933e0971e67fd6889c6446d:

  ARM: OMAP4: Add local timer support for Device Tree (2012-08-13 11:59:26 +0530)

----------------------------------------------------------------
Aneesh V (3):
      dt: device tree bindings for LPDDR2 memories
      dt: emif: device tree bindings for TI's EMIF sdram controller
      ARM: dts: EMIF and LPDDR2 device tree data for OMAP4 boards

Santosh Shilimkar (2):
      ARM: OMAP4: Add L2 Cache Controller in Device Tree
      ARM: OMAP4: Add local timer support for Device Tree

 .../devicetree/bindings/lpddr2/lpddr2-timings.txt  |   52 ++++++++++
 .../devicetree/bindings/lpddr2/lpddr2.txt          |  102 ++++++++++++++++++++
 .../bindings/memory-controllers/ti/emif.txt        |   55 +++++++++++
 arch/arm/boot/dts/elpida_ecb240abacn.dtsi          |   67 +++++++++++++
 arch/arm/boot/dts/omap4-panda.dts                  |   13 +++
 arch/arm/boot/dts/omap4-sdp.dts                    |   13 +++
 arch/arm/boot/dts/omap4.dtsi                       |   31 ++++++
 arch/arm/mach-omap2/omap4-common.c                 |    6 +-
 arch/arm/mach-omap2/timer.c                        |    6 ++
 9 files changed, 344 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/lpddr2/lpddr2-timings.txt
 create mode 100644 Documentation/devicetree/bindings/lpddr2/lpddr2.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
 create mode 100644 arch/arm/boot/dts/elpida_ecb240abacn.dtsi

Aneesh V (3):
  dt: device tree bindings for LPDDR2 memories
  dt: emif: device tree bindings for TI's EMIF sdram controller
  ARM: dts: EMIF and LPDDR2 device tree data for OMAP4 boards

Santosh Shilimkar (2):
  ARM: OMAP4: Add L2 Cache Controller in Device Tree
  ARM: OMAP4: Add local timer support for Device Tree

 .../devicetree/bindings/lpddr2/lpddr2-timings.txt  |   52 ++++++++++
 .../devicetree/bindings/lpddr2/lpddr2.txt          |  102 ++++++++++++++++++++
 .../bindings/memory-controllers/ti/emif.txt        |   55 +++++++++++
 arch/arm/boot/dts/elpida_ecb240abacn.dtsi          |   67 +++++++++++++
 arch/arm/boot/dts/omap4-panda.dts                  |   13 +++
 arch/arm/boot/dts/omap4-sdp.dts                    |   13 +++
 arch/arm/boot/dts/omap4.dtsi                       |   31 ++++++
 arch/arm/mach-omap2/omap4-common.c                 |    6 +-
 arch/arm/mach-omap2/timer.c                        |    6 ++
 9 files changed, 344 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/lpddr2/lpddr2-timings.txt
 create mode 100644 Documentation/devicetree/bindings/lpddr2/lpddr2.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ti/emif.txt
 create mode 100644 arch/arm/boot/dts/elpida_ecb240abacn.dtsi

-- 
1.7.9.5

