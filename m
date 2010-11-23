From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 00/13] OMAP3: OFF mode fixes
Date: Tue, 23 Nov 2010 12:35:57 -0800
Message-ID: <87pqtveq1e.fsf@deeprootsystems.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com>
	<87r5edp3so.fsf@deeprootsystems.com>
	<8ef3de873d51409a38f19becb0d339cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38756 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214Ab0KWUgA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Nov 2010 15:36:00 -0500
Received: by pzk6 with SMTP id 6so739112pzk.19
        for <linux-omap@vger.kernel.org>; Tue, 23 Nov 2010 12:35:59 -0800 (PST)
In-Reply-To: <8ef3de873d51409a38f19becb0d339cb@mail.gmail.com> (Santosh
	Shilimkar's message of "Tue, 23 Nov 2010 14:32:25 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Nishanth Menon <nm@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Jean Pihet <jean.pihet@newoldbits.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Kevin Hilman
>> Sent: Tuesday, November 23, 2010 12:46 AM
>> To: Nishanth Menon
>> Cc: linux-omap; Jean Pihet; Vishwanath Sripathy; Tony
>> Subject: Re: [PATCH 00/13] OMAP3: OFF mode fixes
>>
>> Nishanth Menon <nm@ti.com> writes:
>>
>> > Bunch of fixes as part of phase 1 targetting mainly OMAP3630 HS
> devices
>> > for OFF mode logic.
>> >
>> > It is important to note - for proper functionality of HS OFF mode on
>> OMAP3630,
>> >    CONFIG_OMAP3_L2_AUX_SECURE_SAVE_RESTORE=y and
>> >    CONFIG_OMAP3_L2_AUX_SECURE_SERVICE_SET_ID should be set to the
>> correct
>> >    service that the security PPA supports on the platform.
>> >
>> > Based on kernel.org 2.6.37-rc2 tag
>> >
>> > Smoke tested on:
>> > SDP3630 -GP
>> > Zoom3 (3630): GP & EMU (Es1.1, ES1.2)
>> > SDP3430 - GP & EMU (ES3.1)
>> >
>> > These are fixes for corner case bugs seen, so tests of off and ret
> done
>> with
>> > wakeup timer - behavior between 2.6.37-rc2 before and after applying
>> patch
>> > seen consistent.
>> >
>> > Request for testing this series for comparison between master and this
>> > series requested for additional platforms where available.
>>
>> After some more thought and review, here's what I think should be the
>> approach moving this forward:
>>
>> This can be broken up into 3 independent series as follows:
>>
>> 1) fix for UART erratum (patch 10)
>> 2) fixes for idle path errata (patches 1, 2, 11, 12, 13)
>> 3) secure ram save path (the rest)
>>
>> For (3), I'd like to see the secure ram management moved out of the PM
>> core, and into it's own library/driver.  Strictly speaking, context
>> save/restore for secure ram is not a function of the PM idle core.   As
>> with every other device, context save/restore is the responsibility of
>> the driver(s) using that device.
>>
>> For secure RAM, the restore is handled by ROM code, but the save should
>> be managed by the secure driver(s).  IOW, any secure driver should be
>> using runtime PM and when the secure driver is no longer in use, it
>> should ensure secure RAM context is saved using its runtime_suspend
>> method to save secure RAM.  The code in this series should be moved out
>> into a library/driver which can be called by secure drivers in their
>> runtime PM hooks.
>>
> I agree with you Kevin here except one point. The secure RAM contents
> are not just secure driver data but the ROM code infrastructure as well.
> And we should treat ROM code as a hardware. Secure services
> don't give  you garrulity of saving per each secure module. To
> get CPU OFF working on secure device, secure RAM must be saved.
> So I still think it is CPU specific code and pretty much relevant
> to CPU IDLE OFF state considering ROM code.
> Ofcourse this not related to GP device because we never enter Secure
> world again after the boot-up.
> So moving this code to a separate file is fine but it still related
> to CPU.

Sure, it's still *related* to the CPU, but what I am arguing is that it
should not be related to CPU *idle*.

My undersanding is this (please correct me):

Secure RAM context only needs to be saved/updated when something in it
changes changes (e.g. secure driver usage.)  Therefore, any
driver/device usage that has a side effect of changing secure RAM should
be responsible for updating secure RAM.  

The approach taken in $SUBJECT series is basically: since we don't know
who is using/changing secure RAM, we better save it (or have the option
to) during every off-mode transition.  This approach is what I do not
like.  It's pushing work (and intellegence) that should be in the
drivers into the PM core where it does not belong.

Rather, I want to follow the same approach we follow for every other
device driver.  Drivers must assume they can lose context.  Therefore
it's up to them to save it.

IOW, the drivers that *change* secure RAM should be responsible for
ensuring that any of the changes they make are saved.  

Kevin



