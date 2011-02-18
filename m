From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v6 0/4] omap: mailbox: hwmod support
Date: Thu, 17 Feb 2011 19:42:23 -0600
Message-ID: <1297993347-5654-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42677 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318Ab1BRBxw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Feb 2011 20:53:52 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Sourav Poddar <sourav.poddar@ti.com>, lo <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>, Omar Ramirez Luna <omar.ramirez@ti.com>

Mailbox hwmod support for OMAP 2,3,4.

This was tested on OMAP3 (3430, 3630) by using
tidspbridge and OMAP4 (blaze). Also using Kevin's
mailbox test: http://bit.ly/fdk8Au 

No testing on OMAP2 since I don't have the hardware.

Changes on v6 include:
- Dropping OMAP4 hwmod patch, as Benoit already sent it.
- Removing irq names in hwmod data for single irq, changed
  mailbox to use platform_request_irq in these cases.
- Moved ick to be the main_clk so it can be disabled on
  pm_runtime_put_sync.

Highlights from v5 include the comments received from
previous version v4 (http://bit.ly/gfLaIs)

Felipe Contreras (2):
  OMAP3: hwmod data: add mailbox data
  OMAP: mailbox: build device using omap_device/omap_hwmod

Omar Ramirez Luna (2):
  OMAP2: hwmod data: add mailbox data
  OMAP: mailbox: use runtime pm for clk and sysc handling

 arch/arm/mach-omap2/devices.c              |   98 +++++-----------------------
 arch/arm/mach-omap2/mailbox.c              |   72 ++------------------
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   73 +++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   72 ++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   71 ++++++++++++++++++++
 5 files changed, 240 insertions(+), 146 deletions(-)

