From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 0/3] OMAP: add runtime PM support at bus-level
Date: Wed, 23 Jun 2010 16:37:01 -0700
Message-ID: <1277336224-24826-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:43062 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753287Ab0FWXhH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jun 2010 19:37:07 -0400
Received: by pvg2 with SMTP id 2so110112pvg.19
        for <linux-omap@vger.kernel.org>; Wed, 23 Jun 2010 16:37:06 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

This series introduces runtime PM support at the platform bus level
for OMAP.

In a nutshell, when using the runtime PM API for any device with an
assocated omap_device (and hwmod), the omap device API will be used to
handle the hardware-level power management of that device, including
managing clocks, etc.

Today, most drivers handle this by manually enabling/disabling their
clocks when needed.  With this series (and an omap_device/hwmod for
each device) direct clock managment can be removed from the driver in
favor of using the runtime PM API.

This series applies on top v2.6.35-rc2 + Tony's omap-fixes branch and
is also available in the pm-wip/runtime branch of my linux-omap-pm git
tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git

Kevin Hilman (3):
  OMAP: PM: initial runtime PM core support
  OMAP: PM: use omap_device API for suspend/resume
  OMAP1: PM: add simple runtime PM layer to manage clocks

 arch/arm/mach-omap1/Makefile |    2 +-
 arch/arm/mach-omap1/pm_bus.c |   77 ++++++++++++++++++++++++
 arch/arm/mach-omap2/Makefile |    7 ++-
 arch/arm/mach-omap2/pm_bus.c |  133 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 217 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-omap1/pm_bus.c
 create mode 100644 arch/arm/mach-omap2/pm_bus.c

