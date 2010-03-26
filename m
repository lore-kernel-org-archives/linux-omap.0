From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 0/2] DSPBRIDGE: 128 bytes alignment check
Date: Fri, 26 Mar 2010 15:02:26 -0600
Message-ID: <1269637348-20608-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57828 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990Ab0CZUqu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Mar 2010 16:46:50 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Technical info:
https://omapzoom.org/gf/download/docmanfileversion/52/985/DSP_cache.pdf

This set of patches introduces the 128 byte alignment check,
needed to avoid corruption if the dsp is meant to write to
boundary portions of an unaligned chunk of memory.

The second patch uses a field composed of 2 bits to distinguish
if the mapped chunk is readable/writeable, so the check can be
performed on w/rw chunks of memory. 

Omar Ramirez Luna (2):
  DSPBRIDGE: add checking 128 byte alignment for dsp cache line size
  DSPBRIDGE: Distinguish between read or write buffers

 arch/arm/plat-omap/include/dspbridge/dbdefs.h |    7 ++++++-
 drivers/dsp/bridge/Kconfig                    |   14 ++++++++++++++
 drivers/dsp/bridge/rmgr/proc.c                |   19 +++++++++++++++++++
 drivers/dsp/bridge/wmd/tiomap3430.c           |    4 ++--
 4 files changed, 41 insertions(+), 3 deletions(-)

