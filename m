From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: USB gadgets with configfs hang reboot
Date: Fri, 15 Jan 2016 14:48:39 -0800
Message-ID: <20160115224839.GA19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Pietrasiewicz <andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi all,

Looks like there's some issue with the USB gadgets and configfs.

I'm seeing rmmod of the UDC driver cause a warning and then reboot
hangs the system. This happens at least with v4.4, and I've reproduced
it with dwc3 and musb so it seems to be generic.

I think Felipe is offline for next few days, but anyways here are
the error messages and a shells script to reproduce the issue.

Cheers,

Tony

Warning on rmmod $udc_module after gadgets are configured:

kobject: 'udc' (c202f700): kobject_release, parent c20ab818 (delayed 400)
kobject: '4a030000.dwc3' (c21b7c10): kobject_release, parent   (null) (delayed 200)
kobject: 'gadget' (c21911c0): kobject_release, parent   (null) (delayed 200)
------------[ cut here ]------------
WARNING: CPU: 1 PID: 1609 at lib/debugobjects.c:263 debug_print_object+0x8c/0xb8()
ODEBUG: free active (active state 0) object type: timer_list hint: delayed_work_timer_fn+0x0/0x10
Modules linked in: bluetooth cpufreq_dt leds_gpio led_class omap4_keypad matrix_keymap omap_wdt evdev ti_soc_thermal thermal_sys hwmon snd_soc_omap_mcbsp wlcore_sdio wl18xx wl12xx wlcore mac80211 cfg80211 omapfb connector_hdmi encoder_tpds
CPU: 1 PID: 1609 Comm: rmmod Not tainted 4.4.0-00009-g37797bf #228
Hardware name: Generic OMAP5 (Flattened Device Tree)
[<c0017c08>] (unwind_backtrace) from [<c0013f60>] (show_stack+0x10/0x14)
[<c0013f60>] (show_stack) from [<c034f180>] (dump_stack+0x84/0x9c)
[<c034f180>] (dump_stack) from [<c003cb64>] (warn_slowpath_common+0x78/0xb4)
[<c003cb64>] (warn_slowpath_common) from [<c003cbd0>] (warn_slowpath_fmt+0x30/0x40)
[<c003cbd0>] (warn_slowpath_fmt) from [<c0368e6c>] (debug_print_object+0x8c/0xb8)
[<c0368e6c>] (debug_print_object) from [<c036960c>] (__debug_check_no_obj_freed+0x1a0/0x228)
[<c036960c>] (__debug_check_no_obj_freed) from [<c0166080>] (kfree+0x80/0x1bc)
[<c0166080>] (kfree) from [<c03ed13c>] (release_nodes+0x164/0x1c8)
[<c03ed13c>] (release_nodes) from [<c03e9dc0>] (__device_release_driver+0x90/0x114)
[<c03e9dc0>] (__device_release_driver) from [<c03e9e64>] (device_release_driver+0x20/0x2c)
[<c03e9e64>] (device_release_driver) from [<c03e96b0>] (bus_remove_device+0xd8/0x108)
[<c03e96b0>] (bus_remove_device) from [<c03e69b0>] (device_del+0x10c/0x210)
[<c03e69b0>] (device_del) from [<c03eba8c>] (platform_device_del+0x18/0x88)
[<c03eba8c>] (platform_device_del) from [<c03ebb08>] (platform_device_unregister+0xc/0x20)
[<c03ebb08>] (platform_device_unregister) from [<c04e0e10>] (of_platform_device_destroy+0x8c/0x98)
[<c04e0e10>] (of_platform_device_destroy) from [<c03e6554>] (device_for_each_child+0x50/0x7c)
[<c03e6554>] (device_for_each_child) from [<c04e0d6c>] (of_platform_depopulate+0x2c/0x44)
[<c04e0d6c>] (of_platform_depopulate) from [<bf176208>] (dwc3_omap_remove+0x3c/0x5c [dwc3_omap])
[<bf176208>] (dwc3_omap_remove [dwc3_omap]) from [<c03ebbb4>] (platform_drv_remove+0x24/0x3c)
[<c03ebbb4>] (platform_drv_remove) from [<c03e9db8>] (__device_release_driver+0x88/0x114)
[<c03e9db8>] (__device_release_driver) from [<c03ea5d4>] (driver_detach+0xb4/0xb8)
[<c03ea5d4>] (driver_detach) from [<c03e9940>] (bus_remove_driver+0x4c/0xa0)
[<c03e9940>] (bus_remove_driver) from [<c00cb574>] (SyS_delete_module+0x11c/0x1e4)
[<c00cb574>] (SyS_delete_module) from [<c000f740>] (ret_fast_syscall+0x0/0x1c)
---[ end trace 3d4a0455591ff9ed ]---

