From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V2] OMAP3: PM: Set/reset T2 bit for Smartreflex on TWL.
Date: Wed, 02 Feb 2011 07:59:56 +0530
Message-ID: <4D48C1A4.6040600@ti.com>
References: <1295847446-20667-1-git-send-email-shweta.gulati@ti.com> <87wrljnzri.fsf@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070808070303090806040702"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:41734 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752393Ab1BBCan (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Feb 2011 21:30:43 -0500
Received: by vws20 with SMTP id 20so2670905vws.24
        for <linux-omap@vger.kernel.org>; Tue, 01 Feb 2011 18:30:42 -0800 (PST)
In-Reply-To: <87wrljnzri.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Shweta Gulati <shweta.gulati@ti.com>, linux-omap@vger.kernel.org, Thara Gopinath <thara@ti.com>

This is a multi-part message in MIME format.
--------------070808070303090806040702
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Kevin Hilman wrote, on 02/02/2011 04:11 AM:
> Shweta Gulati<shweta.gulati@ti.com>  writes:
>
>> From: Thara Gopinath<thara@ti.com>
>>
>> The smartreflex bit on twl4030 needs to be enabled by default irrespective
>> of whether smartreflex module is enabled on the OMAP side or not.
>> This is because without this bit enabled the voltage scaling through
>> vp forceupdate does not function properly on OMAP3.API added
>> 'omap3_twl_set_sr_bit' with parameter to set/clear SR bit. It is cleared
>> for platforms where voltage is not scaled using vpforceupdate
>> or vc_bypass Method. In those cases 'omap3_twl_set_sr_bit' is called
>> from board file, to make sure this bit is not overwritten in
>> 'omap3_twl_init', a flag 'twl_sr_enable'
>> is added.
>
> As Sanjeev pointed out, the use of 'irrespective' above is confusing, in
> fact the whole changelog is kind of confusing.
>
> The changelog states that it has to always be enabled, but then goes on
> to describe the situation(s) where it would be disabled.
>
> Here's my rephrasing of how I understand the above changelog
>
> - enable: *always* be enabled
> - enable: needed for VP force update
> - disable: platforms using VP forced update or VP bypass
>
> -ECONFUSED
>
> Kevin

How about this as the commit log?

The smartreflex bit on twl4030 specifies if the setting of voltage
is done over the I2C_SR path. Given that there are platforms that
do not use I2C_SR path for voltage scaling, a new function
'omap3_twl_set_sr_bit' with parameter to set/clear SR bit has been
provided for flexibility. It is called with appropriate param
for platforms where voltage is not scaled using I2C_SR path
from board file, to make sure this bit is not overwritten in
'omap3_twl_init'.



>
>> This patch is based on LO PM Branch and Smartreflex has been
>> tested on OMAP3430 SDP, OMAP3630 SDP and boot tested on
>> OMAP2430 SDP.

this belongs into the diffstat.

Attached is a modified version of this patch - i'vent tested it though.. 
but basically improves the logic a little:

*) made the comments more generic to ensure that this is more of I2C_SR 
path as far as TWL is concerned(yes, from OMAP perspective it is vp 
forceupdate/bypass), but it is more of an OMAP problem than omap_twl.c 
problem.
*) modified the function call sequences to prevent rentry even if board 
file calls with various other params
*) shifted to using bool
*) use init and initdata to free up the space once we are done with init 
sequence

etc...


Do let me know if this is good enough.


-- 
Regards,
Nishanth Menon

--------------070808070303090806040702
Content-Type: text/x-patch;
 name="0001-OMAP3-PM-Set-clear-T2-bit-for-Smartreflex-on-TWL.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-OMAP3-PM-Set-clear-T2-bit-for-Smartreflex-on-TWL.patch"

>From 6474825fd3800f296da6103e198f563938572f67 Mon Sep 17 00:00:00 2001
From: Thara Gopinath <thara@ti.com>
Date: Mon, 24 Jan 2011 11:07:26 +0530
Subject: [PATCH] OMAP3: PM: Set/clear T2 bit for Smartreflex on TWL

The smartreflex bit on twl4030 specifies if the setting of voltage
is done over the I2C_SR path. Given that there are platforms that
do not use I2C_SR path for voltage scaling, a new function
'omap3_twl_set_sr_bit' with parameter to set/clear SR bit has been
provided for flexibility. It is called with appropriate param
for platforms where voltage is not scaled using I2C_SR path
from board file, to make sure this bit is not overwritten in
'omap3_twl_init'.

