From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH v2 0/3] nand: omap2: Two and a half improvements
Date: Mon,  8 Sep 2014 08:27:13 -0300
Message-ID: <1410175636-4036-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:45212 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbaIHL2i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2014 07:28:38 -0400
Received: by mail-qg0-f45.google.com with SMTP id j107so2053731qga.18
        for <linux-omap@vger.kernel.org>; Mon, 08 Sep 2014 04:28:37 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, Roger Quadros <rogerq@ti.com>
Cc: linux-mtd@lists.infradead.org, =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

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
 drivers/mtd/nand/omap2.c                     | 162 +++++++++++++++------------
 include/linux/platform_data/elm.h            |  14 +++
 include/linux/platform_data/mtd-nand-omap2.h |   1 +
 4 files changed, 107 insertions(+), 72 deletions(-)

-- 
2.0.1

