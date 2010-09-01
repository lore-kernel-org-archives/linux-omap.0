From: "Gopinath, Thara" <thara@ti.com>
Subject: RE: [PATCH 2/2] OMAP: omap_device: make all devices a child of a
 new omap_bus device
Date: Wed, 1 Sep 2010 10:12:46 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0328C1D64F@dbde02.ent.ti.com>
References: <1283299395-24193-1-git-send-email-khilman@deeprootsystems.com>
 <1283299395-24193-2-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38670 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779Ab0IAEmy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Sep 2010 00:42:54 -0400
In-Reply-To: <1283299395-24193-2-git-send-email-khilman@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "paul@pwsan.com" <paul@pwsan.com>



>>-----Original Message-----
>>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin
>>Hilman
>>Sent: Wednesday, September 01, 2010 5:33 AM
>>To: linux-omap@vger.kernel.org
>>Cc: paul@pwsan.com
>>Subject: [PATCH 2/2] OMAP: omap_device: make all devices a child of a new omap_bus device
>>
>>From: Kevin Hilman <khilman@ti.com>
>>
>>In order to help differentiate omap_devices from normal
>>platform_devices, make them all a parent of a new omap_bus device.
>>
>>Then, in order to determine if a platform_device is also an
>>omap_device, checking the parent is all that is needed.
>>
>>Users of this feature are the runtime PM core for OMAP, where we need
>>to know if a device being passed in is an omap_device or not in order
>>to know whether to call the omap_device API with it.
>>
>>In addition, all omap_devices will now show up under /sys/devices/omap
>>instead of /sys/devices/platform

Hello Kevin,

Couple of minor queries/comments below.

>>
>>Signed-off-by: Kevin Hilman <khilman@ti.com>
>>---
>> arch/arm/plat-omap/include/plat/omap_device.h |    2 ++
>> arch/arm/plat-omap/omap_device.c              |   18 ++++++++++++++++++
>> 2 files changed, 20 insertions(+), 0 deletions(-)
>>
>>diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-
>>omap/include/plat/omap_device.h
>>index bad4c3d..26d0c10 100644
>>--- a/arch/arm/plat-omap/include/plat/omap_device.h
>>+++ b/arch/arm/plat-omap/include/plat/omap_device.h
>>@@ -36,6 +36,8 @@
>>
>> #include <plat/omap_hwmod.h>
>>
>>+extern struct device omap_bus;
>>+

Why is this extern declaration needed? Is it later on
to check in runtime pm code pdev->dev.parent == omap_bus??

>> /* omap_device._state values */
>> #define OMAP_DEVICE_STATE_UNKNOWN	0
>> #define OMAP_DEVICE_STATE_ENABLED	1
>>diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
>>index 7f05f49..3e215fa 100644
>>--- a/arch/arm/plat-omap/omap_device.c
>>+++ b/arch/arm/plat-omap/omap_device.c
>>@@ -463,8 +463,11 @@ int omap_early_device_register(struct omap_device *od)
>>  */
>> int omap_device_register(struct omap_device *od)
>> {
>>+	struct platform_device *pdev = &od->pdev;
>>+
>> 	pr_debug("omap_device: %s: registering\n", od->pdev.name);
>>
>>+	pdev->dev.parent = &omap_bus;

What if device_register(&omap_bus) has returned an
error? Do we still go ahead with assigning omap_bus
as parent?

>> 	return platform_device_register(&od->pdev);
>> }
>>
>>@@ -737,3 +740,18 @@ int omap_device_enable_clocks(struct omap_device *od)
>> 	/* XXX pass along return value here? */
>> 	return 0;
>> }
>>+
>>+struct device omap_bus = {
>>+	.init_name	= "omap",
>>+};
>>+
>>+static int __init omap_device_init(void)
>>+{
>>+	int error = 0;

Is the initialization to 0 needed?

>>+
>>+	printk("%s:\n", __func__);

Spurious printk???

Regards
Thara

>>+	error = device_register(&omap_bus);
>>+
>>+	return error;
>>+}
>>+core_initcall(omap_device_init);
>>--
>>1.7.2.1
>>
>>--
>>To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
