From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 0/2 v2] OMAP2+: hwmod: Add hwmod's API's for pad wakeup
Date: Mon, 9 May 2011 18:05:28 +0530
Message-ID: <1304944530-12998-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40294 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342Ab1EIMi4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 May 2011 08:38:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, "Govindraj.R" <govindraj.raja@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>

Add two API's to set IO Pad wakeup capability based on hwmod
mux pins available and also to check the status of IO Pad wakeup
event.

This two patches are separated from uart_runtime patches posted
earlier and uart_runtime adaptation relies on these two API's.

Based on 2.6.39-rc6

Changes from v1:
---------------
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg49141.html

Reference to Discussion:
------------------------
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg49000.html
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg49001.html

Govindraj.R (2):
  OMAP2+: hwmod: Add API to enable IO ring wakeup.
  OMAP2+: hwmod: Add API to check IO PAD wakeup status

 arch/arm/mach-omap2/mux.c                     |   28 +++++++++++
 arch/arm/mach-omap2/mux.h                     |   13 +++++
 arch/arm/mach-omap2/omap_hwmod.c              |   65 +++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap_device.h |    2 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h  |    4 ++
 arch/arm/plat-omap/omap_device.c              |   50 +++++++++++++++++++
 6 files changed, 162 insertions(+), 0 deletions(-)

