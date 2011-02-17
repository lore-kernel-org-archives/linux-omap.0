From: Felipe Balbi <balbi@ti.com>
Subject: [patch-v2.6.39 0/7] Patches for next merge window
Date: Thu, 17 Feb 2011 14:40:59 +0200
Message-ID: <1297946466-9565-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:51893 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753532Ab1BQMlL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 07:41:11 -0500
Received: by mail-bw0-f48.google.com with SMTP id 8so2854094bwz.21
        for <linux-omap@vger.kernel.org>; Thu, 17 Feb 2011 04:41:10 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

Hi Tony,

here are the patches for next merge window which I
have queued for you. A pull request is comming tomorrow.

All patches where boot tested on omap4430 pandaboard.

Anand Gadiyar (2):
  arm: omap4: usb: explicitly configure MUSB pads
  arm: omap4: 4430sdp: drop ehci support

Hema HK (5):
  OMAP2430: hwmod data: Add USBOTG
  OMAP3xxx: hwmod data: Add USBOTG
  AM35xx: hwmod data: Add USBOTG
  OMAP4430: hwmod data: Adding USBOTG
  OMAP2+: musb: hwmod adaptation for musb registration

 arch/arm/mach-omap2/board-4430sdp.c        |   19 ---
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   98 ++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  166 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   93 ++++++++++++++++
 arch/arm/mach-omap2/usb-musb.c             |  122 ++++++++++++++-------
 5 files changed, 440 insertions(+), 58 deletions(-)

-- 
1.7.4.rc2

