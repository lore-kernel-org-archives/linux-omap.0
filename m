From: Nicholas Chen <nchen@cs.umd.edu>
Subject: Re: new PM branch available
Date: Wed, 18 Mar 2009 15:22:53 -0400
Message-ID: <F0EB7AC5-6447-4D3C-8690-3DC0CD71B66A@cs.umd.edu>
References: <794F9949-C366-41CE-BC4C-AB9AAA95FFD2@cs.umd.edu> <87hc1qodst.fsf@deeprootsystems.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from server-nat-4.cs.umd.edu ([128.8.127.147]:1084 "EHLO
	bacon.cs.umd.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1760161AbZCRTXC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Mar 2009 15:23:02 -0400
In-Reply-To: <87hc1qodst.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

On Mar 18, 2009, at 3:01 PM, Kevin Hilman wrote:

> Nicholas Chen <nchen@cs.umd.edu> writes:
>
>> I recently checked out the latest PM branch from your git repository
>> and put it on the Beagleboard (B5). I have been largely able to
>> reproduce the results others have reported on this PM thread,
>
> ...not sure what "this PM thread" you are referring to?
>
>> but I believe my CORE and PER powerdomains are not hitting RET or
>> OFF.
>
>> I think this based on the following:
>> after I
>> echo 1 > enable_off_mode
>> echo 1 > sleep_while_idle
>> echo mem > state
>
> CORE and PER are still on because UART clocks are not being cut in
> idle:
>
>  # echo 1 > /sys/power/clocks_off_when_idle
>
> And see if that works.  Also at least on my Beagle, I am not able
> to resume from full-chip OFF, so for starters I suggest just testing
> retention: echo 0 > /sys/power/enable_off_mode
>
>> Suspending starts but upon resume I see the following:
>> ...
>> Powerdomain (core_pwrdm) didn't enter target state 0
>> Powerdomain (per_pwrdm) didn't enter target state 0
>> Could not enter target state in pm_suspend
>>
>> looking at debug/pm_debug/count/
>> I see that only the core_pwrdm and per_pwrdm have 0's next to OFF:  
>> and
>> RET:
>>
>> Based on the thread, the resolution seems  to be to disable USB and
>> upgrade u-boot. I think I have done both. My u-boot is 2009.03-rc2
>> from Steve Sakoman's tree, and I have disabled USB support in my
>> Kernel build. Is there something that I am overlooking? Also, I'm
>> curious if the two powerdomains linked (i.e. I need to fix PER before
>> CORE will shut off or vice versa).
>
> For your problem, they're linked in that they both contain a UART
> block.  UART1,2 are in CORE and UART3 is in PER.
>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Thanks for the assistance. I see everything going into RET now, so I  
think I'm duplicating what everybody else is seeing. I also have a  
better understanding what the entries in /sys/power do now.

Nick

PS
Sorry, the thread/message I am referring to is:
http://markmail.org/message/4cynvcjzult4c2rj
 From Feb 4.

