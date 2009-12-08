From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 06/10 V3] omap3: pm: use opp accessor functions for
 omap-target
Date: Tue, 8 Dec 2009 09:59:36 +0200
Message-ID: <20091208075936.GD23829@esdhcp037198.research.nokia.com>
References: <1259122159-1583-1-git-send-email-nm@ti.com>
 <1259122159-1583-2-git-send-email-nm@ti.com>
 <1259122159-1583-3-git-send-email-nm@ti.com>
 <1259122159-1583-4-git-send-email-nm@ti.com>
 <1259122159-1583-5-git-send-email-nm@ti.com>
 <1259122159-1583-6-git-send-email-nm@ti.com>
 <1259122159-1583-7-git-send-email-nm@ti.com>
 <87bpiqh4jr.fsf@deeprootsystems.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:25860 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754592AbZLHH7z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Dec 2009 02:59:55 -0500
Content-Disposition: inline
In-Reply-To: <87bpiqh4jr.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: ext Kevin Hilman <khilman@deeprootsystems.com>, linux-omap <linux-omap@vger.kernel.org>, Benoit Cousson <b-cousson@ti.com>, Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>, Paul Walmsley <paul@pwsan.com>, Romit Dasgupta <romit@ti.com>, Sanjeev Premi <premi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>, Thara Gopinath <thara@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>

Hello Nishanth,

Little style comment.

On Wed, Nov 25, 2009 at 06:56:08PM +0100, ext Kevin Hilman wrote:
> Nishanth Menon <nm@ti.com> writes:
> 
> > The logic in omap-target can now be improved with the accessor
> > functions. Dont scan through the list manually, instead use
> > get_next_freq to do the scanning.
> >
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > Cc: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Romit Dasgupta <romit@ti.com>
> > Cc: Sanjeev Premi <premi@ti.com>
> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Cc: Sergio Alberto Aguirre Rodriguez <saaguirre@ti.com>
> > Cc: Thara Gopinath <thara@ti.com>
> > Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>
> >
> > Signed-off-by: Nishanth Menon <nm@ti.com>
> > ---
> >  arch/arm/plat-omap/cpu-omap.c |   19 +++++++++++--------
> >  1 files changed, 11 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
> > index 449b6b6..7b3ca11 100644
> > --- a/arch/arm/plat-omap/cpu-omap.c
> > +++ b/arch/arm/plat-omap/cpu-omap.c
> > @@ -111,14 +111,17 @@ static int omap_target(struct cpufreq_policy *policy,
> >  	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> >  #elif defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
> >  	if (mpu_opps) {
> > -		int ind;
> > -		for (ind = 1; ind <= MAX_VDD1_OPP; ind++) {
> > -			if (mpu_opps[ind].rate/1000 >= target_freq) {
> > -				omap_pm_cpu_set_freq
> > -					(mpu_opps[ind].rate);
> > -				break;
> > -			}
> > -		}
> > +		unsigned long freq = target_freq * 1000;
> > +		struct omap_opp *opp = NULL;
> > +		int res;

Not mandatory, but add a blank line to separate declaration from rest of the code.

> > +		/* see if we have exact freq match */
> > +		res = opp_is_valid(&opp, mpu_opps, freq);
> > +		/* Get next best if we cant find a exact match */
> > +		if (res)
> > +			res = opp_get_higher_opp(&opp, &freq, mpu_opps);
> 
> These two could just be replaced by a single call to
> opp_find_freq_rounding()

Indeed, I also agree here that having a "find_rounded" as a search option
would make sense.

> 
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Eduardo Valentin