Error on reboot after rmmod $udc_module:

Alignment trap: not handling instruction e1932f9f at [<c009168c>]
Unhandled fault: alignment exception (0x001) at 0x6b6b6c6f
pgd = c27b0000
[6b6b6c6f] *pgd=00000000
Internal error: : 1 [#1] SMP ARM
Modules linked in: usb_f_rndis usb_f_ecm bluetooth leds_gpio led_class cpufreq_dt omap4_keypad omap_wdt matrix_keymap ti_soc_thermal evdev thermal_sys hwmon snd_soc_omap_mcbsp wlcore_sdio wl18xx wl12xx wlcore mac80211 cfg80211 omapfb conn]
CPU: 1 PID: 1935 Comm: reboot Not tainted 4.4.0-00009-g37797bf #228
Hardware name: Generic OMAP5 (Flattened Device Tree)
task: c27a6340 ti: c2502000 task.ti: c2502000
PC is at __lock_acquire+0x25c/0x148c
LR is at 0x1
pc : [<c0091690>]    lr : [<00000001>]    psr: 20080093
sp : c2503d88  ip : c2502000  fp : c096db04
r10: c11ac224  r9 : c27a6340  r8 : c09a54e0
r7 : 00000000  r6 : 00000000  r5 : 00000000  r4 : 6b6b6b6b
r3 : 6b6b6c6f  r2 : 6b6b6b6b  r1 : 00000001  r0 : ee4e828c
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 827b006a  DAC: 00000051
Process reboot (pid: 1935, stack limit = 0xc2502218)
Stack: (0xc2503d88 to 0xc2504000)
3d80:                   ee4e828c c27a6898 c27a6898 00000000 c27a6340 c0b504e8
3da0: 00000000 c27a6898 c27a6898 00000000 ee4e81b8 ee4e828c 00000000 00000000
3dc0: 00000000 c09e5294 60080013 c0093140 00000001 00000000 00000000 c03e826c
3de0: 00000000 00000000 01234567 ee08bdd8 00000000 ee4e8258 ee4e81b8 c23f6330
3e00: c127002c c11ac224 c27a6340 00000000 00000001 c0653250 00000001 00000000
3e20: c03e826c c27a6870 c27a6340 60080013 00000001 c27a6870 c127002c ee08bdc8
3e40: ee4e81b8 c23f633c ee4e81b8 c23f6330 c127002c cc5b4b00 c09ea020 00000000
3e60: 00000001 c03e826c 00000000 01234567 c096b1b4 fee1dead cc5b4b00 c2502000
3e80: 00000000 c005fc54 00000000 c005ff1c c22c4ec0 c22c4ed0 00000000 00000000
3ea0: 00000000 c09e5294 0000005c 00000002 c27a6878 00000000 c09a54e0 c27a6340
3ec0: c11ac224 c00918a8 0000005c 00000000 c27a6878 c27a6870 00000001 c27a6870
3ee0: c09e497a c22c4ec0 c22c4ec0 00000000 c005bb4c c096e6e8 00000000 00000000
3f00: 00000002 c09e5294 600f0013 c0093140 00000000 00000000 00000000 c0199274
3f20: 00000000 00000000 c018f378 ede1e4a0 ed137018 ee11a900 c005bb4c 00000000
3f40: c27a6340 00000000 c27a6340 600f0013 00000000 c27a6870 00000000 c27a67c4
3f60: c09ebd48 00000000 c27a6340 00000000 c2502000 00000000 00000001 c005bb50
3f80: 00000000 c2502000 00000001 00000004 00000001 00000004 00000000 00000058
3fa0: c000f8e4 c000f740 00000001 00000004 fee1dead 28121969 01234567 cc5b4b00
3fc0: 00000001 00000004 00000000 00000058 00000000 00000000 00000000 00000001
3fe0: 00000058 bebfcc84 b6ed9ec5 b6e61966 80080030 fee1dead afffd861 afffdc61
[<c0091690>] (__lock_acquire) from [<c0093140>] (lock_acquire+0xac/0x12c)
[<c0093140>] (lock_acquire) from [<c0653250>] (mutex_lock_nested+0x38/0x3c8)
[<c0653250>] (mutex_lock_nested) from [<c03e826c>] (device_shutdown+0xcc/0x1bc)
[<c03e826c>] (device_shutdown) from [<c005fc54>] (kernel_restart+0xc/0x50)
[<c005fc54>] (kernel_restart) from [<c005ff1c>] (SyS_reboot+0x138/0x1f4)
[<c005ff1c>] (SyS_reboot) from [<c000f740>] (ret_fast_syscall+0x0/0x1c)
Code: 0affff87 e2843f41 f5d3f000 e1932f9f (e2822001)
---[ end trace f16e89fb774cf929 ]---

