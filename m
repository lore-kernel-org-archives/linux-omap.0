From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 0/5] OMAP: Add DT bindings to specify when devices should not be idled or reset
Date: Wed, 9 Oct 2013 15:41:56 +0530
Message-ID: <1381313521-10422-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55385 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752719Ab3JIKMc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Oct 2013 06:12:32 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, paul@pwsan.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>

Changes in v2:
* Patches are split in such a way that DT and hwmod changes are kept in
seperate patches so they can be pulled in by Benoit and Paul seperately.
* Binding names are slightly updated to address the concern from Tony and Benoit [1]
* Added a patch [5/5] to prevent GPIO reset on AM335x EVM-SK board, which
was also the original motivation of this series since the board fails to
boot from mainline despite support for AM335x and a am335x-evmsk.dts file
existing in mainline for quite a while.

We have devices like co-processors, SoC internal busses, memory controllers
etc which should not be idled or reset. In some cases erratas around IP blocks
prevent them from either being idled or reset. Have a way to pass this
information from Device tree, and get rid of similar information that
exists as part of the omap_hwmod data files for various DT only OMAP SoCs.

Boot tested on OMAP4 panda es, AM335x EVM and AM335x EVM-SK

[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg94349.html

Rajendra Nayak (5):
  ARM: OMAP2+: hwmod: cleanup HWMOD_INIT_NO_RESET usage
  ARM: dts: omap: Add new bindings for OMAP
  ARM: OMAP2+: hwmod: Extract no-idle and no-reset info from DT
  ARM: OMAP2+: hwmod: Cleanup usage of HWMOD_INIT_NO_RESET and
    HWMOD_INIT_NO_IDLE
  ARM: dts: AM335x-evmsk: Do not reset gpio0

 .../devicetree/bindings/arm/omap/omap.txt          |    3 ++-
 arch/arm/boot/dts/am335x-evmsk.dts                 |    4 ++++
 arch/arm/boot/dts/am33xx.dtsi                      |    2 ++
 arch/arm/boot/dts/omap4.dtsi                       |    3 +++
 arch/arm/boot/dts/omap5.dtsi                       |    2 ++
 arch/arm/mach-omap2/omap_hwmod.c                   |   23 ++++++++++++++------
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |   22 +++++++++----------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |    6 ++---
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c         |    4 +---
 9 files changed, 43 insertions(+), 26 deletions(-)

-- 
1.7.9.5

