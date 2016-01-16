From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: USB gadgets with configfs hang reboot
Date: Fri, 15 Jan 2016 16:09:05 -0800
Message-ID: <20160116000905.GB19432@atomide.com>
References: <20160115224839.GA19432@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160115224839.GA19432-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Andrzej Pietrasiewicz <andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [160115 14:49]:
> 
> I'm seeing rmmod of the UDC driver cause a warning and then reboot
> hangs the system. This happens at least with v4.4, and I've reproduced
> it with dwc3 and musb so it seems to be generic.
> Error on reboot after rmmod $udc_module:

Here's what CONFIG_DEBUG_KOBJECT gives for the reboot hang. At address
ee79b1c0 we have 'gadget' and that's the null kobject at the WARNING.

Regards,

Tony

...
udc 4a030000.dwc3: releasing '4a030000.dwc3'
kobject: '4a030000.dwc3': free name
kobject: 'gadget' (ee79b1c0): kobject_uevent_env
kobject: 'gadget' (ee79b1c0): kobject_uevent_env: filter function caused the event to drop!
kobject: 'dwc3' (ee76e040): kobject_cleanup, parent ee0edb68
kobject: 'dwc3' (ee76e040): auto cleanup 'remove' event
...

Broadcast message from root@armhf (ttyO2) (Fri Jan 15 23:49:15 2016):

