From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/3] ARM: OMAP2/3: DSS HWMOD fixes
Date: Wed, 22 Aug 2012 09:24:37 +0300
Message-ID: <1345616677.3036.3.camel@deskari>
References: <1336645264-909-1-git-send-email-tomi.valkeinen@ti.com>
	 <alpine.DEB.2.00.1206271416420.27496@utopia.booyaka.com>
	 <alpine.DEB.2.00.1207040610310.6760@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-JpwDbpQuSr/3ayJa2jYK"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:57663 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750817Ab2HVGY6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Aug 2012 02:24:58 -0400
Received: by lbbgk1 with SMTP id gk1so442907lbb.40
        for <linux-omap@vger.kernel.org>; Tue, 21 Aug 2012 23:24:44 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1207040610310.6760@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, archit@ti.com


--=-JpwDbpQuSr/3ayJa2jYK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-07-04 at 06:11 -0600, Paul Walmsley wrote:
> Hi Tomi
>=20
> On Wed, 27 Jun 2012, Paul Walmsley wrote:
>=20
> > On Thu, 10 May 2012, Tomi Valkeinen wrote:
> >=20
> > > These patches fix DSS hwmod data related to sysc flags. I haven't see=
n any
> > > problem produced by these missing bits, but by looking at the TRM it'=
s clear
> > > that they should be defined.
> > >=20
> > > However, applying these will cause additional warnings to show during=
 boot:
> > >=20
> > > omap_hwmod: dss_dispc: softreset failed (waited 10000 usec)
> > > omap_hwmod: dss_rfbi: softreset failed (waited 10000 usec)
> > >=20
> > > Most likely the softreset fails even now, but as there's no check to =
verify it,
> > > no warnings are visible.
> > >=20
> > > I think the reason for the failing softreset is the same problem as w=
e have on
> > > OMAP4: dss_core hwmod should be enabled before other dss hwmods can b=
e enabled
> > > (and reset).
> >=20
> > Thanks, queued for 3.6.
> >=20
> > Not sure what to do about the softreset issues at the moment, due to=
=20
> > competing priorities.  But for sure the data should match the hardware.
>=20
> I've dropped these for 3.6 since they cause a PM regression during a=20
> system suspend test:
>=20
> [   39.721282] Powerdomain (dss_pwrdm) didn't enter target state 1
>=20
> Probably before we can pull these in, we need to figure out what's going=
=20
> on there.

I was testing with omap3 overo, on v3.6-rc2 +
git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc
fixes-for-linus

I don't seem to be able to enter full suspend even without dss. This is
with DSS compiled as modules, and not loaded:

# echo mem > /sys/power/state=20
[   21.697265] PM: Syncing filesystems ... done.
[   21.711059] Freezing user space processes ... (elapsed 0.02 seconds) don=
e.
[   21.740722] Freezing remaining freezable tasks ... (elapsed 0.02 seconds=
) done.
[   21.911407] PM: suspend of devices complete after 134.399 msecs
[   21.921874] PM: late suspend of devices complete after 4.150 msecs
[   21.934753] PM: noirq suspend of devices complete after 6.256 msecs
[   21.941467] Disabling non-boot CPUs ...
[   24.639495] Powerdomain (iva2_pwrdm) didn't enter target state 1
[   24.645812] Powerdomain (dss_pwrdm) didn't enter target state 1
[   24.652008] Powerdomain (per_pwrdm) didn't enter target state 1
[   24.658233] Powerdomain (core_pwrdm) didn't enter target state 1
[   24.664550] Powerdomain (usbhost_pwrdm) didn't enter target state 1
[   24.671112] Could not enter target state in pm_suspend
[   24.679901] PM: noirq resume of devices complete after 3.173 msecs
[   24.691101] PM: early resume of devices complete after 2.716 msecs
[   25.086517] PM: resume of devices complete after 388.793 msecs
[   25.097564] Restarting tasks ... done.

There's also still the old bug that happens if I have USB ethernet
gadget as built-in:

