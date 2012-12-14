From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/2] few trivial omap patches
Date: Fri, 14 Dec 2012 11:44:47 -0800
Message-ID: <20121214194325.9874.95898.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:11726 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932237Ab2LNTot (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Dec 2012 14:44:49 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here's cleanup patch to remove plat/cpu.h usage
where possible, and to add a .dts file maintainers
entry for omaps.

Regards,

Tony

---

Tony Lindgren (2):
      ARM: OMAP2+: Drop remaining plat/cpu.h usage where possible
      MAINTAINERS: Add an entry for omap related .dts files


 MAINTAINERS                      |    9 +++++++++
 arch/arm/mach-omap2/drm.c        |    1 -
 arch/arm/mach-omap2/dss-common.c |    3 +--
 arch/arm/mach-omap2/prm2xxx.c    |    3 +--
 arch/arm/mach-omap2/prm3xxx.c    |    3 +--
 drivers/power/avs/smartreflex.c  |    2 --
 6 files changed, 12 insertions(+), 9 deletions(-)

-- 
Signature