The system is going down for reboot NOW!
...
 restart.
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1949 at lib/kobject.c:597 kobject_get+0x70/0xb0()
kobject: '(null)' (ee79b1c0): is not initialized, yet kobject_get() is being called.
Modules linked in: usb_f_rndis usb_f_ecm bluetooth leds_gpio led_class cpufreq_dt ti_soc_thermal omap4_keypad thermal_sys omap_wdt matrix_keymap evdev hwmon snd_soc_omap_mcbsp wlcore_sdio wl18xx wl12xx wlcore mac80211 cfg80211 omapfb connector_hdmi encoder_tpd12s015 omapdss cfbimgblt cfbfillrect cfbcopyarea gpio_pca953x hid_generic usbhid smsc95xx smsc75xx usbnet usb_f_acm u_ether usb_f_mass_storage usb_f_serial u_serial xhci_plat_hcd xhci_hcd dwc3_omap ohci_omap3 ohci_hcd ehci_omap ehci_hcd phy_omap_usb2 libcomposite udc_core usbcore usb_common snd_soc_omap_abe_twl6040 snd_soc_omap_mcpdm snd_soc_twl6040 snd_soc_omap snd_soc_core snd_pcm_dmaengine snd_pcm snd_timer snd soundcore rtc_ds1307 rtc_palmas rtc_twl palmas_pwrbutton extcon_palmas extcon clk_palmas [last unloaded: dwc3]
CPU: 0 PID: 1949 Comm: reboot Not tainted 4.4.0-00009-g37797bf #231
Hardware name: Generic OMAP5 (Flattened Device Tree)
[<c0017c08>] (unwind_backtrace) from [<c0013f60>] (show_stack+0x10/0x14)
[<c0013f60>] (show_stack) from [<c034cbe0>] (dump_stack+0x84/0x9c)
[<c034cbe0>] (dump_stack) from [<c003cb64>] (warn_slowpath_common+0x78/0xb4)
[<c003cb64>] (warn_slowpath_common) from [<c003cbd0>] (warn_slowpath_fmt+0x30/0x40)
[<c003cbd0>] (warn_slowpath_fmt) from [<c034f1d0>] (kobject_get+0x70/0xb0)
[<c034f1d0>] (kobject_get) from [<c03e4b04>] (device_shutdown+0x84/0x1bc)
[<c03e4b04>] (device_shutdown) from [<c005f9a8>] (kernel_restart+0xc/0x50)
[<c005f9a8>] (kernel_restart) from [<c005fc70>] (SyS_reboot+0x138/0x1f4)
[<c005fc70>] (SyS_reboot) from [<c000f740>] (ret_fast_syscall+0x0/0x1c)
---[ end trace 3ccd9ca0c720ba01 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1949 at include/linux/kref.h:46 kobject_get+0x90/0xb0()
Modules linked in: usb_f_rndis usb_f_ecm bluetooth leds_gpio led_class cpufreq_dt ti_soc_thermal omap4_keypad thermal_sys omap_wdt matrix_keymap evdev hwmon snd_soc_omap_mcbsp wlcore_sdio wl18xx wl12xx wlcore mac80211 cfg80211 omapfb connector_hdmi encoder_tpd12s015 omapdss cfbimgblt cfbfillrect cfbcopyarea gpio_pca953x hid_generic usbhid smsc95xx smsc75xx usbnet usb_f_acm u_ether usb_f_mass_storage usb_f_serial u_serial xhci_plat_hcd xhci_hcd dwc3_omap ohci_omap3 ohci_hcd ehci_omap ehci_hcd phy_omap_usb2 libcomposite udc_core usbcore usb_common snd_soc_omap_abe_twl6040 snd_soc_omap_mcpdm snd_soc_twl6040 snd_soc_omap snd_soc_core snd_pcm_dmaengine snd_pcm snd_timer snd soundcore rtc_ds1307 rtc_palmas rtc_twl palmas_pwrbutton extcon_palmas extcon clk_palmas [last unloaded: dwc3]
CPU: 0 PID: 1949 Comm: reboot Tainted: G        W       4.4.0-00009-g37797bf #231
Hardware name: Generic OMAP5 (Flattened Device Tree)
[<c0017c08>] (unwind_backtrace) from [<c0013f60>] (show_stack+0x10/0x14)
[<c0013f60>] (show_stack) from [<c034cbe0>] (dump_stack+0x84/0x9c)
[<c034cbe0>] (dump_stack) from [<c003cb64>] (warn_slowpath_common+0x78/0xb4)
[<c003cb64>] (warn_slowpath_common) from [<c003cc3c>] (warn_slowpath_null+0x1c/0x24)
[<c003cc3c>] (warn_slowpath_null) from [<c034f1f0>] (kobject_get+0x90/0xb0)
[<c034f1f0>] (kobject_get) from [<c03e4b04>] (device_shutdown+0x84/0x1bc)
[<c03e4b04>] (device_shutdown) from [<c005f9a8>] (kernel_restart+0xc/0x50)
[<c005f9a8>] (kernel_restart) from [<c005fc70>] (SyS_reboot+0x138/0x1f4)
[<c005fc70>] (SyS_reboot) from [<c000f740>] (ret_fast_syscall+0x0/0x1c)
---[ end trace 3ccd9ca0c720ba02 ]---
INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 0 PID: 1949 Comm: reboot Tainted: G        W       4.4.0-00009-g37797bf #231
Hardware name: Generic OMAP5 (Flattened Device Tree)
[<c0017c08>] (unwind_backtrace) from [<c0013f60>] (show_stack+0x10/0x14)
[<c0013f60>] (show_stack) from [<c034cbe0>] (dump_stack+0x84/0x9c)
[<c034cbe0>] (dump_stack) from [<c0092524>] (__lock_acquire+0x13b0/0x148c)
[<c0092524>] (__lock_acquire) from [<c0092e80>] (lock_acquire+0xac/0x12c)
[<c0092e80>] (lock_acquire) from [<c064f680>] (mutex_lock_nested+0x38/0x3c8)
[<c064f680>] (mutex_lock_nested) from [<c03e4b4c>] (device_shutdown+0xcc/0x1bc)
[<c03e4b4c>] (device_shutdown) from [<c005f9a8>] (kernel_restart+0xc/0x50)
[<c005f9a8>] (kernel_restart) from [<c005fc70>] (SyS_reboot+0x138/0x1f4)
[<c005fc70>] (SyS_reboot) from [<c000f740>] (ret_fast_syscall+0x0/0x1c)
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
