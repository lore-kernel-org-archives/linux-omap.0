From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 0/6] OMAP: board file changes for DSS2 porting
Date: Mon,  9 May 2011 10:36:01 +0300
Message-ID: <1304926567-26814-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:42894 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752000Ab1EIHgT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 May 2011 03:36:19 -0400
Received: by mail-ew0-f52.google.com with SMTP id 28so1518243ewy.25
        for <linux-omap@vger.kernel.org>; Mon, 09 May 2011 00:36:18 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Hi Tony,

I posted last week a patch set porting most of the old omapfb OMAP2/3 drivers
to DSS2 (http://marc.info/?l=linux-fbdev&m=130451207802788&w=2). That patch set
contains changes to both the drivers and the board files, and it seems there is
already a minor conflict in them.

So I think it's simpler to divide the set into two parts, this one, which
contains the board file changes, and another containing the driver changes.
Merging will probably go easier if you can take this patch set via linux-omap,
and I'll take the driver changes via dss2 tree.

Applying this set without the driver changes will obviously disable the
displays of the affected boards until the drivers are also merged.

 Tomi


Tomi Valkeinen (6):
  OMAP: RX51: Remove unused old omapfb stuff
  OMAP: omap3touchbook: Remove unused lcd stuff
  OMAP: 2420SDP: Port the display driver to new DSS2
  OMAP: LDP: Port the display driver to new DSS2
  OMAP: H4: Port the display driver to new DSS2
  OMAP: Apollon: Port the display driver to new DSS2

 arch/arm/mach-omap2/board-2430sdp.c        |   84 +++++++++++++++++++++++-----
 arch/arm/mach-omap2/board-apollon.c        |   34 +++++++----
 arch/arm/mach-omap2/board-h4.c             |   41 ++++++++-----
 arch/arm/mach-omap2/board-ldp.c            |   73 +++++++++++++++++++++---
 arch/arm/mach-omap2/board-omap3touchbook.c |   18 ------
 arch/arm/mach-omap2/board-rx51.c           |   25 --------
 6 files changed, 180 insertions(+), 95 deletions(-)

-- 
1.7.4.1

