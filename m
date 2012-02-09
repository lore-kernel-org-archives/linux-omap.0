From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] gpio: omap: be more aggressive with pm_runtime
Date: Thu, 9 Feb 2012 13:29:45 +0200
Message-ID: <20120209112943.GA1121@legolas.emea.dhcp.ti.com>
References: <1328707614-20146-1-git-send-email-balbi@ti.com>
 <877gzwyivt.fsf@ti.com>
 <20120209060939.GB1121@legolas.emea.dhcp.ti.com>
 <20120209111142.GZ1121@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iNKvvK4J48bNrWSb"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:33821 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755100Ab2BIL3t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 06:29:49 -0500
Received: by mail-lpp01m010-f47.google.com with SMTP id c1so1882972lah.34
        for <linux-omap@vger.kernel.org>; Thu, 09 Feb 2012 03:29:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120209111142.GZ1121@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, grant.likely@secretlab.ca, linus.walleij@stericsson.com, tarun.kanti@ti.com


--iNKvvK4J48bNrWSb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 09, 2012 at 01:11:45PM +0200, Felipe Balbi wrote:
> I will continue debugging this, I think it's just something stupid that
> I did. Here's entire log:

Indeed some stupidity of mine. I know the following is wrong, but I just
wanted to test it out. I have added the following to gpio-omap.c:

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index db5dcca..8dc82ee 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1178,11 +1178,13 @@ static int omap_gpio_suspend(struct device *dev)
=20
 	wakeup_enable =3D bank->base + bank->regs->wkup_en;
=20
+	pm_runtime_get_sync(dev);
 	spin_lock_irqsave(&bank->lock, flags);
 	bank->saved_wakeup =3D __raw_readl(wakeup_enable);
 	_gpio_rmw(base, bank->regs->wkup_en, 0xffffffff, 0);
 	_gpio_rmw(base, bank->regs->wkup_en, bank->suspend_wakeup, 1);
 	spin_unlock_irqrestore(&bank->lock, flags);
+	pm_runtime_put_sync(dev);
=20
 	return 0;
 }
@@ -1200,10 +1202,12 @@ static int omap_gpio_resume(struct device *dev)
 	if (!bank->regs->wkup_en || !bank->saved_wakeup)
 		return 0;
=20
+	pm_runtime_get_sync(dev);
 	spin_lock_irqsave(&bank->lock, flags);
 	_gpio_rmw(base, bank->regs->wkup_en, 0xffffffff, 0);
 	_gpio_rmw(base, bank->regs->wkup_en, bank->saved_wakeup, 1);
 	spin_unlock_irqrestore(&bank->lock, flags);
+	pm_runtime_put_sync(dev);
=20
 	return 0;
 }

so, the main problem is that when we try to resume, our clocks aren't on
(off course). I wonder what should really be done here. Should I go
ahead and use the clock API to fix this issue or should I believe
omap PM layer will be able to enable the hwmod so I can resume
properly ?

Bellow, you can see entire log. Note that I can only reach suspend once.
=46rom that point on, MPU never reaches low power anymore; and there is
this L3 debug IRQ happening:

