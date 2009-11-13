From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 12/14] omap3: move check_revision above check_features
Date: Thu, 12 Nov 2009 16:09:32 -0800
Message-ID: <20091113000932.9034.66321.stgit@localhost>
References: <20091113000444.9034.41293.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60669 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754681AbZKMAJ2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 19:09:28 -0500
In-Reply-To: <20091113000444.9034.41293.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Nishanth Menon <nm@ti.com>, Mika Westerberg <mika.westerberg@iki.fi>, linux-omap@vger.kernel.org

From: Tony Lindgren <Menon>

omap3_check_revision() does not depend on omap3_check_features()
move this above so that we can add logic based on revision
detected in check_features.

Signed-off-by: Nishanth Menon <nm@ti.com>
Acked-by: Mika Westerberg <mika.westerberg@iki.fi>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/id.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 441ca26..6c11b41 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -352,8 +352,8 @@ void __init omap2_check_revision(void)
 	if (cpu_is_omap24xx())
 		omap24xx_check_revision();
 	else if (cpu_is_omap34xx()) {
-		omap3_check_features();
 		omap3_check_revision();
+		omap3_check_features();
 		omap3_cpuinfo();
 	}
 	else if (cpu_is_omap44xx()) {

