From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/4] Minimal generic wakeirq helpers
Date: Thu,  5 Mar 2015 16:34:05 -0800
Message-ID: <1425602049-2674-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pmta1.delivery2.ore.mailhop.org ([54.149.210.130]:56536 "EHLO
	pmta1.delivery2.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751628AbbCFAjv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Mar 2015 19:39:51 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Andreas Fenkart <afenkart@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Huiquan Zhong <huiquan.zhong@intel.com>, Kevin Hilman <khilman@kernel.org>, NeilBrown <neilb@suse.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, Nishanth Menon <nm@ti.com>, Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org

Hi all,

Here's an attempt to have Linux generic wakeirq helpers. This allows
removing most of the related code from drivers. Currently the drivers
all do it in a slightly different way. And may have issues with interrupt
re-entrancy and getting the suspend/resume vs runtime_pm wake handling
right.

This is for wakerirqs that are available for some devices in addition
to the regular device interrupts. The seprate always-on wake-up interrupt
controller is needed to allow devices and the SoC to enter deeper idle
states and still be able to wake-up to events.

Some of this was discussed in the kernel/irq context a while back [1].
But it seems that this can be done in drivers/base/power. If somebody has
hardware that needs to replay lost device interrupts based on the
wake-up interrupts, then additional kernel/irq changes will be needed.

This set fixes up three drivers to use the generic wakeirq. Note that
eventually the wakeirq handling for these drivers might end up in a
bus specific code and could be hidden away from the drivers.

Regards,

Tony


[1] https://lkml.org/lkml/2014/11/13/458

Tony Lindgren (4):
  PM / Wakeirq: Add minimal device wakeirq helper functions
  serial: 8250_omap: Move wake-up interrupt to generic wakeirq
  serial: omap: Switch wake-up interrupt to generic wakeirq
  mmc: omap_hsmmc: Change wake-up interrupt to use generic wakeirq

 arch/arm/mach-omap2/Kconfig         |   1 +
 drivers/base/power/Makefile         |   1 +
 drivers/base/power/wakeirq.c        | 201 ++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/omap_hsmmc.c       |  55 +++-------
 drivers/tty/serial/8250/8250_omap.c |  67 +++---------
 drivers/tty/serial/omap-serial.c    |  38 +++----
 include/linux/pm_wakeirq.h          |  69 +++++++++++++
 kernel/power/Kconfig                |   4 +
 8 files changed, 318 insertions(+), 118 deletions(-)
 create mode 100644 drivers/base/power/wakeirq.c
 create mode 100644 include/linux/pm_wakeirq.h

-- 
2.1.4

