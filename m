From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 14/23] OMAP2/3 clock: convert remaining MPU barriers into OCP
	barriers
Date: Sun, 04 Jan 2009 19:34:56 -0700
Message-ID: <20090105023455.12661.73796.stgit@localhost.localdomain>
References: <20090105022953.12661.57701.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42892 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244AbZAEDWs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Jan 2009 22:22:48 -0500
In-Reply-To: <20090105022953.12661.57701.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Several parts of the OMAP2/3 clock code use wmb() to try to ensure
that the hardware write completes before continuing.  This approach is
problematic: wmb() only ensures that the write leaves the ARM.  It
does not ensure that the write actually reaches the endpoint device.
The endpoint device in this case - either the PRM, CM, or SCM - is
three interconnects away from the ARM - and the final interconnect is
low-speed.  And the OCP interconnects will post the write, and who
knows how long that will take to complete.  So the wmb() is not what
we want.  Worse, the wmb() is indiscriminate; it causes the ARM to
flush any other unrelated buffered writes and wait for the local
interconnect to acknowledge them - potentially very expensive.

Fix this by converting the wmb()s into readbacks of the same PRM/CM/SCM
register.  Since the PRM/CM/SCM devices use a single OCP thread, this
will cause the MPU to block while waiting for posted writes to that device
to complete.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 78e14bf..0946a5a 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -446,7 +446,7 @@ static int _omap2_clk_enable(struct clk *clk)
 	else
 		v |= (1 << clk->enable_bit);
 	_omap2_clk_write_reg(v, clk->enable_reg, clk);
-	wmb();
+	v = _omap2_clk_read_reg(clk->enable_reg, clk); /* OCP barrier */
 
 	omap2_clk_wait_ready(clk);
 
@@ -774,8 +774,7 @@ int omap2_clksel_set_rate(struct clk *clk, unsigned long rate)
 	v &= ~clk->clksel_mask;
 	v |= field_val << __ffs(clk->clksel_mask);
 	_omap2_clk_write_reg(v, clk->clksel_reg, clk);
-
-	wmb();
+	v = _omap2_clk_read_reg(clk->clksel_reg, clk); /* OCP barrier */
 
 	clk->rate = clk->parent->rate / new_div;
 
@@ -851,7 +850,7 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
 	v &= ~clk->clksel_mask;
 	v |= field_val << __ffs(clk->clksel_mask);
 	_omap2_clk_write_reg(v, clk->clksel_reg, clk);
-	wmb();
+	v = _omap2_clk_read_reg(clk->clksel_reg, clk);    /* OCP barrier */
 
 	_omap2xxx_clk_commit(clk);
 


