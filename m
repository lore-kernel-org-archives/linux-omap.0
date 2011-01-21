From: John Ogness <john.ogness@linutronix.de>
Subject: [PATCH v3] OMAP2/3: clock: fix fint calculation for DPLL_FREQSEL
Date: Fri, 21 Jan 2011 09:33:33 +0100
Message-ID: <87y66e3bc2.fsf_-_@vostro.fn.ogness.net>
References: <87ei8726wf.fsf@vostro.fn.ogness.net>
	<20110120111645.GB2223@legolas.emea.dhcp.ti.com>
	<8739on1wdd.fsf_-_@vostro.fn.ogness.net>
	<20110121031553.GA2448@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110121031553.GA2448@legolas.emea.dhcp.ti.com> (Felipe Balbi's message of "Fri\, 21 Jan 2011 05\:15\:53 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

From: John Ogness <john.ogness@linutronix.de>

In OMAP35X TRM Rev 2010-05 Figure 7-18 "DPLL With EMI Reduction
Feature", it is shown that the internal frequency is calculated by
CLK_IN/(N+1). However, the value passed to _dpll_test_fint() is
already "N+1" since Linux is using the values to divide by. In the
technical reference manual, "N" is referring to the divider's register
value (0-127).

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
patch v3:
Patch against linux-next-20110121.
I have improved the commit message so that it is acceptable for the
git commit log.

 arch/arm/mach-omap2/clkt_dpll.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt_dpll.c b/arch/arm/mach-omap2/clkt_dpll.c
index 337392c..acb7ae5 100644
--- a/arch/arm/mach-omap2/clkt_dpll.c
+++ b/arch/arm/mach-omap2/clkt_dpll.c
@@ -77,7 +77,7 @@ static int _dpll_test_fint(struct clk *clk, u8 n)
 	dd = clk->dpll_data;
 
 	/* DPLL divider must result in a valid jitter correction val */
-	fint = clk->parent->rate / (n + 1);
+	fint = clk->parent->rate / n;
 	if (fint < DPLL_FINT_BAND1_MIN) {
 
 		pr_debug("rejecting n=%d due to Fint failure, "
-- 
1.5.6.5
