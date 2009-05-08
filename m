From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH 0/3] Support multiple PMICs in Voltage Regulator Framework
Date: Fri,  8 May 2009 20:41:13 +0530
Message-ID: <1241795473-15610-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34445 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759886AbZEHPLV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 May 2009 11:11:21 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n48FBFgs015005
	for <linux-omap@vger.kernel.org>; Fri, 8 May 2009 10:11:21 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Anuj Aggarwal <anuj.aggarwal@ti.com>

Based on the discussion we had at:

http://marc.info/?l=linux-omap&m=124083364321017&w=2

I am sending the following patches which allows one to move the board-dependent
regulator-specific code to a newly created file drivers\regulator\pmic.c. This
file will have the board specific information for different regulators and
it will do the regulator initialization depending on one which is available.

Anuj Aggarwal (3):
  Regulator: Add pmic.c file to regulator framework
  Regulator: Add TPS65023 Regulator Driver
  Regulator: Added board-dependent code for TPS65023

 drivers/regulator/Kconfig              |    8 +
 drivers/regulator/Makefile             |    3 +-
 drivers/regulator/pmic.c               |  195 ++++++++++++
 drivers/regulator/tps65023-regulator.c |  510 ++++++++++++++++++++++++++++++++
 include/linux/regulator/pmic.h         |   29 ++
 5 files changed, 744 insertions(+), 1 deletions(-)
 create mode 100644 drivers/regulator/pmic.c
 create mode 100644 drivers/regulator/tps65023-regulator.c
 create mode 100644 include/linux/regulator/pmic.h

