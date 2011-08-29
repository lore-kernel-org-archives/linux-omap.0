From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 00/12] OMAP: voltage cleanup part C: VP cleanup
Date: Mon, 29 Aug 2011 10:58:00 -0700
Message-ID: <1314640692-3386-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:42795 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754085Ab1H2R5p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Aug 2011 13:57:45 -0400
Received: by gyf3 with SMTP id 3so6676245gyf.17
        for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 10:57:44 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

This series focuses on cleanup and better abstraction in the voltage
processor (VP) layer.

Available in the pm-wip/voltdm_c branch of my linux-omap-pm tree
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git

Applies on v3.1-rc3 + the part A & B series.

Kevin


Kevin Hilman (11):
  OMAP3+: VP: cleanup: move VP instance into voltdm, misc. renames
  OMAP3+: voltage: remove unneeded debugfs interface
  OMAP3+: VP: struct omap_vp_common: replace shift with __ffs(mask)
  OMAP3+: VP: move SoC-specific sys clock rate retreival late init
  OMAP3+: VP: move timing calculation/config into VP init
  OMAP3+: VP: create VP helper function for updating error gain
  OMAP3+: VP: remove omap_vp_runtime_data
  OMAP3+: VP: move voltage scale function pointer into struct
    voltagedomain
  OMAP3+: VP: update_errorgain(): return error if VP
  OMAP3+: VP: remove unused omap_vp_get_curr_volt()
  OMAP3+: VP: combine setting init voltage into common function

Todd Poynor (1):
  OMAP: VP: Explicitly mask VPVOLTAGE field

 arch/arm/mach-omap2/smartreflex.c             |   29 ++-
 arch/arm/mach-omap2/vc.c                      |   22 +--
 arch/arm/mach-omap2/voltage.c                 |  161 ++------------
 arch/arm/mach-omap2/voltage.h                 |   24 +--
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |   18 +-
 arch/arm/mach-omap2/voltagedomains44xx_data.c |   23 ++-
 arch/arm/mach-omap2/vp.c                      |  292 +++++++++----------------
 arch/arm/mach-omap2/vp.h                      |   91 +++-----
 arch/arm/mach-omap2/vp3xxx_data.c             |   16 +-
 arch/arm/mach-omap2/vp44xx_data.c             |   19 +-
 10 files changed, 226 insertions(+), 469 deletions(-)

-- 
1.7.6

