From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [pm-wip/cpufreq][PATCH 3/3] OMAP2+: cpufreq: do lateinit
Date: Tue, 7 Jun 2011 19:28:32 -0500
Message-ID: <BANLkTikUiOV6rYFbrULVMWkOS23Msy3hXg@mail.gmail.com>
References: <1307412330-25798-1-git-send-email-nm@ti.com> <1307412330-25798-4-git-send-email-nm@ti.com>
 <8762ohnwgb.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:34906 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756201Ab1FHA2z convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Jun 2011 20:28:55 -0400
Received: by mail-ww0-f43.google.com with SMTP id 17so12016wwb.24
        for <linux-omap@vger.kernel.org>; Tue, 07 Jun 2011 17:28:54 -0700 (PDT)
In-Reply-To: <8762ohnwgb.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Tue, Jun 7, 2011 at 16:49, Kevin Hilman <khilman@ti.com> wrote:
> Nishanth Menon <nm@ti.com> writes:
>
>> Since we do module_init, cpufreq initializes before power late_init
>> where many of the required data structures are registered.
>
> What exactly are the dependencies here? =A0The only thing I see is th=
e
> dependency on omap2_get_mpuss_device(), and those devices should be
> created as a postcore_initcall.
>
> If there are other dependencies, they're probably created a side effe=
ct
> of your earlier patches where you moved stuff from the ->init hook
> (which happens much later) into the initcall function. =A0Maybe that =
needs
> a rethink?
>
>> Move cpufreq init to late_initcall instead. Further CONFIG_CPU_FREQ =
on
>> which the build depends is bool and does'nt support modules yet.
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>
> If this works, it's only because of the link order defined by the
> Makefile ordering since both are the same level of initcall.
>
> When I move this driver to drivers/cpufreq, then the link order is le=
ss
> obvious.

the issue is as follows:
currently we dont do voltage transitions. when we do that
eventually(and my current code has an forked implementation of dvfs,
the following steps happen):
late_initcall(omap2_common_pm_late_init);
does pmic inits, omap_voltage_late_init, init_voltages and SR dev initi=
alization

without these, there is no way to transition MPU to proper voltage,
frequency combination. The requirement will have to be that
omap2-cpufreq.c allows for cpufreq transitions only after voltage and
clk layers are ready for transitions - if we ever want to do dvfs -
which we will eventually need to.

Regards,
Nishanth Menon


>
> Kevin
>
>> ---
>> =A0arch/arm/mach-omap2/omap2plus-cpufreq.c | =A0 =A02 +-
>> =A01 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach=
-omap2/omap2plus-cpufreq.c
>> index 2177381..07c2ab9 100644
>> --- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
>> +++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
>> @@ -273,5 +273,5 @@ static void __exit omap_cpufreq_exit(void)
>>
>> =A0MODULE_DESCRIPTION("cpufreq driver for OMAP2PLUS SOCs");
>> =A0MODULE_LICENSE("GPL");
>> -module_init(omap_cpufreq_init);
>> +late_initcall(omap_cpufreq_init);
>> =A0module_exit(omap_cpufreq_exit);
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
