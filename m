From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv13 00/40] ARM: TI SoC clock DT conversion
Date: Tue, 14 Jan 2014 14:41:40 +0200
Message-ID: <52D53084.1070105@ti.com>
References: <1389276051-1326-1-git-send-email-t-kristo@ti.com> <52CF12FB.6000602@ti.com> <20140109231513.GA11648@saruman.home> <52CFC2F1.706@ti.com> <20140110161352.GG6665@saruman.home> <52D02037.3090705@ti.com> <20140110185110.GM31323@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37522 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751329AbaANMmL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Jan 2014 07:42:11 -0500
In-Reply-To: <20140110185110.GM31323@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: balbi@ti.com, Nishanth Menon <nm@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On 01/10/2014 08:51 PM, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [140110 08:32]:
>> On 01/10/2014 06:13 PM, Felipe Balbi wrote:
>>> On Fri, Jan 10, 2014 at 11:52:49AM +0200, Tero Kristo wrote:
>>>> On 01/10/2014 01:15 AM, Felipe Balbi wrote:
>>>>> On Thu, Jan 09, 2014 at 03:22:03PM -0600, Nishanth Menon wrote:
>>>>>>
>>>>>> conflicts with be changes on Tony's be branch.
>>>>>> commit 80f304dd2360cf5d50953c4eb4e902536f6a1263
>>>>>>      ARM: OMAP2+: raw read and write endian fix
>>>>>>
>>>>>> Conflict:
>>>>>> arch/arm/mach-omap2/clkt_clksel.c
>>>>>> arch/arm/mach-omap2/clkt_dpll.c
>>>>>> arch/arm/mach-omap2/clkt_iclk.c
>>>>>> arch/arm/mach-omap2/clock.c
>>>>>> arch/arm/mach-omap2/clock36xx.c
>>>>>> arch/arm/mach-omap2/dpll3xxx.c
>>>>>> arch/arm/mach-omap2/dpll44xx.c
>>>>>>
>>>>>> Both change raw_readls -> should now be just clk api instead which
>>>>>> already does readl_relaxed etc.. If Tony feels like, then we should
>>>>>> probably post a branch based on 'be' branch for easy merge.
>
> This should be a trivial merge conflict to handle, so let's not base
> things on the BE changes.
>
>>>> I think all of these fails are caused by the initially bugged
>>>> Makefile + Kconfig under mach-omap2. Seems like they can be fixed by
>>>> the patches I inlined at the end (will also post them as proper
>>>> patches to l-o list after this.) The question is, should Mike go
>>>> ahead and merge these along with the base clk patches or how should
>>>> we handle them? Patch 1 must be merged, patch 2 is a nice to have one
>>>> which allows DRA7 only builds (doing DRA7 only build currently seems
>>>> not possible.)
>>>
>>> If it's OK with Tony, I would suggest having a branch with both patches
>>> below which both Tony and Mike merge before merging CCF series. That way
>>> we avoid bisection problems.
>
> I can queue those two separately as fixes.
>
>> That reminds me, I think the baseline branch for the mach-omap2
>> patches is still somewhat unclear to me, what should be used for
>> this? And which patches should be put there (the mach-omap2 patches
>> depend on the drivers/clk/ti part basically, so I need to put at
>> least those there also.)
>
> I would keep the clock patches against some mainline -rc commit if
> possible, and if there are non trivial merge conflicts, the omap
> to use as the base is commit adfe9361b236154215d4b0fc8b6d79995394b15c.
>
> In any case, it's probably best that Mike merges this all via his
> clock tree unless there non-trivial merge conflicts.
>

I just pushed a branch against rc7 with makefile fixes in place to fix 
omap1 and omap2 only builds for this stuff. Inlined the delta here at 
the end. Do you want me to repost the series as v14 for this or is the 
attached delta ok for review purposes? All the changes have been 
squashed to existing patches (except the 2 patches I posted separately 
for DRA7xx / AM43xx only builds.)

