From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 0/4] CBUS patches (v2)
Date: Fri,  1 Oct 2010 15:33:35 +0300
Message-ID: <1285936419-28426-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44071 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495Ab0JAMdm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Oct 2010 08:33:42 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Tony,

Now CBUS patches changing also n770. Sorry about the previous
version. I was too quick when thinking a non-functional change
couldn't possibly be wrong hehe :-p

At least know, the patches look better. Below is pull request
too if you prefer to pull into your cbus branch:

***** Note: compilation of nokia770 doesn't work, so I couldn't even compile
***** test these patches against that board :-(

The following changes since commit 2365f1f7e5544b531ccd3e07fd06bb12bf7a62a7:

  Linux-omap rebuilt: Updated to v2.6.36-rc6, merged in few more patches (2010-09-29 11:19:10 -0700)

are available in the git repository at:

  git://gitorious.org/usb/usb.git cbus

Felipe Balbi (4):
      cbus: remove unneded includes
      cbus: retu: move platform_device to board file
      cbus: tahvo: move platform_device to board file
      cbus: tahvo-usb: move platform_device to board file

 arch/arm/mach-omap1/board-nokia770.c |   72 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-n8x0.c     |   68 ++++++++++++++++++++++++++++++++
 drivers/cbus/cbus.c                  |    5 --
 drivers/cbus/retu.c                  |   69 +--------------------------------
 drivers/cbus/tahvo-usb.c             |   15 +------
 drivers/cbus/tahvo.c                 |   63 +-----------------------------
 6 files changed, 144 insertions(+), 148 deletions(-)

-- 
1.7.3.rc0.35.g8ac8c

