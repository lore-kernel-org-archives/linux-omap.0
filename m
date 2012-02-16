From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH/RFT 1/1] OMAP2+: cpufreq: scale voltage along with frequency
Date: Thu, 16 Feb 2012 11:36:05 -0800
Message-ID: <87lio2fu56.fsf@ti.com>
References: <1329420043-32656-1-git-send-email-khilman@ti.com>
	<1329420043-32656-2-git-send-email-khilman@ti.com>
	<CAORVsuUsnp8gMygbsrQh7O6048eUyjTrT3Ob_Jop5JKQyxiMOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:44774 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752041Ab2BPTgI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Feb 2012 14:36:08 -0500
Received: by mail-pw0-f43.google.com with SMTP id ro2so3933243pbb.16
        for <linux-omap@vger.kernel.org>; Thu, 16 Feb 2012 11:36:05 -0800 (PST)
In-Reply-To: <CAORVsuUsnp8gMygbsrQh7O6048eUyjTrT3Ob_Jop5JKQyxiMOA@mail.gmail.com>
	(Jean Pihet's message of "Thu, 16 Feb 2012 11:24:22 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>

Jean Pihet <jean.pihet@newoldbits.com> writes:

> Hi Kevin,
>
> On Thu, Feb 16, 2012 at 11:20 AM, Kevin Hilman <khilman@ti.com> wrote=
:
>> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/vol=
tage.c
>> index 8a36342..140c032 100644
>> --- a/arch/arm/mach-omap2/voltage.c
>> +++ b/arch/arm/mach-omap2/voltage.c
>> @@ -89,6 +89,8 @@ int voltdm_scale(struct voltagedomain *voltdm,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D voltdm->scale(voltdm, target_volt=
);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!ret)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0voltdm->nomin=
al_volt =3D target_volt;
>> + =C2=A0 =C2=A0 =C2=A0 printk("KJH: %s: %d\n", __func__, target_volt=
);
>> + =C2=A0 =C2=A0 =C2=A0 dump_stack();
> The debugging letfovers need to be removed.

heh, that's why it's RFT.  :)

Here's a version without the stack dumping.


=46rom 62541aac986ee8ba3b67f40de4610068b2d7fbd7 Mon Sep 17 00:00:00 200=
1
=46rom: Kevin Hilman <khilman@ti.com>
Date: Fri, 15 Jul 2011 15:05:04 -0700
Subject: [PATCH/RFT 1/1] OMAP2+: cpufreq: scale voltage along with freq=
uency

Use the regulator framework to get the voltage regulator associated
with the MPU voltage domain and use it to scale voltage along with
frequency.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 drivers/cpufreq/omap-cpufreq.c |   29 ++++++++++++++++++++++++++++-
 1 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/drivers/cpufreq/omap-cpufreq.c b/drivers/cpufreq/omap-cpuf=
req.c
index 5d04c57..e4f4841 100644
--- a/drivers/cpufreq/omap-cpufreq.c
+++ b/drivers/cpufreq/omap-cpufreq.c
@@ -25,6 +25,7 @@
 #include <linux/opp.h>
 #include <linux/cpu.h>
 #include <linux/module.h>
+#include <linux/regulator/consumer.h>
=20
 #include <asm/system.h>
 #include <asm/smp_plat.h>
@@ -52,6 +53,7 @@ static atomic_t freq_table_users =3D ATOMIC_INIT(0);
 static struct clk *mpu_clk;
 static char *mpu_clk_name;
 static struct device *mpu_dev;
+static struct regulator *mpu_reg;
=20
 static int omap_verify_speed(struct cpufreq_policy *policy)
 {
@@ -78,6 +80,8 @@ static int omap_target(struct cpufreq_policy *policy,
 	unsigned int i;
 	int ret =3D 0;
 	struct cpufreq_freqs freqs;
+	struct opp *opp;
+	unsigned long freq, volt;
=20
 	if (!freq_table) {
 		dev_err(mpu_dev, "%s: cpu%d: no freq table!\n", __func__,
@@ -115,9 +119,26 @@ static int omap_target(struct cpufreq_policy *poli=
cy,
 	pr_info("cpufreq-omap: transition: %u --> %u\n", freqs.old, freqs.new=
);
 #endif
=20
+	freq =3D freqs.new * 1000;
+	opp =3D opp_find_freq_ceil(mpu_dev, &freq);
+	if (IS_ERR(opp)) {
+		printk(KERN_ERR "%s: unable to find MPU OPP for %d\n",
+		       __func__, freqs.new);
+		return -EINVAL;
+	}
+	volt =3D opp_get_voltage(opp);
+
+	/* scaling up?  scale voltage before frequency */
+	if (mpu_reg && (freqs.new > freqs.old))
+		regulator_set_voltage(mpu_reg, volt, volt);
+
 	ret =3D clk_set_rate(mpu_clk, freqs.new * 1000);
-	freqs.new =3D omap_getspeed(policy->cpu);
=20
+	/* scaling down?  scale voltage after frequency */
+	if (mpu_reg && (freqs.new < freqs.old))
+		regulator_set_voltage(mpu_reg, volt, volt);
+
+	freqs.new =3D omap_getspeed(policy->cpu);
 #ifdef CONFIG_SMP
 	/*
 	 * Note that loops_per_jiffy is not updated on SMP systems in
@@ -260,6 +281,12 @@ static int __init omap_cpufreq_init(void)
 		return -EINVAL;
 	}
=20
+	mpu_reg =3D regulator_get(mpu_dev, "vcc");
+	if (IS_ERR(mpu_reg)) {
+		pr_warning("%s: unable to get MPU regulator\n", __func__);
+		mpu_reg =3D NULL;
+	}
+
 	return cpufreq_register_driver(&omap_driver);
 }
=20
--=20
1.7.9

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
