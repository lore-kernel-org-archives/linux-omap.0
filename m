From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Thu, 12 Jan 2012 18:42:31 +0200
Message-ID: <1326386551.1896.41.camel@deskari>
References: <WC20120109124643.880164@terrafix.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-SHkrkRVTWLbBEBql2O90"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:34725 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754185Ab2ALQmm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Jan 2012 11:42:42 -0500
Received: by lahc1 with SMTP id c1so1390463lah.37
        for <linux-omap@vger.kernel.org>; Thu, 12 Jan 2012 08:42:34 -0800 (PST)
In-Reply-To: <WC20120109124643.880164@terrafix.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joe Woodward <jw@terrafix.co.uk>, Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>


--=-SHkrkRVTWLbBEBql2O90
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-01-09 at 12:46 +0000, Joe Woodward wrote:
> I'm running on a Gumstix Overo (OMAP3530) with an 24-bit LCD panel connec=
ted via the DPI interface (using the generic panel driver).
>=20
> Entering standby used to work just fine on 3.0, but on 3.2 I get the foll=
owing:

I've been debugging this, but I'm at loss. I added some debug prints,
which I show below, and I also pushed them to
"git://gitorious.org/linux-omap-dss2/linux.git pm-test-prints" if
somebody wants to see exactly what they print.

Kevin, perhaps you have an idea what could be wrong here. Long version
below, short version: doing system suspend breaks omapdss, if omapdss
uses pm_runtime_put, but works with pm_runtime_put_sync.

