From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH v2 0/3] OMAP: l3: fixes and cleanup
Date: Mon, 18 Apr 2011 11:39:39 -0500
Message-ID: <1303144782-5591-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33124 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755848Ab1DRQvQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Apr 2011 12:51:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Omar Ramirez Luna <omar.ramirez@ti.com>

Based on the comments received for the first patch:
OMAP3: l3: fix for "irq 10: nobody cared" message[1],
and quick skimming through the code.

Although there are still parenthesis that are not needed
because of operator precedence, they were left for clarity.

E.g.:
(error >> 32) & 0xffff;

clear = (L3_AGENT_STATUS_CLEAR_IA << int_type) |
       L3_AGENT_STATUS_CLEAR_TA;

v2:
- Joining omap3_l3_probe fixes into a single patch.
- Joining trivial cleanups into a single patch.
- Adding acked by Santosh line.

---
[1] https://patchwork.kernel.org/patch/665141/

Omar Ramirez Luna (3):
  OMAP3: l3: fix for "irq 10: nobody cared" message
  OMAP3/4: l3: fix omap3_l3_probe error path
  OMAP3/4: l3: minor cleanup for parenthesis and extra spaces

 arch/arm/mach-omap2/omap_l3_noc.c |   51 ++++++++++++++++--------------------
 arch/arm/mach-omap2/omap_l3_smx.c |   46 ++++++++++++---------------------
 2 files changed, 40 insertions(+), 57 deletions(-)

