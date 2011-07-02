From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 0/2 v4] OMAP2+: hwmod: Add hwmod's API's for pad wakeup
Date: Sat, 2 Jul 2011 16:22:24 +0530
Message-ID: <1309603946-25395-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56661 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754442Ab1GBKxH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 2 Jul 2011 06:53:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>

Add two API's to set IO Pad wakeup capability based on hwmod
mux pins available and also to check the status of IO Pad wakeup
event.

This two patches are separated from uart_runtime patches posted
earlier and uart_runtime adaptation relies on these two API's.

Rebased on 3.0-rc5

Changes from v3:
---------------
Hooked up enable/disable io-ring to hwmod enable/disable

Changes from v2:
---------------
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg49194.html

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

 arch/arm/mach-omap2/mux.c                    |   30 ++++++++++++
 arch/arm/mach-omap2/mux.h                    |   13 +++++
 arch/arm/mach-omap2/omap_hwmod.c             |   66 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 4 files changed, 110 insertions(+), 0 deletions(-)

-- 
1.7.4.1

