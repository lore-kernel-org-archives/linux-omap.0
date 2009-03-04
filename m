From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/4] Still more omap fixes for current -rc series
Date: Wed, 04 Mar 2009 10:25:17 -0800
Message-ID: <20090304182342.27331.35004.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61955 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752977AbZCDSZW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Mar 2009 13:25:22 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

This should be it for the omap fixes for this -rc cycle. Hopefully
we can still get these in.

Regards,

Tony

---

Aaro Koskinen (2):
      ARM: OMAP: Allow I2C bus driver to be compiled as a module
      ARM: OMAP: sched_clock() corrected

David Brownell (1):
      ARM: OMAP: Fix compile error if pm.h is included

Koen Kooi (1):
      ARM: OMAP: board-omap3beagle: set i2c-3 to 100kHz


 arch/arm/mach-omap2/board-omap3beagle.c  |    4 +++-
 arch/arm/plat-omap/Makefile              |    3 ++-
 arch/arm/plat-omap/common.c              |   14 +++++---------
 arch/arm/plat-omap/include/mach/common.h |    2 +-
 arch/arm/plat-omap/include/mach/pm.h     |    2 +-
 5 files changed, 12 insertions(+), 13 deletions(-)

-- 
Signature
