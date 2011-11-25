From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v8 00/24] gpio/omap: driver cleanup and fixes
Date: Fri, 25 Nov 2011 16:00:27 +0530
Message-ID: <CAC83Zv++T96AZRHbEiS_UaGp=Dmu+zQ8se97oaBLhg_+eW-smA@mail.gmail.com>
References: <1317803593-12259-1-git-send-email-tarun.kanti@ti.com>
	<87obwsg9ua.fsf@ti.com>
	<CAC83ZvKd3iBrQS5wESnAok8W_a4z-3jZYz17wy376sZJw6sCWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:36058 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752789Ab1KYKa3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Nov 2011 05:30:29 -0500
Received: by mail-qy0-f177.google.com with SMTP id 7so149944qyk.36
        for <linux-omap@vger.kernel.org>; Fri, 25 Nov 2011 02:30:28 -0800 (PST)
In-Reply-To: <CAC83ZvKd3iBrQS5wESnAok8W_a4z-3jZYz17wy376sZJw6sCWg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>

On Fri, Nov 4, 2011 at 2:57 PM, DebBarma, Tarun Kanti
<tarun.kanti@ti.com> wrote:
> On Fri, Nov 4, 2011 at 3:14 AM, Kevin Hilman <khilman@ti.com> wrote:
>> Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:
>>
>>> This series is continuation of cleanup of OMAP GPIO driver and fixe=
s.
>>
>> Using this series on 3630/Zoom3, UART wakeups no longer work from
>> suspend. =A0That suggests that GPIO wakeups from retention/off are n=
ot
>> working.
>>
>> Please test GPIO wakeups from retention/off. =A0One way is to use Zo=
om3
>> UART wakeup from suspend using by enabling UART wakeups and suspendi=
ng:
>>
>> =A0 # echo enabled > /sys/devices/platform/serial8250.0/tty/ttyS0/po=
wer/wakeup
>> =A0 # echo mem > /sys/power/state
> Ok, I will test and make necessary fix.
I have done retention test of the latest series on Zoom3. When I try
running off mode
test it says support is not present because of an errata. Here is the
overall log:

/ # mount -t debugfs debugfs /proc/sys/debug
/ # echo enabled > /sys/devices/platform/serial8250.0/tty/ttyS0/power/w=
akeup
/ # echo mem > /sys/power/state
[   18.359161] PM: Syncing filesystems ... done.
[   18.477172] PM: Preparing system for mem sleep
[   18.501037] Freezing user space processes ... (elapsed 0.02 seconds)=
 done.
