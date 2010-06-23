From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/9 v2] introduce generic OMAP SOC features
Date: Tue, 22 Jun 2010 21:16:06 -0500
Message-ID: <1277259375-18521-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45141 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750945Ab0FWCQV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jun 2010 22:16:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Venkatraman S <svenkatr@ti.com>, Senthilvadivu Guruswamy <svadivu@ti.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>

With OMAP4 we have the need to have SOC independent features
handling. This makes sense from a long run as other OMAP4
derivatives gets generated in parallel to OMAP3 generation
of chips.

V1: http://marc.info/?l=linux-omap&m=127458581708411&w=2

V2 incorporates additional patches which were posted as part
of http://marc.info/?t=127357973500002&r=1&w=2

Example usages:
	http://marc.info/?t=127376415000008&r=1&w=2
	http://marc.info/?t=127265012000008&r=1&w=2

This series attempts to introduce a framework which could
be used from OMAP1 onwards.

Caveat: this series just introduces the framework by reorganizing
the existing data, it introduces just a basic support on OMAP1,2,4
while reorganizing the existing omap3 features as needed for
OMAP1,2,3,4. As usual, comments are welcome.

NOTE: Tested on OMAP3430, 3630, OMAP4. Requesting help to verify on
other platforms as well - OMAP1,2 etc..(only very limited change has
been done for these, expectation is for them to continue to function).

Nishanth Menon (9):
  omap1: rename check_revision
  omap2/3: id: fix sparse warning
  omap: generic: introduce a single check_revision
  omap: improve OMAP3_HAS_FEATURE
  omap: introduce OMAP_SHOW_FEATURE
  omap: move generic omap3 features to generic
  omap: introduce omap4 feature
  omap: introduce omap24xx generic features
  omap: id: add feature check for omap1

 arch/arm/mach-omap1/id.c              |    8 +++-
 arch/arm/mach-omap1/io.c              |    1 -
 arch/arm/mach-omap2/id.c              |   61 +++++++++++++++++++---------
 arch/arm/mach-omap2/io.c              |    2 +-
 arch/arm/plat-omap/common.c           |   16 +++++++
 arch/arm/plat-omap/include/plat/cpu.h |   72 ++++++++++++++++++++++-----------
 6 files changed, 113 insertions(+), 47 deletions(-)

Regards,
Nishanth Menon
