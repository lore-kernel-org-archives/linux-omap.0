From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/8] ARM: OMAP3: clock data: add clockdomain for HDQ
 functional clock
Date: Sat, 21 Jan 2012 16:59:31 -0700
Message-ID: <20120121235928.17619.38147.stgit@dusk>
References: <20120121235333.17619.56725.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120121235333.17619.56725.stgit@dusk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: NeilBrown <neilb@suse.de>
List-Id: linux-omap@vger.kernel.org

Add the correct clockdomain for the HDQ functional clock.  This is needed
for the clock and hwmod PM code to work correctly.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: NeilBrown <neilb@suse.de>
---
 arch/arm/mach-omap2/clock3xxx_data.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index d75e5f6..98cb408 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -1,7 +1,7 @@
 /*
  * OMAP3 clock data
  *
- * Copyright (C) 2007-2010 Texas Instruments, Inc.
+ * Copyright (C) 2007-2010, 2012 Texas Instruments, Inc.
  * Copyright (C) 2007-2011 Nokia Corporation
  *
  * Written by Paul Walmsley
@@ -1634,6 +1634,7 @@ static struct clk hdq_fck = {
 	.name		= "hdq_fck",
 	.ops		= &clkops_omap2_dflt_wait,
 	.parent		= &core_12m_fck,
+	.clkdm_name	= "core_l4_clkdm",
 	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
 	.enable_bit	= OMAP3430_EN_HDQ_SHIFT,
 	.recalc		= &followparent_recalc,
