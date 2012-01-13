From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH RFC/RFT] mmc : updates
Date: Fri, 13 Jan 2012 14:13:11 +0530
Message-ID: <1326444194-13414-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41526 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754722Ab2AMInV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Jan 2012 03:43:21 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Shubhrajyoti D <shubhrajyoti@ti.com>

This patch series is untested from the mmc point of view.
While testing some other modules on OMAP4 random behavior
crash/hang was observed.
The patch 3 [remove pm_runtime_get_sync/put sync from
    suspend/resume ]
Fixed the echo mem > /sys/power/state


This patchset does the following
- remove pm_runtime_get_sync/put sync from
    suspend/resume. 
- does some cleanup of the flags used.

remove pm_runtime_get_sync/put sync from
    suspend/resume


Shubhrajyoti D (3):
  mmc: omap_hsmmc : Make the suspend/resume functions depend on
    CONFIG_PM_SLEEP
  mmc: omap_hsmmc : Clean up the runtime suspend/resume
  omap : hsmmc : remove pm_runtime_get_sync/put sync from
    suspend/resume

 drivers/mmc/host/omap_hsmmc.c |  199 ++++++++++++++++++----------------------
 1 files changed, 90 insertions(+), 109 deletions(-)

