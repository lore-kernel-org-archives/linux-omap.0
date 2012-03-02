From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH] cpufreq: OMAP: specify range for voltage scaling
Date: Fri, 2 Mar 2012 12:19:36 +0200
Message-ID: <1330683576.2116.108.camel@sokoban>
References: <1330004964-22831-1-git-send-email-afzal@ti.com>
	 <87fwdshyhk.fsf@ti.com>  <87d38wf008.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-vFHIu7gFD5wdcmaBAh1U"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50662 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755847Ab2CBKTj (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Mar 2012 05:19:39 -0500
Received: from dlep26.itg.ti.com ([157.170.170.121])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id q22AJcsq003279
	for <linux-omap@vger.kernel.org>; Fri, 2 Mar 2012 04:19:38 -0600
Received: from DFLE71.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id q22AJcKm002381
	for <linux-omap@vger.kernel.org>; Fri, 2 Mar 2012 04:19:38 -0600 (CST)
In-Reply-To: <87d38wf008.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Afzal Mohammed <afzal@ti.com>, linux-omap@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>

--=-vFHIu7gFD5wdcmaBAh1U
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2012-03-01 at 14:07 -0800, Kevin Hilman wrote:
> +Tero
> 
> Kevin Hilman <khilman@ti.com> writes:
> 
> > Afzal Mohammed <afzal@ti.com> writes:
> >
> >> Specify voltage in ranges for regulator. Range
> >> used is tolerance specified for OPP.
> >>
> >> This helps to achieve DVFS with a wider range of
> >> regulators.
> >>
> >> Cc: Kevin Hilman <khilman@ti.com>
> >> Cc: Sekhar Nori <nsekhar@ti.com>
> >> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> >
> > Thanks, will queue this with the CPUfreq changes for MPU DVFS.
> 
> Actually, not quite yet...
> 
> After some testing with the SMPS regulators, this won't quite work with
> the current SMPS regulators.  Does this actually work with the
> regulators you're using?
> 
> For OMAPs using VC/VP for voltage scaling, the TWL regulator passes on
> the voltage requested directly to the voltage layer.  When using voltage
> - tolerance, this results in voltages that the voltage layer doesn't
> know about because they do not match any of the voltages from the known
> OPPs.
> 
> The problem that we have is that while the regulators can support a
> broad range of voltages (from min to max with a some step), the on-chip
> voltage domains cannot, which is why we have defined the OPPs which are
> known to work.
> 
> Tero, for the SMPS regulators, would it be possible to configure the
> regulators so that only a discrete set voltages are availble to pick
> from?  These should be initialied from the OPP layer.

I guess this would be possible. Looking at this patch, I guess what we
want to do is that we just use the current API we have at the SMPS
regulator layer to pass the min_uV as target_uV for the regulator, and
just get the next opp voltage that is >= than the target_uV.

Here is an inline patch that does this (also attached), this applies on
top of my SMPS regulator changes:

diff --git a/arch/arm/mach-omap2/twl-common.c
b/arch/arm/mach-omap2/twl-common.c
index f19793e..7dc891f 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -41,7 +41,16 @@ static struct i2c_board_info __initdata
pmic_i2c_board_info = {
 static int twl_set_voltage(void *data, int target_uV)
 {
        struct voltagedomain *voltdm = (struct voltagedomain *)data;
-       return voltdm_scale(voltdm, target_uV);
+       struct omap_volt_data *volt_data = voltdm->volt_data;
+       
+       while (1) {
+               if (!volt_data->volt_nominal)
+                       return -EINVAL;
+               if (volt_data->volt_nominal >= target_uV)
+                       break;
+               volt_data++;
+       }
+       return voltdm_scale(voltdm, volt_data->volt_nominal);
 }
 
 static int twl_get_voltage(void *data)


Do you want a new version of the whole set or just this as a separate
one?

-Tero

> 
> Somehow we need to support something like $SUBJECT patch in order to
> support a broad range of regulators.   The OMAP voltagedomain
> limitations need to configured in platform specific way such that the
> CPUfreq driver can remain generic.
> 
> Kevin
> 


--=-vFHIu7gFD5wdcmaBAh1U
Content-Disposition: attachment;
	filename*0="0001-ARM-OMAP3-smps-regulator-match-target_uV-against-OPP.pat";
	filename*1="ch"
Content-Type: text/x-patch;
	name="0001-ARM-OMAP3-smps-regulator-match-target_uV-against-OPP.patch";
	charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From 8b4c16fdfee63a414ebee52e674b6d9fbc16e7c9 Mon Sep 17 00:00:00 2001
From: Tero Kristo <t-kristo@ti.com>
Date: Fri, 2 Mar 2012 12:14:57 +0200
Subject: [PATCH] ARM: OMAP3+: smps regulator: match target_uV against OPP definitions

Scans through the nominal voltage for OPPs until a voltage is found
that is greater than equal to the one requested. This allows the
target_uV to have some error margin in it, and we will always scale
to the next closest OPP voltage.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/twl-common.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
index f19793e..7dc891f 100644
--- a/arch/arm/mach-omap2/twl-common.c
+++ b/arch/arm/mach-omap2/twl-common.c
@@ -41,7 +41,16 @@ static struct i2c_board_info __initdata pmic_i2c_board_info = {
 static int twl_set_voltage(void *data, int target_uV)
 {
 	struct voltagedomain *voltdm = (struct voltagedomain *)data;
-	return voltdm_scale(voltdm, target_uV);
+	struct omap_volt_data *volt_data = voltdm->volt_data;
+	
+	while (1) {
+		if (!volt_data->volt_nominal)
+			return -EINVAL;
+		if (volt_data->volt_nominal >= target_uV)
+			break;
+		volt_data++;
+	}
+	return voltdm_scale(voltdm, volt_data->volt_nominal);
 }
 
 static int twl_get_voltage(void *data)
-- 
1.7.4.1


--=-vFHIu7gFD5wdcmaBAh1U--