The test branch itself can be found here:

tree: https://github.com/t-kristo/linux-pm.git
branch: 3.13-rc7-dt-clks-v13-build-fixes

Felipe, care to run your randconfig magic for this?

-Tero

----------------
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
index 088305f..8ebe9f3 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -132,6 +132,7 @@ obj-$(CONFIG_SOC_AM33XX)		+= $(voltagedomain-common)
  obj-$(CONFIG_SOC_AM43XX)		+= $(voltagedomain-common)
  obj-$(CONFIG_SOC_OMAP5)			+= $(voltagedomain-common)
  obj-$(CONFIG_SOC_OMAP5)                += voltagedomains54xx_data.o
+obj-$(CONFIG_SOC_DRA7XX)		+= $(voltagedomain-common)

  # OMAP powerdomain framework
  powerdomain-common			+= powerdomain.o powerdomain-common.o
@@ -191,6 +192,9 @@ obj-$(CONFIG_ARCH_OMAP4)		+= dpll3xxx.o dpll44xx.o
  obj-$(CONFIG_SOC_AM33XX)		+= $(clock-common) dpll3xxx.o
  obj-$(CONFIG_SOC_OMAP5)			+= $(clock-common)
  obj-$(CONFIG_SOC_OMAP5)			+= dpll3xxx.o dpll44xx.o
+obj-$(CONFIG_SOC_DRA7XX)		+= $(clock-common)
+obj-$(CONFIG_SOC_DRA7XX)		+= dpll3xxx.o dpll44xx.o
+obj-$(CONFIG_SOC_AM43XX)		+= $(clock-common) dpll3xxx.o

  # OMAP2 clock rate set data (old "OPP" data)
  obj-$(CONFIG_SOC_OMAP2420)		+= opp2420_data.o
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index c61f768..41bd909 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -35,7 +35,7 @@ obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
  obj-$(CONFIG_PLAT_SAMSUNG)	+= samsung/
  obj-$(CONFIG_COMMON_CLK_XGENE)  += clk-xgene.o
  obj-$(CONFIG_COMMON_CLK_KEYSTONE)	+= keystone/
-obj-$(CONFIG_ARCH_OMAP)		+= ti/
+obj-$(CONFIG_ARCH_OMAP2PLUS)	+= ti/

  obj-$(CONFIG_X86)		+= x86/

diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index 007c3c2..4319d40 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -1,10 +1,11 @@
  ifneq ($(CONFIG_OF),)
-obj-y					+= clk.o dpll.o autoidle.o divider.o \
-					   fixed-factor.o gate.o clockdomain.o \
-					   composite.o mux.o apll.o clk-43xx.o
-obj-$(CONFIG_SOC_AM33XX)		+= clk-33xx.o
-obj-$(CONFIG_ARCH_OMAP3)		+= interface.o clk-3xxx.o
-obj-$(CONFIG_ARCH_OMAP4)		+= clk-44xx.o
-obj-$(CONFIG_SOC_OMAP5)			+= clk-54xx.o
-obj-$(CONFIG_SOC_DRA7XX)		+= clk-7xx.o
+obj-y					+= clk.o autoidle.o clockdomain.o
+clk-common				= dpll.o composite.o divider.o gate.o \
+					  fixed-factor.o mux.o apll.o
+obj-$(CONFIG_SOC_AM33XX)		+= $(clk-common) clk-33xx.o
+obj-$(CONFIG_ARCH_OMAP3)		+= $(clk-common) interface.o clk-3xxx.o
+obj-$(CONFIG_ARCH_OMAP4)		+= $(clk-common) clk-44xx.o
+obj-$(CONFIG_SOC_OMAP5)			+= $(clk-common) clk-54xx.o
+obj-$(CONFIG_SOC_DRA7XX)		+= $(clk-common) clk-7xx.o
+obj-$(CONFIG_SOC_AM43XX)		+= $(clk-common) clk-43xx.o
  endif


