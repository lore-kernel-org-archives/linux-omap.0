From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCHv2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
Date: Sun, 26 Jun 2011 00:23:31 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D6C2FE3@dbde02.ent.ti.com>
References: <1308923618-5333-1-git-send-email-premi@ti.com>
	<20110624140142.GM9449@n2100.arm.linux.org.uk>
	<B85A65D85D7EB246BE421B3FB0FBB593024D6C2EF2@dbde02.ent.ti.com>
	<20110624141402.GN9449@n2100.arm.linux.org.uk>
 <20110624151201.GO9449@n2100.arm.linux.org.uk> <4E04DBF8.1050401@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46776 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751630Ab1FYSx4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 25 Jun 2011 14:53:56 -0400
In-Reply-To: <4E04DBF8.1050401@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Hilman, Kevin" <khilman@ti.com>

> -----Original Message-----
> From: Shilimkar, Santosh 
> Sent: Saturday, June 25, 2011 12:18 AM
> To: Russell King - ARM Linux
> Cc: Premi, Sanjeev; linux-omap@vger.kernel.org; 
> linux-arm-kernel@lists.infradead.org; Hilman, Kevin
> Subject: Re: [PATCHv2] omap2+: pm: cpufreq: Fix 
> loops_per_jiffy calculation
> 
> Russell,
> 
> On 6/24/2011 8:12 AM, Russell King - ARM Linux wrote:
> > Right, thanks for the file.  Here's the patch.
> >
> 
> [.....]
> 
> > Notice how we adjust _both_ the per-cpu loops_per_jiffy, and that we
> > adjust them with reference to the initial values.
> >
> > If you adjust lpj with reference to the last, then you 
> _will_ build up
> > a progressively bigger and bigger error in the value over time.
> >
> Thanks Russell for the change. This change should fix the global
> lpj for UP machine as well when build with SMP_ON_UP.
> 
> Can you have a look at below complete change which should
> make the BOGOMIPS happy on all OMAP2PLUS machines. Generated
> against Kevin's cpufreq branch.
> 
> url = 
> git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-om
> ap-pm.git 
> pm-wip/cpufreq.
> 
> Just compile tested with UP and SMP OMAP builds. After your
> review, I can give a test.
> 
> Regards
> Santosh
> 
>  From 9a6154c0f68e39c4d1fbc4ef3fef5ce577ba87d4 Mon Sep 17 
> 00:00:00 2001
> From: Russell King <rmk+kernel@arm.linux.org.uk>
> Date: Fri, 24 Jun 2011 10:51:17 -0700
> Subject: [PATCH] OMAP2+: CPUfreq: update lpj with refernce value to 
> avoid progressive error.
> 
> Adjust _both_ the per-cpu loops_per_jiffy and global lpj. 
> Calibrate them
> with with reference to the initial values to avoid a progressively
> bigger and bigger error in the value over time.
> 
> While at this also re-use the notifiers for UP/SMP since on
> UP machine or UP_ON_SMP policy->cpus mask would contain only
> the one CPU.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> [santosh.shilimkar@ti.com: rebased against omap cpufreq 
> upstream branch]
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Kevin Hilman <khilman@ti.com>

[sp] I thought we were solving a problem - but this makes it
     look like race for addding sign-offs - which I am not
     interested in.

[snip]...[snip]
