From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/3] musb_hdrc: Clean-up init code for mainline merge
Date: Thu, 12 Feb 2009 11:16:44 -0800
Message-ID: <20090212191408.19766.62874.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59428 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127AbZBLTQq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Feb 2009 14:16:46 -0500
Received: from c-69-181-40-92.hsd1.ca.comcast.net ([69.181.40.92] helo=[127.0.0.1])
	by mho-01-bos.mailhop.org with esmtpa (Exim 4.68)
	(envelope-from <tony@atomide.com>)
	id 1LXh3F-000FPD-Am
	for linux-omap@vger.kernel.org; Thu, 12 Feb 2009 19:16:45 +0000
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hi Felipe & Dave,

While creating a patch for usb-musb.c init code for mainline
kernel, I ended up cleaning up following stuff in the l-o tree.

Does it look OK to you?

Regards,

Tony 

---

Tony Lindgren (3):
      musb_hdrc: Build usb-musb based on config entry, clean-up Makefile
      musb_hdrc: Clean-up MUSB init code for next merge window
      musb_hdrc: Set musb_resources dynamically


 arch/arm/mach-omap2/Makefile               |   17 +++++---------
 arch/arm/mach-omap2/board-2430sdp.c        |    2 +-
 arch/arm/mach-omap2/board-3430sdp.c        |    2 +-
 arch/arm/mach-omap2/board-ldp.c            |    2 +-
 arch/arm/mach-omap2/board-omap3beagle.c    |    2 +-
 arch/arm/mach-omap2/board-omap3evm.c       |    2 +-
 arch/arm/mach-omap2/board-omap3pandora.c   |    2 +-
 arch/arm/mach-omap2/board-overo.c          |    2 +-
 arch/arm/mach-omap2/board-rx51.c           |    2 +-
 arch/arm/mach-omap2/usb-musb.c             |   28 ++++++++++------------
 arch/arm/plat-omap/include/mach/usb-musb.h |   35 ----------------------------
 arch/arm/plat-omap/include/mach/usb.h      |   11 +++++++--
 12 files changed, 35 insertions(+), 72 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/mach/usb-musb.h

-- 
Signature
