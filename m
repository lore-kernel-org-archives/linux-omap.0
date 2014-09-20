From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH v4 0/5] nand: OMAP collected fixes
Date: Sat, 20 Sep 2014 17:53:11 +0100
Message-ID: <1411231996-6387-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:56596 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752898AbaITQyd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 20 Sep 2014 12:54:33 -0400
Received: by mail-wg0-f49.google.com with SMTP id x12so744081wgg.8
        for <linux-omap@vger.kernel.org>; Sat, 20 Sep 2014 09:54:32 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>, Roger Quadros <rogerq@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

I've collected all the changes recently discussed in a whole patchset.
If you are just reading this for the first time please take a look at:

[1] http://www.spinics.net/lists/linux-omap/msg110965.html
[2] http://www.spinics.net/lists/linux-omap/msg110958.html 

As requested by Roger, the omap_elm is a 'bool' driver now. The plan
is to merge it inside omap2_nand, but my queue is really filled, so
if anyone feels like doing, please be my guest.

Although I'm hoping this to be the last round, feedback and testing
is welcome.

Brian: I wonder if it's too late for v3.18?

Thanks!

Ezequiel Garcia (5):
  nand: omap2: Remove horrible ifdefs to fix module probe
  nand: omap2: Replace pr_err with dev_err
  mtd: nand: Move ELM driver and rename as omap_elm
  mtd: nand: Rename OMAP NAND driver
  mtd: nand: Constrain omap_elm to built-in

 drivers/mtd/devices/Makefile                   |   1 -
 drivers/mtd/nand/Kconfig                       |   2 +-
 drivers/mtd/nand/Makefile                      |   3 +-
 drivers/mtd/nand/{omap2.c => omap2_nand.c}     | 160 ++++++++++++++-----------
 drivers/mtd/{devices/elm.c => nand/omap_elm.c} |   0
 include/linux/platform_data/elm.h              |  16 +++
 6 files changed, 107 insertions(+), 75 deletions(-)
 rename drivers/mtd/nand/{omap2.c => omap2_nand.c} (95%)
 rename drivers/mtd/{devices/elm.c => nand/omap_elm.c} (100%)

-- 
2.1.0

