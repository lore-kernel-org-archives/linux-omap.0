From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PM-OPP][PATCH 2/2] omap3: opp: make independent of cpufreq
Date: Wed, 11 Aug 2010 14:42:36 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0324110879@dbde02.ent.ti.com>
References: <1281493018-29294-1-git-send-email-nm@ti.com>
 <1281493018-29294-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53969 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753044Ab0HKJMr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 05:12:47 -0400
In-Reply-To: <1281493018-29294-3-git-send-email-nm@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Paul Walmsley <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Premi, Sanjeev" <premi@ti.com>, Tony Lindgren <tony@atomide.com>



>>-----Original Message-----
>>From: Menon, Nishanth
>>Sent: Wednesday, August 11, 2010 7:47 AM
>>To: linux-omap
>>Cc: Menon, Nishanth; Eduardo Valentin; Kevin Hilman; Paul Walmsley; Nayak, Rajendra; Premi, Sanjeev;
>>Gopinath, Thara; Tony Lindgren
>>Subject: [PM-OPP][PATCH 2/2] omap3: opp: make independent of cpufreq
>>
>>Make opp3xx data which is registered with the opp layer
>>dependent purely on CONFIG_PM as opp layer and pm.c users
>>are CONFIG_PM dependent not cpufreq dependent.
>>so we rename the data definition to opp3xxx_data.c (inline with what
>>we have for omap2), also move the build definition to be under
>>the existing CONFIG_PM build instead of CPUFREQ.
>>
>>Cc: Eduardo Valentin <eduardo.valentin@nokia.com>
>>Cc: Kevin Hilman <khilman@deeprootsystems.com>
>>Cc: Paul Walmsley <paul@pwsan.com>
>>Cc: Rajendra Nayak <rnayak@ti.com>
>>Cc: Sanjeev Premi <premi@ti.com>
>>Cc: Thara Gopinath <thara@ti.com>
>>Cc: Tony Lindgren <tony@atomide.com>
>>
>>Signed-off-by: Nishanth Menon <nm@ti.com>
>>---
>>Note:
>>This takes care of the discussion on opp file renaming and making
>>it independent of cpufreq, unless I missed something else
>>
>> arch/arm/mach-omap2/Makefile                       |    5 +----
>> .../mach-omap2/{cpufreq34xx.c => opp3xxx_data.c}   |    0
>> 2 files changed, 1 insertions(+), 4 deletions(-)
>> rename arch/arm/mach-omap2/{cpufreq34xx.c => opp3xxx_data.c} (100%)

Is this part of PM-OPP branch? Also I was thinking of reusing the same file for OMAP4.
No reason why we should have a different file for OMAP4. So a better name than opp3xxx_data.c?

Regards
Thara
>>
>>diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
>>index 0b188fa..43d7372 100644
>>--- a/arch/arm/mach-omap2/Makefile
>>+++ b/arch/arm/mach-omap2/Makefile
>>@@ -58,11 +58,8 @@ obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS3)	+= smartreflex-class3.o
>> AFLAGS_sleep24xx.o			:=-Wa,-march=armv6
>> AFLAGS_sleep34xx.o			:=-Wa,-march=armv7-a
>>
>>-endif
>>+obj-$(CONFIG_ARCH_OMAP3)		+= opp3xxx_data.o
>>
>>-# CPU Frequency
>>-ifeq ($(CONFIG_CPU_FREQ),y)
>>-obj-$(CONFIG_ARCH_OMAP3)		+= cpufreq34xx.o
>> endif
>>
>> # PRCM
>>diff --git a/arch/arm/mach-omap2/cpufreq34xx.c b/arch/arm/mach-omap2/opp3xxx_data.c
>>similarity index 100%
>>rename from arch/arm/mach-omap2/cpufreq34xx.c
>>rename to arch/arm/mach-omap2/opp3xxx_data.c
>>--
>>1.6.3.3

