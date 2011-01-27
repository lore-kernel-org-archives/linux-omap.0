From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 0/5] OMAP3EVM: Board bug fixes/enhancements
Date: Thu, 27 Jan 2011 12:05:13 -0800
Message-ID: <87lj26kt8m.fsf@ti.com>
References: <1295977061-11086-1-git-send-email-hvaibhav@ti.com>
	<87pqrinq8x.fsf@ti.com>
	<19F8576C6E063C45BE387C64729E739404BD7BE82E@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:46640 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752614Ab1A0UF1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Jan 2011 15:05:27 -0500
Received: by yxl31 with SMTP id 31so925679yxl.0
        for <linux-omap@vger.kernel.org>; Thu, 27 Jan 2011 12:05:17 -0800 (PST)
In-Reply-To: <19F8576C6E063C45BE387C64729E739404BD7BE82E@dbde02.ent.ti.com>
	(Vaibhav Hiremath's message of "Fri, 28 Jan 2011 00:16:07 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Vaibhav,

"Hiremath, Vaibhav" <hvaibhav@ti.com> writes:

[...]

>> 
>> >   OMAP3EVM: Made backlight GPIO default state to off
>> >   OMAP3EVM: Set TSC wakeup option in pad config
>> 
>> And this one doesn't apply as it seems to apply on top of code that
>> doesn't exist upstream.
>> 
>
> You should first apply Ethernet-reset patch first, and then all
> patches will get applied cleanly. I have tested it here at my end.

OK, sorry to have missed that one.

In the future, dependencies need to be clearly stated in the patch 0
cover letter.  When reviewers/maintainers are looking at lots of
patches, it is not easy to keep context for all the patches and series
arriving on the list.  Additional information such as dependencies and
change history are extremely valuable to reviewers & maintainers.

> Since you already acked Ethernet patch, I thought it will make its way
> to mainline before all these patches. And also while posting, I posted
> Ethernet patch again first and then this series.

It will likely make it's way upstream sooner since it's a regression
fix, however, it is not yet queued anywhere so dependencies on it should
be clearly stated here.

Thanks,

Kevin

