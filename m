From: Jani Nikula <ext-jani.1.nikula@nokia.com>
Subject: [PATCH v3 00/21] OMAP: DSS2: Taal panel driver updates
Date: Wed,  5 May 2010 17:27:20 +0300
Message-ID: <cover.1273067195.git.ext-jani.1.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:64967 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934647Ab0EEO15 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 10:27:57 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi.Valkeinen@nokia.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, ext-jani.1.nikula@nokia.com

Hi -

This set of patches, on top of [1], contains assorted fixes and cleanups to the
Taal panel driver (01-14), configures board/platform specific things in a new
Nokia DSI command mode panel specific struct instead of DSS structs (15-17), and
makes it feasible to add support for similar DSI command mode panels in the same
driver (18-21).

v3: 
- patch 01: move taal_hw_reset() earlier than request_irq() in probe to be ready
  to handle the irqs
- patch 07: add panel enabled check also to taal_enable_te(), not just
  taal_run_test()

v2:
- No functional changes since v1, just filled in some missing commit messages
  (thanks Tony for your feedback!)

[1] git://gitorious.org/linux-omap-dss2/linux.git

BR,
Jani.


Jani Nikula (20):
  OMAP: DSS2: Taal: Add panel hardware reset
  OMAP: DSS2: Taal: Add locks to protect taal data access
  OMAP: DSS2: Taal: Cosmetic improvement to backlight properties
    initialization
  OMAP: DSS2: Taal: Remove platform enable/disable
  OMAP: DSS2: Taal: Fix request_irq() error handling
  OMAP: DSS2: Taal: Remove ESD work cancel from driver probe error
    handling
  OMAP: DSS2: Taal: Improve taal_power_on() error handling
  OMAP: DSS2: Taal: Ensure panel is enabled in enable_te() and
    run_test()
  OMAP: DSS2: Taal: Change DSI bus locking to avoid deadlock in ESD
    work
  OMAP: DSS2: Taal: Check taal_power_on() return value in taal_resume()
  OMAP: DSS2: Taal: Change ESD work management
  OMAP: DSS2: Taal: Change probe error handling labels
  OMAP: DSS2: Taal: Add proper external TE support
  OMAP: DSS2: Add Nokia DSI command mode panel configuration struct
  OMAP: DSS2: Taal: Use Nokia DSI panel data
  OMAP: DSS2: Taal: Configure ESD check in DSI panel data
  OMAP: DSS2: Taal: Add panel specific configuration structure
  OMAP: DSS2: Taal: Print panel name in addition to revision
  OMAP: DSS2: Taal: Add regulator configuration support
  OMAP: DSS2: Taal: CABC workaround is Taal specific

Valkeinen Tomi (Nokia-D/Helsinki) (1):
  OMAP: DSS2: Taal: add locks to taal_bl_update_status

 arch/arm/plat-omap/include/plat/nokia-dsi-panel.h |   31 ++
 drivers/video/omap2/displays/panel-taal.c         |  552 ++++++++++++++++-----
 2 files changed, 463 insertions(+), 120 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/nokia-dsi-panel.h

