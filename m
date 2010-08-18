From: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: [PATCH 0/5] usb: omap: prepare for OMAP4 EHCI and OHCI support
Date: Wed, 18 Aug 2010 08:25:40 +0530
Message-ID: <1282100145-27485-1-git-send-email-keshava_mgowda@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34661 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753703Ab0HROzQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Aug 2010 10:55:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Keshava Munegowda <keshava_mgowda@ti.com>

This series does minor code cleanup in preparation of an upcoming
series to add support for EHCI and OHCI on the OMAP4 SoC.

The changes are:
- Rename clock names to be consistent across OMAP3 and OMAP4
- Remove hardcoding of the number of TLL channels
- Move PHY reset earlier in the init sequence

These patches do not make any changes to existing functionalities.

Diffstat is below:

drivers/usb/host/ehci-omap.c                   |  104 ++++++++++++-------------
drivers/usb/host/ohci-omap3.c                  |   55 ++++++-------
2 files changed
---
Keshava
