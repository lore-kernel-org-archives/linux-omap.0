From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/2] drop plat/cpu.h for omap2plus
Date: Sun, 16 Dec 2012 12:03:11 -0800
Message-ID: <20121216200236.24238.38151.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:40209 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751569Ab2LPUDN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Dec 2012 15:03:13 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Finally it can be dropped. Thanks for help everybody.

Regards,

Tony

---

Tony Lindgren (2):
      ARM: OMAP: Split vrfb.c to remove last remaining cpu_is_omap usage
      ARM: OMAP2+: Drop plat/cpu.h for omap2plus


 arch/arm/mach-omap1/Makefile          |    2 -
 arch/arm/mach-omap1/fb.c              |   80 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/Makefile          |    2 -
 arch/arm/mach-omap2/drm.c             |    1 
 arch/arm/mach-omap2/dss-common.c      |    3 -
 arch/arm/mach-omap2/fb.c              |   50 +--------------------
 arch/arm/mach-omap2/prm2xxx.c         |    3 -
 arch/arm/mach-omap2/prm3xxx.c         |    3 -
 arch/arm/plat-omap/Makefile           |    2 -
 arch/arm/plat-omap/include/plat/cpu.h |    4 --
 drivers/media/platform/omap3isp/isp.c |    2 -
 drivers/power/avs/smartreflex.c       |    2 -
 12 files changed, 88 insertions(+), 66 deletions(-)
 create mode 100644 arch/arm/mach-omap1/fb.c
 rename arch/arm/{plat-omap/fb.c => mach-omap2/fb.c} (76%)

-- 
Signature
