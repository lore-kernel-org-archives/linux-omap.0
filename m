From: Felipe Balbi <me@felipebalbi.com>
Subject: [PULL REQUEST] arm omap patches for -next merge window
Date: Wed, 30 Dec 2009 01:01:37 +0200
Message-ID: <1262127697.28789.92.camel@gandalf>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:50618 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbZL2XBl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Dec 2009 18:01:41 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org

After these, all the patches I have for you are
done, besides the CBUS stuff which I want to test
further. DSME is turning off my device right after
boot so I can't really test anything. If you have
some hint, I'd be glad to hear ;-)

The following changes since commit
bb65718ad7ed3c4231f67cf3f8b4a9a071bdfd53:
  Felipe Balbi (1):
        arm: omap: perseus: kill compile warning on board-perseus2.c

are available in the git repository at:

  git://gitorious.org/usb/usb.git for-tony-next

Felipe Balbi (9):
      arm: omap: musb: remove unused data
      arm: omap: musb: we can use clk framework
      arm: omap: musb: remove unused soft_con field
      arm: omap: musb: remove unused dma data
      arm: omap: musb: remove unnecessary return
      arm: omap: gpmc: avoid section definitions on headers
      usb: musb: use only clk framework for clk handling
      arm: omap: musb: do not pass clock name to driver
      arm: omap: musb: get rid of dyn_fifo

 arch/arm/mach-omap2/usb-musb.c         |   71
+-------------------------------
 arch/arm/plat-omap/include/plat/gpmc.h |    2 +-
 drivers/usb/musb/musb_core.c           |   48 +++++++--------------
 drivers/usb/musb/musb_core.h           |    2 -
 drivers/usb/musb/omap2430.c            |   10 +----
 drivers/usb/musb/tusb6010.c            |   16 +++----
 include/linux/usb/musb.h               |    4 +-
 7 files changed, 28 insertions(+), 125 deletions(-)

-- 
balbi