# echo mem > /sys/power/state=20
[   25.011657] PM: Syncing filesystems ... done.
[   25.026184] Freezing user space processes ... (elapsed 0.02 seconds) don=
e.
[   25.055145] Freezing remaining freezable tasks ... (elapsed 0.02 seconds=
) done.
[   25.086303] Suspending console(s) (use no_console_suspend to debug)
[   25.264953] PM: suspend of devices complete after 166.717 msecs
[   25.269348] PM: late suspend of devices complete after 4.394 msecs
[   25.275482] twl: i2c_read failed to transfer all messages
[   25.275543] twl: i2c_write failed to transfer all messages
[   25.275604] twl: i2c_write failed to transfer all messages
[   25.275634] ------------[ cut here ]------------
[   25.275665] WARNING: at drivers/usb/otg/twl4030-usb.c:360 __twl4030_phy_=
power+0x88/0x98()
[   25.275665] Modules linked in:
[   25.275726] [<c001b8cc>] (unwind_backtrace+0x0/0xf0) from [<c004217c>] (=
warn_slowpath_common+0x4c
/0x64)
[   25.275756] [<c004217c>] (warn_slowpath_common+0x4c/0x64) from [<c00421b=
0>] (warn_slowpath_null+0
x1c/0x24)
[   25.275787] [<c00421b0>] (warn_slowpath_null+0x1c/0x24) from [<c03babe8>=
] (__twl4030_phy_power+0x
88/0x98)
[   25.275787] [<c03babe8>] (__twl4030_phy_power+0x88/0x98) from [<c03bac84=
>] (twl4030_phy_power+0x8
c/0xf4)
[   25.275817] [<c03bac84>] (twl4030_phy_power+0x8c/0xf4) from [<c03bad90>]=
 (twl4030_phy_suspend.clo
ne.7+0x18/0x44)
[   25.275848] [<c03bad90>] (twl4030_phy_suspend.clone.7+0x18/0x44) from [<=
c03bae38>] (twl4030_set_s
uspend+0x1c/0x24)
[   25.275878] [<c03bae38>] (twl4030_set_suspend+0x1c/0x24) from [<c03d92ec=
>] (omap2430_runtime_susp
end+0x4c/0x54)
[   25.275909] [<c03d92ec>] (omap2430_runtime_suspend+0x4c/0x54) from [<c03=
28b10>] (pm_generic_runti
me_suspend+0x2c/0x40)
[   25.275939] [<c0328b10>] (pm_generic_runtime_suspend+0x2c/0x40) from [<c=
003dcd0>] (_od_suspend_no
irq+0x34/0x68)
[   25.275939] [<c003dcd0>] (_od_suspend_noirq+0x34/0x68) from [<c0329bf0>]=
 (dpm_run_callback.clone.
10+0x30/0xb4)
[   25.275970] [<c0329bf0>] (dpm_run_callback.clone.10+0x30/0xb4) from [<c0=
32a3c4>] (dpm_suspend_end
+0x30c/0x514)
[   25.276000] [<c032a3c4>] (dpm_suspend_end+0x30c/0x514) from [<c00830c0>]=
 (suspend_devices_and_ent
er+0xbc/0x2d0)
[   25.276031] [<c00830c0>] (suspend_devices_and_enter+0xbc/0x2d0) from [<c=
0083460>] (pm_suspend+0x1
8c/0x208)
[   25.276031] [<c0083460>] (pm_suspend+0x18c/0x208) from [<c00826f4>] (sta=
te_store+0x120/0x134)
[   25.276062] [<c00826f4>] (state_store+0x120/0x134) from [<c02c0b10>] (ko=
bj_attr_store+0x14/0x20)
[   25.276092] [<c02c0b10>] (kobj_attr_store+0x14/0x20) from [<c0170668>] (=
sysfs_write_file+0x100/0x
184)
[   25.276123] [<c0170668>] (sysfs_write_file+0x100/0x184) from [<c010e238>=
] (vfs_write+0xb4/0x148)
[   25.276153] [<c010e238>] (vfs_write+0xb4/0x148) from [<c010e4c0>] (sys_w=
rite+0x40/0x70)
[   25.276184] [<c010e4c0>] (sys_write+0x40/0x70) from [<c0013ee0>] (ret_fa=
st_syscall+0x0/0x3c)
[   25.276184] ---[ end trace 7ca935fb21bbfe5c ]---
[   25.276397] twl: i2c_read failed to transfer all messages
[   25.276397] VUSB1V5: failed to disable
[   25.276428] twl: i2c_read failed to transfer all messages
[   25.276428] VUSB1V8: failed to disable
[   25.276458] twl: i2c_read failed to transfer all messages
[   25.276489] VUSB3V1: failed to disable
[   25.277252] PM: noirq suspend of devices complete after 7.843 msecs
[   25.277313] Disabling non-boot CPUs ...
[   27.809631] Powerdomain (iva2_pwrdm) didn't enter target state 1
[   27.809631] Powerdomain (dss_pwrdm) didn't enter target state 1
[   27.809631] Powerdomain (per_pwrdm) didn't enter target state 1
[   27.809661] Powerdomain (core_pwrdm) didn't enter target state 1
[   27.809661] Powerdomain (usbhost_pwrdm) didn't enter target state 1
[   27.809661] Could not enter target state in pm_suspend
[   27.810699] twl: i2c_write failed to transfer all messages
[   27.810760] twl: i2c_read failed to transfer all messages
[   27.810791] twl: i2c_write failed to transfer all messages
[   27.810821] twl: i2c_write failed to transfer all messages
[   27.810852] ------------[ cut here ]------------
[   27.810882] WARNING: at drivers/usb/otg/twl4030-usb.c:360 __twl4030_phy_=
power+0x88/0x98()
[   27.810913] Modules linked in:
[   27.810943] [<c001b8cc>] (unwind_backtrace+0x0/0xf0) from [<c004217c>] (=
warn_slowpath_common+0x4c
/0x64)
[   27.810974] [<c004217c>] (warn_slowpath_common+0x4c/0x64) from [<c00421b=
0>] (warn_slowpath_null+0
x1c/0x24)
[   27.810974] [<c00421b0>] (warn_slowpath_null+0x1c/0x24) from [<c03babe8>=
] (__twl4030_phy_power+0x
88/0x98)
[   27.811004] [<c03babe8>] (__twl4030_phy_power+0x88/0x98) from [<c03bac40=
>] (twl4030_phy_power+0x4
8/0xf4)
[   27.811035] [<c03bac40>] (twl4030_phy_power+0x48/0xf4) from [<c03bacfc>]=
 (__twl4030_phy_resume+0x
10/0x48)
[   27.811065] [<c03bacfc>] (__twl4030_phy_resume+0x10/0x48) from [<c03bad4=
c>] (twl4030_phy_resume+0
x18/0x44)
[   27.811065] [<c03bad4c>] (twl4030_phy_resume+0x18/0x44) from [<c03bae2c>=
] (twl4030_set_suspend+0x
10/0x24)
[   27.811096] [<c03bae2c>] (twl4030_set_suspend+0x10/0x24) from [<c03d9298=
>] (omap2430_runtime_resu
me+0x50/0x58)
[   27.811126] [<c03d9298>] (omap2430_runtime_resume+0x50/0x58) from [<c032=
8b50>] (pm_generic_runtim
e_resume+0x2c/0x40)
[   27.811157] [<c0328b50>] (pm_generic_runtime_resume+0x2c/0x40) from [<c0=
03dc10>] (_od_resume_noir
q+0x44/0x58)
[   27.811187] [<c003dc10>] (_od_resume_noirq+0x44/0x58) from [<c0329bf0>] =
(dpm_run_callback.clone.1
0+0x30/0xb4)
[   27.811187] [<c0329bf0>] (dpm_run_callback.clone.10+0x30/0xb4) from [<c0=
329d00>] (dpm_resume_noir
q+0x8c/0x224)
[   27.811218] [<c0329d00>] (dpm_resume_noirq+0x8c/0x224) from [<c032a5d8>]=
 (dpm_resume_start+0xc/0x
18)
[   27.811248] [<c032a5d8>] (dpm_resume_start+0xc/0x18) from [<c0083118>] (=
suspend_devices_and_enter
+0x114/0x2d0)
[   27.811279] [<c0083118>] (suspend_devices_and_enter+0x114/0x2d0) from [<=
c0083460>] (pm_suspend+0x
18c/0x208)
[   27.811279] [<c0083460>] (pm_suspend+0x18c/0x208) from [<c00826f4>] (sta=
te_store+0x120/0x134)
[   27.811309] [<c00826f4>] (state_store+0x120/0x134) from [<c02c0b10>] (ko=
bj_attr_store+0x14/0x20)
[   27.811340] [<c02c0b10>] (kobj_attr_store+0x14/0x20) from [<c0170668>] (=
sysfs_write_file+0x100/0x
184)
[   27.811370] [<c0170668>] (sysfs_write_file+0x100/0x184) from [<c010e238>=
] (vfs_write+0xb4/0x148)
[   27.811401] [<c010e238>] (vfs_write+0xb4/0x148) from [<c010e4c0>] (sys_w=
rite+0x40/0x70)
[   27.811401] [<c010e4c0>] (sys_write+0x40/0x70) from [<c0013ee0>] (ret_fa=
st_syscall+0x0/0x3c)
[   27.811431] ---[ end trace 7ca935fb21bbfe5d ]---
[   27.811462] twl: i2c_read failed to transfer all messages
[   27.811492] twl: i2c_write failed to transfer all messages
[   27.811523] twl: i2c_read failed to transfer all messages
[   27.811553] twl: i2c_write failed to transfer all messages
[   27.811614] twl: i2c_write failed to transfer all messages
[   27.811645] twl: i2c_write failed to transfer all messages
[   27.811676] twl: i2c_read failed to transfer all messages
[   27.814544] PM: noirq resume of devices complete after 4.638 msecs
[   27.819000] PM: early resume of devices complete after 2.960 msecs
[   28.240875] PM: resume of devices complete after 421.783 msecs
[   28.878845] Restarting tasks ... done.

