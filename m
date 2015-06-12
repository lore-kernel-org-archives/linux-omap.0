From: Ash Charles <ashcharles@gmail.com>
Subject: [PATCH 0/5] Device Tree Fixes for Overo
Date: Fri, 12 Jun 2015 13:37:21 -0700
Message-ID: <1434141446-11568-1-git-send-email-ashcharles@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33299 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbbFLUh2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Jun 2015 16:37:28 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, devicetree@vger.kernel.org
Cc: tony@atomide.com, bcousson@baylibre.com

This series updates the device trees for Gumstix Overo COMs with some
minor fixes and support for NAND, the TobiDuo expansion baords, and the
Palo35 board.

Adam YH Lee (3):
  omap3: overo: Update LCD panel names
  omap3: overo: Enable McBSP2 for all Overo COMs
  omap3: overo: Add device tree for Palo35 board

Ash Charles (2):
  omap3: dts: Add DTS for Gumstix TobiDuo expansion board
  omap3: overo: Support PoP NAND

 arch/arm/boot/dts/Makefile                        |  4 ++
 arch/arm/boot/dts/omap3-overo-base.dtsi           | 55 +++++++++++++++++++
 arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi   |  5 +-
 arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi   |  2 +-
 arch/arm/boot/dts/omap3-overo-palo35-common.dtsi  | 54 +++++++++++++++++++
 arch/arm/boot/dts/omap3-overo-palo35.dts          | 38 +++++++++++++
 arch/arm/boot/dts/omap3-overo-storm-palo35.dts    | 38 +++++++++++++
 arch/arm/boot/dts/omap3-overo-storm-tobiduo.dts   | 22 ++++++++
 arch/arm/boot/dts/omap3-overo-tobiduo-common.dtsi | 66 +++++++++++++++++++++++
 arch/arm/boot/dts/omap3-overo-tobiduo.dts         | 22 ++++++++
 arch/arm/boot/dts/omap3-overo.dtsi                |  4 --
 11 files changed, 303 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/boot/dts/omap3-overo-palo35-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-overo-palo35.dts
 create mode 100644 arch/arm/boot/dts/omap3-overo-storm-palo35.dts
 create mode 100644 arch/arm/boot/dts/omap3-overo-storm-tobiduo.dts
 create mode 100644 arch/arm/boot/dts/omap3-overo-tobiduo-common.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-overo-tobiduo.dts

-- 
2.1.4

