From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 08/22] OMAP: hwmod: Do not exit the iteration if one clock
	init failed
Date: Tue, 18 May 2010 20:18:47 -0600
Message-ID: <20100519021846.19716.52695.stgit@localhost.localdomain>
References: <20100519021800.19716.8938.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:39791 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754434Ab0ESCVA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 22:21:00 -0400
In-Reply-To: <20100519021800.19716.8938.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Benoit Cousson <b-cousson@ti.com>

From: Benoit Cousson <b-cousson@ti.com>

During the _init_clocks phase, the iteration is stopped but the
status is still change from _HWMOD_STATE_REGISTERED to
_HWMOD_STATE_CLKS_INITED.
Since the _setup phase will be done nevertheless, it might be
better to keep initializing the others clocks nodes and just
keep the warning.
It is much easier to debug when a important number of clocks
name are wrong during the early debug phase of a new platform.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 5d3a3ea..b624ad6 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -783,9 +783,10 @@ static int _init_clocks(struct omap_hwmod *oh)
 	ret |= _init_interface_clks(oh);
 	ret |= _init_opt_clks(oh);
 
-	oh->_state = _HWMOD_STATE_CLKS_INITED;
+	if (!ret)
+		oh->_state = _HWMOD_STATE_CLKS_INITED;
 
-	return ret;
+	return 0;
 }
 
 /**


