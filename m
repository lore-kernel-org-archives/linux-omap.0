From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCHv3 1/1] OMAP3: PM: move omap opp layer from pm34xx.c
Date: Wed, 20 Jan 2010 14:49:06 +0200
Message-ID: <20100120124906.GI12231@esdhcp037198.research.nokia.com>
References: <1263983963-18480-1-git-send-email-eduardo.valentin@nokia.com>
 <4B56E5B3.8070303@ti.com>
 <20100120115407.GG12231@esdhcp037198.research.nokia.com>
 <4B56F045.4040708@ti.com>
 <20100120124052.GH12231@esdhcp037198.research.nokia.com>
 <4B56FAAF.2070600@ti.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:48766 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349Ab0ATMtU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jan 2010 07:49:20 -0500
Content-Disposition: inline
In-Reply-To: <4B56FAAF.2070600@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Romit Dasgupta <romit@ti.com>
Cc: "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, ext Kevin Hilman <khilman@deeprootsystems.com>, "Menon, Nishanth" <nm@ti.com>, "Keski-Saari Juha.1 (EXT-Teleca/Helsinki)" <ext-juha.1.keski-saari@nokia.com>, "Cousson, Benoit" <b-cousson@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>

On Wed, Jan 20, 2010 at 01:44:31PM +0100, ext Romit Dasgupta wrote:
> Eduardo Valentin wrote:
> > On Wed, Jan 20, 2010 at 01:00:05PM +0100, ext Romit Dasgupta wrote:
> >> Eduardo Valentin wrote:
> >>> On Wed, Jan 20, 2010 at 12:14:59PM +0100, ext Romit Dasgupta wrote:
> >>>>> From: Eduardo Valentin <eduardo.valentin@nokia.com>
> >>>>>
> >>>>> OMAP OPP layer functions now have dependencies of CONFIG_CPU_FREQ only.
> >>>>>
> >>>>> With this patch, omap opp layer now has its compilation flags
> >>>>> bound to CONFIG_CPU_FREQ. Also its code has been removed from pm34xx.c.
> >>>>>
> >>>>> A new file has been created to contain cpu freq code related to
> >>>>> OMAP3: cpufreq34xx.c.
> >>>>>
> >>>>> Signed-off-by: Eduardo Valentin <eduardo.valentin@nokia.com>
> >>>> NAK also for the following  non-working kernel (smartreflex without cpufreq).
> >>> Then this is a problem of dependency with smartreflex and cpufreq. In this case
> >>> better to solve this other problem with another patch. This patch is to rip off
> >>> cpufreq code from pm34xx, as stated in the above description.
> >> In that case the right fix should
> > 
> > OK
> > 
> >> 1) __not__ include opp.h for non cpufreq builds
> > 
> > I guess the patch is "more or less" this option, as it maps
> > all functions inside opp.h to nops if it is a cpufreq build.
> > And all related real code is not compiled.
> > 
> > Basically removes the opp layer  code if cpufreq is disabled.
> > 
> IMHO, making functions return 0 will give you run time issues when opp related
> APIs are called in non cpufreq path. So your patch will for the time being solve
> the build issue but not runtime issue. Hence I suggested to compile out opp.h if
> you are not using cpufreq. Solving a build issue is not the right fix for this.

No, they are cleaned up by compiler. The following:

+static inline unsigned long omap_twl_vsel_to_uv(const u8 vsel)
+{
+	return 0;
+}

will be translated to a nop in final kernel image.

That's the whole idea of this patch.


-- 
Eduardo Valentin
