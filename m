From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH 0/2] OMAP: Update nr_irqs field in machine descriptors
Date: Thu, 25 Aug 2011 01:16:53 +0530
Message-ID: <1314215215-18683-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47176 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750767Ab1HXTrR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Aug 2011 15:47:17 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Venkatraman S <svenkatr@ti.com>

As part of an effort to get single ARM kernel binary [1],
multiple  definitions of NR_IRQS under various platforms
have to be reconciled and abstracted away from common code.

This patch series takes the small step of populating the 
machine descriptors with the pre-existing nr_irqs field.
Eventually, the common irq handler code will only look at this
field and not the compile time constant.

[1]: https://blueprints.launchpad.net/ubuntu/+spec/kernel-maverick-arm-single-zimage

Venkatraman S (2):
  omap2+: Populate nr_irqs field in machine descriptors
  omap1: Populate nr_irqs field in machine descriptors

 arch/arm/mach-omap1/board-ams-delta.c      |    1 +
 arch/arm/mach-omap1/board-fsample.c        |    1 +
 arch/arm/mach-omap1/board-generic.c        |    1 +
 arch/arm/mach-omap1/board-h2.c             |    1 +
 arch/arm/mach-omap1/board-h3.c             |    1 +
 arch/arm/mach-omap1/board-htcherald.c      |    1 +
 arch/arm/mach-omap1/board-innovator.c      |    1 +
 arch/arm/mach-omap1/board-nokia770.c       |    1 +
 arch/arm/mach-omap1/board-osk.c            |    1 +
 arch/arm/mach-omap1/board-palmte.c         |    1 +
 arch/arm/mach-omap1/board-palmtt.c         |    1 +
 arch/arm/mach-omap1/board-palmz71.c        |    1 +
 arch/arm/mach-omap1/board-perseus2.c       |    1 +
 arch/arm/mach-omap1/board-sx1.c            |    1 +
 arch/arm/mach-omap1/board-voiceblue.c      |    1 +
 arch/arm/mach-omap2/board-2430sdp.c        |    1 +
 arch/arm/mach-omap2/board-3430sdp.c        |    1 +
 arch/arm/mach-omap2/board-3630sdp.c        |    1 +
 arch/arm/mach-omap2/board-4430sdp.c        |    1 +
 arch/arm/mach-omap2/board-am3517crane.c    |    1 +
 arch/arm/mach-omap2/board-am3517evm.c      |    1 +
 arch/arm/mach-omap2/board-apollon.c        |    1 +
 arch/arm/mach-omap2/board-cm-t35.c         |    2 ++
 arch/arm/mach-omap2/board-cm-t3517.c       |    1 +
 arch/arm/mach-omap2/board-devkit8000.c     |    1 +
 arch/arm/mach-omap2/board-generic.c        |    1 +
 arch/arm/mach-omap2/board-h4.c             |    1 +
 arch/arm/mach-omap2/board-igep0020.c       |    2 ++
 arch/arm/mach-omap2/board-ldp.c            |    1 +
 arch/arm/mach-omap2/board-n8x0.c           |    3 +++
 arch/arm/mach-omap2/board-omap3beagle.c    |    1 +
 arch/arm/mach-omap2/board-omap3evm.c       |    1 +
 arch/arm/mach-omap2/board-omap3logic.c     |    2 ++
 arch/arm/mach-omap2/board-omap3pandora.c   |    1 +
 arch/arm/mach-omap2/board-omap3stalker.c   |    1 +
 arch/arm/mach-omap2/board-omap3touchbook.c |    1 +
 arch/arm/mach-omap2/board-omap4panda.c     |    1 +
 arch/arm/mach-omap2/board-overo.c          |    1 +
 arch/arm/mach-omap2/board-rm680.c          |    1 +
 arch/arm/mach-omap2/board-rx51.c           |    1 +
 arch/arm/mach-omap2/board-ti8168evm.c      |    1 +
 arch/arm/mach-omap2/board-zoom.c           |    2 ++
 42 files changed, 48 insertions(+), 0 deletions(-)

