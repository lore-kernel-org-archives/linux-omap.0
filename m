From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 0/2] OMAP2+: hwmod: Add hwmod's API's for pad wakeup
Date: Fri, 6 May 2011 15:39:15 +0530
Message-ID: <1304676557-15613-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35219 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755892Ab1EFKOD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 May 2011 06:14:03 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org, "Govindraj.R" <govindraj.raja@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>

Add two API's to set IO Pad wakeup capability based on hwmod
mux pins available and also to check the status of IO Pad wakeup
event.

This two patches are separated from uart_runtime patches posted
earlier and uart_runtime adaptation relies on these two API's.

Based on 2.6.39-rc6

Reference to Discussion:
------------------------
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg49000.html
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg49001.html

Govindraj.R (2):
  OMAP2+: hwmod: Add API to enable IO ring wakeup.
  OMAP2+: hwmod: Add API to check IO PAD wakeup status

 arch/arm/mach-omap2/mux.c                     |   28 ++++++++++++++
 arch/arm/mach-omap2/mux.h                     |   13 +++++++
 arch/arm/mach-omap2/omap_hwmod.c              |   49 +++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap_device.h |    1 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    2 +
 arch/arm/plat-omap/omap_device.c              |   27 ++++++++++++++
 6 files changed, 120 insertions(+), 0 deletions(-)

