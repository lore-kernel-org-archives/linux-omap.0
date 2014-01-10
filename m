From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv13 00/40] ARM: TI SoC clock DT conversion
Date: Fri, 10 Jan 2014 11:52:49 +0200
Message-ID: <52CFC2F1.706@ti.com>
References: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
 <52CF12FB.6000602@ti.com> <20140109231513.GA11648@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140109231513.GA11648@saruman.home>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: balbi@ti.com, Nishanth Menon <nm@ti.com>
Cc: devicetree@vger.kernel.org, paul@pwsan.com, mturquette@linaro.org, tony@atomide.com, rnayak@ti.com, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 01/10/2014 01:15 AM, Felipe Balbi wrote:
> Hi,
>
> On Thu, Jan 09, 2014 at 03:22:03PM -0600, Nishanth Menon wrote:
>>> So, bad luck number release for this, as v12 wasn't sufficient still.
>>>
>>> Changes compared to previous version:
>>> - Dropped any changes to generic clock drivers, as it seems impossible
>>>    to agree anything in short term, this means the patch set shrank in
>>>    size from 49 patches to 40 (first 9 patches were dropped).
>>> - Copy pasted implementation for clk-divider and clk-mux from drivers/clk
>>>    to drivers/clk/ti, and made the modifications needed to the TI version
>>>    of the clock drivers only (based on discussions with Mike, this is fine)
>>> - Changed name of clk_ll_ops to ti_clk_ll_ops so that this doesn't conflict
>>>    with any generic implementation we might have at some point, migrating
>>>    this to the generic version should be easy enough also.
>>> - Fixed trace_clk_div_div_ck for omap4, this node was broken in previous
>>>    versions and resulted into an orphan clock node
>>> - Fixed compile problem for omap5 only build reported by Felipe
>>> - Fixed a couple of sparse warnings
>>> - changed the mach-omap2/clock.c to use readl_relaxed / writel_relaxed
>>>    instead of __raw_readl / __raw_writel
>>>
>>> Testing done:
>>> - omap3-beagle: boot / suspend-resume (RET) / suspend-resume (OFF)
>>> - omap4-panda-es: boot / suspend-resume (RET)
>>> - omap5-uevm: boot
>>> - am335x-bone: boot
>>> - dra7-evm: boot
>>>
>>> Maintainer friendly branches also available:
>>>
>>> tree: https://github.com/t-kristo/linux-pm.git
>>>
>>> clk driver only (Mike): clk-next-dt-clks-v13
>>> DTS data only (Benoit): dts_for_3.14-dt-clks-v13
>>> full-branch (Tony/Paul): 3.13-rc7-dt-clks-v13
>>>
>>> -Tero
>>>
>>
>> Maintainer branches conflicts (using 3.13-rc7-dt-clks-v13):
>> =============================
>> Conflict resolution during rebase to maintainer's -14 branches:
>>
>> 1. (trivial) Against mike's clk-next dbdf6ff Merge branch
>> 'clk-next-unregister' into clk-next
>>
>> Could not apply 2edf7ad... CLK: TI: add DT alias clock registration
>> mechanism
>> conflict drivers/clk/Makefile (trivial fix)
>>
>> 2. (manual, but changes are easy) Against Tony's omap-for-v3.14/be
>> fc6ca98 ARM: OMAP: debug-leds: raw read and write endian fix
>>
>> ARM: OMAP2+: clock: use driver API instead of direct memory read/write
>>
>> conflicts with be changes on Tony's be branch.
>> commit 80f304dd2360cf5d50953c4eb4e902536f6a1263
>>      ARM: OMAP2+: raw read and write endian fix
>>
>> Conflict:
>> arch/arm/mach-omap2/clkt_clksel.c
>> arch/arm/mach-omap2/clkt_dpll.c
>> arch/arm/mach-omap2/clkt_iclk.c
>> arch/arm/mach-omap2/clock.c
>> arch/arm/mach-omap2/clock36xx.c
>> arch/arm/mach-omap2/dpll3xxx.c
>> arch/arm/mach-omap2/dpll44xx.c
>>
>> Both change raw_readls -> should now be just clk api instead which
>> already does readl_relaxed etc.. If Tony feels like, then we should
>> probably post a branch based on 'be' branch for easy merge.
>>
>> 3. I could not detect any merge conflict against Benoit's queued up
>> series (but maybe he has'nt pushed everything to remote tree)..
>>
>>
>> Patch verification report:
>> ==========================
>> Report: http://pastebin.mozilla.org/3976492
>>
>>
>> * sparse warning added in [PATCH 06/40] CLK: ti: add support for ti
>> divider-clock, [PATCH 10/40] clk: ti: add support for basic mux clock
>> +drivers/clk/ti/divider.c: warning: context imbalance in
>> 'ti_clk_divider_set_rate' - different lock contexts for basic block
>> +drivers/clk/ti/mux.c: warning: context imbalance in
>> 'ti_clk_mux_set_parent' - different lock contexts for basic block
>>
>> * checkpatch warning [PATCH 16/40] CLK: TI: add am33xx clock init
>> file, [PATCH 18/40] CLK: TI: add omap3 clock init file
>> WARNING: static const char * array should probably be static const
>> char * const
>>
>>
>> Boot reports:
>> =============
>> - previous orphan clocks seem solved.
>> - All available platforms seem to boot fine and no regression could be
>> seen on initial view
>>
>> OMAP2430:
>>    1. SDP2430
>>      before: http://pastebin.mozilla.org/3976359
>>      after: http://pastebin.mozilla.org/3976467
>>
>> AM335x:
>>    2. am335x-evm
>>      before: http://pastebin.mozilla.org/3976284
>>      after: http://pastebin.mozilla.org/3976374
>>    3. am335x-sk
>>      before: http://pastebin.mozilla.org/3976295
>>      after: http://pastebin.mozilla.org/3976375
>>    4. BeagleBone Black:
>>      before: http://pastebin.mozilla.org/3976321
>>      after: http://pastebin.mozilla.org/3976441
>>
>> AM3517:
>>    5. am3517-evm
>>      before: http://pastebin.mozilla.org/3976297
>>      after: http://pastebin.mozilla.org/3976397
>>    6. craneboard
>>      before: http://pastebin.mozilla.org/3976322
>>      after: http://pastebin.mozilla.org/3976452
>>
>> OMAP3430:
>>    7. ldp
>>      before: http://pastebin.mozilla.org/3976356
>>      after: http://pastebin.mozilla.org/3976455
>>    8. sdp3430
>>      before: http://pastebin.mozilla.org/3976360
>>      after: http://pastebin.mozilla.org/3976468
>>
>> OMAP3630/DM3730:
>>    9. am37x-evm
>>      before: http://pastebin.mozilla.org/3976300
>>      after: http://pastebin.mozilla.org/3976398
>>    10. beagle-XM
>>      before: http://pastebin.mozilla.org/3976319
>>      after: http://pastebin.mozilla.org/3976440
>>
>> OMAP4430:
>>    11. SDP4430
>>      before: http://pastebin.mozilla.org/3976361
>>      after: http://pastebin.mozilla.org/3976470
>>
>> OMAP4460:
>>    12. PandaBoard-ES
>>      before: http://pastebin.mozilla.org/3976358
>>      after: http://pastebin.mozilla.org/3976456
>>
>> OMAP5432:
>>    13. OMAP5uEVM
>>      before: http://pastebin.mozilla.org/3976362 (no boot)
>>      after: http://pastebin.mozilla.org/3976471 (boot)
>>
>> DRA7:
>>    14. dra7evm
>>      before: http://pastebin.mozilla.org/3976354 (no boot)
>>      after: http://pastebin.mozilla.org/3976453 (boot)
>>
>> AM437x:
>>    15. am43xx-epos + out-of-tree patches for engineering samples
>>      before: http://pastebin.mozilla.org/3976306 (no boot)
>>      after: http://pastebin.mozilla.org/3976399 (boot)
>
> to add here, I ran 70 different randconfigs, all seeds are available on
> pastebin (took RMK's 4430sdp seed as a starting point):
>
> am33xx-only.config	http://pastebin.com/nVA3xSwb
> am43xx-only.config	http://pastebin.com/RbUdKuUh
> dra7xx-only.config	http://pastebin.com/ribnaSzS
> omap2-only.config	http://pastebin.com/QPUG0wqe
> omap3-only.config	http://pastebin.com/B8ctX8yM
> omap4-only.config	http://pastebin.com/3D8NAExm
> omap5-only.config	http://pastebin.com/3mtQN38Z
>
> Had a total of 16 failing builds, all .configs were also published on
> pastebin:
>
> config-am33xx-only.config-1	http://pastebin.com/5xhXZpev
> config-am33xx-only.config-2	http://pastebin.com/NsrruJcQ
> config-am33xx-only.config-3	http://pastebin.com/CGbB3qb8
> config-am33xx-only.config-4	http://pastebin.com/86cu0uZ1
> config-am43xx-only.config-1	http://pastebin.com/MCBCAd4X
> config-am43xx-only.config-3	http://pastebin.com/hVpCgwSn
> config-am43xx-only.config-4	http://pastebin.com/8SXAKHed
> config-am43xx-only.config-6	http://pastebin.com/59riPMfw
> config-am43xx-only.config-8	http://pastebin.com/03bt2VEZ
> config-am43xx-only.config-9	http://pastebin.com/tePGwtWA
> config-am43xx-only.config-10	http://pastebin.com/nrtXPqrF
> config-omap2-only.config-2	http://pastebin.com/AKyvMqQU
> config-omap2-only.config-4	http://paste.debian.net/75329
> config-omap2-only.config-5	http://paste.debian.net/75330/
> config-omap2-only.config-7	http://paste.debian.net/75332/
> config-omap2-only.config-10	http://paste.debian.net/75333/
>
> Failing configs all build fine on v3.13-rc7 except for
> config-omap2-only.config-10, which fails due to a broken staging driver.
>

I think all of these fails are caused by the initially bugged Makefile + 
Kconfig under mach-omap2. Seems like they can be fixed by the patches I 
inlined at the end (will also post them as proper patches to l-o list 
after this.) The question is, should Mike go ahead and merge these along 
with the base clk patches or how should we handle them? Patch 1 must be 
merged, patch 2 is a nice to have one which allows DRA7 only builds 
(doing DRA7 only build currently seems not possible.)

-Tero

-----------

 From f552421bbfe85ffba1f10df7a286216aa822a749 Mon Sep 17 00:00:00 2001
From: Tero Kristo <t-kristo@ti.com>
Date: Fri, 10 Jan 2014 11:20:18 +0200
Subject: [PATCH 1/2] ARM: DRA7XX/AM43XX: randconfig fixes

DRA7XX and AM43XX were missing common clock code from the Makefile, which
causes build breakage in DRA7XX / AM43XX only builds once clock support
for these SoCs is added. Add the missing entries to the Makefile as
preparation of this.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
  arch/arm/mach-omap2/Makefile |    3 +++
  1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 088305f..96a990f 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -191,6 +191,9 @@ obj-$(CONFIG_ARCH_OMAP4)		+= dpll3xxx.o dpll44xx.o
  obj-$(CONFIG_SOC_AM33XX)		+= $(clock-common) dpll3xxx.o
  obj-$(CONFIG_SOC_OMAP5)			+= $(clock-common)
  obj-$(CONFIG_SOC_OMAP5)			+= dpll3xxx.o dpll44xx.o
+obj-$(CONFIG_SOC_DRA7XX)		+= $(clock-common)
+obj-$(CONFIG_SOC_DRA7XX)		+= dpll3xxx.o dpll44xx.o
+obj-$(CONFIG_SOC_AM43XX)		+= $(clock-common) dpll3xxx.o

  # OMAP2 clock rate set data (old "OPP" data)
  obj-$(CONFIG_SOC_OMAP2420)		+= opp2420_data.o
-- 
1.7.9.5

------------------

 From 14d3443d5fd8d16d4422de84cff16f4bc78f03dc Mon Sep 17 00:00:00 2001
From: Tero Kristo <t-kristo@ti.com>
Date: Fri, 10 Jan 2014 11:25:28 +0200
Subject: [PATCH 2/2] ARM: DRA7XX: Add support for DRA7XX only build

SOC_DRA7XX was under wrong menu within Kconfig file, which prevented
DRA7XX only build. Fixed the kconfig options for this SoC as we are
there. voltage.c needs to be added to the DRA7XX build also, otherwise
DRA7XX only build will fail.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
  arch/arm/mach-omap2/Kconfig  |   18 ++++++++++--------
  arch/arm/mach-omap2/Makefile |    1 +
  2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index dc21df1..e65948a 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -76,6 +76,16 @@ config SOC_AM43XX
  	select ARM_GIC
  	select MACH_OMAP_GENERIC

+config SOC_DRA7XX
+	bool "TI DRA7XX"
+	depends on ARCH_MULTI_V7
+	select ARCH_OMAP2PLUS
+	select ARM_CPU_SUSPEND if PM
+	select ARM_GIC
+	select CPU_V7
+	select HAVE_SMP
+	select HAVE_ARM_ARCH_TIMER
+
  config ARCH_OMAP2PLUS
  	bool
  	select ARCH_HAS_BANDGAP
@@ -128,14 +138,6 @@ config SOC_HAS_REALTIME_COUNTER
  	depends on SOC_OMAP5 || SOC_DRA7XX
  	default y

-config SOC_DRA7XX
-	bool "TI DRA7XX"
-	select ARM_ARCH_TIMER
-	select CPU_V7
-	select ARM_GIC
-	select HAVE_SMP
-	select COMMON_CLK
-
  comment "OMAP Core Type"
  	depends on ARCH_OMAP2

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 96a990f..8ebe9f3 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -132,6 +132,7 @@ obj-$(CONFIG_SOC_AM33XX)		+= $(voltagedomain-common)
  obj-$(CONFIG_SOC_AM43XX)		+= $(voltagedomain-common)
  obj-$(CONFIG_SOC_OMAP5)			+= $(voltagedomain-common)
  obj-$(CONFIG_SOC_OMAP5)                += voltagedomains54xx_data.o
+obj-$(CONFIG_SOC_DRA7XX)		+= $(voltagedomain-common)

  # OMAP powerdomain framework
  powerdomain-common			+= powerdomain.o powerdomain-common.o
-- 
1.7.9.5
