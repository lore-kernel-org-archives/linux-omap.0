From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 2/2] OMAP: omap_device: make all devices a child of a new omap_bus device
Date: Wed, 01 Sep 2010 08:16:12 -0700
Message-ID: <87occhmr43.fsf@deeprootsystems.com>
References: <1283299395-24193-1-git-send-email-khilman@deeprootsystems.com>
	<1283299395-24193-2-git-send-email-khilman@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0328C1D64F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50846 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755215Ab0IAPQQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Sep 2010 11:16:16 -0400
Received: by pwi3 with SMTP id 3so802054pwi.19
        for <linux-omap@vger.kernel.org>; Wed, 01 Sep 2010 08:16:15 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0328C1D64F@dbde02.ent.ti.com>
	(Thara Gopinath's message of "Wed, 1 Sep 2010 10:12:46 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>

"Gopinath, Thara" <thara@ti.com> writes:

>>>-----Original Message-----
>>>From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin
>>>Hilman
>>>Sent: Wednesday, September 01, 2010 5:33 AM
>>>To: linux-omap@vger.kernel.org
>>>Cc: paul@pwsan.com
>>>Subject: [PATCH 2/2] OMAP: omap_device: make all devices a child of a new omap_bus device
>>>
>>>From: Kevin Hilman <khilman@ti.com>
>>>
>>>In order to help differentiate omap_devices from normal
>>>platform_devices, make them all a parent of a new omap_bus device.
>>>
>>>Then, in order to determine if a platform_device is also an
>>>omap_device, checking the parent is all that is needed.
>>>
>>>Users of this feature are the runtime PM core for OMAP, where we need
>>>to know if a device being passed in is an omap_device or not in order
>>>to know whether to call the omap_device API with it.
>>>
>>>In addition, all omap_devices will now show up under /sys/devices/omap
>>>instead of /sys/devices/platform
>
> Hello Kevin,
>
> Couple of minor queries/comments below.

Hi Thara, 

Thanks for the review.

>>>
>>>Signed-off-by: Kevin Hilman <khilman@ti.com>
>>>---
>>> arch/arm/plat-omap/include/plat/omap_device.h |    2 ++
>>> arch/arm/plat-omap/omap_device.c              |   18 ++++++++++++++++++
>>> 2 files changed, 20 insertions(+), 0 deletions(-)
>>>
>>>diff --git a/arch/arm/plat-omap/include/plat/omap_device.h b/arch/arm/plat-
>>>omap/include/plat/omap_device.h
>>>index bad4c3d..26d0c10 100644
>>>--- a/arch/arm/plat-omap/include/plat/omap_device.h
>>>+++ b/arch/arm/plat-omap/include/plat/omap_device.h
>>>@@ -36,6 +36,8 @@
>>>
>>> #include <plat/omap_hwmod.h>
>>>
>>>+extern struct device omap_bus;
>>>+
>
> Why is this extern declaration needed? Is it later on
> to check in runtime pm code pdev->dev.parent == omap_bus??

Yes.

>>> /* omap_device._state values */
>>> #define OMAP_DEVICE_STATE_UNKNOWN	0
>>> #define OMAP_DEVICE_STATE_ENABLED	1
>>>diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
>>>index 7f05f49..3e215fa 100644
>>>--- a/arch/arm/plat-omap/omap_device.c
>>>+++ b/arch/arm/plat-omap/omap_device.c
>>>@@ -463,8 +463,11 @@ int omap_early_device_register(struct omap_device *od)
>>>  */
>>> int omap_device_register(struct omap_device *od)
>>> {
>>>+	struct platform_device *pdev = &od->pdev;
>>>+
>>> 	pr_debug("omap_device: %s: registering\n", od->pdev.name);
>>>
>>>+	pdev->dev.parent = &omap_bus;
>
> What if device_register(&omap_bus) has returned an
> error? Do we still go ahead with assigning omap_bus
> as parent?

Good point.  I followed the lead of the platform_bus here which does the
same thing, and bascially assumes that device_register() does not fail.

I'll take a look to see if this could be handled cleaner.  Thanks.

>>> 	return platform_device_register(&od->pdev);
>>> }
>>>
>>>@@ -737,3 +740,18 @@ int omap_device_enable_clocks(struct omap_device *od)
>>> 	/* XXX pass along return value here? */
>>> 	return 0;
>>> }
>>>+
>>>+struct device omap_bus = {
>>>+	.init_name	= "omap",
>>>+};
>>>+
>>>+static int __init omap_device_init(void)
>>>+{
>>>+	int error = 0;
>
> Is the initialization to 0 needed?

Nope

>>>+
>>>+	printk("%s:\n", __func__);
>
> Spurious printk???

Yup.

Oops, I cleaned those two up locally but sent the wrong version.

Thanks for catching,

Kevin
