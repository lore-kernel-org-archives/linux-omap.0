From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 0/6] OMAP: DSS: porting old drivers to DSS2 (board files part)
Date: Mon, 12 Sep 2011 14:20:42 +0300
Message-ID: <1315826448-27891-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:35869 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750835Ab1ILLU6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Sep 2011 07:20:58 -0400
Received: by mail-bw0-f53.google.com with SMTP id zt12so1943242bkb.40
        for <linux-omap@vger.kernel.org>; Mon, 12 Sep 2011 04:20:56 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

This patch set ports all the OMAP2/3 boards, except N8x0, that use the old
omapfb to use the newer DSS2 driver. Only board files are changed, the panel
driver additions are done in separate patch set. Applying this set without the
driver changes will obviously disable the displays of the affected boards until
the drivers are also merged.

Some board files contained old omapfb code, but there wasn't a matching LCD
driver. That board file code is also removed.

Porting N800 driver is more complicated, as the blizzard chip driver is quite
big and includes features that cannot be supported in DSS2 currently. I will
post patches for that later.

I don't have any of the boards touched by these patches, so testing is
appreciated.

 Tomi

Tomi Valkeinen (6):
  OMAP: RX51: Remove unused old omapfb stuff
  OMAP: omap3touchbook: Remove unused lcd stuff
  OMAP: 2420SDP: Port the display driver to new DSS2
  OMAP: LDP: Port the display driver to new DSS2
  OMAP: H4: Port the display driver to new DSS2
  OMAP: Apollon: Port the display driver to new DSS2

 arch/arm/mach-omap2/board-2430sdp.c        |   78 ++++++++++++++---
 arch/arm/mach-omap2/board-apollon.c        |   35 +++++---
 arch/arm/mach-omap2/board-h4.c             |   42 ++++++----
 arch/arm/mach-omap2/board-ldp.c            |  123 +++++++++++++++++++++++++---
 arch/arm/mach-omap2/board-omap3touchbook.c |   18 ----
 arch/arm/mach-omap2/board-rx51.c           |   25 ------
 6 files changed, 225 insertions(+), 96 deletions(-)

-- 
1.7.4.1

