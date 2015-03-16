From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 0/2] Couple of DRA7 hwmod patches on Timers
Date: Mon, 16 Mar 2015 15:54:52 -0500
Message-ID: <1426539294-28375-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39977 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751563AbbCPUzY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Mar 2015 16:55:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

Hi Paul,

Following are couple of DRA7 hwmod patches for the GPTimers.
Patches based on 4.0-rc1.

The first patch adds the data for timers 13 through 16, the DT
nodes are already present, and when enabled without the hwmod
data triggers a l3_noc interrupt and hangs the kernel boot [1].
The boot hang can also be fixed by checking the return status
of pm_runtime_get_sync() in the OMAP dmtimer probe, I will post
a separate fix for that.

Second patch is a minor fix.

regards
Suman

[1] http://pastebin.ubuntu.com/10611882/

Suman Anna (2):
  ARM: DRA7: hwmod: Add data for GPTimers 13 through 16
  ARM: DRA7: hwmod: Fix the hwmod class for GPTimer4

 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 98 ++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 1 deletion(-)

-- 
2.3.2

