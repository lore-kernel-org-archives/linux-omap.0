From: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Subject: [PATCH 0/1] RX-51: add full regulator definitions
Date: Fri, 29 Apr 2011 15:47:43 +0300
Message-ID: <1304081264-4915-1-git-send-email-kalle.jokiniemi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:19255 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757472Ab1D2Msq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Apr 2011 08:48:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: sakari.ailus@nokia.com, linux-omap@vger.kernel.org, lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com, Kalle Jokiniemi <kalle.jokiniemi@nokia.com>

Adding regulator definitions to correctly shut down unneeded
regulators. Needed, but previously undefined regulators were
marked "always_on".

Tested on top of MeeGo N900 DE daily release (.37 kernel) and
with linux-omap. Patch based on linux-omap HEAD.

Kalle Jokiniemi (1):
  OMAP3: rx-51: Add full regulator definitions

 arch/arm/mach-omap2/board-rx51-peripherals.c |   75 ++++++++++++++++++++++++++
 1 files changed, 75 insertions(+), 0 deletions(-)

