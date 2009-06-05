From: "Wang Sawsd-A24013" <cqwang@motorola.com>
Subject: RE: PM error: Powerdomain (core_pwddm) didn't enter target state 1
Date: Fri, 5 Jun 2009 23:42:46 +0800
Message-ID: <B00E06E2766C2744B022DE9BAF3C59D5372EE6@zmy16exm69.ds.mot.com>
References: <42B46BA8-AF35-42B5-9616-EADA31EF0553@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail153.messagelabs.com ([216.82.253.51]:45746 "EHLO
	mail153.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbZFEPn3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 11:43:29 -0400
Received: from il27exr04.cig.mot.com ([10.17.196.73])
	by motgate5.mot.com (8.14.3/8.14.3) with ESMTP id n55FhURC017874
	for <linux-omap@vger.kernel.org>; Fri, 5 Jun 2009 08:43:30 -0700 (MST)
Received: from az10vts04.mot.com (il27vts04.cig.mot.com [10.17.196.88])
	by il27exr04.cig.mot.com (8.13.1/Vontu) with SMTP id n55FhUYh010907
	for <linux-omap@vger.kernel.org>; Fri, 5 Jun 2009 10:43:30 -0500 (CDT)
Received: from zmy16exm69.ds.mot.com (zmy16exm69.ap.mot.com [10.179.4.36])
	by il27exr04.cig.mot.com (8.13.1/8.13.0) with ESMTP id n55FhS2I010892
	for <linux-omap@vger.kernel.org>; Fri, 5 Jun 2009 10:43:29 -0500 (CDT)
Content-class: urn:content-classes:message
In-Reply-To: <42B46BA8-AF35-42B5-9616-EADA31EF0553@mac.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Elvis Dowson <elvis.dowson@mac.com>, Kevin Hilman <khilman@deeprootsystems.com>
Cc: Linux OMAP Users <linux-omap@vger.kernel.org>

=20

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org=20
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Elvis Dowson
> Sent: 2009=C4=EA6=D4=C25=C8=D5 15:33
> To: Kevin Hilman
> Cc: Linux OMAP Users
> Subject: PM error: Powerdomain (core_pwddm) didn't enter=20
> target state 1
>=20
> Hi Kevin,
> 		  I managed to successfully incorporate all=20
> your PM patches to the =20
> linux-omap-2.6 master branch, for the gumstix overo earth (TI OMAP =20
> 3503). I am currently using it with Tomi's DSS2 (not the full=20
> set, but =20
> the dss2.patch that comes with the overo openembedded repository.
>=20
> When the device goes to suspend mode, and I immediately touch the =20
> touch screen, to wake it up, two things happen:
>=20
> a. it wakes up and immediately goes back to suspend.
> b. if I touch it once more, a bit longer this time, it wakes up.
It seems you are running Android, I guess the frist time you just got a=
n IOPAD wakeup
Which wakes up the HW, the second time you got the touch event and repo=
rt
It to the upper layer SW, so the UI is woken up.

>=20
> However, in the console, I see the following error message:
>=20
> request_suspend_state: wakeup (3->0) at 14677886951 (2000-01-01 =20
> 00:01:16.457611018 UTC)
> request_suspend_state: sleep (0->3) at 76534332261 (2000-01-01 =20
> 00:02:18.314025810 UTC)
> PM: Syncing filesystems ... done.
> Freezing user space processes ... (elapsed 0.00 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
> Suspending console(s) (use no_console_suspend to debug)
> PM: suspend devices took 0.226 seconds
> Powerdomain (mpu_pwrdm) didn't enter target state 1
> Powerdomain (neon_pwrdm) didn't enter target state 1
> Powerdomain (core_pwrdm) didn't enter target state 1
> Powerdomain (cam_pwrdm) didn't enter target state 1
> Powerdomain (per_pwrdm) didn't enter target state 1
> Powerdomain (usbhost_pwrdm) didn't enter target state 1
> Could not enter target state in pm_suspend
> wakeup wake lock: mmc_delayed_work
> mmc1: mmc_rescan - card ocr from io_op=3D0x00000000, err =3D -110
> PM: resume devices took 0.531 seconds
> Restarting tasks ... <7>hub 1-0:1.0: state 7 ports 1 chg 0000 evt 000=
0
> done.
> suspend: exit suspend, ret =3D 0 (2000-01-01 00:02:24.561462403 UTC)
> PM: Syncing filesystems ... done.
> Freezing user space processes ... (elapsed 0.00 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.00 seconds) done.
>=20
>=20
> What do these error messages indicate ?
It means most of the power domains didn't enter RETENTION in your case,
It is so strange that even your MPU didn't hit RETENTION state.
Did you set any SLEEP dependency on some other power domains for MPU?

>=20
> Best regards,
>=20
> Elvis
> --
> To unsubscribe from this list: send the line "unsubscribe=20
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
