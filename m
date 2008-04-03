From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/2] PRM/CM: Add several new PRM/CM mutator functions
Date: Thu, 03 Apr 2008 16:34:39 -0600
Message-ID: <20080403223439.820599556@pwsan.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51592 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757869AbYDCWiI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Apr 2008 18:38:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


Hello, 

The following two patches add several new PRM/CM manipulation functions
and convert existing code to use them when appropriate.  

At the moment, there are not very many users, but the (as yet unpublished)
PM patches make more extensive use of these.

Boot-tested on N800.

- Paul


size:

   text    data     bss     dec     hex filename
2812474  128976   86636 3028086  2e3476 vmlinux.orig
2812378  128976   86636 3027990  2e3416 vmlinux

diffstat:

 arch/arm/mach-omap2/clock.c       |    8 +++-----
 arch/arm/mach-omap2/clock24xx.c   |   15 ++++-----------
 arch/arm/mach-omap2/cm.h          |   34 +++++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/pm.c          |   19 +++++--------------
 arch/arm/mach-omap2/prcm.c        |   14 ++++++++------
 arch/arm/mach-omap2/prm.h         |   37 ++++++++++++++++++++++++++++++++++---
 drivers/dsp/dspgateway/dsp_core.c |   14 +++++---------
 7 files changed, 92 insertions(+), 49 deletions(-)



