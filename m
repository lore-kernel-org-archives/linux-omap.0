From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/4] Generic gpmc-onenand initialization
Date: Wed, 29 Apr 2009 14:47:45 -0700
Message-ID: <20090429214345.13065.37228.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49523 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbZD2Vrs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Apr 2009 17:47:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, adrian.hunter@nokia.com

Hi all,

This series creates a generic gpmc-onenand.c from the board-n800-flash.c.
Eventually we should be able to use this for all boards with onenand
connected.

This should allow us to start syncing up the mach-omap2/board-*.c files
with mainline, and the the gpmc-onenand code into the mainline.

Testing & patches welcome to convert more boards! Adrian & Artem, could
you guys please check the partition tables I created in these patches?

Regards,

Tony

---

Tony Lindgren (4):
      onenand init: Pass configuration data from board-*.c files
      onenand init: Rename n800_* functions to gpmc_onenand_* functions
      onenand init: Build gpmc-onenand.o based on CONFIG_MTD_ONENAND_OMAP2
      onenand init: Rename board-n800-flash.c to gpmc-onenand.c


 arch/arm/mach-omap2/Makefile                 |    7 ++-
 arch/arm/mach-omap2/board-n800.c             |   49 ++++++++++++++++++++++++
 arch/arm/mach-omap2/board-rx51-flash.c       |   21 ----------
 arch/arm/mach-omap2/board-rx51-peripherals.c |   46 +++++++++++++++++++++++
 arch/arm/mach-omap2/board-rx51.c             |    2 -
 arch/arm/mach-omap2/gpmc-onenand.c           |   53 ++++++--------------------
 arch/arm/plat-omap/include/mach/board.h      |    8 ----
 arch/arm/plat-omap/include/mach/onenand.h    |   22 +++++++++++
 8 files changed, 132 insertions(+), 76 deletions(-)
 delete mode 100644 arch/arm/mach-omap2/board-rx51-flash.c
 rename arch/arm/mach-omap2/{board-n800-flash.c => gpmc-onenand.c} (85%)

-- 
Signature
