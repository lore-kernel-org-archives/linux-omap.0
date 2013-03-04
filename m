From: <hvaibhav@ti.com>
Subject: [RFC PATCH 0/3] ARM: OMAP2+: Add command line parameter for debugSS module control
Date: Mon, 4 Mar 2013 17:05:54 +0530
Message-ID: <1362396957-30113-1-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42327 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757132Ab3CDLgb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Mar 2013 06:36:31 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@linaro.org, paul@pwsan.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

Currently there is no clean mechanism to control debugSS module and
you have to always keep clocks enabled, either,

    - By enabling it during boot as part of clk_init function
      (post common-clock migration).
    Or
    - By having HWMOD_INIT_NO_IDLE flag in hwmod data
      (Joel submitted patch for AM335x earlier).

Based on the discussion with Kevin H,
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg81771.html

This patch introduces new kernel parameter "omap_debugss_en",
which will allow user to control debugSS module enable/disable
part during boot-time.

In case of OMAP3, the debugSS is part of EMU domain and
is currently controlled by clock tree alone.

In case of OMAP4, the debugSS is part of EMU domain and
is currently controlled by clock tree, as MODULEMODE_SWCTRL
is not defined for hwmod.

In case of AM335x, the debugSS is in wakeup domain and is currently
controlled through hwmod alone. Currently we keep it always enabled.

Testing:
	- Tested on AM335x based EVM and BeagleBone platform

	  As required, without this flag the debugSS module will be disabled
	  during kernel boot.

OMAP (2/3/4) may require some changes from clock/hwmod perspective
in order to use this new parameter.
I am still looking into OMAP spec and this RFC version of patch-series
is to get comments or opinion from list.

Vaibhav Hiremath (3):
  ARM: AM33XX: clock: Add debugSS clock nodes to clock tree
  ARM: AM33XX: hwmod: Add hwmod data for debugSS
  ARM: OMAP2+: Add command line parameter for debugSS module control

 Documentation/kernel-parameters.txt        |    3 +
 arch/arm/mach-omap2/Makefile               |    2 +-
 arch/arm/mach-omap2/cclock33xx_data.c      |   47 +++++++++++++++--
 arch/arm/mach-omap2/debugss.c              |   80 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |   69 ++++++++++++++++--------
 5 files changed, 173 insertions(+), 28 deletions(-)
 create mode 100644 arch/arm/mach-omap2/debugss.c

