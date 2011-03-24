From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 00/19] OMAP4: PM: Suspend, CPU-hotplug and CPUilde support.
Date: Thu, 24 Mar 2011 08:09:53 -0700
Message-ID: <87mxkk1rni.fsf@ti.com>
References: <1299766095-23879-1-git-send-email-santosh.shilimkar@ti.com>
	<87d3lycu0h.fsf@ti.com>
	<49a5273c412bf9193a9f930e990d22d4@mail.gmail.com>
	<87pqpxbqho.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:38920 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756381Ab1CXPJ6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Mar 2011 11:09:58 -0400
Received: by mail-iy0-f171.google.com with SMTP id 40so78383iyf.2
        for <linux-omap@vger.kernel.org>; Thu, 24 Mar 2011 08:09:57 -0700 (PDT)
In-Reply-To: <87pqpxbqho.fsf@ti.com> (Kevin Hilman's message of "Fri, 11 Mar
	2011 07:56:19 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org

Kevin Hilman <khilman@ti.com> writes:

> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
> [...]
>
>>> >
>>> > This series doesn't boot on ES1 (boot log below.)  Do we need to
>>> > totally prevent WFI on ES1?
>>> >
>> Nope. WFI is ok.
>> The ES1.0 boot issue on pm-core branch doesn't seems to
>> be related to this series. Without this series as well
>> OMAP4 ES1.0 is not booting for me. When I disable
>> CONFIG_PM + WATCHDOG fix, it booted ok. I will
>> git-bisect this later on pm-core branch.
>>
>>> > Also, if we want a CPUidle enabled kernel to boot on all silicon,
>>> > it will need a omap_rev() check during init to ensure it doesn't
>>> > override the default idle path.
>>> >
>> OMAP4 PM series already takes care of not overriding
>> the default idle path for ES1.0. The omap4_mpuss_init()
>> fails on ES1.0 and hence the CPUidle init is skipped in
>> that case.
>>
>> Just to further check, I pulled the latest omap-for-linus
>> branch and merged Paul's pull-request into it. Then
>> applied OMAP4 PM series and I got a boot crash, a different
>> one. This was again related to clock-domain initialization
>> and static deps. I fixed this issue by avoiding omap4_pm_init()
>> code running on ES1.0. With this boot on ES1.0 works fine now
>> with OMAP4 PM series.
>
> Thanks for finding this.  I just tested your v3 branch together with my
> pm-core and it's now booting fine on ES1.
>

Hi Santosh,

Can you rebase and repost your v3 series, I'd like to get this queued
up early in the 2.6.40 dev cycle.

You can base on my current pm-core branch, which also has Russell's 
devel-stable branch merged in.

Thanks,

Kevin
