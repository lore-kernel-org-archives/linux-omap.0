From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/1] PM : cpuidle - update statistics for correct state
Date: Tue, 29 Sep 2009 08:36:52 -0700
Message-ID: <87pr99zrsb.fsf@deeprootsystems.com>
References: <1252144594-17906-1-git-send-email-premi@ti.com>
	<87zl928xvn.fsf@deeprootsystems.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301DDAB4053@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f194.google.com ([209.85.216.194]:52928 "EHLO
	mail-px0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbZI2Pgu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Sep 2009 11:36:50 -0400
Received: by pxi32 with SMTP id 32so4431968pxi.4
        for <linux-omap@vger.kernel.org>; Tue, 29 Sep 2009 08:36:54 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59301DDAB4053@dbde02.ent.ti.com> (Sanjeev Premi's message of "Tue\, 29 Sep 2009 20\:11\:35 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Premi, Sanjeev" <premi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Premi, Sanjeev" <premi@ti.com> writes:

>> -----Original Message-----
>> From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>> Sent: Thursday, September 10, 2009 11:51 PM
>> To: Premi, Sanjeev
>> Cc: linux-omap@vger.kernel.org
>> Subject: Re: [PATCH 1/1] PM : cpuidle - update statistics for 
>> correct state
>> 
>> Sanjeev Premi <premi@ti.com> writes:
>> 
>> > When 'enable_off_mode' is 0, the target power state for MPU
>> > and Core is locally changed to PWRDM_POWER_RET but, the
>> > statistics are updated for idle state originally selected
>> > by the governor.
>> >
>> > This patch 'invalidates' the idle states that lead either of
>> > MPU or Core to PWRDM_POWER_OFF state when 'enable_off_mode'
>> > is '0'. The states are valid once 'enable_off_mode' is set
>> > to '1'.
>> >
>> > Signed-off-by: Sanjeev Premi <premi@ti.com>
>> 
>> This is a good start, but doesn't actually fix the problem.  This is
>> because the 'valid' field is an OMAP specific field and is not checked
>> in any of our  'enter_idle' hooks.
>> 
>> It works in your test case because the code snippet you mentioned in
>> PATCH 0/0 still modifies the target state.
>> 
>> What we need is for the enter_idle_bm() enter function to check the
>> .valid flag.  If it's not valid, then keep dropping states until it
>> finds a valid flag or it hits the safe state.
>
> We do have a omap3_enter_idle_bm(), but the problem is that calculating
> the current index in dev->states will be costly operation. We know the
> pointer to 'target' c-state; but the translating the index back to the
> omap3_power_states[] seems 'intense' operation in idle_bm check.

Maybe this array should be converted to a list.

> I believe the right solution will be to add .valid in the cpuidle framework
> itself. I am submitting a patch for same.

I like this idea better.

Kevin
