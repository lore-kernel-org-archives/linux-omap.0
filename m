From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 00/12] mfd: twl: Fix for irqdomain/next + SPARSE_IRQ + MMC card detect
Date: Wed, 14 Mar 2012 14:24:50 -0700
Message-ID: <87ty1qeuzh.fsf@ti.com>
References: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
	<87399ahppf.fsf@ti.com> <4F61072B.9030606@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:42754 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1760725Ab2CNVYl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Mar 2012 17:24:41 -0400
Received: by mail-pz0-f42.google.com with SMTP id g27so3462545dan.15
        for <linux-omap@vger.kernel.org>; Wed, 14 Mar 2012 14:24:38 -0700 (PDT)
In-Reply-To: <4F61072B.9030606@ti.com> (Benoit Cousson's message of "Wed, 14
	Mar 2012 22:01:31 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, sameo@linux.intel.com, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

"Cousson, Benoit" <b-cousson@ti.com> writes:

> Hi Kevin,
>
> On 3/14/2012 9:50 PM, Kevin Hilman wrote:
>> Hi Benoit,
>>
>> Benoit Cousson<b-cousson@ti.com>  writes:
>>
>> [...]
>>
>>> This is not for pull-request, becasue it is based on irqdomain + OMAP
>>> IRQ DT series + OMAP twl DT series yet to be pushed.
>>
>> What's the status of this series?
>
> I sent earlier today the pull request to Samuel.
>
> Here is the branch for information: for_3.4/twl_irq_gpio_mmc_fix
>
>> At least 'gpio/twl: Allocate irq_desc dynamically for SPARSE_IRQ
>> support' is needed in mainline (linux-next) now since without it, non-DT
>> boots will dump a big fat warning trace[2].
>
> Yeah, I know :-(
>
>> Also FYI, I needed the patch below[1] in order to build this series.
>
> That's weird, this include was added by the following commit
> a7cbb9b15d55dff0488b1a6d93929c2386d8632b at 3.2 time frame.

OK.

> What branch are you using?

I was using your for_3.4/twl_irq_gpio_cleanup, but had some merge
conflicts.  Maybe I mis-merged something and dropped that include.

Kevin
