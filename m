From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: PM branch updates: 3430sdp and omap3evm results
Date: Tue, 27 Jan 2009 11:52:49 -0800
Message-ID: <87wscgsezy.fsf@deeprootsystems.com>
References: <87fxj4ty1l.fsf@deeprootsystems.com>
	<C4A9358E-0172-49B4-9E23-21A87732C37B@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.171]:31649 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755851AbZA0Twx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jan 2009 14:52:53 -0500
Received: by wf-out-1314.google.com with SMTP id 27so7648147wfd.4
        for <linux-omap@vger.kernel.org>; Tue, 27 Jan 2009 11:52:52 -0800 (PST)
In-Reply-To: <C4A9358E-0172-49B4-9E23-21A87732C37B@student.utwente.nl> (Koen Kooi's message of "Tue\, 27 Jan 2009 20\:29\:10 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: linux-omap@vger.kernel.org

Koen Kooi <k.kooi@student.utwente.nl> writes:

> Op 27 jan 2009, om 19:16 heeft Kevin Hilman het volgende geschreven:
>
>> Hello,
>>
>> I've updated the PM branch with a couple of fixes that get it working
>> on the 3430SDP.
>
> Any chance of the beagle cpufreq patch ending up in the branch?
>

Yes, a 100% chance.  :)

I reworked the version you sent me to use a common header for the
rates since it was shared between beagle and SDP.

Just pushed it to my pm branch[1].

NOTE: Tony's tree wont sync yet for while, so I recomment you pull
straight from mine.  Also, I just pushed this, so the git.kernel.org
mirrors might take some time to sync up as well.

The tip of the branch should now be:
OMAP3: PM: add common OPP definitions and use them on Beagle

Kevin

[1] http://git.kernel.org/?p=linux/kernel/git/khilman/linux-omap-pm.git;a=summary
>>
>>
>> For it to work on the SDP, you need the latest u-boot from the
>> omapzoom u-boot tree[1].  This fixes the problems I was having with
>> the D2D clockdomain remaining active or hanging upon clock disable.
>>
>> For omap3evm, it is not hitting retention because it uses the GPIO
>> debounce feature for the touchscreen and the GPIO debounce clocks are
>> not disabled in idle or suspend.  As a temporary hack, you can test
>> the patch below[2] which simply doesn't call the gpio debounce
>> functions for the touchscreen.  In the meantime, I'm working on a
>> patch to disable the debounce clocks on idle.
>>
>> Kevin
>>
>> [1] git://git.omapzoom.org/repo/u-boot.git
>>
>> [2]
>> da7df18bc7f5648ac7fe6e674065ca5899ff8d3d
>> arch/arm/mach-omap2/board-omap3evm.c |    4 ++--
>> 1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach- 
>> omap2/board-omap3evm.c
>> index 6fbbe95..18a07b5 100644
>> --- a/arch/arm/mach-omap2/board-omap3evm.c
>> +++ b/arch/arm/mach-omap2/board-omap3evm.c
>> @@ -176,8 +176,8 @@ static void ads7846_dev_init(void)
>>
>> 	gpio_direction_input(OMAP3_EVM_TS_GPIO);
>>
>> -	omap_set_gpio_debounce(OMAP3_EVM_TS_GPIO, 1);
>> -	omap_set_gpio_debounce_time(OMAP3_EVM_TS_GPIO, 0xa);
>> +/* 	omap_set_gpio_debounce(OMAP3_EVM_TS_GPIO, 1); */
>> +/* 	omap_set_gpio_debounce_time(OMAP3_EVM_TS_GPIO, 0xa); */
>> }
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux- 
>> omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
