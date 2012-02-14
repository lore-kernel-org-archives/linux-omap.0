From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH 0/2] ARM: OMAP4: Cleanup in cminst code
Date: Tue, 14 Feb 2012 20:59:06 +0530
Message-ID: <1329233348-23356-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49983 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751373Ab2BNPfc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Feb 2012 10:35:32 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, khilman@ti.com, rnayak@ti.com, tony@atomide.com, paul@pwsan.com, b-cousson@ti.com, Vaibhav Hiremath <hvaibhav@ti.com>

Similar to PRM code cleanup done recently to reuse prminst api's
for AM33xx device, so in order to reuse the existing OMAP4
cminst code for AM33xx this patch adds,

  - Boot time __init function, to initialize _cm_bases
    based on cpu_is_xxx
  - Instead of maintaining phy addr for CM partition
    in _cm_bases[] table and then changing it to virt addr,
    directly maintain respective virt addr.

And also hook-up support for AM33xx device to existing cminst
code.

Patch series is boot tested on AM335x EVM and AM37xEVM.

NOTE: This patch series is dependent on earlier submitted PRM
      cleanup patch-series -
      http://www.spinics.net/lists/linux-omap/msg62351.html


Vaibhav Hiremath (2):
  ARM: OMAP4: cminst: Add boot time __init function for cminst
  ARM: OMAP: am33xx: Hook-up am33xx support to existing cm code

 arch/arm/mach-omap2/cminst44xx.c |   38 +++++++++++++++++++++++++++++---------
 arch/arm/mach-omap2/cminst44xx.h |    1 +
 arch/arm/mach-omap2/io.c         |    3 +++
 arch/arm/mach-omap2/omap_hwmod.c |   23 +++++++++++++++--------
 4 files changed, 48 insertions(+), 17 deletions(-)

