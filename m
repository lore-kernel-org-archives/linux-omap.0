From: a0393909 <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 0/6] ARM: OMAP: hwmod: remove runtime cpu_is checking
Date: Thu, 14 Jun 2012 15:31:54 +0530
Message-ID: <4FD9B692.4080208@ti.com>
References: <1335557140-10854-1-git-send-email-khilman@ti.com> <alpine.DEB.2.00.1204300835550.10308@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:56931 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755448Ab2FNKCG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jun 2012 06:02:06 -0400
Received: by obbwc20 with SMTP id wc20so1099681obb.3
        for <linux-omap@vger.kernel.org>; Thu, 14 Jun 2012 03:02:03 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1204300835550.10308@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Tony <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Paul,

On 04/30/2012 08:11 PM, Paul Walmsley wrote:
> Hi Kevin,
>
> On Fri, 27 Apr 2012, Kevin Hilman wrote:
>
>> This series attempts to remove all the runtime cpu_is* checking in
>> omap_hwmod.c in favor of using function pointers initialized at init
>> time.
>>
>> This series was motivated by the addition of support for the AM335x
>> series which was done by adding several more cpu_is* checks, and
>> provided the proverbial straw that broke the camel's back.
>>
>> In addition to the cleanup, this provides a much cleaner way of adding
>> additional SoC support since it no longer requires adding additional
>> runtime cpu_is* checks.
>>
>> Boot tested on OMAP3530/Overo and OMAP4430/Panda.
>
> Thanks Kevin, this series should bridge the gap nicely between the current
> code, and the point in time that we're able to move these functions into
> PRM/CM device driver code.  And allow us to avoid adding more cpu_is_*()
> when we merge Vaibhav's hwmod changes.
>
> As you've probably seen, the patches have been updated here.  The function
> pointers have been made file-static rather than per-hwmod; this should
> conserve some memory and cache.  Since they don't change on a per-hwmod
> basis, this should be safe.  Also added quite a bit of kerneldoc --
> basically I have an internal rule here now to ensure this exists on all
> functions and structures that are added, so it would be great to have this
> on future code :-)
>
> The updated series is at git://git.pwsan.com/linux-2.6 in
> the "hwmod_soc_conditional_cleanup_3.5" branch.  Please let me know if
> you have any comments.  It's only compile-tested here so far.  I'll be
> rebasing my local copy of Vaibhav's series on it and will plan to send it
> upstream for 3.5.
>
I guess this series missed 3.5 merge window. I was re-basing the OMAP5
minimal support against the 3.5-rc2 and one of the dependency for that
series is $subject series.

Tony,
How do we get the dependent series merged early enough so that OMAP5
support can be merged in linux-omap master to avoid any late build
breaks.

Regards
santosh



