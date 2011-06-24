From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH 2/2] omap2+: pm: cpufreq: Fix loops_per_jiffy	calculation
Date: Fri, 24 Jun 2011 16:18:31 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D6C2DD9@dbde02.ent.ti.com>
References: <1308911742-27394-1-git-send-email-premi@ti.com>
 <1308911742-27394-3-git-send-email-premi@ti.com>
 <20110624104331.GK9449@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34466 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751769Ab1FXKso convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jun 2011 06:48:44 -0400
In-Reply-To: <20110624104331.GK9449@n2100.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk] 
> Sent: Friday, June 24, 2011 4:14 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 2/2] omap2+: pm: cpufreq: Fix 
> loops_per_jiffy calculation
> 
> On Fri, Jun 24, 2011 at 04:05:42PM +0530, Sanjeev Premi wrote:
> > Currently, loops_per_jiffy is being calculated before calling
> > cpufreq_notify_transition().
> > 
> > However, generic cpufreq driver adjusts the jiffies as well.
> > Double adjustment leads to incorrect value being assigned to
> > loops_per_jiffy.
> 
> Are you sure the generic cpufreq driver adjusts the per-cpu 
> loops_per_jiffy
> values?  I don't believe it does.

Russell,

I am quoting the function from drivers/cpufreq/cpufreq.h
Follow the arrows:

[quote]
void cpufreq_notify_transition(struct cpufreq_freqs *freqs, unsigned int state)
{
      [snip]...[snip]

	case CPUFREQ_PRECHANGE:

	      [snip]...[snip]
		srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
				CPUFREQ_PRECHANGE, freqs);
---->		adjust_jiffies(CPUFREQ_PRECHANGE, freqs);
		break;

	case CPUFREQ_POSTCHANGE:
---->		adjust_jiffies(CPUFREQ_POSTCHANGE, freqs);
	      [snip]...[snip]
	}
}
[/quote]

Same can be viewed here:
http://lxr.free-electrons.com/source/drivers/cpufreq/cpufreq.c?a=arm#L300


~sanjeev

[snip]...[snip]