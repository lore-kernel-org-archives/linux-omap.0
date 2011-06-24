From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
Date: Fri, 24 Jun 2011 11:51:44 +0100
Message-ID: <20110624105144.GL9449@n2100.arm.linux.org.uk>
References: <1308911742-27394-1-git-send-email-premi@ti.com> <1308911742-27394-3-git-send-email-premi@ti.com> <20110624104331.GK9449@n2100.arm.linux.org.uk> <B85A65D85D7EB246BE421B3FB0FBB593024D6C2DD9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47005 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392Ab1FXKvw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jun 2011 06:51:52 -0400
Content-Disposition: inline
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024D6C2DD9@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Jun 24, 2011 at 04:18:31PM +0530, Premi, Sanjeev wrote:
> > -----Original Message-----
> > From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk] 
> > Sent: Friday, June 24, 2011 4:14 PM
> > To: Premi, Sanjeev
> > Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > Subject: Re: [PATCH 2/2] omap2+: pm: cpufreq: Fix 
> > loops_per_jiffy calculation
> > 
> > On Fri, Jun 24, 2011 at 04:05:42PM +0530, Sanjeev Premi wrote:
> > > Currently, loops_per_jiffy is being calculated before calling
> > > cpufreq_notify_transition().
> > > 
> > > However, generic cpufreq driver adjusts the jiffies as well.
> > > Double adjustment leads to incorrect value being assigned to
> > > loops_per_jiffy.
> > 
> > Are you sure the generic cpufreq driver adjusts the per-cpu 
> > loops_per_jiffy
> > values?  I don't believe it does.
> 
> Russell,
> 
> I am quoting the function from drivers/cpufreq/cpufreq.h
> Follow the arrows:

Let's go to war with quotes then, because clearly you haven't read the code
properly:

| #ifndef CONFIG_SMP
^^^^^^^^^^^^^^^^^^^^^
| static unsigned long l_p_j_ref;
| static unsigned int  l_p_j_ref_freq;
| 
| static void adjust_jiffies(unsigned long val, struct cpufreq_freqs *ci)
| {
| 	... code to adjust jiffies ...
| }
| #else
| static inline void adjust_jiffies(unsigned long val, struct cpufreq_freqs *ci)
| {
|         return;
| }
| #endif

Notice how if CONFIG_SMP is set, adjust_jiffies becomes a no-op.  So if
CONFIG_SMP=y, loops_per_jiffy will _not_ be scaled by core code.
