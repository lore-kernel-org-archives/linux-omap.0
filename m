From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH v3 0/3] nand: omap2: Two and a half improvements
Date: Thu, 11 Sep 2014 12:02:07 -0300
Message-ID: <1410447730-16087-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:37850 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649AbaIKPES (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2014 11:04:18 -0400
Received: by mail-qc0-f179.google.com with SMTP id o8so5113426qcw.24
        for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2014 08:04:17 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>, Brian Norris <computersforpeace@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Changes from v2:

  * Fixed some silly mistakes in patch 3, and reverted the removed
    error messages when nand_bch_init fails.

Changes from v1:

  * Rebased on v3.14-rc2.

  * Removed a few s/pr_err/dev_err change from patch two, and added it
    to patch three. This was some git-rebase leftover.

Pekon's attempt to add flash BBT support for this driver made me realise
the addition made sense and there were good reasons for it. The first patch
adds support for enabling a flash BBT either from legacy board files or
from devicetree.

While testing this, I noticed how the driver relied on a whole bunch of
horrible #ifdefs, which prevented me from loading the driver as a module.
The second patch attempts to fix that.

The third patch is just a dummy cleanup replacing pr_errs with dev_errs.
This driver is abusing from user messages, but I'm not sure fixing them
worths the trouble.

Ezequiel Garcia (3):
  nand: omap2: Add support for flash-based bad block table
  nand: omap2: Remove horrible ifdefs to fix module probe
  nand: omap2: Replace pr_err with dev_err

 arch/arm/mach-omap2/gpmc.c                   |   2 +
 drivers/mtd/nand/omap2.c                     | 166 +++++++++++++++------------
 include/linux/platform_data/elm.h            |  14 +++
 include/linux/platform_data/mtd-nand-omap2.h |   1 +
 4 files changed, 110 insertions(+), 73 deletions(-)

-- 
2.1.0

