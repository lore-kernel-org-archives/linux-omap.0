From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCHv3 1/1] OMAP3: PM: move omap opp layer from pm34xx.c
Date: Wed, 20 Jan 2010 14:40:52 +0200
Message-ID: <20100120124052.GH12231@esdhcp037198.research.nokia.com>
References: <1263983963-18480-1-git-send-email-eduardo.valentin@nokia.com>
 <4B56E5B3.8070303@ti.com>
 <20100120115407.GG12231@esdhcp037198.research.nokia.com>
 <4B56F045.4040708@ti.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:35989 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751931Ab0ATMlA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jan 2010 07:41:00 -0500
Content-Disposition: inline
In-Reply-To: <4B56F045.4040708@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Romit Dasgupta <romit@ti.com>
Cc: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, "Menon, Nishanth" <nm@ti.com>, "Keski-Saari Juha.1 (EXT-Teleca/Helsinki)" <ext-juha.1.keski-saari@nokia.com>, "Cousson, Benoit" <b-cousson@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>

On Wed, Jan 20, 2010 at 01:00:05PM +0100, ext Romit Dasgupta wrote:
> Eduardo Valentin wrote:
> > On Wed, Jan 20, 2010 at 12:14:59PM +0100, ext Romit Dasgupta wrote:
> >>> From: Eduardo Valentin <eduardo.valentin@nokia.com>
> >>>
> >>> OMAP OPP layer functions now have dependencies of CONFIG_CPU_FREQ only.
> >>>
> >>> With this patch, omap opp layer now has its compilation flags
> >>> bound to CONFIG_CPU_FREQ. Also its code has been removed from pm34xx.c.
> >>>
> >>> A new file has been created to contain cpu freq code related to
> >>> OMAP3: cpufreq34xx.c.
> >>>
> >>> Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> >> NAK also for the following  non-working kernel (smartreflex without cpufreq).
> > 
> > Then this is a problem of dependency with smartreflex and cpufreq. In this case
> > better to solve this other problem with another patch. This patch is to rip off
> > cpufreq code from pm34xx, as stated in the above description.
> 
> In that case the right fix should

OK

> 
> 1) __not__ include opp.h for non cpufreq builds

I guess the patch is "more or less" this option, as it maps
all functions inside opp.h to nops if it is a cpufreq build.
And all related real code is not compiled.

Basically removes the opp layer  code if cpufreq is disabled.

One thing I forgot to add here was this part:

diff --git a/arch/arm/plat-omap/include/plat/opp_twl_tps.h b/arch/arm/plat-omap/include/plat/opp
index 8784e5f..0460ca8 100644
--- a/arch/arm/plat-omap/include/plat/opp_twl_tps.h
+++ b/arch/arm/plat-omap/include/plat/opp_twl_tps.h
@@ -15,7 +15,16 @@
 
 #include <linux/kernel.h>
 
+#ifdef CONFIG_CPU_FREQ
 unsigned long omap_twl_vsel_to_uv(const u8 vsel);
 u8 omap_twl_uv_to_vsel(unsigned long uV);
+#else
+static inline unsigned long omap_twl_vsel_to_uv(const u8 vsel)
+{
+}
+static inline u8 omap_twl_uv_to_vsel(unsigned long uV)
+{
+}
+#endif


> OR
> 2) If it includes opp.h the functions for getting current opp
> should abstract out the right mechanism to get current frequency/voltage from
>  the chip/power IC.

I guess this looks as good way to do it. But the patch I sent is more like the first
option and fixes the compilation issue.

> 
> > 
> > And sorry, I didn't get your boot log (if you intended to put it, as you said
> > "following non-working kernel"
> > 
> Actually I meant for the following non-working kernel __configuration__. I do
> not have boot logs!

Ahh. right! No I see. Yeah, as mention in other thread, the patch is meant to fix that one.

-- 
Eduardo Valentin
