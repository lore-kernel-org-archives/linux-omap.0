From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/19] omap: Checkpatch cleanup for blizzard.h
Date: Thu, 11 Mar 2010 15:48:29 -0800
Message-ID: <20100311234829.4500.8994.stgit@baageli.muru.com>
References: <20100311234404.4500.82861.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53427 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753786Ab0CKXrG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Mar 2010 18:47:06 -0500
In-Reply-To: <20100311234404.4500.82861.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Andrea Gelmini <andrea.gelmini@gelma.net>, linux-omap@vger.kernel.org

From: Andrea Gelmini <andrea.gelmini@gelma.net>

arch/arm/plat-omap/include/plat/blizzard.h:9:
ERROR: spaces prohibited around that ':' (ctx:WxW)

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/blizzard.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/blizzard.h b/arch/arm/plat-omap/include/plat/blizzard.h
index 8d160f1..56e7f2e 100644
--- a/arch/arm/plat-omap/include/plat/blizzard.h
+++ b/arch/arm/plat-omap/include/plat/blizzard.h
@@ -6,7 +6,7 @@ struct blizzard_platform_data {
 	void		(*power_down)(struct device *dev);
 	unsigned long	(*get_clock_rate)(struct device *dev);
 
-	unsigned	te_connected : 1;
+	unsigned	te_connected:1;
 };
 
 #endif

