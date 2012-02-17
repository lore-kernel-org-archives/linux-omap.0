From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 0/3] omap hsmmc init cleanup and section warning fixes
 for v3.4 merge window
Date: Fri, 17 Feb 2012 15:48:44 +0530
Message-ID: <4F3E2984.6000201@ti.com>
References: <20120215182355.18884.18682.stgit@kaulin.local> <CACYZBRE_Vf8qDQYPRgsL03T8oy2Kv4fYRfE8U7y79Xhb1nwC2A@mail.gmail.com> <20120216121234.GJ15338@n2100.arm.linux.org.uk> <4F3CF7D1.8050807@ti.com> <4F3D0186.2010500@ti.com> <20120216135151.GK15338@n2100.arm.linux.org.uk> <20120217091433.GL15338@n2100.arm.linux.org.uk> <4F3E1ED5.6090305@ti.com> <4F3E251B.6040404@ti.com> <20120217100632.GM15338@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:52961 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752203Ab2BQKTG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Feb 2012 05:19:06 -0500
Received: by pbcwz12 with SMTP id wz12so5853078pbc.1
        for <linux-omap@vger.kernel.org>; Fri, 17 Feb 2012 02:19:05 -0800 (PST)
In-Reply-To: <20120217100632.GM15338@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Friday 17 February 2012 03:36 PM, Russell King - ARM Linux wrote:
> On Fri, Feb 17, 2012 at 03:29:55PM +0530, Rajendra Nayak wrote:
>> hmm, rmmod does not even seem to trigger the drivers .remove if there
>> are outstanding requests on the module, so a pdata->teardown called
>> from within the .remove does not help to get the gpio_requests done
>> from the board file cleaned.
>
> If the module use count is non-zero, then it's only right that it won't
> let you remove the module.  So as far as that goes, that's fine.
>
> However, it's still possible to unbind the device:
>
> 	echo twl4030_gpio>  /sys/bus/platform/driver/twl4030_gpio/unbind
>
> and rebind it:
>
> 	echo twl4030_gpio>  /sys/bus/platform/driver/twl4030_gpio/bind
>
> assuming that the gpios device name is twl4030_gpio and not twl4030_gpio.0.
> This would be equivalent to my steps (4) and (5).
>
> As you point out, the there's no teardown function, which suggests that
> the gpios won't be able to be requested at step (5).  You'll probably

I now have a teardown for beagle which does free the gpios.

> also get a WARN_ON() dump too when the hsmmc device is registered for a
> second time, or maybe an oops (as it'll be a device which has already
> been registered being registered for a second time).

Yes, I did get a WARN saying the device is already registered. An 
unregister in my teardown should fix that too.

Thanks for recommending the tests.

# echo twl4030_gpio > unbind
# echo twl4030_gpio > bind
[ 1202.119354] twl4030_gpio twl4030_gpio: can't dispatch IRQs from modules
[ 1202.129913] gpiochip_add: registered GPIOs 192 to 211 on device: twl4030
[ 1202.137145] ------------[ cut here ]------------
[ 1202.142120] WARNING: at kernel/resource.c:597 
__insert_resource+0x168/0x17c()
[ 1202.149658] Modules linked in: gpio_twl4030
[ 1202.154113] [<c001bcd0>] (unwind_backtrace+0x0/0xf4) from 
[<c0042040>] (warn_slowpath_common+0x4c/0x64)
[ 1202.164062] [<c0042040>] (warn_slowpath_common+0x4c/0x64) from 
[<c0042074>] (warn_slowpath_null+0x1c/0x24)
[ 1202.174285] [<c0042074>] (warn_slowpath_null+0x1c/0x24) from 
[<c004a5c0>] (__insert_resource+0x168/0x17c)
[ 1202.184387] [<c004a5c0>] (__insert_resource+0x168/0x17c) from 
[<c004a75c>] (insert_resource_conflict+0x24/0x3c)
[ 1202.195037] [<c004a75c>] (insert_resource_conflict+0x24/0x3c) from 
[<c004a77c>] (insert_resource+0x8/0x14)
[ 1202.205261] [<c004a7ncsert_resource+0x8/0x14) from [<c02be0a4>] 
(platform_device_add+0x70/0x20c)
[ 1202.215118] [<c02be0a4>] (platform_device_add+0x70/0x20c) from 
[<c003628c>] (omap_hsmmc_late_init+0x30/0x5c)
[ 1202.225524] [<c003628c>] (omap_hsmmc_late_init+0x30/0x5c) from 
[<c0034828>] (beagle_twl_gpio_setup+0x20/0xf4)
[ 1202.235992] [<c0034828>] (beagle_twl_gpio_setup+0x20/0xf4) from 
[<bf0005e4>] (gpio_twl4030_probe+0x1ac/0x1ec [gpio_twl4030])
[ 1202.247924] [<bf0005e4>] (gpio_twl4030_probe+0x1ac/0x1ec 
[gpio_twl4030]) from [<c02bdb50>] (platform_drv_probe+0x18/0x1c)
[ 1202.259521] [<c02bdb50>] (platform_drv_probe+0x18/0x1c) from 
[<c02bc6b4>] (driver_probe_device+0x98/0x1a0)
[ 1202.269744] [<c02bc6b4>] (driver_probe_device+0x98/0x1a0) from 
[<c02bb73c>] (driver_bind+0xac/0xe0)
[ 1202.279296] [<c02bb73c>] (driver_bind+0xac/0xe0) from [<c02bad20>] 
(drv_attr_store+0x24/0x28)
[ 1202.288360] [<c02bad20>] (drv_attr_store+0x24/0x28) from [<c0166ca4>] 
(sysfs_write_file+0xfc/0x180)
[ 1202.297943] [<c0166ca4>] (sysfs_write_file+0xfc/0x180) from 
[<c0106d80>] (vfs_write+0xb0/0x134)
[ 1202.307128] [<c0106d80>] /v0x134) from [<c0106ed4>] (sys_write+0x40/0x70)
[ 1202.315612] [<c0106ed4>] (sys_write+0x40/0x70) from [<c0014160>] 
(ret_fast_syscall+0x0/0x3c)
[ 1202.324554] ---[ end trace b395a818cb06b1ff ]---
[ 1202.329467] omap_hsmmc.0: failed to claim resource 3
[ 1202.334747] Could not late init MMC (null)