--=-JpwDbpQuSr/3ayJa2jYK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQNHslAAoJEPo9qoy8lh71JjwQAJFTAeV62wE3Bv6bXPpsY7M4
pXea+loY9QAfrOc4i2ybQ1A7nNBT546j5nWYHEY5jM4t+UeRUWsgstzGqh6nR/pH
59A3uqOyD8C/S4uAx5DXOJFO0jf3TFcUmzI+rmGSW2SpugqC2NQQCFvMCM1Qos+c
GQ2eMWi9wKtDknqtvZyRPZQUNbp8LGmgXKfd23X0H1GGPExlQ9glirulHi9CaHLK
gGwZBIa8WVDEezxHU0VC4rZBCLs3pllP0fHsfa9KJsOAXEy0J84QX6VdmLzr4/Sc
7rbIYIMapFXDMEzdy71MnYDNE1dx/h3K8QmPr8xjVxpfrkmyfSFHO7koj9T4FSvF
q6MYjrwNmPFBS51BSpzcofBeOL71uRfzgYqXRGnK7PVoX3POqB/nyC4l9hlo7qFL
nZLwFZIymBvacNF4UbHp1wBIvxn5ty7oTGylbMedXPmqDp97+6VUGEegGmOKZ5Xq
isU4zJNfz+yhDgdsKEZjTjV7eIPQu/yhD1mzPDTv47pTBTRtamYnmD+kJdne8+mq
2qDKYAI6tcHac+GME7VsAa53ymUk48T7uNpQQ1/67GVDjpSxZm2BiMWCWMcrrj4A
aOe4tnOCTNAo8GuQioAorHPrQLDrdMgxupeF/MT+2qPQGKjh3dOTRs84b0DlqNf9
/uMHW5vFhCSAyAcFdM2+
=y/g/
-----END PGP SIGNATURE-----

--=-JpwDbpQuSr/3ayJa2jYK--

