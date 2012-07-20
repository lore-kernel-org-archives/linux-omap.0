From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC 0/4] OMAP Cpuidle/Suspend Cleanups
Date: Fri, 20 Jul 2012 11:34:40 +0530
Message-ID: <1342764284-8143-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52523 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752189Ab2GTGFt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Jul 2012 02:05:49 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, santosh.shilimkar@ti.com, t-kristo@ti.com, Rajendra Nayak <rnayak@ti.com>

Hi,

Here are some CPUidle/Suspend cleanup patches done by adding
some more functionality in the OMAP Powerdomain framework.
They mostly cleanup OMAP3 but the same ideas can be used/
applied for OMAP4 and beyond.

The series is based off Teros' series [1] to add usecounting
support within the OMAP Powerdomain framework.

The patches are tested with RET/OFF in CPUidle and Suspend
on 3630 beagle Xm and 3430 SDP.

regards,
Rajendra

[1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg72163.html

Rajendra Nayak (4):
  ARM: OMAP3: cpuidle: Remove unused MPU OSWR support code
  ARM: OMAP: PM: Get rid of Powerdomain book-keeping from cpuidle
  ARM: OMAP: powerdomain: Add .power_on/.power_down hooks for
    powerdomains
  ARM: OMAP3: PM: Use .power_on/.power_down to clean omap_sram_idle

 arch/arm/mach-omap2/omap-mpuss-lowpower.c |    4 +-
 arch/arm/mach-omap2/pm34xx.c              |  158 ++++++++++++++---------------
 arch/arm/mach-omap2/powerdomain.c         |   40 ++++----
 arch/arm/mach-omap2/powerdomain.h         |    8 +-
 arch/arm/mach-omap2/sleep34xx.S           |    4 +-
 5 files changed, 104 insertions(+), 110 deletions(-)

