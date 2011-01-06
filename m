From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] arm: mach-omap2: pm: cleanup !CONFIG_SUSPEND handling
Date: Thu, 06 Jan 2011 14:31:09 -0800
Message-ID: <87vd21slzm.fsf@ti.com>
References: <1293640483-25610-1-git-send-email-aaro.koskinen@nokia.com>
	<874o9mvpxf.fsf@ti.com>
	<BC214410FD04D84F9079A62423659707161C0C@008-AM1MPN1-003.mgdnok.nokia.com>
	<87ei8qx8v3.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:53936 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754453Ab1AFWbT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 17:31:19 -0500
Received: by mail-gw0-f51.google.com with SMTP id a18so8360639gwa.24
        for <linux-omap@vger.kernel.org>; Thu, 06 Jan 2011 14:31:18 -0800 (PST)
In-Reply-To: <87ei8qx8v3.fsf@ti.com> (Kevin Hilman's message of "Thu, 06 Jan
	2011 09:03:28 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: aaro.koskinen@nokia.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Kevin Hilman <khilman@ti.com> writes:

> <aaro.koskinen@nokia.com> writes:
>
>> Hi,
>>
>> Kevin Hilman [khilman@ti.com]:
>>> Aaro Koskinen <aaro.koskinen@nokia.com> writes:
>>>
>>> > Make !CONFIG_SUSPEND init declarations identical on all OMAPs and
>>> > eliminate some ifdefs.
>>> >
>>> > Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
>>>
>>> I like this solution, but it introduces compiler warnings:
>>>
>>> [...]
>>>
>>> As you likely noticed, removing the const leads to checkpatch warnings:
>>>
>>> WARNING: struct platform_suspend_ops should normally be const
>>>
>>> so the choice is between a checkpatch warning or a bunch of compiler
>>> warnings.
>>>
>>> Alternatively, I just posted a patch[1] to linux-pm propsing to fix this
>>> at the source.  Let's see what happens there.  Merging $SUBJECT patch
>>> will depend on how this is fixed upstream.
>>
>> Sorry, I should have mentioned this when I posted the patch. I was aware of
>> this issue, but I thought this was already fixed in upstream. Check the following
>> commit in linux-next:
>>
>> http://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=commitdiff;h=2f55ac072f5344519348c0c94b3d2f4cca46847b
>>
>> (suspend: constify platform_suspend_ops)
>
> ah, thanks.  somehow I missed that one when looking to see if this was
> already fixed.

OK, now your patch and the one from linux-next are conflicting as they
both touch the platform_suspend_ops in pm*.c.

So for now, I'm gonna drop this one, but it should be rebased/reposted as
soon as 2.6.38-rc1 is out.

Thanks,

Kevin
