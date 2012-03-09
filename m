From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 4/4] ARM: OMAP2430SDP: No support to switch to external clock on omap2430
Date: Fri, 9 Mar 2012 14:41:49 +0530
Message-ID: <1331284309-22101-5-git-send-email-rnayak@ti.com>
References: <1331284309-22101-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56157 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751151Ab2CIJMV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Mar 2012 04:12:21 -0500
In-Reply-To: <1331284309-22101-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Balaji TK <balajitk@ti.com>, Venkatraman S <svenkatr@ti.com>

As stated in the latest 2430 TRM version Z, Table 7-135 and Table 7-154,
omap2430 does not support switching between internal loopback and external
clock for MMC modules. This is supported only on some instances of MMC
modules on omap3430 only.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Balaji TK <balajitk@ti.com>
Cc: Venkatraman S <svenkatr@ti.com>
---
 arch/arm/mach-omap2/board-2430sdp.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 7370983..eb70b00 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -249,7 +249,6 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 		.caps		= MMC_CAP_4_BIT_DATA,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
-		.ext_clock	= 1,
 	},
 	{}	/* Terminator */
 };
-- 
1.7.1

