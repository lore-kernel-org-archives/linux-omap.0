From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 0/5] OMAP: l3: fixes and cleanup
Date: Tue, 29 Mar 2011 11:20:14 -0600
Message-ID: <1301419219-30547-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34332 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752549Ab1C2Rbs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Mar 2011 13:31:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>, l-o <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>, sricharan <r.sricharan@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>, Benoit Cousson <b-cousson@ti.com>, Sergei Shtylyov <sshtylyov@mvista.com>, Omar Ramirez Luna <omar.ramirez@ti.com>

Based on the comments received for the first patch:
OMAP3: l3: fix for "irq 10: nobody cared" message[1],
and quick skimming through the code.

Although there are still parenthesis that are not needed
because of operator precedence, they were left for clarity.

E.g.:
(error >> 32) & 0xffff;

clear = (L3_AGENT_STATUS_CLEAR_IA << int_type) |
        L3_AGENT_STATUS_CLEAR_TA;

---
[1] https://patchwork.kernel.org/patch/665141/

Omar Ramirez Luna (5):
  OMAP3: l3: fix for "irq 10: nobody cared" message
  OMAP3: l3: fix omap3_l3_probe error path
  OMAP3: l3: minor cleanup for error message, parenthesis and extra
    lines
  OMAP4: l3: fix omap4_l3_probe error path
  OMAP4: l3: minor cleanup for parenthesis and extra spaces

 arch/arm/mach-omap2/omap_l3_noc.c |   51 ++++++++++++++++--------------------
 arch/arm/mach-omap2/omap_l3_smx.c |   46 ++++++++++++---------------------
 2 files changed, 40 insertions(+), 57 deletions(-)

