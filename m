From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH D 01/11] OMAP: Add clk_get_parent() for OMAP2/3
Date: Wed, 28 Jan 2009 12:18:16 -0700
Message-ID: <20090128191807.16688.91255.stgit@localhost.localdomain>
References: <20090128191638.16688.33452.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60904 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754AbZA1U1Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 15:27:24 -0500
In-Reply-To: <20090128191638.16688.33452.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Cc: linux-omap@vger.kernel.org, =?utf-8?b?TcOlbnM=?= =?utf-8?b?UnVsbGfDpXJk?= <mans@mansr.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

=46rom: Mans Rullgard <mans@mansr.com>

This makes clk_get_parent() work on OMAP2/3.

linux-omap source commit is efd65273726b12e42c7225bd1703e5252bdb46c0.

Signed-off-by: M=C3=A5ns Rullg=C3=A5rd <mans@mansr.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock.c     |    5 +++++
 arch/arm/mach-omap2/clock.h     |    1 +
 arch/arm/mach-omap2/clock24xx.c |    1 +
 arch/arm/mach-omap2/clock34xx.c |    1 +
 4 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index e57694f..9957813 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -870,6 +870,11 @@ int omap2_clk_set_parent(struct clk *clk, struct c=
lk *new_parent)
 	return 0;
 }
=20
+struct clk *omap2_clk_get_parent(struct clk *clk)
+{
+	return clk->parent;
+}
+
 /* DPLL rate rounding code */
=20
 /**
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 72bb320..4dbd582 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -44,6 +44,7 @@ int omap2_clk_set_rate(struct clk *clk, unsigned long=
 rate);
 int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent);
 int omap2_dpll_set_rate_tolerance(struct clk *clk, unsigned int tolera=
nce);
 long omap2_dpll_round_rate(struct clk *clk, unsigned long target_rate)=
;
+struct clk *omap2_clk_get_parent(struct clk *clk);
=20
 #ifdef CONFIG_OMAP_RESET_CLOCKS
 void omap2_clk_disable_unused(struct clk *clk);
diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/cloc=
k24xx.c
index a2c13ef..2398711 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -436,6 +436,7 @@ static struct clk_functions omap2_clk_functions =3D=
 {
 	.clk_round_rate		=3D omap2_clk_round_rate,
 	.clk_set_rate		=3D omap2_clk_set_rate,
 	.clk_set_parent		=3D omap2_clk_set_parent,
+	.clk_get_parent		=3D omap2_clk_get_parent,
 	.clk_disable_unused	=3D omap2_clk_disable_unused,
 #ifdef	CONFIG_CPU_FREQ
 	.clk_init_cpufreq_table	=3D omap2_clk_init_cpufreq_table,
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/cloc=
k34xx.c
index 33d5a51..0c8d88e 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -565,6 +565,7 @@ static struct clk_functions omap2_clk_functions =3D=
 {
 	.clk_round_rate		=3D omap2_clk_round_rate,
 	.clk_set_rate		=3D omap2_clk_set_rate,
 	.clk_set_parent		=3D omap2_clk_set_parent,
+	.clk_get_parent		=3D omap2_clk_get_parent,
 	.clk_disable_unused	=3D omap2_clk_disable_unused,
 };
=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
