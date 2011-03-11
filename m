From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 00/19] OMAP4: PM: Suspend, CPU-hotplug and CPUilde support.
Date: Fri, 11 Mar 2011 07:52:13 -0800
Message-ID: <871v2dd58y.fsf@ti.com>
References: <1299766095-23879-1-git-send-email-santosh.shilimkar@ti.com>
	<87d3lycu0h.fsf@ti.com>
	<3b3d5e28815aa8bcedf6f43688f403b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:56474 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754632Ab1CKPwS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Mar 2011 10:52:18 -0500
Received: by mail-qy0-f174.google.com with SMTP id 7so6009081qyk.5
        for <linux-omap@vger.kernel.org>; Fri, 11 Mar 2011 07:52:17 -0800 (PST)
In-Reply-To: <3b3d5e28815aa8bcedf6f43688f403b5@mail.gmail.com> (Santosh
	Shilimkar's message of "Fri, 11 Mar 2011 11:22:26 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

>> -----Original Message-----
>> From: Kevin Hilman [mailto:khilman@ti.com]
>> Sent: Friday, March 11, 2011 7:13 AM
>> To: Santosh Shilimkar
>> Cc: linux-omap@vger.kernel.org; rnayak@ti.com; linux-arm-
>> kernel@lists.infradead.org
>> Subject: Re: [PATCH v2 00/19] OMAP4: PM: Suspend, CPU-hotplug and
>> CPUilde support.
>>
>> Hi Santosh,
>>
>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> [....]
>
>>
>> This series doesn't boot on ES1 (boot log below.)  Do we need to
>> totally prevent WFI on ES1?
>>
>> Also, if we want a CPUidle enabled kernel to boot on all silicon, it
>> will need a omap_rev() check during init to ensure it doesn't
>> override the default idle path.
>>
> Make sense. Will try it on ES1.0 silicon.
>
>
> [....]
>
>> > off-mode debugfs control:
>> > 	enable: $echo 1 > /proc/sys/debug/pm_debug/enable_off_mode
>> > 	disable: $echo 0 > /proc/sys/debug/pm_debug/enable_off_mode
>>
>> Without enabling off-mode, I took CPU1 offline and see that it
>> immediatly goes off.  This makes sense based on the HW, but not in
>> light
>> of the enable_off_mode flag.  For OMAP4, maybe it makes sense to not
>> have the enable_off_mode flag at all?   We'll be getting rid of it
>> on OMAP3 as soon as the constraints framework is ready, so maybe it
>> makes sense to just go without it for OMAP4?
>>
> Actually that's expected since enable_off_mode flag doesn't manage CPUX
> power domain states and they are always hit OFF. CSWR isn't
> supported on CPUX power domains as captured in the series. But
> I agree with you that it might be confusing.
>
> [...]
>> More confusion: another test (also with CPUidle enabled), I see that
>> the MPU and DSS are also hitting off-mode:
>>
> This behavior changed when we dropped enable_off_mode flag to updated
> C-states in favor of prepare() hooks. DSS showing OFF mode is because
> of debug counter issue. DSS PD doesn't support previous power state
> which these counter code is trying to read. There are couple of
> patches from Rajendra and Thara do address this counter issues but
> they are bit of hacky. May be we can get them on the list to discuss
> further.
>
> So just to summaries, on OMAP$ 'enable_off_mode' flag is
> used __only__ in Suspend. CPUx power domain always hit OFF
> mode no matter what is state of this flag because CSWR isn't
> supported on these PD's.

If it's useful only in suspend, then it's redundant with the
<debugfs>/pm_debug/*_pwrdm/suspend controls which allow per-pwrdm
control over next states.

> We could remove this flag as well but thought that this might be
> useful especially when we add CORE RET, DEVICE OFF support.

I'd rather see working off-mode be a requirement for getting OMAP4
drivers supported.

Also, we can still test suspend/resume with off-mode disabled by using
the above debugfs controls.

> May be we keep this till the constraint frameworks comes in and
> then drop it once for all. I am ok with whatever direction you
> decide here.

I prefer to drop it completely for OMAP4.

Kevin
