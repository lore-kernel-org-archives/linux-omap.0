From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/3] ARM: OMAP: add corrected DSS regulator supplies
Date: Fri, 31 May 2013 10:37:51 +0300
Message-ID: <1369985874-8571-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49471 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752012Ab3EaHim (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 May 2013 03:38:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi Tony,

Here are a few patches adding corrected DSS regulator supplies. The current
ones in the board files are not really correct, although the dss driver works
ok with them.

So these patches add new regulator supply entries. When these are merged, I'll
change omapdss driver to use the new ones, instead of the old ones. After that,
we can remove the old ones from the board files.

Note that these patches were also present in the big DSS series I sent
yesterday. There's no reason for these patches to be there, so I'm sending them
separately, and will drop these from my DSS series.

 Tomi

Tomi Valkeinen (3):
  ARM: OMAP: fix dsi regulator names
  ARM: OMAP: add vdds_dsi supply for omapdss_dpi.0
  ARM: OMAP: add vdds_sdi supply for omapdss_sdi.0

 arch/arm/mach-omap2/board-cm-t35.c           | 3 ++-
 arch/arm/mach-omap2/board-devkit8000.c       | 1 +
 arch/arm/mach-omap2/board-ldp.c              | 3 ++-
 arch/arm/mach-omap2/board-omap3pandora.c     | 1 +
 arch/arm/mach-omap2/board-rx51-peripherals.c | 1 +
 arch/arm/mach-omap2/twl-common.c             | 1 +
 6 files changed, 8 insertions(+), 2 deletions(-)

-- 
1.8.1.2