Test script to reproduce the problem, need to uncomment the reboot part:

8< --------------------
#!/bin/bash

# Change for your UDC controller
udc_module=dwc3-omap
udc_name=4a030000.dwc3

#
# Calling this and then doing rmmod $udc_module
# followed by reboot seems to produce the follow:
# WARNING: CPU: 1 PID: 1617 at lib/debugobjects.c:263
#
start_usb_gadgets() {
	vendor=0x1d6b
	product=0x0106
	file=$1

	mount -t configfs none /sys/kernel/config
	mkdir /sys/kernel/config/usb_gadget/g1
	old_pwd=$(pwd)
	cd /sys/kernel/config/usb_gadget/g1

	echo $product > idProduct
	echo $vendor > idVendor
	mkdir strings/0x409
	echo 123456789 > strings/0x409/serialnumber
	echo foo > strings/0x409/manufacturer
	echo "Multi Gadget" > strings/0x409/product

	mkdir configs/c.1
	echo 120 > configs/c.1/MaxPower
	mkdir configs/c.1/strings/0x409
	echo "Conf 1" > configs/c.1/strings/0x409/configuration

	mkdir configs/c.2
	echo 500 > configs/c.2/MaxPower
	mkdir configs/c.2/strings/0x409
	echo "Conf 2" > configs/c.2/strings/0x409/configuration

	mkdir functions/mass_storage.0
	echo $file > functions/mass_storage.0/lun.0/file
	ln -s functions/mass_storage.0 configs/c.1
	ln -s functions/mass_storage.0 configs/c.2

	# Not configuring further here just produces
	# WARNING: CPU: 1 PID: 1609 at lib/debugobjects.c:263

	mkdir functions/acm.0
	ln -s functions/acm.0 configs/c.1
	ln -s functions/acm.0 configs/c.2

	mkdir functions/ecm.0
	ln -s functions/acm.0 configs/c.1
	ln -s functions/acm.0 configs/c.2

	# Adding rndis seems to cause alignment trap or some
	# random oops on reboot after rmmod $udc_module
	mkdir functions/rndis.0
	ln -s functions/rndis.0 configs/c.1
	ln -s functions/rndis.0 configs/c.2

	echo $udc_name > /sys/kernel/config/usb_gadget/g1/UDC
	cd $old_pwd
}

function rmmod_and_shutdown() {
	rmmod $udc_module
	reboot
}

modprobe $udc_module

start_usb_gadgets ""

# uncomment this to reproduce bug
# rmmod_and_shutdown
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
