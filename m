From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [pm-wip/cpufreq][PATCH 3/3] OMAP2+: cpufreq: do lateinit
Date: Wed, 8 Jun 2011 13:59:48 -0500
Message-ID: <BANLkTinsZ2hqBvVnrJBe2EQR+kLD1AuuDQ@mail.gmail.com>
References: <1307412330-25798-1-git-send-email-nm@ti.com> <1307412330-25798-4-git-send-email-nm@ti.com>
 <8762ohnwgb.fsf@ti.com> <BANLkTikUiOV6rYFbrULVMWkOS23Msy3hXg@mail.gmail.com> <87ei34i2ck.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:42190 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753448Ab1FHTAJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Jun 2011 15:00:09 -0400
Received: by mail-ww0-f49.google.com with SMTP id 39so665229wwb.18
        for <linux-omap@vger.kernel.org>; Wed, 08 Jun 2011 12:00:08 -0700 (PDT)
In-Reply-To: <87ei34i2ck.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

On Wed, Jun 8, 2011 at 13:51, Kevin Hilman <khilman@ti.com> wrote:
[..]
>> the issue is as follows:
>> currently we dont do voltage transitions. when we do that
>> eventually(and my current code has an forked implementation of dvfs,
>> the following steps happen):
>> late_initcall(omap2_common_pm_late_init);
>> does pmic inits, omap_voltage_late_init, init_voltages and SR dev in=
itialization
>>
>> without these, there is no way to transition MPU to proper voltage,
>> frequency combination. The requirement will have to be that
>> omap2-cpufreq.c allows for cpufreq transitions only after voltage an=
d
>> clk layers are ready for transitions - if we ever want to do dvfs -
>> which we will eventually need to.
>
> Yes, I understand.
>
> But $SUBJECT patch is fixing this as an _init_ time ordering problem,
> What you're describing is a runtime requirement that doesn't exist un=
til
> a DVFS transition is done. =A0IOW, the requirement is that the voltag=
e
> etc. layers have to be init'd before the first transition.
>
> So, rather than fix this with initcall ordering (which will have to b=
e
> redone as things git moved and converted to modules), just create a t=
ype
> of late init function in this driver, which gets called on the first
> transition.

The tricky part ofcourse is for the registration - if we do the
registration, omap_cpu_init will get called once the registration
happens - no reason to stop it, which in turn triggers omap_target the
moment the governors are ready to do their thing. Is the following
what you are talking about? I am not completely sure how this helps..

diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c
b/arch/arm/mach-omap2/omap2plus-cpufreq.c
index 77efcb0..8586df8 100644
--- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
+++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
@@ -253,6 +253,11 @@ static struct cpufreq_driver omap_driver =3D {
        .attr           =3D omap_cpufreq_attr,
 };

+static int __init omap_cpufreq_lateinit(void)
+{
+       return cpufreq_register_driver(&omap_driver);
+}
+
 static int __init omap_cpufreq_init(void)
 {
        if (cpu_is_omap24xx()) {
@@ -277,8 +282,7 @@ static int __init omap_cpufreq_init(void)
                pr_warning("%s: unable to get the mpu device\n", __func=
__);
                return -EINVAL;
        }
-
-       return cpufreq_register_driver(&omap_driver);
+       return 0;
 }

 static void __exit omap_cpufreq_exit(void)
@@ -288,5 +292,6 @@ static void __exit omap_cpufreq_exit(void)

 MODULE_DESCRIPTION("cpufreq driver for OMAP2PLUS SOCs");
 MODULE_LICENSE("GPL");
+late_initcall(omap_cpufreq_lateinit);
 module_init(omap_cpufreq_init);
 module_exit(omap_cpufreq_exit);


Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
