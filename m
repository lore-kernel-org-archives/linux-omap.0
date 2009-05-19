From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 0/2] PM: drop clocks_off_while_idle
Date: Tue, 19 May 2009 10:14:22 -0700
Message-ID: <1242753264-12600-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f191.google.com ([209.85.216.191]:46562 "EHLO
	mail-px0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689AbZESROb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 13:14:31 -0400
Received: by pxi29 with SMTP id 29so2526560pxi.33
        for <linux-omap@vger.kernel.org>; Tue, 19 May 2009 10:14:32 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The sysfs control /sys/power/clocks_off_while_idle only affects
the UART clocks.  And these can now be controlled with a UART
specific timeout sysfs control.  The system default behavior
is to have the equivalent of clocks_off_while_idle == 1 and
a UART inactivity timeout of 5 seconds.

Now one can use

  /sys/devices/platform/serial8250.<uart>/sleep_timeout

to set the inactivity timer for the UART in seconds.  Setting
this value to zero disables the timout and is the equivalent
of doing an

  echo 0 > /sys/power/clocks_off_while_idle


Kevin Hilman (2):
  OMAP: PM: UART: zero sleep_timeout will disable timeout feature
  OMAP2/3: PM: remove /sys/power/clocks_off_while_idle

 arch/arm/mach-omap2/pm.c     |   12 ------------
 arch/arm/mach-omap2/pm.h     |    1 -
 arch/arm/mach-omap2/serial.c |   16 +++++++++++-----
 3 files changed, 11 insertions(+), 18 deletions(-)

