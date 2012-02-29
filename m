From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 0/6] ARM: OMAP3PLUS: IO daisychain support fixes
Date: Wed, 29 Feb 2012 16:26:55 +0200
Message-ID: <1330525621-29836-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33310 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752486Ab2B2O1P (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Feb 2012 09:27:15 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com
Cc: linux-arm-kernel@lists.infradead.org

Hi,

The previous version of this set was sent by Vishwanath BS, but as he
is busy with other stuff, I am taking over.

Some basic info about this set based on comments received on set v2.
IO chain is now enabled always, and a re-trigger for the chain is
done during hwmod enable / disable. This means that IO chain is always
armed according to the latest pad specific WAKE_ENABLE setting, and
if it is modified, the IO chain needs to be re-armed (thus the hooks
within omap_hwmod code.) Having IO chain armed all the time allows us
to receive IO event interrupts even during non-sleep states if the
corresponding hardware module is disabled, and is unable to detect any
IO activity itself.

Version 3 contains the following changes:

- global: renamed *_trigger_wuclk_ctrl funcs as *_trigger_io_chain
- patch 3: added trigger WUCLKIN disable at the end of omap4_trigger_io_chain
  (fix pulled from the omap4 core retention set)
- patch 5: added function pointer for using machine specific io_chain trigger
  function, initialized during boot
- patch 7 dropped as the support capability for omap3 is now handled as
  part of patch 5 init

Tested on omap3 beagle + omap4 blaze boards. Suspend / resume works, and
hwmod_io interrupts are generated. Omap4 was tested with the core retention
support set.

PS: Vishwa / Rajendra, let me know if you are unhappy with me keeping
your signed-off-by tags in place, I did some minor changes to the patches
from you.

-Tero

