From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] cpufreq: OMAP: specify range for voltage scaling
Date: Fri, 02 Mar 2012 14:39:30 -0800
Message-ID: <87vcmmpqzh.fsf@ti.com>
References: <1330004964-22831-1-git-send-email-afzal@ti.com>
	<87fwdshyhk.fsf@ti.com> <87d38wf008.fsf@ti.com>
	<1330683576.2116.108.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:46539 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965271Ab2CBWjd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Mar 2012 17:39:33 -0500
Received: by mail-pw0-f46.google.com with SMTP id un15so585471pbc.19
        for <linux-omap@vger.kernel.org>; Fri, 02 Mar 2012 14:39:32 -0800 (PST)
In-Reply-To: <1330683576.2116.108.camel@sokoban> (Tero Kristo's message of
	"Fri, 2 Mar 2012 12:19:36 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: t-kristo@ti.com, nm@ti.com
Cc: Afzal Mohammed <afzal@ti.com>, linux-omap@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>

+Nishanth

Tero Kristo <t-kristo@ti.com> writes:

> On Thu, 2012-03-01 at 14:07 -0800, Kevin Hilman wrote:
>> +Tero
>> 
>> Kevin Hilman <khilman@ti.com> writes:
>> 
>> > Afzal Mohammed <afzal@ti.com> writes:
>> >
>> >> Specify voltage in ranges for regulator. Range
>> >> used is tolerance specified for OPP.
>> >>
>> >> This helps to achieve DVFS with a wider range of
>> >> regulators.
>> >>
>> >> Cc: Kevin Hilman <khilman@ti.com>
>> >> Cc: Sekhar Nori <nsekhar@ti.com>
>> >> Signed-off-by: Afzal Mohammed <afzal@ti.com>
>> >
>> > Thanks, will queue this with the CPUfreq changes for MPU DVFS.
>> 
>> Actually, not quite yet...
>> 
>> After some testing with the SMPS regulators, this won't quite work with
>> the current SMPS regulators.  Does this actually work with the
>> regulators you're using?
>> 
>> For OMAPs using VC/VP for voltage scaling, the TWL regulator passes on
>> the voltage requested directly to the voltage layer.  When using voltage
>> - tolerance, this results in voltages that the voltage layer doesn't
>> know about because they do not match any of the voltages from the known
>> OPPs.
>> 
>> The problem that we have is that while the regulators can support a
>> broad range of voltages (from min to max with a some step), the on-chip
>> voltage domains cannot, which is why we have defined the OPPs which are
>> known to work.
>> 
>> Tero, for the SMPS regulators, would it be possible to configure the
>> regulators so that only a discrete set voltages are availble to pick
>> from?  These should be initialied from the OPP layer.
>
> I guess this would be possible. Looking at this patch, I guess what we
> want to do is that we just use the current API we have at the SMPS
> regulator layer to pass the min_uV as target_uV for the regulator, and
> just get the next opp voltage that is >= than the target_uV.

Yeah, this should work.

However, after discussing this on IRC with Nishanth, instead of enforcing
this in the TWL glue layer, I think we need to enforce using OPP
voltages in the voltage layer itself.  Patch below[1].

I've now added that patch to my for_3.4/pm/smps-regulator branch (and
will post to the list shortly.)

I've also added $SUBJECT patch (back) to my for_3.4/cpufreq branch. 

I'd appreciate some testing of these two branches together.  With those
two, I've tested MPU DVFS on 3530/Overo, 3630/Zoom3 and 4430/Panda, but
would appreciate any additional testing.

Kevin


>From 212024af641266c3de8b55764f84d923f238315c Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@ti.com>
Date: Fri, 2 Mar 2012 14:08:57 -0800
Subject: [PATCH] ARM: OMAP2+: voltage: ensure voltage used is exact voltage
 from OPP table

When using the SMPS regulators to scale voltages, the regulator
framework may pass a minimum voltage that is not an exact OPP voltage.
For the VC/VP controlled voltage domains, we must ensure that the
voltage requested is the exact voltage from the OPP table.  This is
especially critical when using SR.

To fix, voltdm_scale() uses the target voltage passed to walk through
the OPP voltages until it finds a voltage that is >= one of the OPP
voltages.

Cc: Tero Kristo <t-kristo@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/voltage.c |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 8a36342..4dc60e8 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -73,7 +73,8 @@ unsigned long voltdm_get_voltage(struct voltagedomain *voltdm)
 int voltdm_scale(struct voltagedomain *voltdm,
 		 unsigned long target_volt)
 {
-	int ret;
+	int ret, i;
+	unsigned long volt = 0;
 
 	if (!voltdm || IS_ERR(voltdm)) {
 		pr_warning("%s: VDD specified does not exist!\n", __func__);
@@ -86,9 +87,23 @@ int voltdm_scale(struct voltagedomain *voltdm,
 		return -ENODATA;
 	}
 
-	ret = voltdm->scale(voltdm, target_volt);
+	/* Adjust voltage to the exact voltage from the OPP table */
+	for (i = 0; voltdm->volt_data[i].volt_nominal != 0; i++) {
+		if (voltdm->volt_data[i].volt_nominal >= target_volt) {
+			volt = voltdm->volt_data[i].volt_nominal;
+			break;
+		}
+	}
+
+	if (!volt) {
+		pr_warning("%s: not scaling. OPP voltage for %lu, not found.\n",
+			   __func__, target_volt);
+		return -EINVAL;
+	}
+
+	ret = voltdm->scale(voltdm, volt);
 	if (!ret)
-		voltdm->nominal_volt = target_volt;
+		voltdm->nominal_volt = volt;
 
 	return ret;
 }
-- 
1.7.9.2

