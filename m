From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 2/2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
Date: Fri, 24 Jun 2011 16:41:11 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D6C2E04@dbde02.ent.ti.com>
References: <1308911742-27394-1-git-send-email-premi@ti.com>
 <1308911742-27394-3-git-send-email-premi@ti.com>
 <20110624104331.GK9449@n2100.arm.linux.org.uk>
 <B85A65D85D7EB246BE421B3FB0FBB593024D6C2DD9@dbde02.ent.ti.com>
 <20110624105144.GL9449@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35383 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753197Ab1FXLLZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jun 2011 07:11:25 -0400
In-Reply-To: <20110624105144.GL9449@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk] 
> Sent: Friday, June 24, 2011 4:22 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 2/2] omap2+: pm: cpufreq: Fix 
> loops_per_jiffy calculation
> 
> On Fri, Jun 24, 2011 at 04:18:31PM +0530, Premi, Sanjeev wrote:
> > > -----Original Message-----
> > > From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk] 
> > > Sent: Friday, June 24, 2011 4:14 PM
> > > To: Premi, Sanjeev
> > > Cc: linux-omap@vger.kernel.org; 
> linux-arm-kernel@lists.infradead.org
> > > Subject: Re: [PATCH 2/2] omap2+: pm: cpufreq: Fix 
> > > loops_per_jiffy calculation
> > > 
> > > On Fri, Jun 24, 2011 at 04:05:42PM +0530, Sanjeev Premi wrote:
> > > > Currently, loops_per_jiffy is being calculated before calling
> > > > cpufreq_notify_transition().
> > > > 
> > > > However, generic cpufreq driver adjusts the jiffies as well.
> > > > Double adjustment leads to incorrect value being assigned to
> > > > loops_per_jiffy.
> > > 
> > > Are you sure the generic cpufreq driver adjusts the per-cpu 
> > > loops_per_jiffy
> > > values?  I don't believe it does.
> > 
> > Russell,
> > 
> > I am quoting the function from drivers/cpufreq/cpufreq.h
> > Follow the arrows:
> 
> Let's go to war with quotes then, because clearly you haven't 
> read the code
> properly:

[sp] Peace. No war!
     Looks like I missed the ifndef in systax highlighting on my
     editor. As mentioned, I couldn't test on OMAP4.
     The patch obvioulsy works for A8... SMP needs to be fixed.
     v2 coming soon.

~sanjeev

> 
> | #ifndef CONFIG_SMP
> ^^^^^^^^^^^^^^^^^^^^^
> | static unsigned long l_p_j_ref;
> | static unsigned int  l_p_j_ref_freq;
> | 
> | static void adjust_jiffies(unsigned long val, struct 
> cpufreq_freqs *ci)
> | {
> | 	... code to adjust jiffies ...
> | }
> | #else
> | static inline void adjust_jiffies(unsigned long val, struct 
> cpufreq_freqs *ci)
> | {
> |         return;
> | }
> | #endif
> 
> Notice how if CONFIG_SMP is set, adjust_jiffies becomes a 
> no-op.  So if
> CONFIG_SMP=y, loops_per_jiffy will _not_ be scaled by core code.
> 