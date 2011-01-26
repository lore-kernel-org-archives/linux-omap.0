From: Sumit Semwal <sumit.semwal@ti.com>
Subject: [PATCH v2 0/3] OMAP4: hwmod DSS support
Date: Wed, 26 Jan 2011 09:53:41 +0530
Message-ID: <1296015824-3912-1-git-send-email-sumit.semwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34625 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101Ab1AZEYa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Jan 2011 23:24:30 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@ti.com, hvaibhav@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com
Cc: Sumit Semwal <sumit.semwal@ti.com>

This patch series enables support for OMAP4 DSS, and adds hwmod support
for dss, dispc, dsi1, dsi2, hdmi, rfbi and venc hwmods.

In OMAP4 there are severals IPs that can be reached by differents
interconnect paths depending of the access initiator (MPU vs. SDMA).

In the case of the DSS, both L3 direct path and L4 CFG path can be
used to access all the DSS IPs.
dss is also considered as an IP as dispc, rfbi, and named as dss_core.

TODO:
This patch doesn't handle the opt clocks via hwmod - there will be a separate
patch series which will take opt clock roles from hwmod, populate them in
the device structure, so that the driver can ask for relevant opt-clocks.

Also TBD is the migration to pm_runtime APIs, which need to be adapted a little
for handling DSS-family of clocks completely.

Changes from v1:
----------------
- dss_dss device is renamed as dss_core as per suggestion from Benoit Cousson.

Patch Base:
===========
Patch-set rebased and tested w/ Zoom3 (OMAP3630) on top of:
url = git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
branch "master"
commit	e8883f8057c0f7c9950fa9f20568f37bfa62f34a
Description: Add linux-next specific files for 20110115
+
Patch mentioned in http://www.mail-archive.com/linux-omap@vger.kernel.org/msg42384.html
[PATCH] OMAP: counter_32k: init clocksource as part of machine timer init
(This patch is required for OMAP bootup w/ 20110115 linux-next)
+
DSS hwmod patch series: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg42914.html
+
patch series: OMAP2PLUS: DSS: Generalize clock names
 (http://www.mail-archive.com/linux-omap@vger.kernel.org/msg43058.html)
--------------------------------------------------------


Benoit Cousson (1):
  OMAP4: hwmod data: add DSS DISPC DSI1,2 RFBI HDMI VENC

Mayuresh Janorkar (1):
  OMAP2PLUS: DSS2: Add OMAP4 support

Sumit Semwal (1):
  OMAP4: DSS2: Add hwmod device names for OMAP4.

 arch/arm/mach-omap2/display.c              |   21 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  588 ++++++++++++++++++++++++++++
 drivers/video/omap2/dss/Kconfig            |    6 +-
 drivers/video/omap2/omapfb/Kconfig         |    6 +-
 4 files changed, 608 insertions(+), 13 deletions(-)

