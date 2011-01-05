From: Sumit Semwal <sumit.semwal@ti.com>
Subject: [PATCH 0/3] OMAP4: DSS OMAP4 hwmod support
Date: Wed,  5 Jan 2011 23:14:01 +0530
Message-ID: <1294249444-11951-1-git-send-email-sumit.semwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37711 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751312Ab1AERoR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Jan 2011 12:44:17 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@deeprootsystems.com, hvaibhav@ti.com, linux-omap@vger.kernel.org
Cc: Sumit Semwal <sumit.semwal@ti.com>

This patch series enables support for OMAP4 DSS, and adds hwmod support
for dss, dispc, dsi1, dsi2, hdmi, rfbi and venc hwmods.

In OMAP4 there are severals IPs that can be reached by differents
interconnect paths depending of the access initiator (MPU vs. SDMA).

In the case of the DSS, both L3 direct path and L4 CFG path can be
used to access all the DSS IPs.
dss is also considered as an IP as dispc, rfbi, and named as dss_dss.

TODO:
This patch doesn't handle the opt clocks via hwmod - there will be a separate
patch series which will take opt clock roles from hwmod, populate them in
the device structure, so that the driver can ask for relevant opt-clocks.

Also TBD is the migration to pm_runtime APIs, which need to be adapted a little
for handling DSS-family of clocks completely.

Patch Base:
===========
url = git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
branch "master"
Commit id: fa3b4e23ec20cfc944db7cc2b30b0d82c20e4472
Description:  cbus: Fix retu_rtc_do_reset
+
hwmod patches under discussion: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41534.html
+
patch series: OMAP2PLUS: DSS: Generalize clock names
--------------------------------------------------------

Benoit Cousson (1):
  OMAP4: hwmod data: add DSS DISPC DSI1,2 RFBI HDMI VENC

Mayuresh Janorkar (1):
  OMAP2PLUS: DSS2: Add OMAP4 support

Sumit Semwal (1):
  OMAP4: DSS2: Add hwmod device names for OMAP4.

 arch/arm/mach-omap2/display.c              |   23 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  588 ++++++++++++++++++++++++++++
 drivers/video/omap2/dss/Kconfig            |    6 +-
 drivers/video/omap2/omapfb/Kconfig         |    6 +-
 4 files changed, 609 insertions(+), 14 deletions(-)