echo enabled > /sys/devices/platform/gpio-keys/power/wakeup
root@legolas:~# grep user /proc/interrupts=20
281:          0          0      GPIO  user
root@legolas:~# grep user /proc/interrupts=20
281:          2          0      GPIO  user
root@legolas:~#=20
root@legolas:~# echo mem > /sys/power/state=20
[   36.300933] PM: Syncing filesystems ... done.
[   36.312561] Freezing user space processes ... (elapsed 0.02 seconds) don=
e.
[   36.347015] Freezing remaining freezable tasks ... (elapsed 0.03 seconds=
) done.
[   36.381072] Suspending console(s) (use no_console_suspend to debug)
[   36.397827] PM: suspend of devices complete after 14.768 msecs
[   36.399780] PM: late suspend of devices complete after 1.952 msecs
[   36.399780] Disabling non-boot CPUs ...
[   36.402984] CPU1: shutdown
[   37.953826] Successfully put all powerdomains to target state
[   37.953948] Enabling non-boot CPUs ...
[   37.955566] CPU1: Booted secondary processor
[   37.956115] Calibrating delay loop (skipped) already calibrated this CPU
[   37.956695] CPU1 is up
[   37.957946] PM: early resume of devices complete after 1.251 msecs
[   37.957946] ------------[ cut here ]------------
[   37.958068] WARNING: at arch/arm/mach-omap2/omap_l3_noc.c:113 l3_interru=
pt_handler+0x184/0x1c4()
[   37.958068] L3 custom error: MASTER:MPU TARGET:L4 PER2
[   37.958068] Modules linked in:
[   37.958068] [<c001b824>] (unwind_backtrace+0x0/0xf0) from [<c0042a60>] (=
warn_slowpath_common+0x4c/0x64)
[   37.958190] [<c0042a60>] (warn_slowpath_common+0x4c/0x64) from [<c0042b0=
c>] (warn_slowpath_fmt+0x30/0x40)
[   37.958190] [<c0042b0c>] (warn_slowpath_fmt+0x30/0x40) from [<c0034a88>]=
 (l3_interrupt_handler+0x184/0x1c4)