[   18.528564] Freezing remaining freezable tasks ... (elapsed 0.02
seconds) done.
[   18.559020] PM: Entering mem sleep
[   18.594299] ------------[ cut here ]------------
[   18.599090] WARNING: at drivers/mmc/core/core.c:453
mmc_wait_for_cmd+0x74/0x80()
[   18.606536] Modules linked in:
[   18.609649] [<c001ba18>] (unwind_backtrace+0x0/0xf4) from
[<c0052d88>] (warn_slowpath_common+0x4c/0x64)
[   18.619110] [<c0052d88>] (warn_slowpath_common+0x4c/0x64) from
[<c0052dbc>] (warn_slowpath_null+0x1c/0x24)
[   18.628845] [<c0052dbc>] (warn_slowpath_null+0x1c/0x24) from
[<c0365f8c>] (mmc_wait_for_cmd+0x74/0x80)
[   18.638183] [<c0365f8c>] (mmc_wait_for_cmd+0x74/0x80) from
[<c0368e54>] (mmc_switch+0x84/0x140)
[   18.646942] [<c0368e54>] (mmc_switch+0x84/0x140) from [<c0364ab0>]
(mmc_power_off+0xd8/0x108)
[   18.655548] [<c0364ab0>] (mmc_power_off+0xd8/0x108) from
[<c036558c>] (mmc_suspend_host+0xf0/0x1d4)
[   18.664672] [<c036558c>] (mmc_suspend_host+0xf0/0x1d4) from
[<c0376be8>] (omap_hsmmc_suspend+0x6c/0x100)
[   18.674194] [<c0376be8>] (omap_hsmmc_suspend+0x6c/0x100) from
[<c02b1c50>] (platform_pm_suspend+0x2c/0x54)
[   18.683929] [<c02b1c50>] (platform_pm_suspend+0x2c/0x54) from
[<c02b58f0>] (pm_op+0x6c/0xc0)
[   18.692443] [<c02b58f0>] (pm_op+0x6c/0xc0) from [<c02b5dcc>]
(__device_suspend+0xc0/0x1e4)
[   18.701080] [<c02b5dcc>] (__device_suspend+0xc0/0x1e4) from
[<c02b5fd4>] (dpm_suspend+0x58/0x214)
[   18.710021] [<c02b5fd4>] (dpm_suspend+0x58/0x214) from [<c0099950>]
(suspend_devices_and_enter+0x78/0x2d8)
[   18.719757] [<c0099950>] (suspend_devices_and_enter+0x78/0x2d8)
from [<c0099cf0>] (enter_state+0x140/0x180)
[   18.729553] [<c0099cf0>] (enter_state+0x140/0x180) from
[<c0098adc>] (state_store+0xe4/0x170)
[   18.738159] [<c0098adc>] (state_store+0xe4/0x170) from [<c0246ae8>]
(kobj_attr_store+0x18/0x1c)
[   18.746917] [<c0246ae8>] (kobj_attr_store+0x18/0x1c) from
[<c0162e04>] (sysfs_write_file+0xfc/0x180)
[   18.756103] [<c0162e04>] (sysfs_write_file+0xfc/0x180) from
[<c0102940>] (vfs_write+0xb0/0x134)
[   18.764862] [<c0102940>] (vfs_write+0xb0/0x134) from [<c0102a94>]
(sys_write+0x40/0x70)
[   18.772949] [<c0102a94>] (sys_write+0x40/0x70) from [<c0014040>]
(ret_fast_syscall+0x0/0x3c)
[   18.781433] ---[ end trace 1b75b31a2719ed1e ]---
[   18.786102] ------------[ cut here ]------------
[   18.790771] WARNING: at drivers/mmc/core/core.c:210
__mmc_start_req+0xe4/0x10c()
[   18.798156] Modules linked in:
[   18.801300] [<c001ba18>] (unwind_backtrace+0x0/0xf4) from
[<c0052d88>] (warn_slowpath_common+0x4c/0x64)
[   18.810760] [<c0052d88>] (warn_slowpath_common+0x4c/0x64) from
[<c0052dbc>] (warn_slowpath_null+0x1c/0x24)
[   18.820465] [<c0052dbc>] (warn_slowpath_null+0x1c/0x24) from
[<c0365e6c>] (__mmc_start_req+0xe4/0x10c)
[   18.829833] [<c0365e6c>] (__mmc_start_req+0xe4/0x10c) from
[<c0365f08>] (mmc_wait_for_req+0x10/0x20)
[   18.839019] [<c0365f08>] (mmc_wait_for_req+0x10/0x20) from
[<c0365f74>] (mmc_wait_for_cmd+0x5c/0x80)
[   18.848205] [<c0365f74>] (mmc_wait_for_cmd+0x5c/0x80) from
[<c0368e54>] (mmc_switch+0x84/0x140)
[   18.856964] [<c0368e54>] (mmc_switch+0x84/0x140) from [<c0364ab0>]
(mmc_power_off+0xd8/0x108)
[   18.865570] [<c0364ab0>] (mmc_power_off+0xd8/0x108) from
[<c036558c>] (mmc_suspend_host+0xf0/0x1d4)
[   18.874664] [<c036558c>] (mmc_suspend_host+0xf0/0x1d4) from
[<c0376be8>] (omap_hsmmc_suspend+0x6c/0x100)
[   18.884216] [<c0376be8>] (omap_hsmmc_suspend+0x6c/0x100) from
[<c02b1c50>] (platform_pm_suspend+0x2c/0x54)
[   18.893920] [<c02b1c50>] (platform_pm_suspend+0x2c/0x54) from
[<c02b58f0>] (pm_op+0x6c/0xc0)
[   18.902435] [<c02b58f0>] (pm_op+0x6c/0xc0) from [<c02b5dcc>]
(__device_suspend+0xc0/0x1e4)
[   18.910736] [<c02b5dcc>] (__device_suspend+0xc0/0x1e4) from
[<c02b5fd4>] (dpm_suspend+0x58/0x214)
[   18.919677] [<c02b5fd4>] (dpm_suspend+0x58/0x214) from [<c0099950>]
(suspend_devices_and_enter+0x78/0x2d8)
[   18.929382] [<c0099950>] (suspend_devices_and_enter+0x78/0x2d8)
from [<c0099cf0>] (enter_state+0x140/0x180)
[   18.939178] [<c0099cf0>] (enter_state+0x140/0x180) from
[<c0098adc>] (state_store+0xe4/0x170)
[   18.947784] [<c0098adc>] (state_store+0xe4/0x170) from [<c0246ae8>]
(kobj_attr_store+0x18/0x1c)
[   18.956542] [<c0246ae8>] (kobj_attr_store+0x18/0x1c) from
[<c0162e04>] (sysfs_write_file+0xfc/0x180)
[   18.965728] [<c0162e04>] (sysfs_write_file+0xfc/0x180) from
[<c0102940>] (vfs_write+0xb0/0x134)
[   18.974487] [<c0102940>] (vfs_write+0xb0/0x134) from [<c0102a94>]
(sys_write+0x40/0x70)
[   18.982543] [<c0102a94>] (sys_write+0x40/0x70) from [<c0014040>]
(ret_fast_syscall+0x0/0x3c)
[   18.991027] ---[ end trace 1b75b31a2719ed1f ]---
[   18.996124] Device failed to respond within 0 poweroff time.
=46orcefully powering down the device
[   19.010314] PM: suspend of devices complete after 434.539 msecs
[   19.019683] PM: late suspend of devices complete after 3.417 msecs
[   19.026000] Disabling non-boot CPUs ...
[   28.653900] Powerdomain (core_pwrdm) didn't enter target state 1
[   28.659912] Could not enter target state in pm_suspend
[   28.667297] PM: early resume of devices complete after 2.044 msecs
[   28.904083] PM: resume of devices complete after 228.668 msecs
[   28.914062] PM: Finishing wakeup.
[   28.917388] Restarting tasks ... done.
/ #
/ # cat /proc/sys/debug/pm_debug/count | grep per_pwrdm
per_pwrdm (ON),OFF:0,RET:88,INA:0,ON:89,RET-LOGIC-OFF:0,RET-MEMBANK1-OF=
=46:0
per_clkdm->per_pwrdm (18)
/ # cat /proc/sys/debug/pm_debug/count | grep per_pwrdm
per_pwrdm (ON),OFF:0,RET:127,INA:0,ON:128,RET-LOGIC-OFF:0,RET-MEMBANK1-=
OFF:0
per_clkdm->per_pwrdm (18)
/ # cat /proc/sys/debug/pm_debug/count | grep per_pwrdm
per_pwrdm (ON),OFF:0,RET:155,INA:0,ON:156,RET-LOGIC-OFF:0,RET-MEMBANK1-=
OFF:0
per_clkdm->per_pwrdm (18)
/ # echo 1 > /proc/sys/debug/pm_debug/enable_off_mode
[  119.895996] omap3_pm_off_mode_enable: Core OFF disabled due to errat=
a i583

--
Tarun
[...]
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
