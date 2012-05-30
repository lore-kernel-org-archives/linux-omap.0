From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] ARM: OMAP3/4: consolidate cpuidle Makefile
Date: Wed, 30 May 2012 11:07:52 -0700
Message-ID: <87pq9l8ruv.fsf@ti.com>
References: <1336644177-13834-1-git-send-email-daniel.lezcano@linaro.org>
	<4FB08D24.7070101@ti.com> <4FC59CDD.1030100@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:47161 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757180Ab2E3SHz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 May 2012 14:07:55 -0400
Received: by dajz8 with SMTP id z8so121255daj.2
        for <linux-omap@vger.kernel.org>; Wed, 30 May 2012 11:07:54 -0700 (PDT)
In-Reply-To: <4FC59CDD.1030100@linaro.org> (Daniel Lezcano's message of "Wed,
	30 May 2012 06:06:53 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Rajendra Nayak <rnayak@ti.com>, tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> On 05/14/2012 06:42 AM, Rajendra Nayak wrote:
>> On Thursday 10 May 2012 03:32 PM, Daniel Lezcano wrote:
>>> The current Makefile compiles the cpuidle34xx.c and cpuidle44xx.c files
>>> even if the cpuidle option is not set in the kernel.
>>>
>>> This patch fixes this by creating a section in the Makefile where these
>>> files are compiled only if the CONFIG_CPU_IDLE option is set.
>>>
>>> This modification breaks an implicit dependency between CPU_IDLE and
>>> PM as
>>> they belong to the same block in the Makefile. This is fixed in the
>>> Kconfig
>>> by selecting explicitely PM is CPU_IDLE is set.
>>>
>>> The linux coding style recommend to use no-op functions in the headers
>>> when the subsystem is disabled instead of adding big section in C files.
>> 
>> Looks good to me.
>> Reviewed-by: Rajendra Nayak <rnayak@ti.com>
>
> Hi Kevin,
>
> I think I addressed all the points. Is it possible to consider this
> patch for inclusion ?
>

Yes.  I'll queue up as a cleanup for v3.6 with the reviewed-by from
Rajendra.

Thanks,

Kevin
