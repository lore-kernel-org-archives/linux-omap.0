From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/3]: ARM: OMAP2/3: HWMOD fixes for DSS
Date: Tue, 24 Jan 2012 12:45:17 +0200
Message-ID: <1327401920-5617-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:32890 "HELO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755634Ab2AXKpc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jan 2012 05:45:32 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, paul@pwsan.com
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

There are some sysconfig flags missing for OMAP2/3 DSS hwmods. This series adds
those.

This series is based on the earlier series "[PATCH 0/3] OMAP: DSS PM fixes",
but is sent separately here as the first series is inteded to go into the next
rc, and this can be left to next merge window.

Tested on OMAP3 Overo. I don't have OMAP3 DSI or RFBI boards, so I haven't been
able to test those.

 Tomi

Tomi Valkeinen (3):
  ARM: OMAP2/3: HWMOD: Add missing flags for dispc class
  ARM: OMAP2/3: HWMOD: Add missing flag for rfbi class
  ARM: OMAP3: HWMOD: Add omap_hwmod_class_sysconfig for dsi

 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |    2 +-
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    3 ++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   15 ++++++++++++++-
 3 files changed, 17 insertions(+), 3 deletions(-)

-- 
1.7.4.1

