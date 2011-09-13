From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/6] OMAP2+: id: cleanup for 3.2
Date: Tue, 13 Sep 2011 15:28:01 -0600
Message-ID: <20110913212638.26161.62284.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40101 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932751Ab1IMVbT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Sep 2011 17:31:19 -0400
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

- Paul

---

Paul Walmsley (6):
      OMAP3: id: remove identification codes that only correspond to marketing names
      OMAP3: id: remove useless strcpy()s
      OMAP3: id: use explicit omap_revision codes for 3505/3517 ES levels
      OMAP3: id: add fallthrough warning; fix some CodingStyle issues
      OMAP3: id: remove duplicate code for testing SoC ES level
      OMAP2+: id: remove OMAP_REVBITS_* macros


 arch/arm/mach-omap2/id.c              |  134 ++++++++++++---------------------
 arch/arm/plat-omap/include/plat/cpu.h |   41 +++-------
 2 files changed, 62 insertions(+), 113 deletions(-)

