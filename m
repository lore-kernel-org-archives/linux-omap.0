From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 0/3] watchdog fixes
Date: Tue, 23 Sep 2008 14:33:48 +0300
Message-ID: <1222169631-24556-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:35134 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbYIWLeY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Sep 2008 07:34:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>, Felipe Balbi <felipe.balbi@nokia.com>

Hi Tony,

following we have omap versions of the watchdog patches.

As you can see in [1], they're already applied to Wim's
tree and in fact, you only need the first patch from this
series; the others can be fetched from Wim.

Felipe Balbi (3):
  watchdog: sync mainline changes
  watchdog: another ioremap() fix
  watchdog: cleanup a bit omap_wdt.c

 drivers/watchdog/omap_wdt.c |  223 +++++++++++++++++++++++++------------------
 1 files changed, 132 insertions(+), 91 deletions(-)

