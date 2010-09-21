From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH] OMAP: hwmod: softreset fixes with opt clocks
Date: Tue, 21 Sep 2010 18:57:57 +0200
Message-ID: <1285088279-425-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42144 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757838Ab0IUQ6j (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Sep 2010 12:58:39 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, p-basak2@ti.com, Benoit Cousson <b-cousson@ti.com>

Hi Paul,

Here are some fixes for the softreset issues that were highlighted
on some IPs like GPIO or DSS.

For the moment they are still based on your previous series:
git://git.pwsan.com/linux-2.6 hwmod_hardreset_dev

If you are OK with these, I'll rebase that on top of your latest submission to l-o / linux-arm-kernel.

Thanks,
Benoit


Benoit Cousson (2):
  OMAP: hwmod: Fix softreset for modules with optional clocks
  OMAP: hwmod: Fix softreset status check for some new OMAP4 IPs

 arch/arm/mach-omap2/omap_hwmod.c             |   73 ++++++++++++++++++++++----
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    8 +++-
 2 files changed, 70 insertions(+), 11 deletions(-)

