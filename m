From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: PM(?) problems on v3.3-rc1 on OMAP3
Date: Fri, 20 Jan 2012 14:36:30 +0100
Message-ID: <CAORVsuVGT1AaMzo0r6T4vWe7zz7Uk=o-DydAcGdMzE+utDoUww@mail.gmail.com>
References: <1327055619.1921.57.camel@deskari>
	<CAAL8m4zYQmKAnzjfP2eQUyO3hJ3pig2H_jenC_WAWAogQ1JTbw@mail.gmail.com>
	<1327060886.1921.63.camel@deskari>
	<CAORVsuVenz_fUPp3o_x+xrN3JJXDUyreMNvqjCPGzLrQf71EnQ@mail.gmail.com>
	<1327063256.1921.68.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:39599 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570Ab2ATNgb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Jan 2012 08:36:31 -0500
Received: by vcbfo1 with SMTP id fo1so339058vcb.19
        for <linux-omap@vger.kernel.org>; Fri, 20 Jan 2012 05:36:30 -0800 (PST)
In-Reply-To: <1327063256.1921.68.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Govindraj <govindraj.ti@gmail.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, t-kristo@ti.com, linux-omap mailing list <linux-omap@vger.kernel.org>, NeilBrown <neilb@suse.de>, Joe Woodward <jw@terrafix.co.uk>

Tomi,

On Fri, Jan 20, 2012 at 1:40 PM, Tomi Valkeinen <tomi.valkeinen@ti.com>=
 wrote:
> On Fri, 2012-01-20 at 13:34 +0100, Jean Pihet wrote:
>> Tomi,
>>
>> On Fri, Jan 20, 2012 at 1:01 PM, Tomi Valkeinen <tomi.valkeinen@ti.c=
om> wrote:
>> > On Fri, 2012-01-20 at 17:26 +0530, Govindraj wrote:
>> >> On Fri, Jan 20, 2012 at 4:03 PM, Tomi Valkeinen <tomi.valkeinen@t=
i.com> wrote:
>> >
>> >> > Is there a way to lock the OPP to the full power OPP?
>> >> >
>> >>
>> >> btw,
>> >>
>> >> I think enabling cpu_idle and performance governor to should ensu=
re that.
>> >>
>> >> However enabling performance governor boot fails.
>> >
>> > I thought so too, and tried it but got the same crash as you.
>> >
>> > However, I'd imagine that if I don't enable CPU idle or the govern=
ors,
>> > the board would stay in full power mode always. But this doesn't s=
eem to
>> > be the case.
>> >
>> > Then again, I don't see how CPU power management could affect the =
DSS
>> > directly. So it's probably something like: cpu goes to RET -> some=
thing
>> > else is allowed go to lower power state (L3?) -> DSS breaks.
>> It is probably related to the CORE state. Can you check if CORE goes
>> to low power mode when CPU_IDLE is enabled?
>
> This is without CPU_IDLE, i.e. when I'm having problems:
>
> # cat /debug/pm_debug/count |grep -i core
> core_pwrdm
> (ON),OFF:0,RET:0,INA:0,ON:1,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0,RET-ME=
MBANK2-OFF:0
>
> According to that, core is always on.
>
>> To prevent the CORE from going into a too-low power mode you need to
>> request a PM QoS constraint, as Govindraj explained here above.
>
> What different power modes there are? With the clock configs I'm usin=
g
> (small display, low clock rates), both OPP100 and OPP50 should work
> fine.
CPU_IDLE is not about the OPP (i.e. frequencies), it is about the
power domains states (ON, RET ...).
Without CPU_IDLE enabled the power domains will try to transition to
the default power states (programmed in the PRCM registers). By
default all power states are programmed to RET or OFF.
In all cases CPU_IDLE should be enabled to ensure the proper
interaction between the cpuidle and PM QoS frameworks.

You can try the following in order to isolate the problem:
1. check if the CORE and DSS are hitting a low power state. The MPU
state should not have a direct impact on the DSS; the CORE state has a
direct effect on DSS since it drives the memory controller,
2. use a fixed frequency for the MPU, by enabling the userspace or the
performance cpufreq governor. This should rule out an MPU performance
problem.

>
> =A0Tomi
>

Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
