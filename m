From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 11/24] ARM: OMAP2+: clock: remove support for legacy mpurate
 command line param
Date: Mon, 9 Mar 2015 11:08:22 +0200
Message-ID: <54FD6306.4050109@ti.com>
References: <1425644939-3232-1-git-send-email-t-kristo@ti.com> <1425644939-3232-12-git-send-email-t-kristo@ti.com> <20150306153254.GK13520@atomide.com> <54F9D160.7010708@ti.com> <20150306162516.GN13520@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53776 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752742AbbCIJIu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Mar 2015 05:08:50 -0400
In-Reply-To: <20150306162516.GN13520@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org

On 03/06/2015 06:25 PM, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [150306 08:10]:
>> On 03/06/2015 05:32 PM, Tony Lindgren wrote:
>>> * Tero Kristo <t-kristo@ti.com> [150306 04:29]:
>>>> The legacy support is wrong and dangerous, as it doesn't take any
>>>> OPPs into account and does not scale voltages. Switching mpurate should
>>>> be handled through cpufreq.
>>>
>>> Hmm I wonder if some systems actually rely on the mpurate cmdline
>>> parameter. If this cannot be fixed properly, you should at least
>>> print an error here.
>>
>> Yea, I was kind of worried about this comment. We have also an option of
>> doing this through clock driver, but I was hesitant of doing this either.
>> Isn't having a global kernel option like this frowned upon anyway? I believe
>> this piece of init code gets executed on every board on multiarch kernel.
>
> Well the option has been there probably for 10 years already so we
> can't just drop it like that. Chances are it's unused though, so I
> suggest you just print out a warning for it.
>
> It's called from omap_arch_initcall which checks for soc_is_omap()
> so that's not an issue. But when moving the code, you naturally
> need to check the moved code initcall usage.

This patch is not really needed for the set itself btw, it can just be 
dropped if you feel it actually is used by someone. Reverting it from 
the set just causes a minor merge conflict and you can't remove two of 
the otherwise empty clock files.

You could also just move the code over to clock.c maybe, merge these and 
do a soc type check to reach the same behaviour.

-Tero
