From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [RFC][PATCH 0/2] DSPBRIDGE: 128 bytes alignment check
Date: Thu, 18 Feb 2010 16:33:47 -0600
Message-ID: <1266532429-30927-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49018 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755012Ab0BRWVN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Feb 2010 17:21:13 -0500
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

 drivers/dsp/bridge/Kconfig     |   19 +++++++++++++++++++
 drivers/dsp/bridge/rmgr/proc.c |   20 ++++++++++++++++++++
 2 files changed, 39 insertions(+), 0 deletions(-)

