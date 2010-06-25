From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH:v4 12/13] OMAP: GPIO: Implement GPIO as a platform device
Date: Fri, 25 Jun 2010 16:36:18 -0700
Message-ID: <87lja28z2l.fsf@deeprootsystems.com>
References: <1277218916-15213-1-git-send-email-charu@ti.com>
	<1277218916-15213-2-git-send-email-charu@ti.com>
	<1277218916-15213-3-git-send-email-charu@ti.com>
	<1277218916-15213-4-git-send-email-charu@ti.com>
	<1277218916-15213-5-git-send-email-charu@ti.com>
	<1277218916-15213-6-git-send-email-charu@ti.com>
	<1277218916-15213-7-git-send-email-charu@ti.com>
	<1277218916-15213-8-git-send-email-charu@ti.com>
	<1277218916-15213-9-git-send-email-charu@ti.com>
	<1277218916-15213-10-git-send-email-charu@ti.com>
	<1277218916-15213-11-git-send-email-charu@ti.com>
	<1277218916-15213-12-git-send-email-charu@ti.com>
	<1277218916-15213-13-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:50822 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245Ab0FYXgW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jun 2010 19:36:22 -0400
Received: by pvg2 with SMTP id 2so1080708pvg.19
        for <linux-omap@vger.kernel.org>; Fri, 25 Jun 2010 16:36:21 -0700 (PDT)
In-Reply-To: <1277218916-15213-13-git-send-email-charu@ti.com> (Charulatha
	V.'s message of "Tue, 22 Jun 2010 20:31:55 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, rnayak@ti.com, p-basak2@ti.com, b-cousson@ti.com

Charulatha V <charu@ti.com> writes:

> This patch implements GPIO as a platform device. Also it
> implements OMAP2PLUS specific GPIO as HWMOD FW adapted device.
> This patch makes GPIO to use runtime APIs.
>
> GPIO APIs are used in machine_init functions. Hence it is
> required to complete GPIO probe before machine_init. Therefore
> GPIO device register and driver register are implemented as
> postcore_initcalls.
>
> Inorder to convert GPIO as platform device, modifications are
> required in clockxxxx_data.c file for OMAP1 so that device names
> can be used to obtain clock instead of getting clocks by
> name/NULL ptr.
>
> omap_gpio_init() does nothing now and this function would be
> removed in the next patch as it's usage is spread across most of
> the board files.
>
> TODO:
> 1. Cleanup the GPIO driver. Use function pointers and register
> offest pointers instead of using hardcoded values
> 2. Remove all cpu_is_ checks and OMAP specific macros
> 3. Remove usage of gpio_bank array so that only
> instance specific information is used in driver code
> 4. Modify save/restore context, gpio_prepare_for_idle,
> and gpio_resume_after_idle functions as instance
> specific function and not for all instances in a single call

init_gpio_info() too.

I think this item (TODO #4) needs to be done as part of this series, as
this new generic driver needs to be completely ignorant of how many
banks are on chip, or currently in use.  All operations should be on a
single device (in this case, a single GPIO bank.)

As each hwmod has its own device, it can have it's own independent
suspend/resume.  To do this, you should remove the sysdev_class and
sys_device just use the regular device.  Here's a little patch[1] on top
of your current series that shows how you would hook up the standard PM
methods.  Also, the prepare_for_idle, resume_from_idle should be handled
by the runtime PM callbacks.

With the save/restore context handled on demand (when mod_usage
transitions to/from zero), and the runtime PM calls handled from within
the driver, we could get rid of all the GPIO calls from
omap_sram_idle().  That would be a huge improvement.

Kevin

[1] compile-tested only

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 6dc5e4b..6a5a8f4 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -2091,10 +2091,44 @@ void omap_gpio_restore_context(void)
 }
 #endif
 
+static int gpio_bank_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int gpio_bank_resume(struct device *dev)
+{
+	return 0;
+}
+
+static int gpio_bank_runtime_idle(struct device *dev)
+{
+	return 0;
+}
+
+static int gpio_bank_runtime_suspend(struct device *dev)
+{
+	return 0;
+}
+
+static int gpio_bank_runtime_resume(struct device *dev)
+{
+	return 0;
+}
+
+static struct dev_pm_ops gpio_pm_ops = {
+	.suspend	 = gpio_bank_suspend,
+	.resume		 = gpio_bank_resume,
+	.runtime_idle	 = gpio_bank_runtime_idle,
+	.runtime_suspend = gpio_bank_runtime_suspend,
+	.runtime_resume	 = gpio_bank_runtime_resume,
+};
+
 static struct platform_driver omap_gpio_driver = {
 	.probe		= omap_gpio_probe,
 	.driver		= {
 		.name	= "omap-gpio",
+		.pm	= &gpio_pm_ops,
 	},
 };
 


