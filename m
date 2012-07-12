From: "Joe Woodward" <jw@terrafix.co.uk>
Subject: Re: PM/RTC 3.5-rc5: System suspends fails when not built with RTC?
Date: Thu, 12 Jul 2012 15:43:08 +0100
Message-ID: <WC20120712144308.86003F@terrafix.co.uk>
References: <WC20120712081507.600002@terrafix.co.uk> <alpine.DEB.2.00.1207120456100.25585@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp3.keele.netcentral.co.uk ([212.57.235.197]:50051 "EHLO
	smtp3.keele.netcentral.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932530Ab2GLOnX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 12 Jul 2012 10:43:23 -0400
In-Reply-To: <alpine.DEB.2.00.1207120456100.25585@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>, "linux-omap\\@vger.kernel.org" <linux-omap@vger.kernel.org>

-----Original Message-----
=46rom: Paul Walmsley <paul@pwsan.com>
To: Joe Woodward <jw@terrafix.co.uk>
Cc: Kevin Hilman <khilman@ti.com>, "linux-omap\\@vger.kernel.org" <linu=
x-omap@vger.kernel.org>
Date: Thu, 12 Jul 2012 04:59:09 -0600 (MDT)
Subject: Re: PM/RTC 3.5-rc5: System suspends fails when not built with =
RTC?

>=20
> Hi Joe
>=20
> can you give this one a try to see if it helps:
>=20
> http://marc.info/?l=3Dlinux-omap&m=3D134209072829531&w=3D2
>=20
>=20
> - Paul

Hi Paul,

I've applied this on top of Kevin's PM branch, along with Kevin's ads78=
46 fix:
http://www.spinics.net/lists/linux-omap/msg73717.html

I think this has fixed the following warning:
[    0.000000] clockdomain: mpu_clkdm: powerdomain =AC=F5`=C08=BAs=C0 d=
oes not exist
=20
But when I try and suspend I still get the same problems:
# echo mem > /sys/power/state
[   13.283935] PM: Syncing filesystems ... done.
[   13.300537] Freezing user space processes ... (elapsed 0.01 seconds)=
 done.
[   13.324859] Freezing remaining freezable tasks ... (elapsed 0.02 sec=
onds) done.
[   13.356140] Suspending console(s) (use no_console_suspend to debug)
[   13.487823] PM: suspend of devices complete after 120.578 msecs
[   13.491577] PM: late suspend of devices complete after 3.722 msecs
[   13.497375] PM: noirq suspend of devices complete after 5.767 msecs
[   13.497436] Disabling non-boot CPUs ...
[   15.806640] Powerdomain (iva2_pwrdm) didn't enter target state 1
[   15.806640] Powerdomain (dss_pwrdm) didn't enter target state 1
[   15.806671] Powerdomain (per_pwrdm) didn't enter target state 1
[   15.806671] Powerdomain (core_pwrdm) didn't enter target state 1
[   15.806671] Powerdomain (usbhost_pwrdm) didn't enter target state 1
[   15.806671] Could not enter target state in pm_suspend
[   15.809722] PM: noirq resume of devices complete after 2.868 msecs
[   15.813598] PM: early resume of devices complete after 2.380 msecs
[   16.179382] mmc1: error -110 during resume (card was removed?)
[   16.189575] PM: resume of devices complete after 375.824 msecs
[   16.279602] Restarting tasks ... done.
sh: write error: Operation not permitted

Cheers,
Joe

> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
