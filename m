From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 0/6] OMAP2+: id: cleanup for 3.2
Date: Wed, 14 Sep 2011 06:39:20 -0600
Message-ID: <20110914123708.25282.78122.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37231 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932381Ab1INMmZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Sep 2011 08:42:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Clean up the SoC detection code for some OMAP3 devices.  The main goal
is to make the AM3517 family detection code work like the rest of the
OMAP3 SoCs, although this series does some other cleanup of this code
at the same time.  This patch series will be a prerequisite for the
OMAP_CHIP removal series.

Tested on an OMAP3530ES2 BeagleBoard C2 and a OMAP3730ES1 BeagleBoard A2.
These are the only OMAP3 boards I have access to right now - testing welcomed
from people with other OMAP3 families or ES levels.

This second version fixes a bug in the first patch, which requires the
later patches to be updated to apply without rejects.  Thanks to Igor
Grinberg <grinberg@compulab.co.il> for comments about this.


- Paul

---
id_3517_cleanup_3.2
   text	   data	    bss	    dec	    hex	filename
6330180	 656956	5591124	12578260	 bfedd4	vmlinux.omap2plus_defconfig.orig
6329884	 656964	5591124	12577972	 bfecb4	vmlinux.omap2plus_defconfig.patched


Paul Walmsley (6):
      OMAP3: id: remove identification codes that only correspond to marketing names
      OMAP3: id: remove useless strcpy()s
      OMAP3: id: use explicit omap_revision codes for 3505/3517 ES levels
      OMAP3: id: add fallthrough warning; fix some CodingStyle issues
      OMAP3: id: remove duplicate code for testing SoC ES level
      OMAP2+: id: remove OMAP_REVBITS_* macros


 arch/arm/mach-omap2/id.c              |  134 ++++++++++++---------------------
 arch/arm/plat-omap/include/plat/cpu.h |   46 ++++-------
 2 files changed, 65 insertions(+), 115 deletions(-)