[   37.958221] [<c0034a88>] (l3_interrupt_handler+0x184/0x1c4) from [<c00a1=
ef8>] (handle_irq_event_percpu+0x5c/0x22c)
[   37.958221] [<c00a1ef8>] (handle_irq_event_percpu+0x5c/0x22c) from [<c00=
a2104>] (handle_irq_event+0x3c/0x5c)
[   37.958282] [<c00a2104>] (handle_irq_event+0x3c/0x5c) from [<c00a4ba0>] =
(handle_fasteoi_irq+0x98/0x140)
[   37.958312] [<c00a4ba0>] (handle_fasteoi_irq+0x98/0x140) from [<c00a170c=
>] (generic_handle_irq+0x30/0x48)
[   37.958312] [<c00a170c>] (generic_handle_irq+0x30/0x48) from [<c0014bd8>=
] (handle_IRQ+0x4c/0xac)
[   37.958374] [<c0014bd8>] (handle_IRQ+0x4c/0xac) from [<c000848c>] (gic_h=
andle_irq+0x28/0xac)
[   37.958374] [<c000848c>] (gic_handle_irq+0x28/0xac) from [<c04809e4>] (_=
_irq_svc+0x44/0x60)
[   37.958374] Exception stack(0xee2dbe60 to 0xee2dbea8)
[   37.958435] be60: 0000c439 00000003 00000000 ee1e4040 60000113 c068c194 =
00000000 c068c194
[   37.958435] be80: 60000113 ee04d780 c068c140 000d7238 00001584 ee2dbea8 =
0000c43a c04807a4
[   37.958435] bea0: 20000113 ffffffff
[   37.958465] [<c04809e4>] (__irq_svc+0x44/0x60) from [<c04807a4>] (_raw_s=
pin_unlock_irqrestore+0x34/0x44)
[   37.958465] [<c04807a4>] (_raw_spin_unlock_irqrestore+0x34/0x44) from [<=
c00a717c>] (resume_irqs+0x9c/0xbc)
[   37.958465] [<c00a717c>] (resume_irqs+0x9c/0xbc) from [<c0080998>] (susp=
end_enter+0xa4/0x168)
[   37.958526] [<c0080998>] (suspend_enter+0xa4/0x168) from [<c0080b0c>] (s=
uspend_devices_and_enter+0xb0/0x18c)
[   37.958526] [<c0080b0c>] (suspend_devices_and_enter+0xb0/0x18c) from [<c=
0080d24>] (enter_state+0x13c/0x17c)
[   37.958557] [<c0080d24>] (enter_state+0x13c/0x17c) from [<c007fa1c>] (st=
ate_store+0xd0/0x178)
[   37.958587] [<c007fa1c>] (state_store+0xd0/0x178) from [<c0258f48>] (kob=
j_attr_store+0x14/0x20)
[   37.958587] [<c0258f48>] (kobj_attr_store+0x14/0x20) from [<c0169958>] (=
sysfs_write_file+0x100/0x184)
[   37.958587] [<c0169958>] (sysfs_write_file+0x100/0x184) from [<c0109d10>=
] (vfs_write+0xb4/0x148)
[   37.958587] [<c0109d10>] (vfs_write+0xb4/0x148) from [<c0109f98>] (sys_w=
rite+0x40/0x70)
[   37.958587] [<c0109f98>] (sys_write+0x40/0x70) from [<c0013cc0>] (ret_fa=
st_syscall+0x0/0x3c)
[   37.958679] ---[ end trace 09fd5633fca7e7bc ]---
[   39.104858] PM: resume of devices complete after 1146.177 msecs
[   39.418762] Restarting tasks ... done.
root@legolas:~# echo mem > /sys/power/state root@legolas:~# grep user /proc=
/interrupts=20
281:          4          0      GPIO  user
root@legolas:~# grep user /proc/interrupts=20
281:          7          0      GPIO  user
root@legolas:~# grep user /proc/interrupts=20
281:          9          0      GPIO  user
root@legolas:~# grep user /proc/interrupts=20
281:         11          0      GPIO  user
root@legolas:~# grep user /proc/interrupts=20
281:         13          0      GPIO  user
root@legolas:~# grep user /proc/interrupts=20
281:         15          0      GPIO  user
root@legolas:~# grep user /proc/interrupts root@legolas:~# echo mem > /sys/=
power/state=20
[   55.532073] PM: Syncing filesystems ... done.
[   57.044281] Freezing user space processes ... (elapsed 0.02 seconds) don=
e.
[   57.066711] Freezing remaining freezable tasks ... (elapsed 0.02 seconds=
) done.
[   57.100799] Suspending console(s) (use no_console_suspend to debug)
[   57.116302] PM: suspend of devices complete after 6.959 msecs
[   57.117980] PM: late suspend of devices complete after 1.678 msecs
[   57.118041] Disabling non-boot CPUs ...
[   57.119628] CPU1: shutdown
[   57.121124] Powerdomain (mpu_pwrdm) didn't enter target state 1
[   57.121154] Could not enter target state in pm_suspend
[   57.121185] Enabling non-boot CPUs ...
[   57.122680] CPU1: Booted secondary processor
[   57.123352] Calibrating delay loop (skipped) already calibrated this CPU
[   57.123382] CPU1: Unknown IPI message 0x1
[   57.123779] CPU1 is up
[   57.124938] PM: early resume of devices complete after 1.159 msecs
[   58.112426] PM: resume of devices complete after 987.488 msecs
[   58.179656] Restarting tasks ... done.
root@legolas:~# echo mem > /sys/power/state=20
[   60.363983] PM: Syncing filesystems ... done.
[   61.850616] Freezing user space processes ... (elapsed 0.03 seconds) don=
e.
[   61.889984] Freezing remaining freezable tasks ... (elapsed 0.03 seconds=
) done.
[   61.928985] Suspending console(s) (use no_console_suspend to debug)
[   61.944213] PM: suspend of devices complete after 6.744 msecs
[   61.945892] PM: late suspend of devices complete after 1.678 msecs
[   61.945953] Disabling non-boot CPUs ...
[   61.947296] CPU1: shutdown
[   61.948608] Powerdomain (mpu_pwrdm) didn't enter target state 1
[   61.948638] Could not enter target state in pm_suspend
[   61.948669] Enabling non-boot CPUs ...
[   61.950744] CPU1: Booted secondary processor
[   61.950775] Calibrating delay loop (skipped) already calibrated this CPU
[   61.950805] CPU1: Unknown IPI message 0x1
[   61.951232] CPU1 is up
[   61.952362] PM: early resume of devices complete after 0.305 msecs
[   62.871063] PM: resume of devices complete after 918.396 msecs
[   62.938262] Restarting tasks ... done.
root@legolas:~# ./show_gpios.sh=20
omap_gpio.0
control auto
runtime_status suspended
runtime_active_time 7
runtime_suspended_time 97625

