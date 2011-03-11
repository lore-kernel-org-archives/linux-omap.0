From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 00/19] OMAP4: PM: Suspend,CPU-hotplug and CPUilde support.
Date: Fri, 11 Mar 2011 09:50:22 -0800
Message-ID: <87k4g5a6n5.fsf@ti.com>
References: <1299766095-23879-1-git-send-email-santosh.shilimkar@ti.com>
	<87d3lycu0h.fsf@ti.com>
	<3b3d5e28815aa8bcedf6f43688f403b5@mail.gmail.com>
	<871v2dd58y.fsf@ti.com>
	<f1ee9adb49c6dbc49205c5ba70007e9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:57009 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752219Ab1CKRu0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Mar 2011 12:50:26 -0500
Received: by mail-iy0-f174.google.com with SMTP id 26so3592218iyb.33
        for <linux-omap@vger.kernel.org>; Fri, 11 Mar 2011 09:50:25 -0800 (PST)
In-Reply-To: <f1ee9adb49c6dbc49205c5ba70007e9a@mail.gmail.com> (Santosh
	Shilimkar's message of "Fri, 11 Mar 2011 22:56:41 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> Kevin,
>
>> -----Original Message-----
>> From: linux-arm-kernel-bounces@lists.infradead.org [mailto:linux-
>> arm-kernel-bounces@lists.infradead.org] On Behalf Of Kevin Hilman
>> Sent: Friday, March 11, 2011 9:22 PM
>> To: Santosh Shilimkar
>> Cc: linux-omap@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org; Rajendra Nayak
>> Subject: Re: [PATCH v2 00/19] OMAP4: PM: Suspend,CPU-hotplug and
>> CPUilde support.
>>
>
> [....]
>
>> >
>> > So just to summaries, on OMAP$ 'enable_off_mode' flag is
>> > used __only__ in Suspend. CPUx power domain always hit OFF
>> > mode no matter what is state of this flag because CSWR isn't
>> > supported on these PD's.
>>
>> If it's useful only in suspend, then it's redundant with the
>> <debugfs>/pm_debug/*_pwrdm/suspend controls which allow per-pwrdm
>> control over next states.
>>
>> > We could remove this flag as well but thought that this might be
>> > useful especially when we add CORE RET, DEVICE OFF support.
>>
>> I'd rather see working off-mode be a requirement for getting OMAP4
>> drivers supported.
>>
>> Also, we can still test suspend/resume with off-mode disabled by
>> using the above debugfs controls.
>>
>> > May be we keep this till the constraint frameworks comes in and
>> > then drop it once for all. I am ok with whatever direction you
>> > decide here.
>>
>> I prefer to drop it completely for OMAP4.
>>
> OK. Lets do that.
>
> Just to not miss your point here, what I understood here
> is default suspend state on OMAP$B will be off mode.
>
> We still keep "enable_off_mode" flag for testing so that we
> can disable off mode to debug regressions.
>
> Is that right?

No, I want to drop "enable_off_mode" all together for OMAP4.

If you want to change any powerdomain's default next_state, you can use
the <debugfs>/pm_debug/*_pwrdm/suspend controls.

Kevin

