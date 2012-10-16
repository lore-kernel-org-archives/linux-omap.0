From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] i2c: omap: revert "i2c: omap: switch to threaded IRQ
 support"
Date: Tue, 16 Oct 2012 16:37:31 +0300
Message-ID: <20121016133731.GH21801@arwen.pp.htv.fi>
References: <alpine.DEB.2.00.1210150148080.16624@utopia.booyaka.com>
 <CAM=Q2csHTbR4rBe1HNr5-M3sG5wgdCv6dCnGLmNQEwo1gjCSGg@mail.gmail.com>
 <20121016133356.GG21801@arwen.pp.htv.fi>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/Gk0KcsbyUMelFU1"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53003 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753841Ab2JPNnd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Oct 2012 09:43:33 -0400
Content-Disposition: inline
In-Reply-To: <20121016133356.GG21801@arwen.pp.htv.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, Paul Walmsley <paul@pwsan.com>, linux-i2c@vger.kernel.org, Shubhrajyoti D <shubhrajyoti@ti.com>, Wolfram Sang <w.sang@pengutronix.de>, Ben Dooks <ben-linux@fluff.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>

--/Gk0KcsbyUMelFU1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi again,

On Tue, Oct 16, 2012 at 04:33:56PM +0300, Felipe Balbi wrote:
> Hi,
>=20
> + Thomas Gleixner
>=20
> On Tue, Oct 16, 2012 at 06:28:13PM +0530, Shubhrajyoti Datta wrote:
> > On Mon, Oct 15, 2012 at 7:21 AM, Paul Walmsley <paul@pwsan.com> wrote:
> > >
> > > Commit 3b2f8f82dad7d1f79cdc8fc05bd1c94baf109bde ("i2c: omap: switch to
> > > threaded IRQ support") causes communication with I2C devices to fail
> > > after system suspend/resume on all OMAP3 devices:
> > >
> > Could you tell me which  omap3 platform
> >=20
> > On Beagle Xm
> > after
> > mount /dev/mmcblk  /mmcfs
> >=20
> >=20
> > # mount /dev/mmcblk0p2 /mmcfs/
> > [  412.480041] kjournald starting.  Commit interval 5 seconds
> > [  412.490020] EXT3-fs (mmcblk0p2): using internal journal
> > [  412.495605] EXT3-fs (mmcblk0p2): mounted filesystem with ordered dat=
a mode
> > #
> >=20
> >=20
> > # cd /mmcfs/
> > #
> > #
> > # ls
> > bin                   omap3_usb_prcm.sh     usb_prcm.sh
> > dev                   omap3_usbhs_off.sh    usb_uhh_show.sh
> > etc                   omap3_usbhs_on.sh     usb_uhh_tll.sh
> > init                  proc                  usbhs_clk_disable.sh
> > lib                   readmem.dat           usbhs_clk_enable.sh
> > lost+found            root                  usbhs_set_sm.sh
> > mnt                   sbin                  usbhs_show.sh
> > modules               sys                   usr
> > msc                   tmp                   var
> > omap3_ehcidump.sh     usb_omap3.sh
> > #
> > #
> > # echo mem > /sys/power/state
> > [  464.785461] PM: Syncing filesystems ... done.
> > [  464.791442] PM: Preparing system for mem sleep
> > [  464.798034] Freezing user space processes ... (elapsed 0.02 seconds)=
 done.
> > [  464.827301] Freezing remaining freezable tasks ... (elapsed 0.02
> > seconds) done.
> > [  464.858703] PM: Entering mem sleep
> > [  464.862304] Suspending console(s) (use no_console_suspend to debug)
> > [  464.994415] PM: suspend of devices complete after 121.002 msecs
> > [  464.998107] PM: late suspend of devices complete after 3.662 msecs
> > [  465.003173] PM: noirq suspend of devices complete after 5.004 msecs
> > [  465.003173] Disabling non-boot CPUs ...
> > [  466.225585] Successfully put all powerdomains to target state
> > [  466.228942] PM: noirq resume of devices complete after 3.051 msecs
> > [  466.232421] PM: early resume of devices complete after 2.349 msecs
> > [  467.492645] PM: resume of devices complete after 1260.131 msecs
> > [  467.546936] PM: Finishing wakeup.
> > [  467.550415] Restarting tasks ... done.
> > #
> > #
> > # cat /debug/pm_debug/count | grep per_pwrdm
> > per_pwrdm (ON),OFF:7,RET:0,INA:0,ON:8,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> > per_clkdm->per_pwrdm (17)
> > # echo mem > /sys/power/state
> > [ 1492.225311] PM: Syncing filesystems ... done.
> > [ 1492.232177] PM: Preparing system for mem sleep
> > [ 1492.238830] Freezing user space processes ... (elapsed 0.02 seconds)=
 done.
> > [ 1492.268188] Freezing remaining freezable tasks ... (elapsed 0.02
> > seconds) done.
> > [ 1492.299804] PM: Entering mem sleep
> > [ 1492.303375] Suspending console(s) (use no_console_suspend to debug)
> > [ 1492.435333] PM: suspend of devices complete after 120.880 msecs
> > [ 1492.439025] PM: late suspend of devices complete after 3.692 msecs
> > [ 1492.444091] PM: noirq suspend of devices complete after 5.004 msecs
> > [ 1492.444091] Disabling non-boot CPUs ...
> > [ 1493.745544] Successfully put all powerdomains to target state
> > [ 1493.748901] PM: noirq resume of devices complete after 3.051 msecs
> > [ 1493.752319] PM: early resume of devices complete after 2.319 msecs
> > [ 1494.794067] PM: resume of devices complete after 1041.625 msecs
> > [ 1494.848388] PM: Finishing wakeup.
> > [ 1494.851867] Restarting tasks ... done.
> > #
> > #
> > # cat /debug/pm_debug/count | grep per_pwrdm
> > per_pwrdm (ON),OFF:8,RET:0,INA:0,ON:9,RET-LOGIC-OFF:0,RET-MEMBANK1-OFF:0
> > per_clkdm->per_pwrdm (17)
> > #
> >=20
> > Anyways will retry with fs on mmc.
>=20
> rootfs has to be on MMC to trigger this. The problem happens because
> omap_hsmmc calls enable_irq() on its resume method. That IRQ line is
> actually a GPIO from TWL4030, so
> twl4030-irq.c::twl4030_sih_bus_sync_unlock() will be called, which will
> trigger an I2C transfer.
>=20
> The problem I see is that even though we properly return IRQ_WAKE_THREAD
> and wake_up_process() manages to wakeup the IRQ thread (it returns 1),
> the thread is never scheduled. To make things even worse, ouw irq thread
> runs once, but doesn't run on a consecutive call. Here's some (rather

another detail here:

if I drop the disable_irq()/enable_irq() from omap_hsmmc driver,
everything ends up being fine, so I'm wondering if we have a race
between omap_hsmmc, twl4030 card detect GPIO and I2C, but I'm not sure
yet.

> nasty) debug prints showing the problem:
>=20
> > [   78.709381] omap_i2c omap_i2c.1: omap_i2c_isr_thread 913
> > [   78.715026] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1038
> > [   78.720733] omap_i2c omap_i2c.1: omap_i2c_xfer 655
> > [   78.725769] omap_i2c omap_i2c.1: omap_i2c_xfer 659
> > [   78.730804] omap_i2c omap_i2c.1: omap_i2c_xfer 663
> > [   78.735870] omap_i2c omap_i2c.1: omap_i2c_xfer 668
> > [   78.850708] PM: suspend of devices complete after 1287.841 msecs
> > [   78.860870] PM: late suspend of devices complete after 3.753 msecs
> > [   78.872283] try_to_wake_up 1411
> > [   78.875701] try_to_wake_up 1411
> > [   78.879028] try_to_wake_up 1411
> > [   78.882537] omap_i2c omap_i2c.1: omap_i2c_runtime_suspend 1359
> > [   78.888763] omap_i2c omap_i2c.1: omap_i2c_low_level_suspend 1261
> > [   78.895416] PM: noirq suspend of devices complete after 28.015 msecs
> > [   78.902160] Disabling non-boot CPUs ...
> > [   88.568664] Powerdomain (per_pwrdm) didn't enter target state 1
> > [   88.574859] Powerdomain (core_pwrdm) didn't enter target state 1
> > [   88.581115] Could not enter target state in pm_suspend
> > [   88.586975] omap_i2c omap_i2c.1: omap_i2c_runtime_resume 1373
> > [   88.592987] omap_i2c omap_i2c.1: omap_i2c_low_level_resume 1287
> > [   88.599243] try_to_wake_up 1411
> > [   88.602569] try_to_wake_up 1411
> > [   88.608459] PM: noirq resume of devices complete after 21.759 msecs
> > [   88.615814] try_to_wake_up 1411
> > [   88.622497] PM: early resume of devices complete after 2.380 msecs
> > [   88.632965] omap_i2c omap_i2c.1: omap_i2c_xfer 626
> > [   88.638092] omap_i2c omap_i2c.1: omap_i2c_xfer 632
> > [   88.643188] omap_i2c omap_i2c.1: omap_i2c_xfer 648
> > [   88.648193] omap_i2c omap_i2c.1: addr: 0x0049, len: 4, flags: 0x0, s=
top: 1
> > [   88.655456] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537
> > [   88.660858] omap_i2c omap_i2c.1: omap_i2c_isr 885
> > [   88.665802] omap_i2c omap_i2c.1: omap_i2c_isr 891: mask 601f stat 15=
10
> > [   88.672637] omap_i2c omap_i2c.1: omap_i2c_isr 894
> > [   88.677551] omap_i2c omap_i2c.1: omap_i2c_isr 899
> > [   88.682495] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1
> > [   88.688751] omap_i2c omap_i2c.1: omap_i2c_isr_thread 913
> > [   88.694335] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1038
> > [   88.700347] omap_i2c omap_i2c.1: omap_i2c_isr 885
> > [   88.705291] omap_i2c omap_i2c.1: omap_i2c_isr 891: mask 601f stat 01=
04
> > [   88.712097] omap_i2c omap_i2c.1: omap_i2c_isr 894
> > [   88.717010] omap_i2c omap_i2c.1: omap_i2c_isr 899
> > [   88.721923] try_to_wake_up 1411
> > [   88.725189] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 0
> > [   88.731292] [sched_delayed] sched: RT throttling activated
> > [   88.737091] omap_i2c omap_i2c.1: omap_i2c_isr_thread 913
> > [   88.742706] omap_i2c omap_i2c.1: omap_i2c_isr_thread 1038
>=20
> this is the last time our omap_i2c_isr_thread() runs. Note that the
> thread was already running when wake_up_process() was called.
>=20
> > [   88.749206] omap_i2c omap_i2c.1: omap_i2c_xfer 655
> > [   88.754302] omap_i2c omap_i2c.1: omap_i2c_xfer 659
> > [   88.759368] omap_i2c omap_i2c.1: omap_i2c_xfer 663
> > [   88.764373] omap_i2c omap_i2c.1: omap_i2c_xfer 668
> > [   88.769531] omap_i2c omap_i2c.1: omap_i2c_xfer 626
> > [   88.774597] omap_i2c omap_i2c.1: omap_i2c_xfer 632
> > [   88.779602] omap_i2c omap_i2c.1: omap_i2c_xfer 648
> > [   88.784667] omap_i2c omap_i2c.1: addr: 0x004b, len: 1, flags: 0x0, s=
top: 0
> > [   88.791900] omap_i2c omap_i2c.1: omap_i2c_xfer_msg 537
> > [   88.797271] omap_i2c omap_i2c.1: omap_i2c_isr 885
> > [   88.802185] omap_i2c omap_i2c.1: omap_i2c_isr 891: mask 601f stat 15=
10
> > [   88.809020] omap_i2c omap_i2c.1: omap_i2c_isr 894
> > [   88.813934] omap_i2c omap_i2c.1: omap_i2c_isr 899
> > [   88.818847] =3D=3D=3D> irq_wake_thread 139: IRQ 72 wake_up_process 1
>=20
> notice here that our omap_i2c_isr_thread() never runs. I'm still
> debugging, trying to pin point what the real issue is, but it's
> definitely not the fact that we have a threaded ISR, since it runs at
> least once.
>=20
> > [   90.610107] try_to_wake_up 1411
> > [   93.821044] try_to_wake_up 1411
> > [   93.824768] omap_i2c omap_i2c.1: controller timed out
> > [   93.830169] [<c001c118>] (unwind_backtrace+0x0/0xf0) from [<c040c738=
>] (omap_i2c_xfer_msg+0x314/0x360)
> > [   93.839935] [<c040c738>] (omap_i2c_xfer_msg+0x314/0x360) from [<c040=
d26c>] (omap_i2c_xfer+0xac/0x220)
> > [   93.849639] [<c040d26c>] (omap_i2c_xfer+0xac/0x220) from [<c040884c>=
] (__i2c_transfer+0x40/0x80)
> > [   93.858886] [<c040884c>] (__i2c_transfer+0x40/0x80) from [<c0409da8>=
] (i2c_transfer+0x1f8/0x26c)
> > [   93.868103] [<c0409da8>] (i2c_transfer+0x1f8/0x26c) from [<c035dab8>=
] (twl_i2c_read+0xc4/0x15c)
> > [   93.877288] [<c035dab8>] (twl_i2c_read+0xc4/0x15c) from [<c03189f4>]=
 (twl4030ldo_get_voltage+0x28/0x60)
> > [   93.887145] [<c03189f4>] (twl4030ldo_get_voltage+0x28/0x60) from [<c=
03120b0>] (_regulator_get_voltage+0x68/0x84)
> > [   93.897827] [<c03120b0>] (_regulator_get_voltage+0x68/0x84) from [<c=
03125a0>] (regulator_get_voltage+0x20/0x38)
> > [   93.908447] [<c03125a0>] (regulator_get_voltage+0x20/0x38) from [<c0=
411bcc>] (mmc_regulator_set_ocr+0x40/0x12c)
> > [   93.919036] [<c0411bcc>] (mmc_regulator_set_ocr+0x40/0x12c) from [<c=
0426418>] (omap_hsmmc_set_power+0xe4/0x11c)
> > [   93.929626] [<c0426418>] (omap_hsmmc_set_power+0xe4/0x11c) from [<c0=
42582c>] (omap_hsmmc_set_ios+0x140/0x150)
> > [   93.940032] [<c042582c>] (omap_hsmmc_set_ios+0x140/0x150) from [<c04=
135c4>] (mmc_power_up+0x80/0xc4)
> > [   93.949615] [<c04135c4>] (mmc_power_up+0x80/0xc4) from [<c04136d8>] =
(mmc_resume_host+0xd0/0x150)
> > [   93.958862] [<c04136d8>] (mmc_resume_host+0xd0/0x150) from [<c0426b5=
c>] (omap_hsmmc_resume+0x7c/0xc8)
> > [   93.968536] [<c0426b5c>] (omap_hsmmc_resume+0x7c/0xc8) from [<c0347a=
78>] (platform_pm_resume+0x2c/0x50)
> > [   93.978424] [<c0347a78>] (platform_pm_resume+0x2c/0x50) from [<c034b=
ca4>] (dpm_run_callback.isra.4+0x2c/0x64)
> > [   93.988830] [<c034bca4>] (dpm_run_callback.isra.4+0x2c/0x64) from [<=
c034ca48>] (device_resume+0xdc/0x18c)
> > [   93.998870] [<c034ca48>] (device_resume+0xdc/0x18c) from [<c034ce8c>=
] (dpm_resume+0xfc/0x21c)
> > [   94.007812] [<c034ce8c>] (dpm_resume+0xfc/0x21c) from [<c034d094>] (=
dpm_resume_end+0xc/0x18)
> > [   94.016723] [<c034d094>] (dpm_resume_end+0xc/0x18) from [<c0087b14>]=
 (suspend_devices_and_enter+0xe8/0x1b0)
> > [   94.026947] [<c0087b14>] (suspend_devices_and_enter+0xe8/0x1b0) from=
 [<c0087c78>] (enter_state+0x9c/0xdc)
> > [   94.036987] [<c0087c78>] (enter_state+0x9c/0xdc) from [<c0087ccc>] (=
pm_suspend+0x14/0x70)
> > [   94.045593] [<c0087ccc>] (pm_suspend+0x14/0x70) from [<c0086d34>] (s=
tate_store+0x30/0x3c)
> > [   94.054199] [<c0086d34>] (state_store+0x30/0x3c) from [<c02d39b8>] (=
kobj_attr_store+0x14/0x20)
> > [   94.063262] [<c02d39b8>] (kobj_attr_store+0x14/0x20) from [<c017bcd0=
>] (sysfs_write_file+0x80/0xb4)
> > [   94.072784] [<c017bcd0>] (sysfs_write_file+0x80/0xb4) from [<c01174c=
4>] (vfs_write+0xa8/0x138)
> > [   94.081817] [<c01174c4>] (vfs_write+0xa8/0x138) from [<c0117730>] (s=
ys_write+0x40/0x68)
> > [   94.090240] [<c0117730>] (sys_write+0x40/0x68) from [<c0013f40>] (re=
t_fast_syscall+0x0/0x3c)
> > [   94.099334] omap_i2c omap_i2c.1: omap_i2c_xfer 655
> > [   94.104431] omap_i2c omap_i2c.1: omap_i2c_xfer 659
> > [   94.109466] omap_i2c omap_i2c.1: omap_i2c_xfer 663
> > [   94.114532] omap_i2c omap_i2c.1: omap_i2c_xfer 668
> > [   94.119567] twl: i2c_read failed to transfer all messages
> > [   94.125244] omap_hsmmc omap_hsmmc.0: could not set regulator OCR (-1=
10)
> > [   94.286773] mmc0: error -110 during resume (card was removed?)
>=20
> --=20
> balbi



--=20
balbi

--/Gk0KcsbyUMelFU1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQfWMbAAoJEIaOsuA1yqREy1gP/jEjIvvRI7h8uzA7IdBTSWCC
U6LoOampv0I7JJ/5n2fladM2WyJSJREKLFt/V1ck9P5JT1wG+KrJa9gglAyCOFSA
H3C+BWrnwa0oKnTCW8XBIdeRNBfWGulSWYQWUSTcCZx1/3pCtWV+bDQIUyolC5Fg
r0gQmkK8NlFic+Ss4nGkHCyCgK2/+IUPd+vcDghXJzFfqTNvf4ZW/zOadua73izj
l3TC7ipNsl6EfMyjbodZ2OtyDIome3aT1LEuBZl2eu0agugwFTNlnjMwHP4V79qQ
P+CZM1PUbR+1WsEtuwzWE4TaSwyGpNfUgeYYZ3kIEdnKyjTuk7Isobqv/CT45/ls
xxN4wfU9FtKGdhKUPL+XlhlWHS/YoBPDVzh1LgFognuLnkqWxYMrththrl+qdqc2
ko+Dhcqjbd1pYVLfZR6nerDjfz1fqqgthnKGqJCWw19OWtvi9hMH/2iY4CXLR31h
gwr4rSZWKjsrffdRJ96JFC0bDOjtyY16b22wMy30gvgyHEaWDwvy8MrWz53j0uJp
Qu5GO+7J4QQMnlztYk11diyOvi3pvIUSVWuzn8orN/Ci1aPm45D94BE0Fs+0M1E/
4QRq0TEeqYyiEiwwbpdQ9cfZOFEEdVqjtLNOheELYR8KZutWTjRw9VwPJlH+p3vF
+h/DM80OcITPOtr4gaZ1
=reKg
-----END PGP SIGNATURE-----

--/Gk0KcsbyUMelFU1--
