From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 0/7] clock/dpll autoidle support
Date: Thu, 10 Feb 2011 14:46:33 +0530
Message-ID: <1297329400-5936-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40985 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753918Ab1BJJQx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Feb 2011 04:16:53 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, b-cousson@ti.com, khilman@ti.com, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

OMAP has various clock nodes and dpll's
which support hardware level autoidle.
Enabling hardware level autoidle provides
better power savings without much software
intervention.

This series does the following to help enable
hardware level autoidling using clock framework
for some of these nodes on OMAP3 and OMAP4

-1- Adds support for providing function pointers
for enabling/disabling autoidle in clkops
-2- Populates these in clkops for all OMAP3/4 dplls
-3- Enables all dpll autoidle late in boot on OMAP3 and OMAP4
-4- Adds support for mx postdivider autoidle (present
only on OMAP4) and enables it late in OMAP4 boot

Some of the patches in this series were earlier posted
and discussed as part of another series here
http://marc.info/?l=linux-omap&m=129681356402594&w=2
They are now posted as a seperate series as discussed
here
http://marc.info/?l=linux-omap&m=129713867702170&w=2

The patches are boot tested on OMAP3430sdp and
OMAP4430sdp.

The following changes since commit 100b33c8bd8a3235fd0b7948338d6cbb3db3c63d:
  Linus Torvalds (1):
        Linux 2.6.38-rc4

are available in the git repository at:

 git://gitorious.org/omap-pm/linux.git dpll-autoidle-v2

Changes in v2:
-1- Added support for clkout_x2 autogating
-2- Populated dpll_usb_clkdcoldo_ck's missing
clksel register

Rajendra Nayak (7):
  omap: clock: Check for enable/disable ops support
  omap3: dpll: Populate clkops for dpll1_ck
  omap: clock: Add allow_idle/deny_idle support in clkops
  omap: dpll: Add allow_idle/deny_idle support for all DPLL's
  omap: dpll: Enable all OMAP3/4 dpll autoidle late at boot
  omap4: dpll: Add dpll api to control GATE_CTRL
  omap4: dpll: Enable auto gate control for all MX postdividers

 arch/arm/mach-omap2/clock.c             |   25 +++++++++++---
 arch/arm/mach-omap2/clock.h             |    5 +++
 arch/arm/mach-omap2/clock3xxx_data.c    |    4 +-
 arch/arm/mach-omap2/clock44xx_data.c    |   54 +++++++++++++++++------------
 arch/arm/mach-omap2/dpll3xxx.c          |   57 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm34xx.c            |   18 ++-------
 arch/arm/mach-omap2/pm44xx.c            |    4 ++
 arch/arm/plat-omap/clock.c              |   26 ++++++++++++++
 arch/arm/plat-omap/include/plat/clock.h |    7 ++++
 9 files changed, 156 insertions(+), 44 deletions(-)

