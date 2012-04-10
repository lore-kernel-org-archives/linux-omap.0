From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [GIT PULL]: omap-serial updates for 3.4-rc
Date: Tue, 10 Apr 2012 15:32:28 +0530
Message-ID: <1334052148-10385-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60788 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753562Ab2DJKCe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Apr 2012 06:02:34 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Hi Tony,

Please Pull the following omap uart changes.
Changes basically involves getting rid of cpu checks
for populating erratas and features and move the same
from serial.c to omap-serial.c, MVR reg is used to find
uart versions and errata flags are populated accordingly.

--
Thanks,
Govindraj.R

The following changes since commit 0034102808e0dbbf3a2394b82b1bb40b5778de9e:

  Linux 3.4-rc2 (2012-04-07 18:30:41 -0700)

are available in the git repository at:

  git://gitorious.org/linux-3-x/omap-serial.git for_3.4/uart_fixes

for you to fetch changes up to 6c34f211069409ea6d08b900eeaf86ef8efd0dca:

  OMAP2+: UART: replace omap34xx/omap4xx cpu checks with not omap24xx (2012-04-10 15:14:58 +0530)

----------------------------------------------------------------
Govindraj.R (3):
      OMAP2+: UART: Remove cpu checks for populating errata flags
      OMAP2+: UART: enable tx wakeup bit for wer reg
      OMAP2+: UART: replace omap34xx/omap4xx cpu checks with not omap24xx

 arch/arm/mach-omap2/serial.c                  |   13 +---
 arch/arm/plat-omap/include/plat/omap-serial.h |    9 +++-
 drivers/tty/serial/omap-serial.c              |   83 ++++++++++++++++++++++++-
 3 files changed, 91 insertions(+), 14 deletions(-)
