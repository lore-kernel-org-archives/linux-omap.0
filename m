From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 0/4] OMAP: hwmod core fix and cleanup for 2.6.38
Date: Mon, 22 Nov 2010 09:50:56 +0100
Message-ID: <1290415860-15632-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40128 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751940Ab0KVIvH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Nov 2010 03:51:07 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Hi Paul,

Here is a small series that just remove the omap_hwmod_mutex
and move functions not needed at runtime to the __init section.

It fix as well a bug discovered during the on-going hwmod migration
of device that does have a functional clock external (mcpdm).


The series is based on mainline (2.6.37-rc2) and is available here:
git://gitorious.org/omap-pm/linux.git for_2.6.38/hwmod

Tested on SDP4430 ES2.0 with omap2plus_defconfig.
It still requires some test on OMAP3 and OMAP2.

Regards,
Benoit


Benoit Cousson (3):
  OMAP: hwmod: Make omap_hwmod_register private and remove omap_hwmod_unregister
  OMAP: hwmod: Mark functions used only during initialization with __init
  OMAP: hwmod: Remove omap_hwmod_mutex

Rajendra Nayak (1):
  OMAP: hwmod: Disable clocks when hwmod enable fails

 arch/arm/mach-omap2/omap_hwmod.c             |  152 +++++++++-----------------
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 -
 2 files changed, 54 insertions(+), 100 deletions(-)

