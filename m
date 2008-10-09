From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 00/05] OMAP3: CPUidle driver
Date: Thu, 09 Oct 2008 17:44:47 +0300
Message-ID: <87hc7lu8tc.fsf@deeprootsystems.com>
References: <001601c9293d$79bd4200$LocalHost@wipultra1382>
	<87prm9ucei.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.176]:5259 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753518AbYJIOo6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Oct 2008 10:44:58 -0400
Received: by ik-out-1112.google.com with SMTP id c30so47864ika.5
        for <linux-omap@vger.kernel.org>; Thu, 09 Oct 2008 07:44:56 -0700 (PDT)
In-Reply-To: <87prm9ucei.fsf@deeprootsystems.com> (Kevin Hilman's message of "Thu\, 09 Oct 2008 16\:27\:17 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

Kevin Hilman <khilman@deeprootsystems.com> writes:

> "Rajendra Nayak" <rnayak@ti.com> writes:
>
>> This patch set implements Cpuidle driver for OMAP3 platforms. It is
>> validated on the 3430SDP (using the omap_3430sdp_min_defconfig) and
>> applies on the pm-20081006 branch.
>
> Excellent.  Thank you.  I'll pull into pm-20081006 today.
>
> One question: You have C6 to hit chip-off, but it is never enabled.
> Has this been tested?  Enabling it allows me to hit chip OFF, but it
> never comes back from OFF-mode.  I will push some patches to make this
> work with /sys/power/enable_off_mode.

I got this to work on custom HW, but not on 3430SDP.  Can you confirm
whether or not you can use C6 on 3430SDP?  Off-in-idle without CPUidle
seems to work, but not with CPUidle + C6.

Kevin

> Some minor problems that I will fixup when rebasing to the next pm
> branch:
>
>  - You removed C0, but all the comments still refer to it
>  - /sys/power/enable_off_mode doesn't affect off-mode states
>    in CPUidle
>
> patch 1:
>  - I still don't like the #ifdefs for the init sequence.
>
> patch 2:
>  - checkpatch warning
>
> Kevin
>
>> The following C states are defined and used 
>>
>>  *      C0 . System executing code (Not an idle state)
>>  *      C1 . MPU WFI + Core active
>>  *      C2 . MPU CSWR + Core active
>>  *      C3 . MPU OFF + Core active
>>  *      C4 . MPU CSWR + Core CSWR
>>  *      C5 . MPU OFF + Core CSWR
>>  *      C6 . MPU OFF + Core OFF
>>
>> CPUidle support is not enabled by default in any of the defconfigs and hence has to enabled seperately 
>> if you plan to test these patches.
>>
>> CPUIdle ---> [*] CPU idle PM support
>>
>> regards,
>> Rajendra
