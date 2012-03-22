From: Russ Dill <Russ.Dill@ti.com>
Subject: [PATCH 00/13] Fixup gmpc smsc911x regulator handling
Date: Wed, 21 Mar 2012 22:19:41 -0700
Message-ID: <1332393594-23993-1-git-send-email-Russ.Dill@ti.com>
References: <20120321194133.GP9859@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35468 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754238Ab2CVFUJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Mar 2012 01:20:09 -0400
Received: by iagz16 with SMTP id z16so2617327iag.19
        for <linux-omap@vger.kernel.org>; Wed, 21 Mar 2012 22:20:08 -0700 (PDT)
In-Reply-To: <20120321194133.GP9859@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Matt Porter <mporter@ti.com>, robert.marklund@stericsson.com, linus.walleij@linaro.org, Russ Dill <Russ.Dill@ti.com>

This patchset cleans up some problems with gpmc connected smsc911x
chips. Commit c7e963f6888816 (net/smsc911x: Add regulator support)
broke registration of gpmc connected smcs911x devices on machines with
regulator support, but without dummy regulator support by requiring
regulators.

Commit e4b0b2cbbb (ARM: OMAP2+: gpmc-smsc911x: add required smsc911x
regulators) fixed the issue for boards with single smsc911x devices,
but attempted to register the fixed voltage regulator twice for boards
with 2 devices which fails.

bb60424af5 (ARM: OMAP2+: gpmc-smsc911x: only register regulator for
first instance) cleaned this up a little bit by only automatically
registering regulators for the first device, but still did not allow
the second device to function because it lacked regulators.

The new patchset pushes register regulation back to where it belongs, 
in the board files. It eliminates a lot of boilerplate by utilizing
the new regulator_register_fixed function.

Additionally, there are 4 cleanup patches in this patch series. One is
a kdoc fix for regulator_register_fixed, 1 is a fix for potential
stale data usage in gpmc-smsc911x, another removes dead code, and the
final one eliminates an unneeded static variable in gpmc-smsc911x.

These patches have been compile tested on next-20120321 with an  
additional patch to fix the omap boot failures and have been tested
on omap3evm (am37x-evm) hardware.

Russ Dill (13):
  Remove odd gpmc_cfg/board_data redirection.
  Fix possible stale smsc911x flags.
  Remove unused rate calculation.
  Remove non-existent parameter from fixed-helper.c kernel doc.
  Remove regulator support from gmpc-smsc911x
  Add dummy smsc911x regulators to cm-t35.
  Add dummy smsc911x regulators to igep0020.
  Add dummy smsc911x regulators to ldp.
  Add dummy smsc911x regulators to omap3evm.
  Add dummy smsc911x regulators to omap3logic.
  Add dummy smsc911x regulators to omap3stalker.
  Add dummy smsc911x regulators to overo.
  Add dummy smsc911x regulators to zoom-debugboard.

 arch/arm/mach-omap2/board-cm-t35.c          |    9 ++++
 arch/arm/mach-omap2/board-igep0020.c        |    6 +++
 arch/arm/mach-omap2/board-ldp.c             |    7 +++
 arch/arm/mach-omap2/board-omap3evm.c        |   15 +++----
 arch/arm/mach-omap2/board-omap3logic.c      |    7 +++
 arch/arm/mach-omap2/board-omap3stalker.c    |   16 +++----
 arch/arm/mach-omap2/board-overo.c           |    8 +++
 arch/arm/mach-omap2/board-zoom-debugboard.c |    9 ++++
 arch/arm/mach-omap2/gpmc-smsc911x.c         |   65 +--------------------------
 drivers/regulator/fixed-helper.c            |    1 -
 10 files changed, 61 insertions(+), 82 deletions(-)

-- 
1.7.9.1

