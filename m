From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH v2 10/13] OMAP: create omap_devices for MPU, DSP, L3
Date: Wed, 30 Jun 2010 09:48:27 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0323763838@dbde02.ent.ti.com>
References: <1277423084-25528-1-git-send-email-khilman@deeprootsystems.com>
	<1277423084-25528-11-git-send-email-khilman@deeprootsystems.com>
 <87y6dxrblk.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35153 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751293Ab0F3ESf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jun 2010 00:18:35 -0400
In-Reply-To: <87y6dxrblk.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "paul@pwsan.com" <paul@pwsan.com>



>>-----Original Message-----
>>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin
>>Hilman
>>Sent: Tuesday, June 29, 2010 11:00 PM
>>To: linux-omap@vger.kernel.org
>>Cc: paul@pwsan.com
>>Subject: Re: [PATCH v2 10/13] OMAP: create omap_devices for MPU, DSP, L3
>>
>>Kevin Hilman <khilman@deeprootsystems.com> writes:
>>
>>> Create simple omap_devices for the main processors and busses.
>>>
>>> This is required to support the forth-coming device-based OPP
>>> approach, where OPPs are managed and tracked at the device level.
>>>
>>> So that these primary devices are available for early PM initialization,
>>> they are created as early platform_devices.
>>
>>I've reworked this patch so that it is no longer using early devices,
>>updated version below.
>>
>>This requires delaying some other PM init as well (OMAP PM layer, OPP
>>layer etc.) so a common_pm_init() function was created and initialized
>>as a device_initcall().
>>
>>My pm-hwmods branch has been updated with this version, and the PM
>>branch now has corresponding changes to the SR/voltage layers to
>>initialize them as device_initcalls as well.
>>
>>Kevin
>>
>>From 5180e0c52509fcf30ad92503b817326856231efb Mon Sep 17 00:00:00 2001
>>From: Kevin Hilman <khilman@deeprootsystems.com>
>>Date: Mon, 21 Jun 2010 10:53:13 -0700
>>Subject: [PATCH] OMAP: create omap_devices for MPU, DSP, L3
>>
>>Create simple omap_devices for the main processors and busses.
>>
>>This is required to support the forth-coming device-based OPP
>>approach, where OPPs are managed and tracked at the device level.
>>
>>Also, move these common PM init functions into a common_pm_init call
>>that is called as a device_initcall().  The PM init is done at this level
>>to ensure that the driver core is initialized before initialized.
>>
>>Cc: Paul Walmsley <paul@pwsan.com>
>>Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
>>---
>> arch/arm/mach-omap2/devices.c            |    2 +
>> arch/arm/mach-omap2/io.c                 |   67 +++++++++++++++++++++++++++++-
>> arch/arm/plat-omap/include/plat/common.h |    4 ++
>> 3 files changed, 71 insertions(+), 2 deletions(-)
>>
>>diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
>>index 03e6c9e..62920ac 100644
>>--- a/arch/arm/mach-omap2/devices.c
>>+++ b/arch/arm/mach-omap2/devices.c
>>@@ -15,6 +15,7 @@
>> #include <linux/platform_device.h>
>> #include <linux/io.h>
>> #include <linux/clk.h>
>>+#include <linux/err.h>
>>
>> #include <mach/hardware.h>
>> #include <mach/irqs.h>
>>@@ -29,6 +30,7 @@
>> #include <mach/gpio.h>
>> #include <plat/mmc.h>
>> #include <plat/dma.h>
>>+#include <plat/omap_device.h>
>>
>> #include "mux.h"
>>
>>diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
>>index 3cfb425..f406fac 100644
>>--- a/arch/arm/mach-omap2/io.c
>>+++ b/arch/arm/mach-omap2/io.c
>>@@ -45,7 +45,7 @@
>>
>> #include <plat/clockdomain.h>
>> #include "clockdomains.h"
>>-#include <plat/omap_hwmod.h>
>>+#include <plat/omap_device.h>
>>
>> /*
>>  * The machine specific code may provide the extra mapping besides the
>>@@ -313,6 +313,70 @@ static int __init _omap2_init_reprogram_sdrc(void)
>> 	return v;
>> }
>>
>>+static struct omap_device_pm_latency *pm_lats;
>>+
>>+static struct device *mpu_dev;
>>+static struct device *dsp_dev;
>>+static struct device *l3_dev;
>>+
>>+struct device *omap_get_mpuss_device(void)
>>+{
>>+	WARN_ON_ONCE(!mpu_dev);
>>+	return mpu_dev;
>>+}
>>+
>>+struct device *omap_get_dsp_device(void)
>>+{
>>+	WARN_ON_ONCE(!dsp_dev);
>>+	return dsp_dev;
>>+}
>>+
>>+struct device *omap_get_l3_device(void)
>>+{
>>+	WARN_ON_ONCE(!l3_dev);
>>+	return l3_dev;
>>+}
>>+
>>+/* static int _init_omap_device(struct omap_hwmod *oh, void *user) */
>>+static int _init_omap_device(char *name, struct device **new_dev)
>>+{
>>+	struct omap_hwmod *oh;
>>+	struct omap_device *od;
>>+
>>+	oh = omap_hwmod_lookup(name);
>>+	if (WARN(!oh, "%s: could not find omap_hwmod for %s\n",
>>+		 __func__, name))
>>+		return -ENODEV;
>>+
>>+	od = omap_device_build(oh->name, 0, oh, NULL, 0, pm_lats, 0, false);
>>+	if (WARN(IS_ERR(od), "%s: could not build omap_device for %s\n",
>>+		 __func__, name))
>>+		return -ENODEV;
>>+
>>+	*new_dev = &od->pdev.dev;
>>+
>>+	return 0;
>>+}
>>+
>>+/*
>>+ * Build omap_devices for processors and bus.
>>+ */
>>+static void omap_init_processor_devices(void)
>>+{
>>+	_init_omap_device("mpu", &mpu_dev);
>>+	_init_omap_device("iva", &dsp_dev);
>>+	_init_omap_device("l3_main", &l3_dev);
>>+}
>>+
>>+static int __init omap_common_pm_init(void)
>>+{
>>+	omap_init_processor_devices();
>>+	omap_pm_if_init();
>>+
>>+	return 0;
>>+}
>>+device_initcall(omap_common_pm_init);
Kevin,

