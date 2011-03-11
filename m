From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 00/19] OMAP4: PM: Suspend, CPU-hotplug and CPUilde support.
Date: Fri, 11 Mar 2011 07:56:19 -0800
Message-ID: <87pqpxbqho.fsf@ti.com>
References: <1299766095-23879-1-git-send-email-santosh.shilimkar@ti.com>
	<87d3lycu0h.fsf@ti.com>
	<49a5273c412bf9193a9f930e990d22d4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:33090 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755485Ab1CKP4X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Mar 2011 10:56:23 -0500
Received: by mail-gw0-f45.google.com with SMTP id 19so1181570gwb.4
        for <linux-omap@vger.kernel.org>; Fri, 11 Mar 2011 07:56:22 -0800 (PST)
In-Reply-To: <49a5273c412bf9193a9f930e990d22d4@mail.gmail.com> (Santosh
	Shilimkar's message of "Fri, 11 Mar 2011 18:01:12 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

[...]

>> >
>> > This series doesn't boot on ES1 (boot log below.)  Do we need to
>> > totally prevent WFI on ES1?
>> >
> Nope. WFI is ok.
> The ES1.0 boot issue on pm-core branch doesn't seems to
> be related to this series. Without this series as well
> OMAP4 ES1.0 is not booting for me. When I disable
> CONFIG_PM + WATCHDOG fix, it booted ok. I will
> git-bisect this later on pm-core branch.
>
>> > Also, if we want a CPUidle enabled kernel to boot on all silicon,
>> > it will need a omap_rev() check during init to ensure it doesn't
>> > override the default idle path.
>> >
> OMAP4 PM series already takes care of not overriding
> the default idle path for ES1.0. The omap4_mpuss_init()
> fails on ES1.0 and hence the CPUidle init is skipped in
> that case.
>
> Just to further check, I pulled the latest omap-for-linus
> branch and merged Paul's pull-request into it. Then
> applied OMAP4 PM series and I got a boot crash, a different
> one. This was again related to clock-domain initialization
> and static deps. I fixed this issue by avoiding omap4_pm_init()
> code running on ES1.0. With this boot on ES1.0 works fine now
> with OMAP4 PM series.

Thanks for finding this.  I just tested your v3 branch together with my
pm-core and it's now booting fine on ES1.

Kevin

> Posted the patch for the same.
> https://patchwork.kernel.org/patch/628231/
>
>
> The rebased series against
> 	Latest 'omap-for-linus + Paul's pull-request'
> have pushed to below branch.
>
> git://dev.omapzoom.org/pub/scm/santosh/kernel-omap4-base.git
> omap4_pm_for-next_v3
>
> Regards,
> Santosh
