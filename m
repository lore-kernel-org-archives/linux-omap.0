From: Tony Lindgren <tony@atomide.com>
Subject: [PATCHv3 0/5] Linux generic wakeirq handling
Date: Wed, 13 May 2015 16:36:31 -0700
Message-ID: <1431560196-5722-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from tkt-001-i372.relay.mailchannels.net ([174.136.5.173]:1098 "EHLO
	relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754387AbbEMXhI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 May 2015 19:37:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alan Stern <stern@rowland.harvard.edu>
Cc: Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org

Hi all,

Here's the third version of the Linux generic wakeirq support.

I've added support for automatically handling wake-up capable
IO interrupts too as suggested by Rafael the last time around.

I think I've addressed all the comments, please review and let
me know if I've missed something.

For reference, the two earlier versions can be found at:

http://www.spinics.net/lists/arm-kernel/msg377300.html
https://lwn.net/Articles/635904/

Regards,

Tony


Tony Lindgren (5):
  PM / Runtime: Update last_busy in rpm_resume
  PM / Wakeirq: Add automated device wake IRQ handling
  serial: omap: Switch wake-up interrupt to generic wakeirq
  serial: 8250_omap: Move wake-up interrupt to generic wakeirq
  mmc: omap_hsmmc: Change wake-up interrupt to use generic wakeirq

 arch/arm/mach-omap2/Kconfig         |   1 +
 drivers/base/power/Makefile         |   1 +
 drivers/base/power/main.c           |   2 +
 drivers/base/power/power.h          |  38 +++++
 drivers/base/power/runtime.c        |   1 +
 drivers/base/power/wakeirq.c        | 316 ++++++++++++++++++++++++++++++++++++
 drivers/base/power/wakeup.c         |  96 +++++++++++
 drivers/mmc/host/omap_hsmmc.c       |  51 +-----
 drivers/tty/serial/8250/8250_omap.c |  61 +------
 drivers/tty/serial/omap-serial.c    |  38 +----
 include/linux/pm.h                  |   2 +
 include/linux/pm_wakeirq.h          |  72 ++++++++
 include/linux/pm_wakeup.h           |   7 +
 kernel/power/Kconfig                |   4 +
 14 files changed, 562 insertions(+), 128 deletions(-)
 create mode 100644 drivers/base/power/wakeirq.c
 create mode 100644 include/linux/pm_wakeirq.h

-- 
2.1.4

