From: Kevin Hilman <khilman@ti.com>
Subject: Re: [pm-wip/cpufreq][PATCH 3/3] OMAP2+: cpufreq: do lateinit
Date: Wed, 08 Jun 2011 11:51:07 -0700
Message-ID: <87ei34i2ck.fsf@ti.com>
References: <1307412330-25798-1-git-send-email-nm@ti.com>
	<1307412330-25798-4-git-send-email-nm@ti.com> <8762ohnwgb.fsf@ti.com>
	<BANLkTikUiOV6rYFbrULVMWkOS23Msy3hXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:52921 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751538Ab1FHSvN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Jun 2011 14:51:13 -0400
Received: by mail-pz0-f42.google.com with SMTP id 37so401904pzk.29
        for <linux-omap@vger.kernel.org>; Wed, 08 Jun 2011 11:51:12 -0700 (PDT)
In-Reply-To: <BANLkTikUiOV6rYFbrULVMWkOS23Msy3hXg@mail.gmail.com> (Nishanth
	Menon's message of "Tue, 7 Jun 2011 19:28:32 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

"Menon, Nishanth" <nm@ti.com> writes:

> On Tue, Jun 7, 2011 at 16:49, Kevin Hilman <khilman@ti.com> wrote:
>> Nishanth Menon <nm@ti.com> writes:
>>
>>> Since we do module_init, cpufreq initializes before power late_init
>>> where many of the required data structures are registered.
>>
>> What exactly are the dependencies here? =C2=A0The only thing I see i=
s the
>> dependency on omap2_get_mpuss_device(), and those devices should be
>> created as a postcore_initcall.
>>
>> If there are other dependencies, they're probably created a side eff=
ect
>> of your earlier patches where you moved stuff from the ->init hook
>> (which happens much later) into the initcall function. =C2=A0Maybe t=
hat needs
>> a rethink?
>>
>>> Move cpufreq init to late_initcall instead. Further CONFIG_CPU_FREQ=
 on
>>> which the build depends is bool and does'nt support modules yet.
>>>
>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>
>> If this works, it's only because of the link order defined by the
>> Makefile ordering since both are the same level of initcall.
>>
>> When I move this driver to drivers/cpufreq, then the link order is l=
ess
>> obvious.
>
> the issue is as follows:
> currently we dont do voltage transitions. when we do that
> eventually(and my current code has an forked implementation of dvfs,
> the following steps happen):
> late_initcall(omap2_common_pm_late_init);
> does pmic inits, omap_voltage_late_init, init_voltages and SR dev ini=
tialization
>
> without these, there is no way to transition MPU to proper voltage,
> frequency combination. The requirement will have to be that
> omap2-cpufreq.c allows for cpufreq transitions only after voltage and
> clk layers are ready for transitions - if we ever want to do dvfs -
> which we will eventually need to.

Yes, I understand.

But $SUBJECT patch is fixing this as an _init_ time ordering problem,
What you're describing is a runtime requirement that doesn't exist unti=
l
a DVFS transition is done.  IOW, the requirement is that the voltage
etc. layers have to be init'd before the first transition.

So, rather than fix this with initcall ordering (which will have to be
redone as things git moved and converted to modules), just create a typ=
e
of late init function in this driver, which gets called on the first
transition.

Kevin

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
