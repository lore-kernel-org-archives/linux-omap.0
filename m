From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH 0/3] arm: omap: add support for Nokia RM-696 (Nokia N9)
Date: Fri,  9 Dec 2011 17:06:48 +0200
Message-ID: <1323443211-3648-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:42015 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754079Ab1LIPEx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Dec 2011 10:04:53 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

The following patches add minimal support for Nokia RM-696 board.
Tested with Linux 3.2-rc4 and busybox, basic functionality like serial
console and MMC are working. So far the code is identical with RM-680.

mach-types update is needed to compile the code. I'm not sure how the
file is updated these days?

For testing, the following patch is also required:
http://www.spinics.net/lists/linux-omap/msg61022.html

Aaro Koskinen (2):
  arm: tools: mach-types: add nokia_rm696
  arm: omap: add minimal support for Nokia RM-696

Igor Dmitriev (1):
  arm: mach-omap2: sdram-nokia: add 200 MHz memory timings info

 arch/arm/mach-omap2/Kconfig                  |    3 ++-
 arch/arm/mach-omap2/board-rm680.c            |   12 +++++++++++-
 arch/arm/mach-omap2/sdram-nokia.c            |   25 ++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/uncompress.h |    1 +
 arch/arm/tools/mach-types                    |    1 +
 5 files changed, 39 insertions(+), 3 deletions(-)

-- 
1.7.2.5

