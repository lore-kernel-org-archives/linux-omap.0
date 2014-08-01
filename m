From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap gta04 dts changes for v3.17 merge window
Date: Fri, 1 Aug 2014 04:16:29 -0700
Message-ID: <20140801111628.GC26699@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:57844 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751008AbaHALR4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Aug 2014 07:17:56 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 3c9464ed75d6c15ee864da6d8f6a4cd3b0f2c934:

  ARM: DTS: omap5-uevm: Enable basic audio (McPDM <-> twl6040) (2014-07-15 00:21:25 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.17/dt-gta04

for you to fetch changes up to c9940680b599300c3fb46e799986b736d394432d:

  ARM: dts: Add gta04a5 model (2014-07-29 23:51:04 -0700)

----------------------------------------------------------------
GTA04 related changes for v3.17 merge window. Except for the last
three patches they were ready to go earlier but I wanted to wait
for the discussion to to settle on the last three patches as these
are all related to GTA04.

If these are too late for v3.17 I can send the pull request again
for these after v3.17-rc1.

----------------------------------------------------------------
Marek Belisko (10):
      ARM: dts: omap3-gta04: Add nand support
      ARM: dts: omap3-gta04: Fix magnetometer model
      ARM: dts: omap3-gta04: Add wifi reset node
      ARM: dts: omap3-gta04: Move spi gpio pins to pmx_core2
      ARM: dts: omap3-gta04: Add USB host support
      ARM: dts: omap3-gta04: Add display alias
      ARM: dts: omap3-gta04: Add twl4030 regulators parameters
      ARM: dts: omap3-gta04: Rename gta04.dts to gta04.dtsi and add a4 model
      ARM: dts: Add gta04a3 model
      ARM: dts: Add gta04a5 model

 arch/arm/boot/dts/Makefile                         |   4 +-
 .../boot/dts/{omap3-gta04.dts => omap3-gta04.dtsi} | 150 ++++++++++++++++++++-
 arch/arm/boot/dts/omap3-gta04a3.dts                |  48 +++++++
 arch/arm/boot/dts/omap3-gta04a4.dts                |  13 ++
 arch/arm/boot/dts/omap3-gta04a5.dts                |  17 +++
 5 files changed, 226 insertions(+), 6 deletions(-)
 rename arch/arm/boot/dts/{omap3-gta04.dts => omap3-gta04.dtsi} (67%)
 create mode 100644 arch/arm/boot/dts/omap3-gta04a3.dts
 create mode 100644 arch/arm/boot/dts/omap3-gta04a4.dts
 create mode 100644 arch/arm/boot/dts/omap3-gta04a5.dts