omap_gpio.1
control auto
runtime_status suspended
runtime_active_time 296
runtime_suspended_time 97351

omap_gpio.2
control auto
runtime_status suspended
runtime_active_time 0
runtime_suspended_time 97671

omap_gpio.3
control auto
runtime_status suspended
runtime_active_time 6906
runtime_suspended_time 90773

omap_gpio.4
control auto
runtime_status suspended
runtime_active_time 0
runtime_suspended_time 97695

root@legolas:~# echo mem > /sys/power/state=20
[  118.066925] PM: Syncing filesystems ... done.
[  118.313720] Freezing user space processes ... (elapsed 0.04 seconds) don=
e.
[  118.359130] Freezing remaining freezable tasks ... (elapsed 0.02 seconds=
) done.
[  118.390228] Suspending console(s) (use no_console_suspend to debug)
[  118.405578] PM: suspend of devices complete after 15.075 msecs
[  118.407379] PM: late suspend of devices complete after 1.708 msecs
[  118.407379] Disabling non-boot CPUs ...
[  118.408752] CPU1: shutdown
[  118.410186] Powerdomain (mpu_pwrdm) didn't enter target state 1
[  118.410186] Could not enter target state in pm_suspend
[  118.410217] Enabling non-boot CPUs ...
[  118.411865] CPU1: Booted secondary processor
[  118.411865] Calibrating delay loop (skipped) already calibrated this CPU
[  118.412445] CPU1: Unknown IPI message 0x1
[  118.412872] CPU1 is up
[  118.414031] PM: early resume of devices complete after 0.335 msecs
[  119.316711] PM: resume of devices complete after 902.374 msecs
[  119.384063] Restarting tasks ... done.
root@legolas:~#=20

--=20
balbi

--iNKvvK4J48bNrWSb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPM64nAAoJEIaOsuA1yqRECVkQAKDTtkeyhxFjZ9xOkvSmIlz8
0QMo4vNztLkfgmZxqRvLrNmeU2zHQb85RLTrXJjQ5JIpqaMIm2YIutNsaNn52u7a
00gH4SUiHD1rp0GTcVObL1xEmbJy6wGXUOXyQGLrT9rDfV6ed0OtF+lWJ4+2wrlX
u0kfaAITx/1MnBr341MvaCsnDqNLmE4JiSMnT4zLSlHlg3qG/UNs1S9xRSb6NDxm
zd356p7ovQsxmCqZ6Yl8I7FD3P//lwsogcEsmEDYJXPq6d4LLIjOTtY+G2614W+/
XaHsJfn0r0fppID1nzERgglW2AAspzkO7RTwGkckCTnSkJoDiip/vaGnEYNh6Qnh
ac/ydyvzNmg1wtgnQ9lERkeNuyHW16ve4fhp1j+VpfoyBXFSJPB5PVj2KPeyrxLN
Z1Zr315ycpR+gEI5Mv4jPKfGM9XopIFss0gGN/H8k/WzU1ziJbtdxpHxrVB/so5E
FCzhYUmY4N0nJjYRgSOGGPOm8GDON6HM9Vqr9Tg/RS94KhU4WPpMTkPC3iPhIhlw
iQeVTw4BafLuUehY9GEzChPEKhCNVKvmEFsMNaW7embAvb0xUbiphjhgRoggpLLJ
4gMco1mS4DWQ4+cVuM60U9dWmda/31En/6ZOxE7r4aE2Bq9KqM/8Ij+QLWNaRtP1
h+aq1VRmUITdr01RoqPk
=rf3K
-----END PGP SIGNATURE-----

--iNKvvK4J48bNrWSb--
