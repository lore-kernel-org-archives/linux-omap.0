From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH 2/2] HSMMC: Enable external input clock for 2430 SDP MMC1
Date: Thu, 13 Nov 2008 23:40:05 +0200
Message-ID: <1226612405-7175-2-git-send-email-notasas@gmail.com>
References: <1226612405-7175-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.191]:43587 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154AbYKMVkV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Nov 2008 16:40:21 -0500
Received: by gv-out-0910.google.com with SMTP id e6so251798gvc.37
        for <linux-omap@vger.kernel.org>; Thu, 13 Nov 2008 13:40:20 -0800 (PST)
In-Reply-To: <1226612405-7175-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Grazvydas Ignotas <notasas@gmail.com>

Previous patch removed cpu_is_omap2430() check in mmc-twl4030.c,
so update twl4030_hsmmc_info to accommodate that.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 arch/arm/mach-omap2/board-2430sdp.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 6aa83ac..22df018 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -396,6 +396,7 @@ static struct twl4030_hsmmc_info mmc[] __initdata = {
 		.wires		= 4,
 		.gpio_cd	= -EINVAL,
 		.gpio_wp	= -EINVAL,
+		.ext_clock	= 1,
 	},
 	{}	/* Terminator */
 };
-- 
1.5.4.3

