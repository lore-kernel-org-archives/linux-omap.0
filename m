From: Nishanth Menon <nm@ti.com>
Subject: [pm_wip/voltdm_nm][PATCH v2 0/4] OMAP4: PM: Voltage cleanups
Date: Sun, 29 May 2011 16:19:37 -0700
Message-ID: <1306711180-8631-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:50617 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751693Ab1E2XTq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 29 May 2011 19:19:46 -0400
Received: by mail-gx0-f177.google.com with SMTP id 2so1536129gxk.36
        for <linux-omap@vger.kernel.org>; Sun, 29 May 2011 16:19:45 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin <khilman@ti.com>, Nishanth Menon <nm@ti.com>

The following patches are on top of:
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
branch: pm-wip/voltdm_nm

Tested on: SDP4430

This is v2 of the series (of which most of the patches were incorporated)
Dropped patches:
	http://marc.info/?l=linux-omap&m=130570864519114&w=2
		- Agree that we should wait for regulators
Pending:
	http://marc.info/?l=linux-omap&m=130569587107997&w=2
		- I have a bunch of scope pictures and xls
		 from which this data was created, so no equation yet available.
Updated patches:
	http://marc.info/?l=linux-omap&m=130569587007994&w=2 - review comments

v1: http://marc.info/?l=linux-omap&m=130569586007964&w=2

Nishanth Menon (3):
  OMAP4: PM: VC: fix channel bit offset for MPU
  OMAP4: PM: VC: introduce concept of default channel
  OMAP4: PM: VC: make omap_vc_i2c_init static

 arch/arm/mach-omap2/vc.c          |   82 ++++++++++++++++++++++---------------
 arch/arm/mach-omap2/vc.h          |   37 +++++++++++++++-
 arch/arm/mach-omap2/vc3xxx_data.c |   11 +++++
 arch/arm/mach-omap2/vc44xx_data.c |   22 ++++++++++
 arch/arm/mach-omap2/voltage.h     |    9 ++++
 5 files changed, 125 insertions(+), 36 deletions(-)

Regards,
	Nishanth Menon
