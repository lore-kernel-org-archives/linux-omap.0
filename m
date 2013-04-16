From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [RFC PATCH v2 0/6] ARM: OMAP3+: Introduce ABB driver
Date: Tue, 16 Apr 2013 12:18:23 -0700
Message-ID: <87y5ci5log.fsf@linaro.org>
References: <1366032491-4162-1-git-send-email-andrii.tseglytskyi@ti.com>
	<87sj2rbguv.fsf@linaro.org> <516D46CC.3080705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f54.google.com ([209.85.160.54]:52605 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753687Ab3DPTS2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Apr 2013 15:18:28 -0400
Received: by mail-pb0-f54.google.com with SMTP id xa7so457011pbc.27
        for <linux-omap@vger.kernel.org>; Tue, 16 Apr 2013 12:18:27 -0700 (PDT)
In-Reply-To: <516D46CC.3080705@ti.com> (Andrii Tseglytskyi's message of "Tue,
	16 Apr 2013 15:40:44 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Cc: linux-omap@vger.kernel.org, =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>, Tero Kristo <t-kristo@ti.com>, Mike Turquette <mturquette@linaro.org>

Andrii Tseglytskyi <andrii.tseglytskyi@ti.com> writes:

> Hi Kevin,
>
> On 04/16/2013 12:53 AM, Kevin Hilman wrote:
>> Andrii Tseglytskyi <andrii.tseglytskyi@ti.com> writes:
>>
>>> From: "Andrii.Tseglytskyi" <andrii.tseglytskyi@ti.com>
>>>
>>> Following patch series introduces the Adaptive Body-Bias
>>> LDO driver, which handles LDOs voltage during OPP change routine.
>>> Current implementation is based on patch series from
>>> Mike Turquette:
>>>
>>> http://marc.info/?l=linux-omap&m=134931341818379&w=2
>>>
>>> ABB transition is a part of OPP changing sequence.
>>> ABB can operate in the following modes:
>>> - Bypass mode: Activated when ABB is not required
>>> - FBB mode: Fast Body Bias mode, used on fast OPPs
>> Fast?  I thought the 'F' was for Forward?
> You are right. Should be 'Forward' here.
>
>>> - RBB mode: Reverse Body Bias mode, used on slow OPPs
>>>
>>> In current implementation ABB is converted to regulator.
>>> Standalone OPP table is used to store ABB mode, it is defined
>>> in device tree for each ABB regulator. It has the following format:
>>>
>>> operating-points = <
>>> 	       /* uV   ABB (0 - Bypass, 1 - FBB, 2 - RBB) */
>>> 	       880000		0
>>> 	       1060000		1
>>> 	       1250000		1
>>> 	       1260000		1
>>>> ;
>>> ABB regulator is linked to regulator chain
>> In addition to Mike's comments (which I completely agree with), it would
>> be very helfpul to see how this is actually used.  e.g, how the
>> regulators are chained together, how the proper ordering is managed,
>> etc. etc.
>
> We would like to handle voltage scaling in the following way:

What I meant is that a detailed description of the use case should be
included in the changelog.

> cpufreq_cpu0
> clk_set_rate(cpu0)
>     |
>     |-->set_voltage(ABB regulator) /* all ABB related stuff will be
> handled here */
>                 |
>                 |-->set_voltage(smps123 regulator) /* actual voltage
> scaling */

-EASCII_ART_WRAP

>
> This simple model will be extended to handle AVS as a part of the chain.
> smps123 regulator may be changed to VP/VC regulator.
>
> Following example is from integration branch, which already has
> smps123 regulator.

I don't know what integration branch you're referring to, and I don't
know what the smps123 regulator is.

> It demonstrates an example of linkage to chain. ABB regulator is
> linked with smps123 and cpu0 inside device tree.
> cpu0 calls set_voltage() function for ABB, and then ABB calls
> set_voltage() function for smps123 to do actual voltage scaling.
>
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index bb5ee70..c8cbbee 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -36,7 +36,7 @@
>         cpus {
>                 cpu@0 {
>                         compatible = "arm,cortex-a15";
> -                       cpu0-supply = <&smps123_reg>;
> +                       cpu0-supply = <&abb_mpu>;
>                         operating-points = <
>                                 /* kHz    uV */
>                                 /* Only for Nominal Samples */
> @@ -94,6 +94,7 @@
>                 reg = <0x4ae07cdc 0x8>,
>                       <0x4ae06014 0x4>;
>                 ti,tranxdone_status_mask = <0x80>;
> +               avs-supply = <&smps123_reg>;
>                 operating-points = <
>                         /* uV   ABB */
>                         880000  0
>
> This RFC patch series is verified together with:
> https://patchwork.kernel.org/patch/2445091/
>
> Kevin, what do you think about this model in general? Does it fit to
> regulator framework?

I don't know yet, because I don't think the use case has been described
well enough for me to fully understand it the motiviation behind the
series.

In addition, there are alternative approaches that seem to have been
ruled out without describing why.  For example, the regulator framework
already allows you to override methods with custom hooks (as we do for
VC/VP controlled regulators already.)  Without thinking about it too
deeply, it seems this approach could be used to manage the chain of
events you need as well.  I can imagine there are limitations to this
approach for what you're trying to do, but I don't feel they have been
described in the changelog as part of the motivation for this series.

So for now, the guidance I have is this:

First, write changelogs (and cover letters) assuming your audience has
not been staring at the code as long as you have.  Even if they have
been staring at the same code, assume they've been staring at mainline,
and not a random integration branch somewhere.  My general advice is to
write changelogs in a way that you will understand what you wrote a year
from now after having forgotten all the details currently in your brains
cache.  Even better, write them so that I will understand them in a year
since I forget much better than I remember.

Second, before inventing something new, start with the existing
framework.  When the existing framework doesn't work, make an argument
for your new approach or extentions to the framework based on why the
existing stuff doesn't work.  If you don't do this, the reviewers first
reaction will almost always be "why don't you use what already exists in
the framework."  And then you'll have a bunch of back and forth with
reviewers when you could've explained the reasoning from the beginning.

Hope that helps,

Kevin


