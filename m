From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 04/11] OMAP2+: clock: comment that osc_ck/osc_sys_ck should
	use clockfw autoidle control
Date: Tue, 15 Feb 2011 23:52:47 -0700
Message-ID: <20110216065246.22089.21163.stgit@twilight.localdomain>
References: <20110216065030.22089.61217.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47513 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816Ab1BPGyE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Feb 2011 01:54:04 -0500
In-Reply-To: <20110216065030.22089.61217.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Place some comments in the OMAP oscillator clock control code to note that
its autoidle mode should eventually be controlled via the new OMAP clockfw
autoidle control interface.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clkt2xxx_osc.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt2xxx_osc.c b/arch/arm/mach-omap2/clkt2xxx_osc.c
index df7b805..c346092 100644
--- a/arch/arm/mach-omap2/clkt2xxx_osc.c
+++ b/arch/arm/mach-omap2/clkt2xxx_osc.c
@@ -30,6 +30,13 @@
 #include "prm2xxx_3xxx.h"
 #include "prm-regbits-24xx.h"
 
+/*
+ * XXX This does not actually enable the osc_ck, since the osc_ck must
+ * be running for this function to be called.  Instead, this function
+ * is used to disable an autoidle mode on the osc_ck.  The existing
+ * clk_enable/clk_disable()-based usecounting for osc_ck should be
+ * replaced with autoidle-based usecounting.
+ */
 static int omap2_enable_osc_ck(struct clk *clk)
 {
 	u32 pcc;
@@ -41,6 +48,13 @@ static int omap2_enable_osc_ck(struct clk *clk)
 	return 0;
 }
 
+/*
+ * XXX This does not actually disable the osc_ck, since doing so would
+ * immediately halt the system.  Instead, this function is used to
+ * enable an autoidle mode on the osc_ck.  The existing
+ * clk_enable/clk_disable()-based usecounting for osc_ck should be
+ * replaced with autoidle-based usecounting.
+ */
 static void omap2_disable_osc_ck(struct clk *clk)
 {
 	u32 pcc;