Signed-off-by: Thara Gopinath <thara@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
---

This patch is based on LO PM Branch and Smartreflex has been
tested on OMAP3430 SDP, OMAP3630 SDP and boot tested on
OMAP2430 SDP.

 arch/arm/mach-omap2/omap_twl.c |   60 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/pm.h       |    1 +
 2 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index 00e1d2b..8b24839 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -59,8 +59,15 @@
 
 static bool is_offset_valid;
 static u8 smps_offset;
+/*
+ * Flag to ensure Smartreflex bit in TWL
+ * being cleared in board file is not overwritten.
+ */
+static bool __initdata twl_sr_enable_autoinit;
 
+#define TWL4030_DCDC_GLOBAL_CFG        0x06
 #define REG_SMPS_OFFSET         0xE0
+#define SMARTREFLEX_ENABLE     BIT(3)
 
 static unsigned long twl4030_vsel_to_uv(const u8 vsel)
 {
@@ -269,6 +276,18 @@ int __init omap3_twl_init(void)
 		omap3_core_volt_info.vp_vddmax = OMAP3630_VP2_VLIMITTO_VDDMAX;
 	}
 
+	/*
+	 * The smartreflex bit on twl4030 specifies if the setting of voltage
+	 * is done over the I2C_SR path. Since this setting is independent of
+	 * the actual usage of smartreflex AVS module, we enable TWL SR bit
+	 * by default irrespective of whether smartreflex AVS module is enabled
+	 * on the OMAP side or not. This is because without this bit enabled,
+	 * the voltage scaling through vp forceupdate/bypass mechanism of
+	 * voltage scaling will not function on TWL over I2C_SR.
+	 */
+	if (!twl_sr_enable_autoinit)
+		omap3_twl_set_sr_bit(true);
+
 	voltdm = omap_voltage_domain_lookup("mpu");
 	omap_voltage_register_pmic(voltdm, &omap3_mpu_volt_info);
 
@@ -277,3 +296,44 @@ int __init omap3_twl_init(void)
 
 	return 0;
 }
+
+/**
+ * omap3_twl_set_sr_bit() - Set/Clear SR bit on TWL
+ * @enable: enable SR mode in twl or not
+ *
+ * If 'enable' is true, enables Smartreflex bit on TWL 4030 to make sure
+ * voltage scaling through OMAP SR works. Else, the smartreflex bit
+ * on twl4030 is cleared as there are platforms which use OMAP3 and T2 but
+ * use Synchronized Scaling Hardware Strategy (ENABLE_VMODE=1) and Direct
+ * Strategy Software Scaling Mode (ENABLE_VMODE=0), for setting the voltages,
+ * in those scenarios this bit is to be cleared (enable = false).
+ *
+ * Returns 0 on sucess, error is returned if I2C read/write fails.
+ */
+int __init omap3_twl_set_sr_bit(bool enable)
+{
+	u8 temp;
+	int ret;
+	if (twl_sr_enable_autoinit)
+		pr_warning("%s: unexpected multiple calls\n", __func__);
+
+	ret = twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &temp,
+				TWL4030_DCDC_GLOBAL_CFG);
+	if (ret)
+		goto err;
+
+	if (enable)
+		temp |= SMARTREFLEX_ENABLE;
+	else
+		temp &= ~SMARTREFLEX_ENABLE;
+
+	ret = twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, temp,
+			TWL4030_DCDC_GLOBAL_CFG);
+	if (!ret) {
+		twl_sr_enable_autoinit = true;
+		return 0;
+	}
+err:
+	pr_err("%s: Error access to TWL4030 (%d)\n", __func__, ret);
+	return ret;
+}
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 1c1b0ab..2f4f2f1 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -127,6 +127,7 @@ static inline void omap_enable_smartreflex_on_init(void) {}
 #ifdef CONFIG_TWL4030_CORE
 extern int omap3_twl_init(void);
 extern int omap4_twl_init(void);
+extern int omap3_twl_set_sr_bit(bool);
 #else
 static inline int omap3_twl_init(void)
 {
-- 
1.7.1


--------------070808070303090806040702--
