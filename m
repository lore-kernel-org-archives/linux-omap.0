From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 00/19] OMAP4: PM: Suspend, CPU-hotplug and CPUilde support.
Date: Fri, 25 Mar 2011 08:24:10 -0700
Message-ID: <87mxkjusth.fsf@ti.com>
References: <1299766095-23879-1-git-send-email-santosh.shilimkar@ti.com>
	<87d3lycu0h.fsf@ti.com>
	<49a5273c412bf9193a9f930e990d22d4@mail.gmail.com>
	<87pqpxbqho.fsf@ti.com> <87mxkk1rni.fsf@ti.com>
	<86f296cd6f86c03bc066efaf7cf2b537@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:54145 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751849Ab1CYPYO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Mar 2011 11:24:14 -0400
Received: by mail-yw0-f43.google.com with SMTP id 6so278386ywa.2
        for <linux-omap@vger.kernel.org>; Fri, 25 Mar 2011 08:24:13 -0700 (PDT)
In-Reply-To: <86f296cd6f86c03bc066efaf7cf2b537@mail.gmail.com> (Santosh
	Shilimkar's message of "Fri, 25 Mar 2011 12:35:00 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org

Hi  Santosh,

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

[...]

>> Can you rebase and repost your v3 series, I'd like to get this
>> queued up early in the 2.6.40 dev cycle.
>>
>> You can base on my current pm-core branch, which also has Russell's
>> devel-stable branch merged in.
>>
> I pulled your latest pm-core branch
> ------
> commit 61cbb3172176b84c106bf0f4c32317c472932ab5
> Merge: d0cf394... da19719...
> Author: Kevin Hilman <khilman@ti.com>
> Date:   Wed Mar 23 16:33:01 2011 -0700
>
>     Merge branch 'for_2.6.40/pm-misc' into pm-reset
> -----------------
> Looks like Russell's devel branch isn't merged in pm-core.
> I didn't find the relevant patches.

hmm, you're right.  I'm actually pulling Russell's devel-stable branch
not his devel branch.  I assumed they were in devel-stable as well.

> By the way the relevant ARM patches are already in mainline.  So if
> the pm-core is rebased against latest mainline, we can get those
> changes as well.

Before I rebase, I'll wait at least until -rc1 and/or Tony rebases to
mainline.

In the mean time, can you create two branches?  One with the
dependencies and another with the OMAP4 PM series.  After some final
review and testing, I'll merge the latter series and by then we'll
probably have an -rc1 baseline.

Kevin



