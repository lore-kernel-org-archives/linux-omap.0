From: Kevin Hilman <khilman@ti.com>
Subject: Re: [pm-wip/cpufreq][PATCH 3/3] OMAP2+: cpufreq: do lateinit
Date: Wed, 08 Jun 2011 14:03:15 -0700
Message-ID: <87fwnkghnw.fsf@ti.com>
References: <1307412330-25798-1-git-send-email-nm@ti.com>
	<1307412330-25798-4-git-send-email-nm@ti.com> <8762ohnwgb.fsf@ti.com>
	<BANLkTikUiOV6rYFbrULVMWkOS23Msy3hXg@mail.gmail.com>
	<87ei34i2ck.fsf@ti.com>
	<BANLkTinsZ2hqBvVnrJBe2EQR+kLD1AuuDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:59872 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754920Ab1FHVDT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Jun 2011 17:03:19 -0400
Received: by mail-pz0-f51.google.com with SMTP id 26so438573pzk.10
        for <linux-omap@vger.kernel.org>; Wed, 08 Jun 2011 14:03:18 -0700 (PDT)
In-Reply-To: <BANLkTinsZ2hqBvVnrJBe2EQR+kLD1AuuDQ@mail.gmail.com> (Nishanth
	Menon's message of "Wed, 8 Jun 2011 13:59:48 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

"Menon, Nishanth" <nm@ti.com> writes:

> On Wed, Jun 8, 2011 at 13:51, Kevin Hilman <khilman@ti.com> wrote:
> [..]
>>> the issue is as follows:
>>> currently we dont do voltage transitions. when we do that
>>> eventually(and my current code has an forked implementation of dvfs=
,
>>> the following steps happen):
>>> late_initcall(omap2_common_pm_late_init);
>>> does pmic inits, omap_voltage_late_init, init_voltages and SR dev i=
nitialization
>>>
>>> without these, there is no way to transition MPU to proper voltage,
>>> frequency combination. The requirement will have to be that
>>> omap2-cpufreq.c allows for cpufreq transitions only after voltage a=
nd
>>> clk layers are ready for transitions - if we ever want to do dvfs -
>>> which we will eventually need to.
>>
>> Yes, I understand.
>>
>> But $SUBJECT patch is fixing this as an _init_ time ordering problem=
,
>> What you're describing is a runtime requirement that doesn't exist u=
ntil
>> a DVFS transition is done. =C2=A0IOW, the requirement is that the vo=
ltage
>> etc. layers have to be init'd before the first transition.
>>
>> So, rather than fix this with initcall ordering (which will have to =
be
>> redone as things git moved and converted to modules), just create a =
type
>> of late init function in this driver, which gets called on the first
>> transition.
>
> The tricky part ofcourse is for the registration - if we do the
> registration, omap_cpu_init will get called once the registration
> happens - no reason to stop it, which in turn triggers omap_target th=
e
> moment the governors are ready to do their thing.=20

Yes.

> Is the following what you are talking about? I am not completely sure
> how this helps..

No.  I was thinking of doing registration as it is today, but have a
late hook that is called in the driver's->target() callback that checks
if the other frameworks are ready. =20

But now I see now that ->target() is called right after ->init(), so I
don't think this helps.  Sheesh.  The PM init sequence/dependencies
right now are a complete mess.

Probably a better solution to this, would be to actually create a
platform driver out of our CPUfreq driver.  Then, PM core late init
would just register the platform device when it's ready.  This would
also work if/when the CPUfreq driver is a module.

Kevin


> diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c
> b/arch/arm/mach-omap2/omap2plus-cpufreq.c
> index 77efcb0..8586df8 100644
> --- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
> +++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
> @@ -253,6 +253,11 @@ static struct cpufreq_driver omap_driver =3D {
>         .attr           =3D omap_cpufreq_attr,
>  };
>
> +static int __init omap_cpufreq_lateinit(void)
> +{
> +       return cpufreq_register_driver(&omap_driver);
> +}
> +
>  static int __init omap_cpufreq_init(void)
>  {
>         if (cpu_is_omap24xx()) {
> @@ -277,8 +282,7 @@ static int __init omap_cpufreq_init(void)
>                 pr_warning("%s: unable to get the mpu device\n", __fu=
nc__);
>                 return -EINVAL;
>         }
> -
> -       return cpufreq_register_driver(&omap_driver);
> +       return 0;
>  }
>
>  static void __exit omap_cpufreq_exit(void)
> @@ -288,5 +292,6 @@ static void __exit omap_cpufreq_exit(void)
>
>  MODULE_DESCRIPTION("cpufreq driver for OMAP2PLUS SOCs");
>  MODULE_LICENSE("GPL");
> +late_initcall(omap_cpufreq_lateinit);
>  module_init(omap_cpufreq_init);
>  module_exit(omap_cpufreq_exit);
>
>
> Regards,
> Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
