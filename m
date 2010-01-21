From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH 0/8] OMAP3: PM: Open Switch Retention support in the
 cpuidle thread.
Date: Thu, 21 Jan 2010 00:18:12 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1001210014000.24456@utopia.booyaka.com>
References: <1264001442-20078-1-git-send-email-thara@ti.com> <alpine.DEB.2.00.1001202314040.24456@utopia.booyaka.com> <5A47E75E594F054BAF48C5E4FC4B92AB031E3F0BE1@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:48201 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753647Ab0AUHSN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 21 Jan 2010 02:18:13 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB031E3F0BE1@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

On Thu, 21 Jan 2010, Gopinath, Thara wrote:

> >>-----Original Message-----
> >>From: Paul Walmsley [mailto:paul@pwsan.com]
> >>Sent: Thursday, January 21, 2010 11:54 AM
> >>To: Gopinath, Thara
> >>Cc: linux-omap@vger.kernel.org; khilman@deeprootsystems.com
> >>Subject: Re: [PATCH 0/8] OMAP3: PM: Open Switch Retention support in the cpuidle thread.
> >>
> >>I'd like to merge the powerdomain changes separately from the other
> >>changes, most of which should probably go through Kevin's PM branch.
> >>
> >>After you revise your patches based on the comments, can you take your
> >>patches 3, 4, and the powerdomain portions of patch 7 and post those in a
> >>separate series as an OSWR preparatory powerdomain patch set?  That will
> >>make it easier for both Kevin and I to handle.
> 
> When you say patch 7, I believe you are mentioning the book keeping part 
> for OSWR where logic_ret_off and mem_ret_off counters are added.

Yes, to be specific, I'm talking about:

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 06bf290..ef9f1bb 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -126,6 +126,16 @@ static int _pwrdm_state_switch(struct powerdomain 
*pwrdm, int flag)
                prev = pwrdm_read_prev_pwrst(pwrdm);
                if (pwrdm->state != prev)
                        pwrdm->state_counter[prev]++;
+               if (prev == PWRDM_POWER_RET) {
+                       if ((pwrdm->pwrsts_logic_ret == PWRSTS_OFF_RET) &&
+                                       (pwrdm_read_prev_logic_pwrst(pwrdm) ==
+                                        PWRDM_POWER_OFF))
+                               pwrdm->ret_logic_off_counter++;
+                       if ((pwrdm->pwrsts_mem_ret[0] == PWRSTS_OFF_RET) &&
+                                       (pwrdm_read_prev_mem_pwrst(pwrdm, 0) ==
+                                       PWRDM_POWER_OFF))
+                               pwrdm->ret_mem_off_counter++;
+               }
                break;
        default:
                return -EINVAL;
@@ -161,6 +171,9 @@ static __init void _pwrdm_setup(struct powerdomain *pwrdm)
        for (i = 0; i < PWRDM_MAX_PWRSTS; i++)
                pwrdm->state_counter[i] = 0;
 
+       pwrdm->ret_logic_off_counter = 0;
+       pwrdm->ret_mem_off_counter = 0;
+
        pwrdm_wait_transition(pwrdm);
        pwrdm->state = pwrdm_read_pwrst(pwrdm);
        pwrdm->state_counter[pwrdm->state] = 1;


and

diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/plat-omap/include/plat/powerdomain.h
index 7576559..405ccd6 100644
--- a/arch/arm/plat-omap/include/plat/powerdomain.h
+++ b/arch/arm/plat-omap/include/plat/powerdomain.h
@@ -124,6 +124,8 @@ struct powerdomain {
 
        int state;
        unsigned state_counter[PWRDM_MAX_PWRSTS];
+       unsigned ret_logic_off_counter;
+       unsigned ret_mem_off_counter;
 
 #ifdef CONFIG_PM_DEBUG
        s64 timer;

> I can separate this out and post these three patches separately. Do let 
> me know should I base these on linux-omap master branch or Kevin's pm 
> tree.

l-o master, please.

> >>Note: the powerdomain code will need to be edited somewhat to bring it
> >>up-to-date with the latest OMAP4 changes in the for_2.6.34 branch, which
> >>is where your patches will go.  I'm happy to do this, but after I do it,
> >>will you be able to test the updated series to ensure that this process
> >>didn't break anything?
> 
> Thanks for this and sure I can test the updated series!

Great.

> But I do not understand what OMAP4 specific support has to be added for 
> these three patches. These three patches will be considerably free of 
> OMAP2/OMAP3/OMAP4 specific stuff. Or are you talking of rebasing on 
> 2.6.34 kernel?

OMAP4 has an additional memory bank.  Also the names of the bitfields have 
been abstracted out, e.g., OMAP_MEM0_RETSTATE_MASK instead of 
OMAP3430_SHAREDL1CACHEFLATRETSTATE.   You can check 'for_2.6.34' branch at 
git://git.pwsan.com/linux-2.6 to see what it looks like.


- Paul

