From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/5] regulator: twl: make 6030 regulators useable
Date: Fri,  1 Apr 2011 10:22:41 +0530
Message-ID: <1301633566-5212-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:57043 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750807Ab1DAEw7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 00:52:59 -0400
Received: by mail-gw0-f42.google.com with SMTP id 17so1659567gwb.15
        for <linux-omap@vger.kernel.org>; Thu, 31 Mar 2011 21:52:57 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, Saquib <saquib@ti.com>, Nishanth Menon <nm@ti.com>

TWL6030 regulator dynamic operations such as those on vaux2 and vaux3
were reported to be broken on platforms such as pandaboard(OMAP4).
Digging deeper into the code, found that 6030 regulator support
requires quiet a bit of fixes to make it useable. Major change w.r.t
TWL4030 has been the introduction of CFG_STATE register in TWL6030
which is needed to be used for regulator control compared to messages
which were used in TWL4030.

This could have been the real root cause of the issue fixed in:
  commit 8b8e2ef328c3378c74fb4347f66df8e58feeaf46
  Author: David Anders <x0132446@ti.com>
  Date:   Fri Mar 18 16:53:20 2011 -0700

  OMAP4: PandaBoard: remove unused power regulators

  the pandaboard does not use the VUSIM or VAUX1 power regulators on the TWL6030
  and are left floating. if the VUSIM and VAUX1 power regulators are initilized,
  noise on the unloaded regulators generates an overcurrent interrupt causing the
  system to power down. this patch removes the initialization of the unused power
  regulators of VUSIM and VAUX1.

Normally just having the regulator resources in board file should'nt have caused
them to have been enabled in the first place - they should have been enabled
only when regulator_enable is invoked and disabled in regulator_disable.
These unfortunately, are'nt working at the moment and the series fixes the same.

This series also allows the regulator framework to actually be able to use the
regulator in lower power "SUSPEND" state which if properly used could reduce
power consumption in usecases.

Based on: 2.6.39-rc1 tag

Saquib Herman (5):
  regulator: twl: fix twl6030 enable/disable
  regulator: twl: remap has no meaning for 6030
  regulator: twl: fix twl6030 regulator is_enabled
  regulator: twl: add twl6030 get_status
  regulator: twl: add twl6030 set_mode

 drivers/regulator/twl-regulator.c |  209 ++++++++++++++++++++++++++++---------
 1 files changed, 159 insertions(+), 50 deletions(-)

Tested on: PandaBoard(OMAP4430 with TWL6030)
Testing patch: http://pastebin.mozilla.org/1195106

Regards,
Nishanth Menon
