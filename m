From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: [PATCH 0/3] omap2: Assorted GPMC cleanups
Date: Sun, 27 Oct 2013 21:51:45 -0300
Message-ID: <1382921508-5104-1-git-send-email-ezequiel.garcia@free-electrons.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:59913 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755304Ab3J1AwC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 27 Oct 2013 20:52:02 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, Enric Balletbo Serra <eballetbo@gmail.com>, Pekon Gupta <pekon@ti.com>, Tony Lindgren <tony@atomide.com>, linux-mtd@lists.infradead.org, Jon Hunter <jgchunter@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

(I'm CCing the MTD list, because GPMC is the memory controller
used for NOR, NAND and OneNAND devices).

Hi all,

Just a small patchset containing two small cleanups and a minor fix
for the GPMC memory controller. The first two are cleanups and can
be considered as preparation work for the fix.

The fix is patch 3/3: "Move legacy GPMC width setting". It makes
explicit use of the DT property "gpmc,device-width" and removes the
subsequent (and redundant) setting of the GPMC width, based in the
NAND bus widht.

Tested in AM335x (using DT) so I'd appreciate if someone can test using
a board-file, on a device with NAND flash.

Jon: If you happen to read this, I'd like if you could take a look at
patch 1/3, since you were the last to touch that part of the code.

Thanks!

Ezequiel Garcia (3):
  omap2: gpmc: Move initialization outside the gpmc_t condition
  omap2: gpmc: Introduce gpmc_set_legacy()
  omap2: gpmc: Move legacy GPMC width setting

 arch/arm/mach-omap2/gpmc-nand.c | 50 +++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

-- 
1.8.1.5

