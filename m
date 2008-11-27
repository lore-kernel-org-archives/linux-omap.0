From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 0/3] OMAP: PM: enable UART clock disabling when idle
Date: Wed, 26 Nov 2008 16:29:57 -0800
Message-ID: <1227745800-5894-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f11.google.com ([209.85.221.11]:45335 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752507AbYK0AaG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2008 19:30:06 -0500
Received: by qyk4 with SMTP id 4so1010021qyk.13
        for <linux-omap@vger.kernel.org>; Wed, 26 Nov 2008 16:30:03 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This series enables UART clock disabling after an inactivity period.
It is based on top of the 2 8250 patches recently sent to linux-serial
and CC'd to linux-omap.

To enable:

  # echo 1 > /sys/power/clocks_off_while_idle
  # echo 1 > /sys/power/sleep_while_idle

NOTE: it is expected that the first character typed is lost
when coming out of idle.  The first char serves as the wakeup
event but is lost.

Kevin Hilman (3):
  OMAP3: PM: Add wake-up bit defintiions for CONTROL_PADCONF_X
  OMAP3: PM: UART: disable clocks when idle
  OMAP3: PM: UART save/restore support for OFF-mode

 arch/arm/mach-omap2/pm-debug.c            |  135 ----------
 arch/arm/mach-omap2/pm.h                  |    8 -
 arch/arm/mach-omap2/pm24xx.c              |   40 ++--
 arch/arm/mach-omap2/pm34xx.c              |   14 +
 arch/arm/mach-omap2/serial.c              |  380 +++++++++++++++++++++++++++--
 arch/arm/plat-omap/include/mach/common.h  |    2 -
 arch/arm/plat-omap/include/mach/control.h |    4 +
 arch/arm/plat-omap/include/mach/serial.h  |    8 +
 include/linux/serial_reg.h                |    1 +
 9 files changed, 404 insertions(+), 188 deletions(-)

