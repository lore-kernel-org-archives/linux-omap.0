From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] cpufreq: OMAP: fix build errors: depends on
	ARCH_OMAP2PLUS
Date: Fri, 13 Apr 2012 19:53:22 +0100
Message-ID: <20120413185322.GG25053@n2100.arm.linux.org.uk>
References: <1332807568-638-1-git-send-email-khilman@ti.com> <4F7CC926.5050300@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4F7CC926.5050300@ti.com>
Sender: cpufreq-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, Dave Jones <davej@redhat.com>
Cc: cpufreq@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grazvydas Ignotas <notasas@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 04, 2012 at 03:20:22PM -0700, Kevin Hilman wrote:
> Hi Dave,
>
> On 03/26/2012 05:19 PM, Kevin Hilman wrote:
>> The OMAP driver needs a 'depends on ARCH_OMAP2PLUS' since it only
>> builds for OMAP2+ platforms.
>>
>> This 'depends on' was in the original patch from Russell King, but was
>> erroneously removed by me when making this option user-selectable in
>> commit b09db45c (cpufreq: OMAP driver depends CPUfreq tables.)  This
>> patch remedies that.
>>
>> Apologies to Russell King for breaking his originally working patch.
>>
>> Also, thanks to Grazvydas Ignotas for reporting the same problem.
>>
>> Cc: Russell King<rmk+kernel@arm.linux.org.uk>
>> Cc: Grazvydas Ignotas<notasas@gmail.com>
>> Signed-off-by: Kevin Hilman<khilman@ti.com>
>> ---
>> Dave, this applies on top of your current fixes branch, and fixes a
>> problem introduced there by me.  Please merge for v3.4-rc.  Thanks.
>
> Can you pick this up for v3.4-rc?

Right, I'm fed up with chasing over this trivial patch.  It's been almost
a full month since the problem was first reported and it _still_ remains
unfixed in mainline, despite me chasing over it.  So, sorry, you lose.

I'm merging my fix (attached) which I've been running against the nightly
builds into my fixes branch and will ask Linus to pull it this weekend.
If you want something else, then please send a patch on top of my fix to
do what you want.

Alternatively, send a replacement fix to Linus _before_ Sunday evening
copying me with it and I'll drop this from my tree.  But I want to see
an alternative going to Linus for that to happen.

8<===
From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH] ARM: OMAP: fix cpufreq build

OMAPs cpufreq requires the frequency table support, but nothing ensures
that this is selected.  This can result in configurations which fail to
build:

drivers/built-in.o:(.data+0x5238): undefined reference to `cpufreq_freq_attr_scaling_available_freqs'
drivers/cpufreq/omap-cpufreq.c:88: undefined reference to `cpufreq_frequency_table_target'
drivers/cpufreq/omap-cpufreq.c:60: undefined reference to `cpufreq_frequency_table_verify'
drivers/cpufreq/omap-cpufreq.c:186: undefined reference to `cpufreq_frequency_table_cpuinfo'
drivers/cpufreq/omap-cpufreq.c:190: undefined reference to `cpufreq_frequency_table_get_attr'

Fix this by introducing a new configuration variable and having that
select CPU_FREQ_TABLE.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |    2 +-
 arch/arm/mach-omap2/clock.c                  |    2 +-
 arch/arm/mach-omap2/clock.h                  |    2 +-
 arch/arm/plat-omap/clock.c                   |    2 +-
 arch/arm/plat-omap/include/plat/clock.h      |    4 ++--
 drivers/cpufreq/Kconfig.arm                  |    4 ++--
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
index 7072e0d..ad35d4e 100644
--- a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
+++ b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
@@ -166,7 +166,7 @@ int omap2_select_table_rate(struct clk *clk, unsigned long rate)
 	return 0;
 }
 
-#ifdef CONFIG_CPU_FREQ
+#ifdef CONFIG_ARM_OMAP2PLUS_CPUFREQ
 /*
  * Walk PRCM rate table and fillout cpufreq freq_table
  * XXX This should be replaced by an OPP layer in the near future
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index f57ed5b..450feb0 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -536,7 +536,7 @@ struct clk_functions omap2_clk_functions = {
 	.clk_set_rate		= omap2_clk_set_rate,
 	.clk_set_parent		= omap2_clk_set_parent,
 	.clk_disable_unused	= omap2_clk_disable_unused,
-#ifdef CONFIG_CPU_FREQ
+#ifdef CONFIG_ARM_OMAP2PLUS_CPUFREQ
 	/* These will be removed when the OPP code is integrated */
 	.clk_init_cpufreq_table	= omap2_clk_init_cpufreq_table,
 	.clk_exit_cpufreq_table	= omap2_clk_exit_cpufreq_table,
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index b8c2a68..f331cfc 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -146,7 +146,7 @@ extern const struct clksel_rate gpt_sys_rates[];
 extern const struct clksel_rate gfx_l3_rates[];
 extern const struct clksel_rate dsp_ick_rates[];
 
-#if defined(CONFIG_ARCH_OMAP2) && defined(CONFIG_CPU_FREQ)
+#if defined(CONFIG_ARCH_OMAP2) && defined(CONFIG_ARM_OMAP2PLUS_CPUFREQ)
 extern void omap2_clk_init_cpufreq_table(struct cpufreq_frequency_table **table);
 extern void omap2_clk_exit_cpufreq_table(struct cpufreq_frequency_table **table);
 #else
diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 8506cbb..304bf4e 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -398,7 +398,7 @@ struct clk dummy_ck = {
 	.ops	= &clkops_null,
 };
 
-#ifdef CONFIG_CPU_FREQ
+#ifdef CONFIG_ARM_OMAP2PLUS_CPUFREQ
 void clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
 {
 	unsigned long flags;
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 240a7b9..879ba27 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -283,7 +283,7 @@ struct clk_functions {
 	void		(*clk_allow_idle)(struct clk *clk);
 	void		(*clk_deny_idle)(struct clk *clk);
 	void		(*clk_disable_unused)(struct clk *clk);
-#ifdef CONFIG_CPU_FREQ
+#ifdef CONFIG_ARM_OMAP2PLUS_CPUFREQ
 	void		(*clk_init_cpufreq_table)(struct cpufreq_frequency_table **);
 	void		(*clk_exit_cpufreq_table)(struct cpufreq_frequency_table **);
 #endif
@@ -301,7 +301,7 @@ extern void recalculate_root_clocks(void);
 extern unsigned long followparent_recalc(struct clk *clk);
 extern void clk_enable_init_clocks(void);
 unsigned long omap_fixed_divisor_recalc(struct clk *clk);
-#ifdef CONFIG_CPU_FREQ
+#ifdef CONFIG_ARM_OMAP2PLUS_CPUFREQ
 extern void clk_init_cpufreq_table(struct cpufreq_frequency_table **table);
 extern void clk_exit_cpufreq_table(struct cpufreq_frequency_table **table);
 #endif
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index ffbb446..9e8f7a9 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -3,8 +3,8 @@
 #
 
 config ARM_OMAP2PLUS_CPUFREQ
-	bool "TI OMAP2+"
-	default ARCH_OMAP2PLUS
+	def_bool y
+	depends on ARCH_OMAP2PLUS
 	select CPU_FREQ_TABLE
 
 config ARM_S3C2416_CPUFREQ
-- 
1.7.4.4

