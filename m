From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH] omap3: Add basic support for 720MHz part
Date: Wed, 19 Jan 2011 10:49:29 +0100
Message-ID: <504C62DB-E7ED-46E6-8825-29A410885087@dominion.thruhere.net>
References: <1295336995-15831-1-git-send-email-premi@ti.com> <789E54BD-D2B6-4B98-B9B8-19688E415E39@dominion.thruhere.net> <4D35C47D.6000102@ti.com> <b8bd13a9f9b383c7db6af63e1aa984be@mail.gmail.com> <4F6B1267-93B8-4698-9880-376076825598@dominion.thruhere.net> <3b2df4e1c65667c6383d654cca4be8ac@mail.gmail.com> <4D36A9AE.1010606@ti.com>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:65135 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519Ab1ASJte convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Jan 2011 04:49:34 -0500
Received: by wwa36 with SMTP id 36so666407wwa.1
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 01:49:33 -0800 (PST)
In-Reply-To: <4D36A9AE.1010606@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>, Sanjeev Premi <premi@ti.com>, l-o List <linux-omap@vger.kernel.org>, Thara Gopinath <thara@ti.com>


Op 19 jan 2011, om 10:06 heeft Nishanth Menon het volgende geschreven:

> Vishwanath Sripathy wrote, on 01/19/2011 10:56 AM:
>> If you want a quick hack, you can modify the voltage for 700M marginally
>> (like you have done above). But it needs to be done in multiple places.
>> You need to modify IVA OPP6 entry in opp table and OPP6 voltage value in
>> voltage.h as well besides above change. This should work.
> we may want to be sure about keeping the additional voltages in 1 step increment (12.5mV - to ensure twl conversion routines sane)- i think we may be pretty much maxed out for the tps chip used, no?

Not using the 12.5mV steps gives me:

[    3.076873] calc_dep_vdd_volt: Not able to find a matching volt forvdd_core corresponding to vdd_mpu 1350001 volt
[    3.095306] omap_voltage_scale: Error in calculating dependent vdd voltagesfor vdd_mpu

It does seem to work, though:

root@usrp-e1xx:~# grep MIPS /proc/cpuinfo 
BogoMIPS	: 717.37

I think I'll just drop the OPP5 voltage by 12.5mV since I know what silicon my usrp-e1xx has, but I can't really give out that patch to others, since someone might replace the overo with another one.

This is the hack I ended up using:

diff --git a/arch/arm/mach-omap2/opp3xxx_data.c b/arch/arm/mach-omap2/opp3xxx_data.c
index 76d26c7..c913240 100644
--- a/arch/arm/mach-omap2/opp3xxx_data.c
+++ b/arch/arm/mach-omap2/opp3xxx_data.c
@@ -37,7 +37,7 @@ static struct omap_opp_def __initdata omap34xx_opp_def_list[] = {
        /* MPU OPP5 */
        OPP_INITIALIZER("mpu", true, 600000000, 1350000),
        /* MPU OPP6 */
-       OPP_INITIALIZER("mpu", false, 720000000, 1350000),
+       OPP_INITIALIZER("mpu", false, 720000000, 1350001),
 
        /*
         * L3 OPP1 - 41.5 MHz is disabled because: The voltage for that OPP is
@@ -64,7 +64,7 @@ static struct omap_opp_def __initdata omap34xx_opp_def_list[] = {
        /* DSP OPP5 */
        OPP_INITIALIZER("iva", true, 430000000, 1350000),
        /* DSP OPP6 */
-       OPP_INITIALIZER("iva", false, 520000000, 1350000),
+       OPP_INITIALIZER("iva", false, 520000000, 1350001),
 };
 
 static struct omap_opp_def __initdata omap36xx_opp_def_list[] = {
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index d10cb1b..2b7ff8f 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -324,6 +324,7 @@ static struct omap_volt_data omap34xx_vddmpu_volt_data[] = {
        VOLT_DATA_DEFINE(OMAP3430_VDD_MPU_OPP3_UV, OMAP343X_CONTROL_FUSE_OPP3_VDD1, 0xf9, 0x18),
        VOLT_DATA_DEFINE(OMAP3430_VDD_MPU_OPP4_UV, OMAP343X_CONTROL_FUSE_OPP4_VDD1, 0xf9, 0x18),
        VOLT_DATA_DEFINE(OMAP3430_VDD_MPU_OPP5_UV, OMAP343X_CONTROL_FUSE_OPP5_VDD1, 0xf9, 0x18),
+       VOLT_DATA_DEFINE(OMAP3430_VDD_MPU_OPP6_UV, OMAP343X_CONTROL_FUSE_OPP5_VDD1, 0xf9, 0x18),
        VOLT_DATA_DEFINE(0, 0, 0, 0),
 };
 
diff --git a/arch/arm/plat-omap/include/plat/voltage.h b/arch/arm/plat-omap/include/plat/voltage.h
index 6782c5e..42b89db 100644
--- a/arch/arm/plat-omap/include/plat/voltage.h
+++ b/arch/arm/plat-omap/include/plat/voltage.h
@@ -31,6 +31,7 @@
 #define OMAP3430_VDD_MPU_OPP3_UV               1200000
 #define OMAP3430_VDD_MPU_OPP4_UV               1270000
 #define OMAP3430_VDD_MPU_OPP5_UV               1350000
+#define OMAP3430_VDD_MPU_OPP6_UV               1350001
 
 #define OMAP3430_VDD_CORE_OPP1_UV              975000
 #define OMAP3430_VDD_CORE_OPP2_UV              1050000


