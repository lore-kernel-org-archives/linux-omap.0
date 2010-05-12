From: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
Subject: [PATCH v3 0/2] McBSP changes for OMAP4 platform
Date: Wed, 12 May 2010 12:18:38 -0500
Message-ID: <1273684720-16619-1-git-send-email-jorge.candelaria@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40700 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756576Ab0ELRaW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 May 2010 13:30:22 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: lrg@slimlogic.co.uk, broonie@opensource.wolfsonmicro.com

The following patches enable McBSP driver to be used along with the
audio driver in SDP4430 and other OMAP4 based boards.

Changes from v2:
- Fixed missing parentheses.
- Added Acked-by tag to patch #1.
- Sending to alsa-devel list also, as suggested by Peter Ujfalusi
  and Liam Girdwood

Jorge Eduardo Candelaria (2):
      ARM: McBSP: Fix request for irq in OMAP4
      ARM: OMAP4: Add support for omap4 in McBSP driver

 arch/arm/mach-omap2/mcbsp.c |   12 ++++--------
 arch/arm/plat-omap/mcbsp.c  |   34 +++++++++++++++++++---------------
 2 files changed, 23 insertions(+), 23 deletions(-)