First, as a test case, here's what happens if I manually disable a
display (with my comments beginning with #):

echo 0 > /sys/devices/platform/omapdss/display0/enabled=20
# here dpi.c calls dispc_runtime_put
[   44.528015] dispc_runtime_put
[   44.531158] dispc disable depth: 0
[   44.535308] dispc disable depth: 0
[   44.538879] dispc_runtime_put end 0
# here dpi.c calls dss_runtime_put
[   44.542633] dss_runtime_put
[   44.545593] dss disable depth: 0
[   44.548980] dss disable depth: 0
[   44.552429] dss_runtime_put end 0

# then the runtime PM runs dispc suspend in its workqueue
[   44.557861] dispc_runtime_suspend start
# here dispc_runtime_suspend uses dss_runtime_put
[   44.561981] dss_runtime_put
[   44.564910] dss disable depth: 0
[   44.568420] dss disable depth: 0
[   44.571838] dss_runtime_put end 0
[   44.575378] dispc_runtime_suspend end
# then the runtime PM runs dss suspend in its workqueue
[   44.579315] dss_runtime_suspend start
[   44.583221] dss_runtime_suspend end


And similarly when enabling the display:

echo 1 > /sys/devices/platform/omapdss/display0/enabled=20
[  442.109222] dss_runtime_get
[  442.112304] dss disable depth: 0
[  442.115753] dss_runtime_resume start
[  442.119537] dss_runtime_resume end
[  442.123199] dss disable depth: 0
[  442.126586] dss_runtime_get end 0
[  442.130126] dispc_runtime_get
[  442.133270] dispc disable depth: 0
[  442.136932] dispc_runtime_resume start
[  442.140869] dss_runtime_get
[  442.143890] dss disable depth: 0
[  442.147308] dss disable depth: 0
[  442.150695] dss_runtime_get end 1
[  442.154235] dispc_runtime_resume end
[  442.158020] dispc disable depth: 0
[  442.161651] dispc_runtime_get end 0


This all works fine. Now, if I suspend the system:

echo mem > /sys/power/state=20
[  482.097930] PM: Syncing filesystems ... done.
[  482.105041] PM: Preparing system for mem sleep
[  482.116394] Freezing user space processes ... (elapsed 0.02 seconds) don=
e.
[  482.146331] Freezing remaining freezable tasks ... (elapsed 0.02 seconds=
) done.
[  482.177520] PM: Entering mem sleep
# dss core suspend disables the displays, as was done manually above
[  482.197570] core suspend 2
[  482.213867] dispc_runtime_put
[  482.217010] dispc disable depth: 0
[  482.220886] dispc disable depth: 0
[  482.224578] dispc_runtime_put end 0
[  482.228271] dss_runtime_put
[  482.231262] dss disable depth: 0
[  482.234649] dss disable depth: 0
[  482.238128] dss_runtime_put end 0
[  482.242218] core suspend end 0
# so far looks exactly the same as above

[  482.246795] PM: suspend of devices complete after 60.260 msecs
# now runtime PM runs the suspends in its workqueue
[  482.256744] dispc_runtime_suspend start
[  482.260955] dss_runtime_put

# dss's disable_depth is 1?? Which, afaik, means something like runtime PM =
is disabled for DSS.

[  482.263916] dss disable depth: 1
[  482.267303] dss disable depth: 1
[  482.270782] dss_runtime_put end 0
[  482.274261] dispc_runtime_suspend end
[  482.278381] dss_runtime_suspend start
[  482.282257] dss_runtime_suspend end
[  482.286224] PM: late suspend of devices complete after 33.209 msecs
[  482.292968] Disabling non-boot CPUs ...


Except the disable_depth, the suspend went as in manual case. But on resume=
 things are rather broken:


[  696.654754] Successfully put all powerdomains to target state

# Here the PM framework calls dss's runtime_resume callback, even if nobody=
 has called pm_rutime_get for dss!

[  696.661254] dss_runtime_resume start
[  696.665100] dss_runtime_resume end
[  696.668731] dispc_runtime_resume start
[  696.672760] dss_runtime_get
[  696.675689] dss disable depth: 1
[  696.679168] EACCESS RPM_RESUME
[  696.682373] dss disable depth: 1

# And here pm_runtime_get fails for DSS, because dss disable_depth is 1...

[  696.685791] ------------[ cut here ]------------
[  696.690734] WARNING: at drivers/video/omap2/dss/dss.c:716 dss_runtime_ge=
t+0x74/0x8c()
[  696.699035] Modules linked in:
[  696.702392] [<c001b3c4>] (unwind_backtrace+0x0/0xf0) from [<c005248c>] (=
warn_slowpath_common+0x4c
/0x64)
[  696.712371] [<c005248c>] (warn_slowpath_common+0x4c/0x64) from [<c00524c=
0>] (warn_slowpath_null+0
x1c/0x24)
[  696.722625] [<c00524c0>] (warn_slowpath_null+0x1c/0x24) from [<c0273cd8>=
] (dss_runtime_get+0x74/0
x8c)
[  696.732421] [<c0273cd8>] (dss_runtime_get+0x74/0x8c) from [<c0274610>] (=
dispc_runtime_resume+0x10
/0x149c)
[  696.742584] [<c0274610>] (dispc_runtime_resume+0x10/0x149c) from [<c02d0=
9c0>] (pm_generic_runtime
_resume+0x2c/0x40)
[  696.753662] [<c02d09c0>] (pm_generic_runtime_resume+0x2c/0x40) from [<c0=
03af70>] (_od_resume_noir
q+0x48/0x54)
[  696.764190] [<c003af70>] (_od_resume_noirq+0x48/0x54) from [<c02d1c54>] =
(pm_noirq_op.clone.5+0x9c
/0x164)
[  696.774291] [<c02d1c54>] (pm_noirq_op.clone.5+0x9c/0x164) from [<c02d1d7=
c>] (dpm_resume_noirq+0x6
0/0x1f4)
[  696.784454] [<c02d1d7c>] (dpm_resume_noirq+0x60/0x1f4) from [<c0098e2c>]=
 (suspend_devices_and_ent
er+0x114/0x2d0)
[  696.795227] [<c0098e2c>] (suspend_devices_and_enter+0x114/0x2d0) from [<=
c0099128>] (enter_state+0
x140/0x180)
[  696.805694] [<c0099128>] (enter_state+0x140/0x180) from [<c0097f54>] (st=
ate_store+0xd0/0x178)
[  696.814758] [<c0097f54>] (state_store+0xd0/0x178) from [<c02460a4>] (kob=
j_attr_store+0x14/0x20)
[  696.824005] [<c02460a4>] (kobj_attr_store+0x14/0x20) from [<c01626c0>] (=
sysfs_write_file+0x100/0x
184)
[  696.833801] [<c01626c0>] (sysfs_write_file+0x100/0x184) from [<c0101e20>=
] (vfs_write+0xb4/0x148)
[  696.843139] [<c0101e20>] (vfs_write+0xb4/0x148) from [<c01020a8>] (sys_w=
rite+0x40/0x70)
[  696.851654] [<c01020a8>] (sys_write+0x40/0x70) from [<c0013b60>] (ret_fa=
st_syscall+0x0/0x3c)
[  696.860626] ---[ end trace 14e40b198c698a6f ]---
[  696.865478] dss_runtime_get end -13
[  696.869201] dispc_runtime_resume end fail
[  696.875549] PM: early resume of devices complete after 214.509 msecs
[  696.884704] dispc_runtime_suspend start
[  696.888824] dss_runtime_put
[  696.891845] dss disable depth: 0
[  696.895568] dss disable depth: 0
[  696.899047] dss_runtime_put end 0
[  696.902526] dispc_runtime_suspend end
[  696.906616] core resume
[  696.910339] dss_runtime_get
[  696.913391] dss disable depth: 0
[  696.916809] dss disable depth: 0
[  696.920196] dss_runtime_get end 1
[  696.923767] dispc_runtime_get
[  696.926879] dispc disable depth: 0
[  696.930603] dispc_runtime_resume start
[  696.934539] dss_runtime_get
[  696.937561] dss disable depth: 0
[  696.940979] dss disable depth: 0
[  696.944366] dss_runtime_get end 1
[  696.947906] dispc_runtime_resume end
[  696.951751] dispc disable depth: 0
[  696.955383] dispc_runtime_get end 0
[  696.961212] core resume end 0
[  696.973419] PM: resume of devices complete after 89.477 msecs
[  696.984893] PM: Finishing wakeup.
[  696.988403] Restarting tasks ... done.


After changing pm_runtime_put calls in dss and dispc to sync versions:


echo mem > /sys/power/state=20
[   21.312133] PM: Syncing filesystems ... done.
[   21.319000] PM: Preparing system for mem sleep
[   21.331390] Freezing user space processes ... (elapsed 0.02 seconds) don=
e.
[   21.361297] Freezing remaining freezable tasks ... (elapsed 0.02 seconds=
) done.
[   21.392517] PM: Entering mem sleep
[   21.412506] core suspend 2
[   21.423370] dispc_runtime_put
[   21.426513] dispc disable depth: 0
[   21.430236] dispc_runtime_suspend start
[   21.434326] dss_runtime_put
[   21.437347] dss disable depth: 0
[   21.440734] dss disable depth: 0
[   21.444152] dss_runtime_put end 0
[   21.447692] dispc_runtime_suspend end
[   21.451660] dispc disable depth: 0
[   21.455322] dispc_runtime_put end 0
[   21.458984] dss_runtime_put
[   21.462005] dss disable depth: 0
[   21.465423] dss_runtime_suspend start
[   21.469329] dss_runtime_suspend end
[   21.473052] dss disable depth: 0
[   21.476531] dss_runtime_put end 0
[   21.480560] core suspend end 0
[   21.485137] PM: suspend of devices complete after 83.606 msecs
[   21.495483] PM: late suspend of devices complete after 4.089 msecs
[   21.502166] Disabling non-boot CPUs ...

Looks quite similar, but everything is done before "PM: suspend of
devices..." line. And resume works fine also.

 Tomi


--=-SHkrkRVTWLbBEBql2O90
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPDw13AAoJEPo9qoy8lh71pbcP/iS81BkjfAEYxNuZGKD5Tare
/VpOOEm9NCx1RMCBAlxnYkAXCQvKNeGN6bzOJNVt1RGFK4ifLleVd9tidh7QkKUn
65hKpoQFowDLIwWbsAxiV7DR8vpkZMQRXjfBUrCjO/xBqUOrpOTgaAHFcFKsEiDS
CPMyvsF7kXHvr9pSEC6CkDFO9du87XYb+Jy7tuynHW6IISZBnHoI82jaDpFQF/B2
UPD8aHA2ZELn7IAMG1+nLPjtA0bm7ImAEIlfqhoWd61RAsXzrctzyOvroDglqoEV
kGB5XMBbMPV0Zozzgrc830UMhAje4u7Bu9W8UDvJbTthdKKasnt51vFhjsuONXFt
qejLGWpLkOPXqpXo3GrmbfMNMF7hcgxPrKEB+vU3I1Tpe6/kDRi2VyzyQK+9Gw6q
qvAAtjyGnE8CE3wNs/fClkHHrGELws12xgNZ2iCDTdvqK3JQMbavRGtU+h/hzHqZ
XJyt3YKRREgZ+B5wJPSe0WgURzPfyv/wYbHNTpM6cjYIbQqCb4FvQX9/UHaAguta
e4n4ubOWqJXqu/uZq88LPM2H6nP1SM15rbRVwU6x8vx6NbQLu9lyknluMaIYPbnX
fOUOsiw+JgcU4PnJQIVToOJnbjeopwMHOMMoI65nfPUIWP7zw8ZENsXucCSFkFQS
yQYOHYG4WKdxcrbPCsVP
=BzE+
-----END PGP SIGNATURE-----

--=-SHkrkRVTWLbBEBql2O90--

