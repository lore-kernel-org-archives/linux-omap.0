From: Felipe Balbi <balbi@ti.com>
Subject: Re: Nokia CBUS code
Date: Tue, 22 Feb 2011 13:05:12 +0200
Message-ID: <20110222110512.GM2979@legolas.emea.dhcp.ti.com>
References: <1298371692.6998.19.camel@maggie>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:47974 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753551Ab1BVLFQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Feb 2011 06:05:16 -0500
Received: by mail-bw0-f45.google.com with SMTP id 16so2505795bwz.32
        for <linux-omap@vger.kernel.org>; Tue, 22 Feb 2011 03:05:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1298371692.6998.19.camel@maggie>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael =?iso-8859-1?Q?B=FCsch?= <mb@bu3sch.de>
Cc: linux-omap <linux-omap@vger.kernel.org>

Hi,

On Tue, Feb 22, 2011 at 11:48:12AM +0100, Michael B=FCsch wrote:
> I was wondering if somebody was working on mainline integration of th=
e
> cbus code.

just look at the cbus from on linux-omap tree:

Alexander Shishkin (1):
      cbus: fix comilation breakage

=46elipe Balbi (85):
      cbus: tahvo-usb: make it build again
      cbus: switch to kzalloc
      cbus: move EXPORT_SYMBOL close to its exported symbols
      cbus: separate into several MODULE_AUTHOR entries
      cbus: move to platform_driver
      cbus: add platform_data to pass gpios
      cbus: convert u32 base to void __iomem *base
      cbus: NULL global variable on exit
      cbus: checkpatch.pl fix on cbus.c
      cbus: don't export the global cbus_host variable
      cbus: rely on gpiolib
      cbus: no ternary on return
      cbus: add read/write flag to cbus_transfer
      cbus: don't type case when issuing read/write
      cbus: fix a resource leakage
      cbus: move cbus_host definition to C source
      cbus: handle possible errors on cbus_send/receive_bit
      cbus: introduce cbus_send/receive_data wrappers
      cbus: add kerneldoc
      cbus: retu-wdt: fix compile breakage
      cbus: retu: fix compile breakage on retu-headset
      cbus: retu: split one MODULE_AUTHOR into several
      cbus: retu: don't assing ret inside the if ()
      cbus: retu: convert printk to dev_*
      cbus: retu: convert to a platform_driver
      cbus: tahvo: split MODULE_AUTHOR into several entries
      cbus: tahvo: move EXPORT_SYMBOL macros closer to functions
      cbus: tahvo: don't assign ret inside if ()
      cbus: tahvo: convert printk into dev_*
      cbus: tahvo: convert to platform_driver
      cbus: retu: allocate platform_device for Retu's children
      cbus: retu-pwrbutton: convert to platform_driver
      cbus: retu-headset: simplify module_init
      cbus: retu-rtc: remove platform_device code
      cbus: retu-rtc: convert to platform_driver
      cbus: retu-rtc: split MODULE_AUTHOR into several entries
      cbus: retu-rtc: get rid of globals
      cbus: retu-rtc: move retu_rtc_barrier up on source code
      cbus: retu-rtc: make checkpatch.pl happy
      cbus: retu-rtc: switch to rtc class device
      cbus: retu-wdt: remove the platform_device
      cbus: retu-wtd: convert to platform_driver
      cbus: retu-wdt: misc cleanup on retu-wdt driver
      cbus: fix compilation with current mainline
      cbus: switch kmalloc() + memset() to kzalloc()
      cbus: remove device_release completion
      cbus: retu: pass irq number via struct resource
      cbus: retu: avoid section mismatch
      cbus: tahvo: usb: convert to platform_driver
      cbus: tahvo: remove device_release
      cbus: tahvo: pass irq via struct resource
      cbus: tahvo: avoid section mismatch
      cbus: remove unneded includes
      cbus: retu: move platform_device to board file
      cbus: tahvo: move platform_device to board file
      cbus: tahvo-usb: move platform_device to board file
      cbus: retu: get rid of retu-user.c
      cbus: retu: give it a context structure
      cbus: retu: move module_* close to the matching symbol
      cbus: retu: cleanup error path
      cbus: retu: move to threaded IRQ and GENIRQ
      cbus: retu: headset: convert to threaded_irq
      cbus: retu-pwrbutton: convert to threaded irq
      cbus: retu-rtc: move to threaded irq
      cbus: retu-rtc: drop the reset_occurred flag
      cbus: Makefile: re-enable retu-wdt
      cbus: tahvo: drop tahvo-user
      cbus: retu: pass IRQ via struct resource
      cbus: retu: headset: grab IRQ via struct resource
      cbus: retu: pwrbutton: grab IRQ via struct resource
      cbus: retu: rtc: grab IRQ via struct resource
      cbus: retu: drop retu_get_status
      cbus: retu: replace BUG_ON with WARN
      cbus: retu: drop the unnecessary spinlock_t
      cbus: retu: drop unused PFX macro
      cbus: retu: use the devid from platform_data
      cbus: retu: introduce internal read/write functions
      cbus: retu: search and replace
      cbus: retu: pwrbutton: save device pointer on our structure
      cbus: retu: wdt: save dev in retu_wdt_dev
      cbus: retu: pass the child device pointer to all retu functions
      cbus: retu: headset: don't save pdev pointer
      cbus: retu: replace EXPORT_SYMBOL with EXPORT_SYMBOL_GPL
      cbus: retu: tabify retu initialization
      cbus: retu: set pm_power_off to NULL when removing retu

=46rancisco Alecrim (1):
      fix compile for tahvo-usb.c

Jarkko Nikula (1):
      cbus: Fix compile by converting ioctl calls to unlocked_ioctlcall=
s

Juha Yrjola (1):
      omap: Add drivers/cbus support

Tony Lindgren (11):
      omap: Search and replace headers to use plat
      cbus: Fix compile and don't try to use tag
      cbus: Make retu watchdog behave like a standard Linux watchdog
      cbus: Fix init on boards with no cbus
      cbus: Fix tahvo init without cbus
      cbus: Fix compile for 770
      cbus: Fix retu init order
      cbus: Disable retu_rtc_do_reset for now
      Revert "cbus: Disable retu_rtc_do_reset for now"
      cbus: Fix retu_rtc_do_reset
      cbus: Fix nested interrupts for retu


> That probably is a major effort, as it needs a rewrite in some parts,
> but I'm certainly interested in getting it mainlined, because I'm
> currently developing a driver on top of it.

We're almost there actually. Retu is in great shape and tahvo is a lot
simpler, but it still needs help. Probably porting the changes I made o=
n
retu would be the way to go.

A small TODO would be to use dev_pm_ops on all driver's suspend/resume
functions, then move retu-headset.c to Jack framework and port all
changes to tahvo as well.

> It's a battery management driver. If somebody is interested, it can
> be found here:
> https://dev.openwrt.org/browser/trunk/target/linux/omap24xx/patches-2=
=2E6.37/900-n810-battery-management.patch

cool.

> It currently doesn't support charging, however, almost all informatio=
n
> for the charging hardware is available. Registers and bits are known.
> The only thing that's missing is the interpreter of the
> calibration data. That's going to be some major effort, though,
> because bme uses software floating point for that. That's currently
> screwing my brains, but it should be doable.

heh, good luck and thanks for the initiative :-)

--=20
balbi
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
