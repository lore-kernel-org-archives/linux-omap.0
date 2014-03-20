From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v8 0/4] mtd: devices: elm: add checks ELM H/W constrains, driver code cleanup
Date: Thu, 20 Mar 2014 18:43:04 +0530
Message-ID: <1395321188-4123-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33747 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754866AbaCTNNY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Mar 2014 09:13:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Stefan Roese <sr@denx.de>, Pekon Gupta <pekon@ti.com>

*changes v7 -> v8*
Incorporated feedbacks from Brian Norris <computersforpeace@gmail.com>
 - renamed ecc_step_bytes -> ecc_syndrome_size


*changes v6 -> v7*
Incorporated feedbacks from Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
 - using dev_err() instead of pr_err()
 - moved un-related addition of info->ecc_steps, info->ecc_step_bytes,
   info->ecc_step_size from [PATCH v6 1/4] into subsequent patches
 - dropped pr_fmt() change


*changes v5 -> v6*
[PATCH 02/04] minor cleanup

*changes v4 -> v5*
This patch series is split version from earlier series [1].
This series refactors and cleans ELM driver which is used by Hardware
based BCHx ecc-schemes.
 - Undo: introduction of 'struct mtd_info' and 'struct nand_chip'. Instead
         keep ELM driver independent of mtd_info and nand_chip structs and
         pass only required ECC configurations as elm_config() arguments
         elm_config(..., int ecc_steps, int ecc_step_size, int ecc_step_bytes)
 - Undo: re-writing of elm_load_syndrome() ECC register configurations.

*changes v3 -> v4 [1]*
 - in-corporated feedbacks from Brian Norris <computersforpeace@gmail.com>
 - updated: use 'pr_fmt(fmt)' to suffix DRIVER_NAME
 - removed: local 'eccsteps' in ELM driver, instead using nand_chip->ecc.steps
 - undo: irrelavant white-space changes

[1] http://lists.infradead.org/pipermail/linux-mtd/2013-November/050242.html

Pekon Gupta (4):
  mtd: devices: elm: check for hardware engine's design constraints
  mtd: devices: elm: clean elm_load_syndrome
  mtd: devices: elm: configure parallel channels based on ecc_steps
  mtd: devices: elm: update DRIVER_NAME as "omap-elm"

 drivers/mtd/devices/elm.c         | 43 ++++++++++++++++++++++++++++-----------
 drivers/mtd/nand/omap2.c          |  9 +++++---
 include/linux/platform_data/elm.h | 10 ++-------
 3 files changed, 39 insertions(+), 23 deletions(-)

-- 
1.8.5.1.163.gd7aced9

