From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [RFC PATCH v2 0/6] ARM: OMAP3+: Introduce ABB driver
Date: Tue, 16 Apr 2013 12:07:03 -0700
Message-ID: <20130416190703.19887.10780@quantum>
References: <1366032491-4162-1-git-send-email-andrii.tseglytskyi@ti.com>
 <87sj2rbguv.fsf@linaro.org> <516D46CC.3080705@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:56912 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230Ab3DPTHJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Apr 2013 15:07:09 -0400
Received: by mail-pd0-f175.google.com with SMTP id g10so447621pdj.34
        for <linux-omap@vger.kernel.org>; Tue, 16 Apr 2013 12:07:08 -0700 (PDT)
In-Reply-To: <516D46CC.3080705@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>, Kevin Hilman <khilman@linaro.org>
Cc: linux-omap@vger.kernel.org, =?utf-8?q?Beno=C3=AEt_Cousson?= <b-cousson@ti.com>, Tero Kristo <t-kristo@ti.com>

Quoting Andrii Tseglytskyi (2013-04-16 05:40:44)
> On 04/16/2013 12:53 AM, Kevin Hilman wrote:
> > In addition to Mike's comments (which I completely agree with), it would
> > be very helfpul to see how this is actually used.  e.g, how the
> > regulators are chained together, how the proper ordering is managed,
> > etc. etc.
> 
> We would like to handle voltage scaling in the following way:
> 

I expanded the example below to include the SR AVS regulator.

> cpufreq_cpu0
> clk_set_rate(cpu0)
>      |
>      |-->set_voltage(ABB regulator)
>                  |
>                  |-->set_voltage(AVS)
>                             |
>                             |-->set_voltage(smps123 regulator)

Hi Andrii,

Why was regulator chaining chosen over a simple sequence of calls to
regulator_set_voltage?  Instead of nested calls into the regulator
framework, why don't you just make the calls serially?  E.g:

regulator_set_voltage(abb_reg, foo_volt);
regulator_set_voltage(avs_reg, bar_volt);
regulator_set_voltage(smps123_reg, baz_volt);

It is still to be determined where these calls originate from; maybe
from clock notifiers, maybe directly from the cpufreq driver's .target()
callback, or maybe somewhere else.  Regardless, I do not see why
regulator chaining is truly necessary here.  You are just calling
regulator_set_voltage in sequence on a few regulators, right?

I think it would help me a lot to understand why regulator chaining is a
requirement for this to work properly.

Thanks,
Mike

> 
> 
> This simple model will be extended to handle AVS as a part of the chain.
> smps123 regulator may be changed to VP/VC regulator.
> 
> Following example is from integration branch, which already has smps123 
> regulator.
> It demonstrates an example of linkage to chain. ABB regulator is linked 
> with smps123 and cpu0 inside device tree.
> cpu0 calls set_voltage() function for ABB, and then ABB calls 
> set_voltage() function for smps123 to do actual voltage scaling.
> 
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index bb5ee70..c8cbbee 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -36,7 +36,7 @@
>          cpus {
>                  cpu@0 {
>                          compatible = "arm,cortex-a15";
> -                       cpu0-supply = <&smps123_reg>;
> +                       cpu0-supply = <&abb_mpu>;
>                          operating-points = <
>                                  /* kHz    uV */
>                                  /* Only for Nominal Samples */
> @@ -94,6 +94,7 @@
>                  reg = <0x4ae07cdc 0x8>,
>                        <0x4ae06014 0x4>;
>                  ti,tranxdone_status_mask = <0x80>;
> +               avs-supply = <&smps123_reg>;
>                  operating-points = <
>                          /* uV   ABB */
>                          880000  0
> 
> This RFC patch series is verified together with:
> https://patchwork.kernel.org/patch/2445091/
> 
> Kevin, what do you think about this model in general? Does it fit to 
> regulator framework?
> 
> Thank you.
> 
> Regards,
> Andrii
