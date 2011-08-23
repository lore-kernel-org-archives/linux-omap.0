From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/9] OMAP: HWMOD: DSS patches
Date: Tue, 23 Aug 2011 15:28:10 +0300
Message-ID: <1314102499-30407-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:42375 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752273Ab1HWM2e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Aug 2011 08:28:34 -0400
Received: by mail-bw0-f45.google.com with SMTP id zv3so47317bkb.32
        for <linux-omap@vger.kernel.org>; Tue, 23 Aug 2011 05:28:33 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

These are the previously sent HWMOD patches split into smaller pieces and with
improved commit messages.

I'm not sure if these are strictly needed to be sent for -rc. The DSS patches
9ede365aa6f74428a1f69c21ca1cf21213167576 ("HACK: OMAP: DSS2: clk hack for
OMAP2/3") and df5d3ed23cf73ee0763a8963003bda9b69d9620f ("OMAP: DSS2: HDMI: fix
hdmi clock name") already circumvent the problems with wrong clocks, and the
DSS reset problem on OMAP4 hasn't caused any actual runtime problems as far as
I know.

So while it'd be nice to remove the hack from omapdss driver and get rid of the
reset error print, it's up to you if you want these for -rc.

 Tomi

Tomi Valkeinen (9):
  OMAP2xxx: HWMOD: Fix DSS reset
  OMAP2xxx: HWMOD: fix DSS clock data
  OMAP3: HWMOD: Fix DSS reset
  OMAP3: HWMOD: fix DSS clock data
  OMAP4: HWMOD: remove extra clocks
  OMAP4: HWMOD: Add HWMOD_CONTROL_OPT_CLKS_IN_RESET for dss_core
  OMAP4: HWMOD: fix DSS clock data
  OMAP2/3: HWMOD: Add SYSS_HAS_RESET_STATUS for dss
  OMAP: HWMOD: Unify DSS resets for OMAPs

 arch/arm/mach-omap2/Makefile                       |    5 +--
 arch/arm/mach-omap2/display.c                      |   35 ++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |   15 +++++++-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |   15 +++++++-
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |    5 ++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   35 +++++++++++++++++--
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   18 +++-------
 arch/arm/plat-omap/include/plat/common.h           |    3 ++
 include/video/omapdss.h                            |    7 ----
 9 files changed, 106 insertions(+), 32 deletions(-)

-- 
1.7.4.1

