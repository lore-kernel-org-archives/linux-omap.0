From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: VDD1 voltage after resume from idle
Date: Fri, 20 Nov 2009 11:11:26 -0800
Message-ID: <878we13tb5.fsf@deeprootsystems.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59301DE5EE5BC@dbde02.ent.ti.com>
	<20091120162933.GC2354@mvista.com>
	<87my2h3v9t.fsf@deeprootsystems.com>
	<200911201955.44354.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:60457 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390AbZKTTLX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Nov 2009 14:11:23 -0500
Received: by pwi3 with SMTP id 3so2248705pwi.21
        for <linux-omap@vger.kernel.org>; Fri, 20 Nov 2009 11:11:29 -0800 (PST)
In-Reply-To: <200911201955.44354.jpihet@mvista.com> (Jean Pihet's message of "Fri\, 20 Nov 2009 19\:55\:44 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jpihet@mvista.com>
Cc: Maxime Petazzoni <mpetazzoni@mvista.com>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Jean Pihet <jpihet@mvista.com> writes:

> Hi Kevin,
>
> On Friday 20 November 2009 19:29:02 Kevin Hilman wrote:
>> Maxime Petazzoni <mpetazzoni@mvista.com> writes:
>> > Hi,
>> >
>> > * Premi, Sanjeev <premi@ti.com> [2009-11-20 21:17:04]:
>> >> I am facing a strange problem on OMAP3EVM after resuming from idle.
>> >> When using OPP5, the VDD1 voltage ramps to 1.35V.
>> >>
>> >> However, when i go thru the idle/wakeup cycle, the voltage never
>> >> ramps back to 1.35V but stays at 1.20V.
>> >
>> > I'm seeing some interesting behavior with the OPP values here, too, with
>> > suspend/resume. I'm using SRF based PM and CPUFREQ. Here's what happens:
>> >
>> > When changing the CPU frequency through the scaling_setfreq knob of
>> > CPUFREQ, the vdd{1,2}_opp values are updated accordingly. After a
>> > suspend/resume cycles, the OPPs return to their pre-suspend values, all
>> > is fine.
>> >
>> > But when changing the OPP values by hand through the vdd{1,2}_opp knobs,
>> > the CPU frequency is changed accordingly, which is expected. But after a
>> > suspend/resume cycle, the OPP values return to the value CPUFREQ set
>> > them to (which may be different than the default OPP values of 3).
>> >
>> > Is this the normal behavior? Is cpufreq authoritative on the OPP values
>> > on resume? Or should it follow whatever value was manually set before
>> > suspending?
>>
>> FWIW, the vdd*_opp sysfs hooks were for initial debug/dev and should
>> be considered experimental (a.k.a broken.) They will disappear from
>> the PM branch shortly.
>>
>> CPUfreq should be the only interface used for DVFS.
> Could the PM page on elinux.org be updated with that info? I am proposing to 
> change it before you ask me ;p

Done.

I added the following note to the 'opp control' section.

OPP control via sysfs is deprecated. Please use CPUfreq interfaces for DVFS. 