But I guess opp layer is still getting initialized before this. Esp if the board files are initializing the opp structures. Or do you have a patch to fix it in some other branch ?

Regards, 
Thara

>>+
>> void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
>> 				 struct omap_sdrc_params *sdrc_cs1)
>> {
>>@@ -342,7 +406,6 @@ void __init omap2_init_common_hw(struct omap_sdrc_params *sdrc_cs0,
>> 	omap_serial_early_init();
>> 	if (cpu_is_omap24xx() || cpu_is_omap34xx())   /* FIXME: OMAP4 */
>> 		omap_hwmod_late_init();
>>-	omap_pm_if_init();
>> 	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
>> 		omap2_sdrc_init(sdrc_cs0, sdrc_cs1);
>> 		_omap2_init_reprogram_sdrc();
>>diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
>>index d265018..9cdd9cd 100644
>>--- a/arch/arm/plat-omap/include/plat/common.h
>>+++ b/arch/arm/plat-omap/include/plat/common.h
>>@@ -87,4 +87,8 @@ void omap2_set_globals_uart(struct omap_globals *);
>> 	}							\
>> })
>>
>>+struct device *omap_get_mpuss_device(void);
>>+struct device *omap_get_dsp_device(void);
>>+struct device *omap_get_l3_device(void);
>>+
>> #endif /* __ARCH_ARM_MACH_OMAP_COMMON_H */
>>--
>>1.7.1
>>
>>--
>>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
