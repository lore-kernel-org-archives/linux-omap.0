From: "Menon, Nishanth" <nm@ti.com>
Subject: RE: [PATCH]  OMAP3: PM: Fix VDD2 OPP1 issue
Date: Thu, 8 Oct 2009 10:12:42 -0500
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C012A6FC716@dlee02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB030A3D062B@dbde02.ent.ti.com>
	<4ACDF533.30205@ti.com> <87fx9udjai.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60628 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758294AbZJHPNX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 11:13:23 -0400
In-Reply-To: <87fx9udjai.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Reddy, Teerth" <teerth@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
> Sent: Thursday, October 08, 2009 9:58 AM
> To: Menon, Nishanth
> Cc: Reddy, Teerth; linux-omap@vger.kernel.org
> Subject: Re: [PATCH] OMAP3: PM: Fix VDD2 OPP1 issue
> 
> Nishanth Menon <nm@ti.com> writes:
> 
> > Reddy, Teerth had written, on 10/08/2009 04:21 AM, the following:
> >> From 144669d941a432875db37ae9431847f6753e566e Mon Sep 17 00:00:00 2001
> >> From: Teerth Reddy <teerth@ti.com>
> >> Date: Wed, 9 Sep 2009 11:01:04 +0530
> >> Subject: [PATCH] ARM: OMAP3: PM: Fix VDD2 OPP1 issue
> >>
> >> This patch fixes the VDD2 OPP1 issue. The patch has change
> >> which does not allow VDD2 OPP setting to 1.VDD2 should not be put at
> >> OPP1 as this is not a supported OPP for VDD2
> >>
> >> Signed-off-by: Teerth Reddy <teerth@ti.com>
> >> ---
> >>  arch/arm/mach-omap2/pm.c |    2 +-
> >>  1 files changed, 1 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> >> index fec7d00..d0e03c4 100644
> >> --- a/arch/arm/mach-omap2/pm.c
> >> +++ b/arch/arm/mach-omap2/pm.c
> >> @@ -195,7 +195,7 @@ static ssize_t vdd_opp_store(struct kobject *kobj,
> struct kobj_attribute *attr,
> >>  		}
> >>  		resource_set_opp_level(VDD1_OPP, value, flags);
> >>  	} else if (attr == &vdd2_opp_attr) {
> >> -		if (value < 1 || value > 3) {
> >> +		if (value < 2 || value > 3) {
> >>  			printk(KERN_ERR "vdd_opp_store: Invalid value\n");
> >>  			return -EINVAL;
> >>  		}
> > this is not scalable. we should be able to disable OPPs for each OPP
> > from the OPP array. with different silicons, we could have the same
> > OPP enabled/disabled. NAK -> need to handle based on
> > mpu_opps[vale].rate ==0
> 
> Agreed that the current code is not scalable, but that was a problem
> before Teerth's fix.
> 
> The proposed patch is a bugfix to existing code and should be merged
> after my comments are addressed.
> 
> Then, the scalability issues can be addressed separately.
> 
Ok, reverting my objection.

Will try to do a follow up patch -> essentially let program_opp make that decision IMHO.


Regards,
Nishanth Menon
