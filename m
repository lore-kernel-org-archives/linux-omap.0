From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v8 0/11] dmtimer adaptation to platform_driver
Date: Thu, 06 Jan 2011 08:21:17 -0800
Message-ID: <87pqsaypdu.fsf@ti.com>
References: <1294228127-11549-1-git-send-email-tarun.kanti@ti.com>
	<87bp3uu9lx.fsf@ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0373D2F357@dbde02.ent.ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0373D2F5FA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:33364 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751538Ab1AFQVX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Jan 2011 11:21:23 -0500
Received: by yxm8 with SMTP id 8so8201736yxm.7
        for <linux-omap@vger.kernel.org>; Thu, 06 Jan 2011 08:21:21 -0800 (PST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0373D2F5FA@dbde02.ent.ti.com>
	(Tarun Kanti DebBarma's message of "Thu, 6 Jan 2011 19:04:55 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Tarun,

"DebBarma, Tarun Kanti" <tarun.kanti@ti.com> writes:

>> >
>> > Also, testing with PM on 34xx/n900, I noticed that this series prevents
>> > PER and CORE from hitting retention during suspend.  I haven't debugged
>> > why yet.
>> I have not done power testing. I will try this out right away and confirm.
>>
> Here is a brief update on pm test.
>
> (1) Without dmtimer patch series:
> [  305.641204] Powerdomain (core_pwrdm) didn't enter target state 1
> [  305.647491] Could not enter target state in pm_suspend

What board is this on?

Indeed some platforms do not hit CORE retention by default, most often
because of the boot loader leaving some devices in a state that prevents
them from idling.

At least on 34xx/n900 (with DSS enabled), core is hitting retention for
me.  On Beagle, I have to also use my pm-otg-reset branch to ensure that
the MUSB block is properly reset on boot, othewise MUSB is preventing
CORE RET.  I suspect this would be the same problem on 3430SDP.

> (2) With dmtimer patch series:
> [   25.291503] Powerdomain (core_pwrdm) didn't enter target state 1
> [   25.297790] Powerdomain (per_pwrdm) didn't enter target state 1
> [   25.303985] Could not enter target state in pm_suspend
>
> I will debug further.

Thanks, you can see from this that something in the dmtimer series is
preventing PER from hitting retention.

Kevin
