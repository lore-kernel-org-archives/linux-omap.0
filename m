From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH 0/8] Adding TI TPS PMICs support in the regulator framework
Date: Fri,  7 Aug 2009 20:55:16 +0530
Message-ID: <1249658716-10726-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51078 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751510AbZHGPZi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Aug 2009 11:25:38 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: broonie@sirena.org.uk, lrg@slimlogic.co.uk, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Anuj Aggarwal <anuj.aggarwal@ti.com>

This patch set adds support for TI TPS65023 and TPS6507x PMICs in the voltage
regulator framework. It also creates a common board-omap35x-pmic.c file which
has the board related information for the TPS devices for the OMAP35x platforms.

The patches also take care of the comments received earlier when only TPS65023
regulator driver was submitted.

The earlier discussions can be found at:

 [1] Add pmic.c file to regulator framework
     http://marc.info/?l=linux-omap&m=124265188617999&w=2

 [2] Add TPS65023 Regulator Driver
     http://marc.info/?l=linux-omap&m=124181108318242&w=2

 [3] Added board-dependent code for TPS65023
     http://marc.info/?l=linux-omap&m=124264951114318&w=2

Anuj Aggarwal (8):
  Regulator: Add TPS65023 regulator driver
  Regulator: Adding header file for TPS65023
  Regulator: Add TPS6507x regulator driver
  Regulator: Adding header file for TI TPS6507x regulator driver
  Regulator: Adding TPS65023 and TPS6507x in Kconfig and Makefile
  Regulator: Add board-omap35x-pmic.c to arch/arm/mach-omap2/
  Regulator: Added board-dependent code for TPS65023
  Regulator: Added board-dependent code for TPS65073

 arch/arm/mach-omap2/board-omap35x-pmic.c |  305 ++++++++++++++++
 drivers/regulator/Kconfig                |   16 +
 drivers/regulator/Makefile               |    2 +
 drivers/regulator/tps65023-regulator.c   |  496 ++++++++++++++++++++++++++
 drivers/regulator/tps6507x-regulator.c   |  563 ++++++++++++++++++++++++++++++
 include/linux/mfd/tps6507x.h             |   93 +++++
 include/linux/regulator/tps65023.h       |   74 ++++
 7 files changed, 1549 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-omap35x-pmic.c
 create mode 100644 drivers/regulator/tps65023-regulator.c
 create mode 100644 drivers/regulator/tps6507x-regulator.c
 create mode 100644 include/linux/mfd/tps6507x.h
 create mode 100644 include/linux/regulator/tps65023.h

