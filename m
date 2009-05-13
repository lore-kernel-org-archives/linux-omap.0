From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 09/10] OMAP3 clock: lessen amount of noisy messages
Date: Tue, 12 May 2009 18:05:27 -0600
Message-ID: <20090513000525.10349.18270.stgit@localhost.localdomain>
References: <20090512235713.10349.49339.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56432 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757127AbZEMAHp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 May 2009 20:07:45 -0400
In-Reply-To: <20090512235713.10349.49339.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Artem Bityutskiy <Artem.Bityutskiy@nokia.com>, Paul Walmsley <paul@pwsan.com>

From: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>

On our system we see the following messages:

Disabling unused clock "gpt2_ick"
Disabling unused clock "gpt3_ick"
Disabling unused clock "gpt4_ick"
Disabling unused clock "gpt5_ick"
...

The messages have KERN_INFO level and if you have serial
console, they normally go there. I do not think it is good
idea to print that much stuff there. Moreover, messages
are not properly prefixed and for mortals it is not
immeadietly clear where they come from.

Let's give them debugging level instead.

Signed-off-by: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
[paul@pwsan.com: trimmed debugging output in patch description]
---
 arch/arm/mach-omap2/clock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 8935a8b..076f0a7 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -1035,7 +1035,7 @@ void omap2_clk_disable_unused(struct clk *clk)
 	if ((regval32 & (1 << clk->enable_bit)) == v)
 		return;
 
-	printk(KERN_INFO "Disabling unused clock \"%s\"\n", clk->name);
+	printk(KERN_DEBUG "Disabling unused clock \"%s\"\n", clk->name);
 	if (cpu_is_omap34xx()) {
 		omap2_clk_enable(clk);
 		omap2_clk_disable(clk);


