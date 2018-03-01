From: Merlijn Wajer <merlijn@wizzup.org>
Subject: usb: musb: "(null)" in sysfs mode file after disabling a gadget (and
 at other times, system hangs)
Date: Fri, 2 Mar 2018 00:47:07 +0100
Message-ID: <f7a8cfac-e70b-046a-b465-7b37630d5d86@wizzup.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oppHN8720nJDSW0moTFny67VymaCCNuFA"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bin Liu <b-liu@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oppHN8720nJDSW0moTFny67VymaCCNuFA
Content-Type: multipart/mixed; boundary="92YCC1hftCZSStZab6Cetqmpq8LUyXBGQ";
 protected-headers="v1"
From: Merlijn Wajer <merlijn@wizzup.org>
To: Bin Liu <b-liu@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>,
 Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, linux-omap@vger.kernel.org
Message-ID: <f7a8cfac-e70b-046a-b465-7b37630d5d86@wizzup.org>
Subject: usb: musb: "(null)" in sysfs mode file after disabling a gadget (and
 at other times, system hangs)

--92YCC1hftCZSStZab6Cetqmpq8LUyXBGQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi,

I found that the "mode" file in musb sys node will return "(null)" when
one would expect it show b_idle.

Wrong /mode file:

[Fresh boot, cable not connected yet]
root@n900devuan:~# modprobe g_nokia
[Insert cable connected to PC]
root@n900devuan:~# cat
/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto/m=
ode
b_peripheral
[Remove cable connected to PC]
root@n900devuan:~# cat
/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto/m=
ode
b_idle
root@n900devuan:~# rmmod g_nokia
root@n900devuan:~# cat
/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto/m=
ode
(null)
[Insert cable connected to PC]
root@n900devuan:~# cat
/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto/m=
ode
b_idle

I would expect it to state "b_idle" instead of "(null)".
I have also been able to reproduce this "(null)" state using only
configfs (and not deprecated g_nokia module), but this example is more
cumbersome to write up)


Sometimes it crashes the entire system (reproducibly):

[Fresh boot, USB cable connect to PC at all times]
root@n900devuan:~# cat
/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto/m=
ode
b_idle
root@n900devuan:~# modprobe g_nokia
root@n900devuan:~# cat
/sys/devices/platform/68000000.ocp/480ab000.usb_otg_hs/musb-hdrc.0.auto/m=
ode
b_peripheral
root@n900devuan:~# rmmod g_nokia
(Hangs, reboots after a few seconds, probably due to watchdog)


This occurs on Nokia N900 (RX-51). Kernel config has:

CONFIG_USB_LIBCOMPOSITE=3Dm
CONFIG_USB_F_*=3Dm
CONFIG_USB_G_*=3Dm

I don't have a trace because I don't have a serial on my Nokia N900. I
have not yet tested this on other musb devices, but I can do that if
that helps reproducing the issue.

Cheers,
Merlijn


--92YCC1hftCZSStZab6Cetqmpq8LUyXBGQ--

--oppHN8720nJDSW0moTFny67VymaCCNuFA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQRM5LT7NbLF9yb6a/UGN09rynK8WgUCWpiQ+wAKCRAGN09rynK8
WtVMAP4himSJrs3BWzRBvU2MnT/2LcIYc63PBQE7RKE03uB4FwD/Rgjdw0KyeEDX
z2D6zNvYfN/0ssZE3v4vQ7ig7W4H/go=
=wlPG
-----END PGP SIGNATURE-----

--oppHN8720nJDSW0moTFny67VymaCCNuFA--
