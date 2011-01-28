From: sricharan <r.sricharan@ti.com>
Subject: [PATCH 0/5] omap2+: mux: Add support for static and dynamic pads.
Date: Fri, 28 Jan 2011 10:38:13 +0530
Message-ID: <1296191298-17545-1-git-send-email-r.sricharan@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46077 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab1A1FGJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Jan 2011 00:06:09 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: r.sricharan@ti.com, linux-omap@vger.kernel.org
Cc: santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com


1) The support to add the pad data to the device hwmod entry and to use
   it to dynamically configure the pads based on the state of the
   hwmod is already present.

2) But using that for pads that requires only initialisation and not
   dynamic remux, brings in a overhead to iterate over all the
   hwmod signals of the device for every device enable/idle transitions.

3) By seperating the pads that requires remux as dynamic and the
   ones that do not as static the above overhead is avoided.

4) This way the static and dynamic pads are initialised, 
   and only dynamic pads are taken for remuxing.

sricharan (5):
  omap2+: mux: Seperate the pads of a hwmod as static and dynamic.
  omap4: board-4430sdp: Initialise the serial pads
  omap3: board-3430sdp: Initialise the serial pads.
  omap4: board-omap4panda: Initialise the serial pads
  omap2+: board-n8x0: Change the flags for the serial pads.

 arch/arm/mach-omap2/board-3430sdp.c          |   86 ++++++++++-
 arch/arm/mach-omap2/board-4430sdp.c          |   73 +++++++++-
 arch/arm/mach-omap2/board-n8x0.c             |    2 +-
 arch/arm/mach-omap2/board-omap4panda.c       |   72 +++++++++-
 arch/arm/mach-omap2/mux.c                    |  219 +++++++++++++++++++++-----
 arch/arm/mach-omap2/mux.h                    |   33 ++++-
 arch/arm/mach-omap2/omap_hwmod.c             |    6 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    7 +-
 8 files changed, 441 insertions(+), 57 deletions(-)

