From: Kevin Hilman <khilman@ti.com>
Subject: [GIT PULL] OMAP: few more PM cleanup/fixes for v3.2
Date: Fri, 07 Oct 2011 14:03:14 -0700
Message-ID: <87sjn4jyzx.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:54821 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754510Ab1JGVDR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 17:03:17 -0400
Received: by mail-yw0-f48.google.com with SMTP id 3so4792917ywb.7
        for <linux-omap@vger.kernel.org>; Fri, 07 Oct 2011 14:03:16 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

Tony,

Please pull the (hopefully) last few PM fixes/cleanups for v3.2.

Kevin


The following changes since commit 976d167615b64e14bc1491ca51d424e2ba9a5e84:

  Linux 3.1-rc9 (2011-10-04 18:11:50 -0700)

are available in the git repository at:
  git://github.com/khilman/linux-omap-pm.git for_3.2/pm-cleanup-2

Charulatha V (1):
      ARM: OMAP3: PM: fix pwrdm_post_transition call sequence

Paul Walmsley (2):
      ARM: OMAP3: PM: fix I/O wakeup and I/O chain clock control detection
      ARM: OMAP3: PM: restrict erratum i443 handling to OMAP3430 only

 arch/arm/mach-omap2/id.c              |    5 ++-
 arch/arm/mach-omap2/pm34xx.c          |   70 +++++++++++++++++---------------
 arch/arm/plat-omap/include/plat/cpu.h |   17 ++++++--
 3 files changed, 53 insertions(+), 39 deletions(-)
