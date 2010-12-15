From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 0/6] OMAP: hwmod core fix and cleanup for 2.6.38
Date: Wed, 15 Dec 2010 15:49:21 +0100
Message-ID: <1292424567-25794-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42805 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754443Ab0LOOtp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Dec 2010 09:49:45 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, Benoit Cousson <b-cousson@ti.com>

Hi Paul,

Here is a small series that just remove the omap_hwmod_mutex
and move functions not needed at runtime to the __init section.

It fix as well a bug discovered during the on-going hwmod migration
of device that does have a functional clock external (mcpdm).

It extends as well the fix Kevin did for wakeup for OMAP4 IP with
smart idle with wakeup support. 

The series is based on my for_2.6.38/hwmod_data branch and is available 
here: git://gitorious.org/omap-pm/linux.git for_2.6.38/hwmod

Tested on sdp4430 ES2.0 with omap2plus_defconfig.
It still requires some test on OMAP3 and OMAP2.

Thanks to Seb Guiriec for testing the SIDLE_SMART_WKUP fix.

Regards,
Benoit


Changes since v1:
    http://www.spinics.net/lists/linux-omap/msg40580.html:
    - Add SIDLE_SMART_WKUP flag support for OMAP4


Benoit Cousson (5):
  OMAP2+: hwmod: Make omap_hwmod_register private and remove omap_hwmod_unregister
  OMAP2+: hwmod: Mark functions used only during initialization with __init
  OMAP2+: hwmod: Remove omap_hwmod_mutex
  OMAP2+: hwmod: Add wakeup support for new OMAP4 IPs
  OMAP4: hwmod data: Add SIDLE_SMART_WKUP modes to several IPs

Rajendra Nayak (1):
  OMAP2+: hwmod: Disable clocks when hwmod enable fails

 arch/arm/mach-omap2/omap_hwmod.c             |  172 +++++++++++---------------
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |   12 ++-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    7 +-
 3 files changed, 82 insertions(+), 109 deletions(-)

