From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V2 0/2] arm:omap:am33xx: Add voltage and power domain data
Date: Sun, 25 Dec 2011 14:30:26 +0530
Message-ID: <1324803628-16790-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34281 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105Ab1LYJAq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 25 Dec 2011 04:00:46 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>

Last time I had submitted a big patch-series, almost changing >7.5K lines
for AM33XX voltage, power, clock and HWMOD data support (as a RFC);
which I believe is very hard to review and difficult to manage also.
So I decided to split the patches as and when they are clean
and ready for review/merge/acceptance,
    - Voltage and Power data (ready)
    - Clock (common-clk migration) and HWMOD

This patch-series is created on top of my last patch submitted
for OMAP4 PRM cleanup for PWRSTCTRL & PWRSTST -
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg60468.html

As always, I maintain a seperate git repository where you can find
these patches + some patches to get AM335xEVM/BeagleBone to boot cleanly.

http://arago-project.org/git/people/?p=vaibhav/ti-psp-omap-video.git;a=summary
Branch - am335x-staging

Link to first version (RFC version) -
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg58742.html

Changes form V1:
	- Splitted patchs based on dependencies.
	- Incorporated all Kevin Hilman's review comments
	  * Have only one patch for data and Makefile/Kconfig changes
	  * Voltage Data: Add ".scalable = false" entry, to indicate
	    clearly that scaling is not supported yet.
	- Reuse all OMAP4 PRM implementation
	  * Thanks to Kevin and Rajendra for helping me out in this.

Vaibhav Hiremath (2):
  arm:omap:am33xx: Add voltage domain data
  arm:omap:am33xx: Add power domain data

 arch/arm/mach-omap2/Makefile                  |    5 +
 arch/arm/mach-omap2/io.c                      |    2 +
 arch/arm/mach-omap2/omap_hwmod.c              |    1 +
 arch/arm/mach-omap2/powerdomain.h             |    5 +-
 arch/arm/mach-omap2/powerdomains33xx_data.c   |  134 +++++++++++++++++++++++++
 arch/arm/mach-omap2/prm33xx.h                 |  118 ++++++++++++++++++++++
 arch/arm/mach-omap2/voltage.h                 |    1 +
 arch/arm/mach-omap2/voltagedomains33xx_data.c |   46 +++++++++
 8 files changed, 310 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-omap2/powerdomains33xx_data.c
 create mode 100644 arch/arm/mach-omap2/prm33xx.h
 create mode 100644 arch/arm/mach-omap2/voltagedomains33xx_data.c

