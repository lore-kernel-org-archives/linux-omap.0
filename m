From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 01/20] OMAP3: wait on IDLEST after enabling USBTLL fclk
Date: Fri, 02 Jul 2010 09:29:10 -0600
Message-ID: <20100702152906.6221.27841.stgit@localhost.localdomain>
References: <20100702152703.6221.33529.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100702152703.6221.33529.stgit@localhost.localdomain>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Anand Gadiyar <gadiyar@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Anand Gadiyar <gadiyar@ti.com>

We need to wait on the IDLEST bit after the clocks are enabled
before attempting to access any register.

Currently, the USBTLL i-clock ops uses the clkops_omap2_dflt_wait,
while the USBTLL f-clock ops uses clkops_omap2_dflt. If the
i-clock is enabled first, the clkops_omap2_dflt_wait is
short-circuited as the companion f-clock is not enabled.
This can cause a data abort if the IDLEST has not transitioned,
and we try to access a USBTLL register.

Since the USBTLL i-clock and f-clock could be enabled in any order,
this is a bug. Fix it by changing the clkops for the f-clock.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 41b155a..c226798 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -1408,7 +1408,7 @@ static struct clk ts_fck = {
 
 static struct clk usbtll_fck = {
 	.name		= "usbtll_fck",
-	.ops		= &clkops_omap2_dflt,
+	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &dpll5_m2_ck,
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP3430ES2_CM_FCLKEN3),
 	.enable_bit	= OMAP3430ES2_EN_USBTLL_SHIFT,
