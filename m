From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCHv2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
Date: Fri, 24 Jun 2011 20:10:29 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D6C2F08@dbde02.ent.ti.com>
References: <1308923618-5333-1-git-send-email-premi@ti.com>
 <4E04A0AB.40608@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44966 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759387Ab1FXOkl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jun 2011 10:40:41 -0400
In-Reply-To: <4E04A0AB.40608@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

> -----Original Message-----
> From: Shilimkar, Santosh 
> Sent: Friday, June 24, 2011 8:05 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCHv2] omap2+: pm: cpufreq: Fix 
> loops_per_jiffy calculation
> 
> On 6/24/2011 7:23 PM, Sanjeev Premi wrote:
> > Currently, loops_per_jiffy is being calculated twice for
> > non-SMP processors.
> >   - Before calling cpufreq_notify_transition()
> >   - From within cpufreq_notify_transition()
> >
> > Double adjustment leads to incorrect value being assigned to
> > loops_per_jiffy. This manifests as incorrect BogoMIPS in
> > "cat /proc/cpuinfo".
> >
> > The value of loops_per_jiffy needs to be calculated only
> > when CONFIG_SMP is true. It is the core change included
> > in this patch.
> >
> > The patch also leverages the definition of for_each_cpu()
> > with and without CONFIG_SMP to consolidate the mechanism
> > to call cpufreq_notify_transition().
> >
> > Signed-off-by: Sanjeev Premi<premi@ti.com>
> 
> NAK. This patch again doesn't make sense considering your issue.
> Also jiffies should not be undated before changing the freq.
> If the set_rate failed for some reason then you will have wrong
> jiffies value.
> 
> I understand your issue now. The code for global lpj updation
> should have been checking smp_on_up() instead of is_smp().
> That one line change is enough. I will post a patch on
> the same once I reach to office.

[sp] Suggest reading the patch before NAKing.
     The patch is updating the loops_per_jiffy value "AFTER"
     the frequency change has happenned and "BEFORE" post
     change notification is sent.

~sanjeev


> 
> Regards
> Santosh
> 