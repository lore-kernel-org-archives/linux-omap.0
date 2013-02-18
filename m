From: Roger Quadros <rogerq@ti.com>
Subject: Re: OMAP EHCI having clock problems?
Date: Mon, 18 Feb 2013 11:49:57 +0200
Message-ID: <5121F945.1020907@ti.com>
References: <87halea4s3.fsf@linaro.org> <511DE9AB.5080403@ti.com> <87fw0x608o.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57724 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754445Ab3BRJuD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Feb 2013 04:50:03 -0500
In-Reply-To: <87fw0x608o.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Mike Turquette <mturquette@linaro.com>

On 02/15/2013 05:54 PM, Kevin Hilman wrote:
> Roger Quadros <rogerq@ti.com> writes:
> 
>> Hi Kevin,
>>
>> On 02/15/2013 12:50 AM, Kevin Hilman wrote:
>>> Felipe, Roger,
>>>
>>> Using Tony's current master branch, and enabling EHCI support, I see 
>>> the clock framework spitting loudly about the EHCI driver (full boot log
>>> below.)   The same thing happens on v3.8-rc7.
>>>
>>> Any idea what's going on?  Am I missing a set of fixes that's already
>>> been posted?
>>
>> Thanks for pointing out. This series should fix the issues
>> https://lkml.org/lkml/2013/1/23/155
>>
>> They should be on their way to linux-next.
> 
> Great.  But what about v3.8?  I see the same problems in v3.8-rc7.
> 

Kevin, the fix is below for older kernels.

>From 4762086167510619f2fb765871e7af144b86e937 Mon Sep 17 00:00:00 2001
From: Roger Quadros <rogerq@ti.com>
Date: Mon, 18 Feb 2013 11:44:59 +0200
Subject: [PATCH] mfd: omap-usb-host: Fix clk warnings at boot

utmi_p1_gfclk and utmi_p2_gfclk are just clock multiplexers and
don't have a gate. So don't call clk_enable/disable on them.

Gets rid of warnings like below

[    0.716613] ------------[ cut here ]------------
[    0.716644] WARNING: at drivers/clk/clk.c:522 __clk_enable+0x94/0xa4()
[    0.716674] Modules linked in:
[    0.716735] [<c001b210>] (unwind_backtrace+0x0/0xf0) from [<c0041730>] (warn_slowpath_common+0x4c/0x64)
[    0.716766] [<c0041730>] (warn_slowpath_common+0x4c/0x64) from [<c0041764>] (warn_slowpath_null+0x1c/0x24)
[    0.716766] [<c0041764>] (warn_slowpath_null+0x1c/0x24) from [<c0409908>] (__clk_enable+0x94/0xa4)
[    0.716796] [<c0409908>] (__clk_enable+0x94/0xa4) from [<c0409938>] (clk_enable+0x20/0x3c)
[    0.716857] [<c0409938>] (clk_enable+0x20/0x3c) from [<c032f420>] (usbhs_runtime_resume+0x1c/0x34)
[    0.716888] [<c032f420>] (usbhs_runtime_resume+0x1c/0x34) from [<c031a3b4>] (pm_generic_runtime_resume+0x2c/0x38)
[    0.716918] [<c031a3b4>] (pm_generic_runtime_resume+0x2c/0x38) from [<c031dec0>] (__rpm_callback+0x2c/0x60)
[    0.716949] [<c031dec0>] (__rpm_callback+0x2c/0x60) from [<c031edec>] (rpm_resume+0x39c/0x60c)
[    0.716979] [<c031edec>] (rpm_resume+0x39c/0x60c) from [<c031f2c4>] (__pm_runtime_resume+0x48/0x60)
[    0.717010] [<c031f2c4>] (__pm_runtime_resume+0x48/0x60) from [<c032f770>] (usbhs_omap_probe+0x1f8/0x85c)
[    0.717041] [<c032f770>] (usbhs_omap_probe+0x1f8/0x85c) from [<c0316e7c>] (platform_drv_probe+0x18/0x1c)
[    0.717041] [<c0316e7c>] (platform_drv_probe+0x18/0x1c) from [<c0315c00>] (driver_probe_device+0x74/0x218)
[    0.717071] [<c0315c00>] (driver_probe_device+0x74/0x218) from [<c0315e38>] (__driver_attach+0x94/0x98)
[    0.717132] [<c0315e38>] (__driver_attach+0x94/0x98) from [<c0314398>] (bus_for_each_dev+0x4c/0x80)
[    0.717132] [<c0314398>] (bus_for_each_dev+0x4c/0x80) from [<c0315430>] (bus_add_driver+0x174/0x240)
[    0.717163] [<c0315430>] (bus_add_driver+0x174/0x240) from [<c0316304>] (driver_register+0x78/0x14c)
[    0.717193] [<c0316304>] (driver_register+0x78/0x14c) from [<c0317068>] (platform_driver_probe+0x18/0x9c)
[    0.717224] [<c0317068>] (platform_driver_probe+0x18/0x9c) from [<c00087a4>] (do_one_initcall+0xfc/0x168)
[    0.717254] [<c00087a4>] (do_one_initcall+0xfc/0x168) from [<c06dc908>] (kernel_init_freeable+0xfc/0x1cc)
[    0.717285] [<c06dc908>] (kernel_init_freeable+0xfc/0x1cc) from [<c04ce3ec>] (kernel_init+0x8/0xe4)
[    0.717315] [<c04ce3ec>] (kernel_init+0x8/0xe4) from [<c00137f0>] (ret_from_fork+0x14/0x24)
[    0.717498] ---[ end trace 3ac11fdde949a96e ]---

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mfd/omap-usb-host.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 05164d7..f6f5b18 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -299,9 +299,6 @@ static int usbhs_runtime_resume(struct device *dev)
 	if (is_ehci_tll_mode(pdata->port_mode[1]))
 		clk_enable(omap->usbhost_p2_fck);
 
-	clk_enable(omap->utmi_p1_fck);
-	clk_enable(omap->utmi_p2_fck);
-
 	spin_unlock_irqrestore(&omap->lock, flags);
 
 	return 0;
@@ -327,9 +324,6 @@ static int usbhs_runtime_suspend(struct device *dev)
 	if (is_ehci_tll_mode(pdata->port_mode[1]))
 		clk_disable(omap->usbhost_p2_fck);
 
-	clk_disable(omap->utmi_p2_fck);
-	clk_disable(omap->utmi_p1_fck);
-
 	if (omap->ehci_logic_fck && !IS_ERR(omap->ehci_logic_fck))
 		clk_disable(omap->ehci_logic_fck);
 
-- 
1.7.4.1



