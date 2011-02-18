From: Felipe Balbi <balbi@ti.com>
Subject: [GIT PULL] USB patches
Date: Fri, 18 Feb 2011 09:35:13 +0200
Message-ID: <20110218073513.GW14574@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:43794 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753352Ab1BRHfT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Feb 2011 02:35:19 -0500
Received: by bwg12 with SMTP id 12so4730211bwg.40
        for <linux-omap@vger.kernel.org>; Thu, 17 Feb 2011 23:35:17 -0800 (PST)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

Hi Tony,

Here's a pull request for the changes we need to get into the upcoming
merge window. These have been tested overnight on pandaboard.

I also checked that it merges cleanly with your omap-for-linus branch.

The following changes since commit 85e2efbb1db9a18d218006706d6e4fbeb0216213:

  Linux 2.6.38-rc5 (2011-02-15 19:23:45 -0800)

are available in the git repository at:
  git://gitorious.org/usb/usb.git for-tony

Anand Gadiyar (2):
      arm: omap4: usb: explicitly configure MUSB pads
      arm: omap4: 4430sdp: drop ehci support

Hema HK (5):
      usb: musb: AM35x: moving internal phy functions out of usb_musb.c file
      OMAP2430: hwmod data: Add USBOTG
      OMAP3xxx: hwmod data: Add USBOTG
      AM35xx: hwmod data: Add USBOTG
      OMAP2+: musb: hwmod adaptation for musb registration

 arch/arm/mach-omap2/Makefile               |    3 +-
 arch/arm/mach-omap2/board-4430sdp.c        |   19 ---
 arch/arm/mach-omap2/board-am3517evm.c      |    4 +
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   98 +++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  166 +++++++++++++++++++++
 arch/arm/mach-omap2/omap_phy_internal.c    |   93 ++++++++++++
 arch/arm/mach-omap2/usb-musb.c             |  219 +++++++++++-----------------
 arch/arm/plat-omap/include/plat/usb.h      |    4 +
 8 files changed, 450 insertions(+), 156 deletions(-)

-- 
balbi
