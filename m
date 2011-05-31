From: Nishanth Menon <nm@ti.com>
Subject: [pm_wip/voltdm_nm][PATCH 0/2] OMAP3+: PM: Support multiple PMICs
Date: Tue, 31 May 2011 02:33:50 -0500
Message-ID: <1306827232-27728-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:47613 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751368Ab1EaHd6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 May 2011 03:33:58 -0400
Received: by mail-yw0-f41.google.com with SMTP id 1so2120707ywa.14
        for <linux-omap@vger.kernel.org>; Tue, 31 May 2011 00:33:57 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin Hilman <khilman@ti.com>, Nishanth Menon <nm@ti.com>

Hi,
This series is a precursor to OMAP4460 support which uses 2 PMICs hence
requiring a slight reorganization of our data. This subject has been brought
up previously in the list as well, this work hopefully will get wider set of
platforms to mainline with power management support.

The following patches are on top of:
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
branch: pm-wip/voltdm_nm

NOTE: This probably has a minor conflict with the following applied.
http://marc.info/?l=linux-omap&m=130672316613644&w=2

Nishanth Menon (2):
  OMAP3+: PM: VP: use uV for max and min voltage limits
  OMAP3+: PM: introduce a central pmic control

 arch/arm/mach-omap2/Makefile    |    2 +-
 arch/arm/mach-omap2/omap_pmic.c |   74 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_twl.c  |  104 +++++++++++++++++----------------------
 arch/arm/mach-omap2/pm.c        |    5 +-
 arch/arm/mach-omap2/pm.h        |   35 +++++++++++--
 arch/arm/mach-omap2/voltage.h   |   27 +++++++++-
 arch/arm/mach-omap2/vp.c        |    4 +-
 7 files changed, 178 insertions(+), 73 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap_pmic.c

 Regards,
 Nishanth Menon
