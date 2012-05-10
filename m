From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/3] ARM: OMAP2/3: DSS HWMOD fixes
Date: Thu, 10 May 2012 13:21:01 +0300
Message-ID: <1336645264-909-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:34793 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757805Ab2EJKVO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 06:21:14 -0400
Received: by lagy4 with SMTP id y4so916658lag.15
        for <linux-omap@vger.kernel.org>; Thu, 10 May 2012 03:21:11 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi,

These patches fix DSS hwmod data related to sysc flags. I haven't seen any
problem produced by these missing bits, but by looking at the TRM it's clear
that they should be defined.

However, applying these will cause additional warnings to show during boot:

omap_hwmod: dss_dispc: softreset failed (waited 10000 usec)
omap_hwmod: dss_rfbi: softreset failed (waited 10000 usec)

Most likely the softreset fails even now, but as there's no check to verify it,
no warnings are visible.

I think the reason for the failing softreset is the same problem as we have on
OMAP4: dss_core hwmod should be enabled before other dss hwmods can be enabled
(and reset).

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
1.7.9.5

