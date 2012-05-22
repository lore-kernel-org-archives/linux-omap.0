From: Siarhei Siamashka <siarhei.siamashka@gmail.com>
Subject: [PATCH 0/2] OMAPDSS: write-through caching support for omapfb
Date: Tue, 22 May 2012 22:54:02 +0300
Message-ID: <1337716444-30139-1-git-send-email-siarhei.siamashka@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:51917 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750989Ab2EVTyT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 May 2012 15:54:19 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux@arm.linux.org.uk, tomi.valkeinen@ti.com, Siarhei Siamashka <siarhei.siamashka@gmail.com>

This is a very simple few-liner patchset, which allows to optionally
enable write-through caching for OMAP DSS framebuffer. The problem with
the current writecombine cacheability attribute is that it only speeds
up writes. Uncached reads are slow, even though the use of NEON mitigates
this problem a bit.

Traditionally, xf86-video-fbdev DDX is using shadow framebuffer in the
system memory. Which contains a copy of the framebuffer data for the
purpose of providing fast read access to it when needed. Framebuffer
read access is required not so often, but it still gets used for
scrolling and moving windows around in Xorg server. And the users
perceive their linux desktop as rather sluggish when these operations
are not fast enough.

In the case of ARM hardware, framebuffer is typically physically
located in the main memory. And the processors still support
write-through cacheability attribute. According to ARM ARM, the writes
done to write-through cached memory inside the level of cache are
visible to all observers outside the level of cache without the need
of explicit cache maintenance (same rule as for non-cached memory).
So write-through cache is a perfect choice when only CPU is allowed
to modify the data in the framebuffer and everyone else (screen
refresh DMA) is only reading it. That is, assuming that write-through
cached memory provides good performance and there are no quirks.
As the framebuffer reads become fast, the need for shadow framebuffer
disappears.

And at least for ARM11 and Cortex-A8 processors, the performance of
write-through cache is really good. Cortex-A9 is another story, because
all pages marked as Write-Through are supposedly treated as Non-Cacheable:
    http://infocenter.arm.com/help/topic/com.arm.doc.ddi0388h/CBBFDIJD.html
So OMAP4 is out of luck. But OMAP3 based hardware can have a nice
graphics performance boost. And OMAP3 actually needs it a lot more.

PS. The xf86-video-omapfb-0.1.1 driver does not even use shadow
    framebuffer (ouch!). So its users, if any, should see an immediate
    speedup.

Siarhei Siamashka (2):
  ARM: pgtable: add pgprot_writethrough() macro
  OMAPDSS: Optionally enable write-through cache for the framebuffer

 Documentation/arm/OMAP/DSS               |   10 ++++++++++
 arch/arm/include/asm/pgtable.h           |    3 +++
 drivers/video/omap2/omapfb/omapfb-main.c |    7 ++++++-
 3 files changed, 19 insertions(+), 1 deletions(-)

-- 
1.7.3.4

