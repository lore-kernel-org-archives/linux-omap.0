From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH B 08/10] OMAP: wait for pwrdm transition after clk_enable()
Date: Tue, 27 Jan 2009 19:44:31 -0700
Message-ID: <20090128024428.27240.35785.stgit@localhost.localdomain>
References: <20090128024301.27240.39391.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60257 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbZA1UYF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 15:24:05 -0500
In-Reply-To: <20090128024301.27240.39391.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

From: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Enabling clock in a disabled power domain causes the power domain to be
turned on. However, the power transition is not always finished when
clk_enable() returns and this randomly crashes the kernel when an
interrupt happens right after the clk_enable, and the kernel tries to
read the irq status register for that domain.

Why the irq status register is inaccessible, I don't know. Also it
doesn't seem to be related to the module being not powered up, but to
the transition itself.

The same could perhaps happen after clk_disable also, but I have not
witnessed that.

The problem affects at least dss, cam and sgx clocks.

This change waits for the transition to be finished before returning
from omap2_clkdm_clk_enable().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clockdomain.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index 882809d..ad6dfe4 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -561,6 +561,8 @@ int omap2_clkdm_clk_enable(struct clockdomain *clkdm, struct clk *clk)
 	else
 		omap2_clkdm_wakeup(clkdm);
 
+	pwrdm_wait_transition(clkdm->pwrdm.ptr);
+
 	return 0;
 }
 


