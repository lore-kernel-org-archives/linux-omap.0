From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 00/19] OMAP4: PM: Suspend,CPU-hotplug and CPUilde support.
Date: Fri, 11 Mar 2011 10:03:52 -0800
Message-ID: <874o79a60n.fsf@ti.com>
References: <1299766095-23879-1-git-send-email-santosh.shilimkar@ti.com>
	<87d3lycu0h.fsf@ti.com>
	<3b3d5e28815aa8bcedf6f43688f403b5@mail.gmail.com>
	<871v2dd58y.fsf@ti.com>
	<f1ee9adb49c6dbc49205c5ba70007e9a@mail.gmail.com>
	<87k4g5a6n5.fsf@ti.com>
	<420e5c6f0aff0bbd23b7f3e9c190ca97@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:51812 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751465Ab1CKSD6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Mar 2011 13:03:58 -0500
Received: by mail-pv0-f178.google.com with SMTP id 7so493450pvg.9
        for <linux-omap@vger.kernel.org>; Fri, 11 Mar 2011 10:03:54 -0800 (PST)
In-Reply-To: <420e5c6f0aff0bbd23b7f3e9c190ca97@mail.gmail.com> (Santosh
	Shilimkar's message of "Fri, 11 Mar 2011 23:28:33 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

>> -----Original Message-----
>> From: Kevin Hilman [mailto:khilman@ti.com]
>> Sent: Friday, March 11, 2011 11:20 PM
>> To: Santosh Shilimkar
>> Cc: linux-omap@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org; Rajendra Nayak
>> Subject: Re: [PATCH v2 00/19] OMAP4: PM: Suspend,CPU-hotplug and
>> CPUilde support.
>>
>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>>
> [...]
>
>> >> I prefer to drop it completely for OMAP4.
>> >>
>> > OK. Lets do that.
>> >
>> > Just to not miss your point here, what I understood here
>> > is default suspend state on OMAP$B will be off mode.
>> >
>> > We still keep "enable_off_mode" flag for testing so that we
>> > can disable off mode to debug regressions.
>> >
>> > Is that right?
>>
>> No, I want to drop "enable_off_mode" all together for OMAP4.
>>
>> If you want to change any powerdomain's default next_state, you can
>> use
>> the <debugfs>/pm_debug/*_pwrdm/suspend controls.
>>
> Thanks for clarification. The change is quite trivial. Will
> update the branch with this change.
> After testing it, will intimate you

One other thing to check...

I've now included Russell's devel branch into my pm-core branch.  Can
you rebase your series there?  I did a test rebase of v3 and it rebased
fine (after dropping the patches that are already in devel.)

After doing that, I get a compile error:

arch/arm/mach-omap2/built-in.o: In function `mmu_on_label':
/work/kernel/omap/pm/arch/arm/mach-omap2/sleep44xx.S:394: undefined reference to `PHYS_OFFSET'
make[1]: *** [.tmp_vmlinux1] Error 1
make: *** [sub-make] Error 2

It looks like there might be some other changes in Russell's queue that
you need to take into consideration.

Kevin
