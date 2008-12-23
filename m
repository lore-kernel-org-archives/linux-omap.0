From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 12/22] OMAP2/3 clock: don't use a barrier after clk_disable()
Date: Mon, 22 Dec 2008 23:38:38 -0700
Message-ID: <20081223063837.8542.99717.stgit@localhost.localdomain>
References: <20081223063709.8542.82882.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:52904 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699AbYLWGju (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Dec 2008 01:39:50 -0500
In-Reply-To: <20081223063709.8542.82882.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

clk_disable() previously used an ARM barrier, wmb(), to try to ensure
that the hardware write completed before continuing.  There are some
problems with this approach.

The first problem is that wmb() only ensures that the write leaves the
ARM -- not that it actually reaches the endpoint device.  In this
case, the endpoint device - either the PRM, CM, or SCM - is three
interconnects away from the ARM, and the final interconnect is
low-speed.  And the OCP interconnects will post the write, who knows
how long that will take to complete.  So the wmb() is not really what
we want.

Worse, the wmb() is indiscriminate; it will cause the ARM to flush any
other unrelated buffered writes and wait for the local interconnect to
acknowledge them - potentially very expensive.

This first problem could be fixed by doing a readback of the same PRM/CM/SCM
register.  Since these devices use a single OCP thread, this will cause the
MPU to wait for the write to complete.

But the primary problem is a conceptual one: clk_disable() should not
need any kind of barrier.  clk_enable() needs one since device driver
code must not access a device until its clocks are known to be
enabled.  But clk_disable() has no such restriction.

Since blocking the MPU on a PRM/CM/SCM write can be a very
high-latency operation - several hundred MPU cycles - it's worth
avoiding this barrier if possible.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 8599b34..d0caeef 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -450,7 +450,7 @@ static void _omap2_clk_disable(struct clk *clk)
 	else
 		v &= ~(1 << clk->enable_bit);
 	_omap2_clk_write_reg(v, clk->enable_reg, clk);
-	wmb();
+	/* No OCP barrier needed here since it is a disable operation */
 }
 
 void omap2_clk_disable(struct clk *clk)


