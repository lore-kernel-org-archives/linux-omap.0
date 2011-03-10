From: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Subject: [PATCH 0/2] OMAP3: wdtimer: fix wdtimer blocking CORE idle
Date: Thu, 10 Mar 2011 11:32:47 +0200
Message-ID: <1299749569-22673-1-git-send-email-kalle.jokiniemi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:17645 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751054Ab1CJJej (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Mar 2011 04:34:39 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, khilman@ti.com, linux-omap@vger.kernel.org
Cc: ilkka.koskinen@nokia.com, jhnikula@gmail.com, b-cousson@ti.com, Kalle Jokiniemi <kalle.jokiniemi@nokia.com>

Currently the wdtimer2 active usage blocks CORE idle transitions.
This patch set fixes the issue by changing the wdtimer sidlemode
form smart idle to force idle.

Improvements were needed to omap_hwmod sysconfig configuration
mechanism to allow this setting.

Kalle Jokiniemi (2):
  OMAP: hw_mod: consider supported idlemodes in enable_sysc
  OMAP3: wdtimer: Disable SMART idle mode

 arch/arm/mach-omap2/omap_hwmod.c           |   28 ++++++++++++++++++++--------
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    7 +++++--
 2 files changed, 25 insertions(+), 10 deletions(-)

