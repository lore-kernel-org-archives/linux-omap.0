From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [RFC 7/7] OMAP3: Update cpufreq driver to use the new set_rate
 API
Date: Thu, 8 Jul 2010 08:41:12 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0323830DD7@dbde02.ent.ti.com>
References: <1278065909-32148-1-git-send-email-thara@ti.com>
 <1278065909-32148-2-git-send-email-thara@ti.com>
 <1278065909-32148-3-git-send-email-thara@ti.com>
 <1278065909-32148-4-git-send-email-thara@ti.com>
 <1278065909-32148-5-git-send-email-thara@ti.com>
 <1278065909-32148-6-git-send-email-thara@ti.com>
 <1278065909-32148-7-git-send-email-thara@ti.com>
 <1278065909-32148-8-git-send-email-thara@ti.com>
 <FCCFB4CDC6E5564B9182F639FC3560870305B06AF9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42522 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753037Ab0GHDLT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jul 2010 23:11:19 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870305B06AF9@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "paul@pwsan.com" <paul@pwsan.com>, "Cousson, Benoit" <b-cousson@ti.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Sawant, Anand" <sawant@ti.com>, "Basak, Partha" <p-basak2@ti.com>



>>-----Original Message-----
>>From: Pandita, Vikram
>>Sent: Thursday, July 08, 2010 8:40 AM
>>To: Gopinath, Thara; linux-omap@vger.kernel.org
>>Cc: khilman@deeprootsystems.com; paul@pwsan.com; Cousson, Benoit; Sripathy, Vishwanath; Sawant,
>>Anand; Basak, Partha
>>Subject: RE: [RFC 7/7] OMAP3: Update cpufreq driver to use the new set_rate API
>>
>>
>>
>>>-----Original Message-----
>>>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>>>owner@vger.kernel.org] On Behalf Of Gopinath, Thara
>>>Sent: Friday, July 02, 2010 5:18 AM
>>>To: linux-omap@vger.kernel.org
>>>Cc: khilman@deeprootsystems.com; paul@pwsan.com; Cousson, Benoit; Sripathy,
>>>Vishwanath; Sawant, Anand; Basak, Partha; Gopinath, Thara
>>>Subject: [RFC 7/7] OMAP3: Update cpufreq driver to use the new set_rate API
>>>
>>>This patch updates the cpufreq driver to use the device
>>>set rate API to scale the mpu frequency for OMAP3.
>>>
>>>Signed-off-by: Thara Gopinath <thara@ti.com>
>>>---
>>> arch/arm/plat-omap/cpu-omap.c |    5 +++--
>>> 1 files changed, 3 insertions(+), 2 deletions(-)
>>>
>>>diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
>>>index 9467827..cde02b5 100644
>>>--- a/arch/arm/plat-omap/cpu-omap.c
>>>+++ b/arch/arm/plat-omap/cpu-omap.c
>>>@@ -29,6 +29,7 @@
>>> #include <mach/hardware.h>
>>> #include <plat/clock.h>
>>> #include <asm/system.h>
>>>+#include <plat/omap_device.h>
>>>
>>> #if defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
>>> #include <plat/omap-pm.h>
>>>@@ -84,7 +85,7 @@ static int omap_target(struct cpufreq_policy *policy,
>>> 		       unsigned int target_freq,
>>> 		       unsigned int relation)
>>> {
>>>-#ifdef CONFIG_ARCH_OMAP1
>>>+#ifdef CONFIG_ARiCH_OMAP1
>>                ^^^^^^
>>		Typo I guess. Needs correction.

Yep.. Thanks..

Regards
Thara
>>
>>
>>> 	struct cpufreq_freqs freqs;
>>> #endif
>>> #if defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
>>>@@ -117,7 +118,7 @@ static int omap_target(struct cpufreq_policy *policy,
>>> #elif defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)
>>> 	freq = target_freq * 1000;
>>> 	if (opp_find_freq_ceil(mpu_dev, &freq))
>>>-		omap_pm_cpu_set_freq(freq);
>>>+		omap_device_set_rate(mpu_dev, freq);
>>> #endif
>>> 	return ret;
>>> }
>>>--
>>>1.7.0.rc1.33.g07cf0f
>>>
>>>--
>>>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>>the body of a message to majordomo@vger.kernel.org
>>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
