From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/2] OMAP: Panda DVI fix and a cleanup
Date: Tue, 23 Jul 2013 12:06:43 +0300
Message-ID: <1374570405-8301-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34624 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752910Ab3GWJHa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Jul 2013 05:07:30 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi Tony,

Here's a fix for 3.11 that makes EDID read for DVI work again.

I also included a cleanup patch that removes the non-DT support functions that
are no longer called from anywhere. It's not a fix, but as we're in quite early
rcs, I thought it would be nice to remove the dead code.

Up to you if you want to include that one for 3.11 or not. If not, I'll include
it in a board file series for 3.12 that I'll send soon.

 Tomi

Tomi Valkeinen (2):
  ARM: OMAP: dss-common: fix Panda's DVI DDC channel
  ARM: OMAP2+: Remove legacy DSS initialization for omap4

 arch/arm/mach-omap2/dss-common.c | 49 +---------------------------------------
 arch/arm/mach-omap2/dss-common.h |  2 --
 2 files changed, 1 insertion(+), 50 deletions(-)

-- 
1.8.1.2

