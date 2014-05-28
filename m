From: Archit Taneja <archit@ti.com>
Subject: [RFC v2 0/6] ARM: dts: Add a new clk provider, and implement dss_deshdcp clock with it
Date: Wed, 28 May 2014 16:20:49 +0530
Message-ID: <1401274255-16845-1-git-send-email-archit@ti.com>
References: <1397654063-8055-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53577 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751441AbaE1KwU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 May 2014 06:52:20 -0400
In-Reply-To: <1397654063-8055-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, t-kristo@ti.com, rnayak@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

This series tries to create CONTROL_MODULE_CORE as a new clock provider, and
create a clock using it required by DSS on DRA7.

The previous revision of the series added the new clock provider within prcm
driver code itself. Suggestions were made by Paul and Tero to move it to control
module driver code.

I picked up 2 patches from Tero's WIP branch below, and added DRA7's control
module core block as a clock provider. The DSS_DESHDCP clock is easy to
implement after that.

https://github.com/t-kristo/linux-pm/tree/3.14-rc4-cm-prm-driver-wip 

Archit Taneja (5):
  ARM: PRCM: split PRCM module init to their own driver files
  ARM: OMAP2+: Add CONTROL_MODULE_CORE as a clock provider for DRA7x
  ARM: dts: Add ctrl-core DT node for DRA7
  ARM: dts: Add dss_deshdcp clock node under dra7-ctrl-core
  CLK: TI: Enable dss_deshdcp clock in dra7xx_clk_init

Tero Kristo (1):
  CLK: TI: clockdomain: add support for retrying init

 arch/arm/boot/dts/dra7.dtsi          | 13 ++++++
 arch/arm/boot/dts/dra7xx-clocks.dtsi | 10 +++++
 arch/arm/mach-omap2/cm_common.c      | 18 +++++++++
 arch/arm/mach-omap2/control.c        | 35 ++++++++++++++++
 arch/arm/mach-omap2/control.h        |  1 +
 arch/arm/mach-omap2/io.c             |  4 ++
 arch/arm/mach-omap2/prcm-common.h    |  5 +++
 arch/arm/mach-omap2/prm_common.c     | 55 +++++++++++++++-----------
 drivers/clk/ti/clk-7xx.c             |  8 +++-
 drivers/clk/ti/clockdomain.c         | 77 ++++++++++++++++++++++++++++++------
 include/linux/clk/ti.h               |  2 +-
 11 files changed, 192 insertions(+), 36 deletions(-)

-- 
1.8.3.2

