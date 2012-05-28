From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCHv9 00/10] I2C fixes
Date: Mon, 28 May 2012 15:22:50 +0530
Message-ID: <4FC34AF2.9000302@ti.com>
References: <1335969135-20858-1-git-send-email-shubhrajyoti@ti.com> <87r4u7j4dr.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:55106 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752145Ab2E1Jw6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 May 2012 05:52:58 -0400
Received: by obbun3 with SMTP id un3so6692678obb.11
        for <linux-omap@vger.kernel.org>; Mon, 28 May 2012 02:52:56 -0700 (PDT)
In-Reply-To: <87r4u7j4dr.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, w.sang@pengutronix.de, linux-i2c@vger.kernel.org, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org

Hi Kevin,


On Saturday 26 May 2012 03:43 AM, Kevin Hilman wrote:
> Shubhrajyoti D <shubhrajyoti@ti.com> writes:
>
>> The patch series does the following
>>
>> - Warn fixes if CONFIG_PM_RUNTIME is not selected.
>> - In case of i2c remove register access was done without any
>>  get_sync fix the same.
>> - Folds a patch from Tasslehoff to prevent any merge conflicts.
>> - Prevents the XDUF flag to be set if the underflow condition is not met.
>> - As per discussion in [1] .Adds a patch to rename the 1p153 errata and
>>  use the unique id instead as the section number in the recent errata
>>  docs has changed.
>>
>> v9:
>> Fix the comments from Wolfram Sang
>>
>> [1] http://www.spinics.net/lists/linux-i2c/msg07607.html
>>
>> Tested on omap4sdp and omap3sdp.
> Can you also describe how it was tested?  
I did basic functionality  tests using i2c-tools.
>
> With the runtime PM changes, does it still hit full-chip retention in
> idle and suspend after these changes?
Will check.
>
> I had a few minor comments on this version,
Will fixup and resend.
>  otherwise feel free add
>
> Reviewed-by: Kevin Hilman <khilman@ti.com>
Thanks for your review.
>
> That being said, before this is merged, I woudl like to see some more
> non-author Tested-bys.  We've been having lots of regressions of late
> from OMAP drivers that are not being sufficiently tested before
> merging.  We need to ensure proper testing before merge.
>
> Other testers should also report what platforms they tested on, and how
> it was tested.
>
> Thanks,
>
> Kevin

