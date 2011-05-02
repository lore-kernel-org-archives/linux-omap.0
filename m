From: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Subject: [PATCH v2 0/1] RX-51: add full regulator definitions
Date: Mon,  2 May 2011 09:28:52 +0300
Message-ID: <1304317733-9639-1-git-send-email-kalle.jokiniemi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:51851 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754636Ab1EBG3q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 May 2011 02:29:46 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: broonie@opensource.wolfsonmicro.com, jhnikula@gmail.com, linux-omap@vger.kernel.org, Kalle Jokiniemi <kalle.jokiniemi@nokia.com>

Adding regulator definitions to correctly shut down unneeded
regulators. Needed, but previously undefined regulators were
marked "always_on".

Tested on top of MeeGo N900 DE daily release (.37 kernel) and
with linux-omap. Patch based on linux-omap HEAD.

v2: updated as per comments from Jarkko Nikula and Mark Brown.

Kalle Jokiniemi (1):
  OMAP3: rx-51: Add full regulator definitions

 arch/arm/mach-omap2/board-rx51-peripherals.c |   69 ++++++++++++++++++++++++++
 1 files changed, 69 insertions(+), 0 deletions(-)

