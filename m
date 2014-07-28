From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP3/AM3517 EHCI USB Issue
Date: Mon, 28 Jul 2014 13:10:24 -0500
Message-ID: <20140728181024.GI7667@saruman.home>
References: <20140725200400.GB18127@sysresccd>
 <Pine.LNX.4.44L0.1407281059060.1183-100000@iolanthe.rowland.org>
 <20140728152948.GA28880@sysresccd>
 <20140728155718.GF7667@saruman.home>
 <20140728175739.GA29212@sysresccd>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3U8TY7m7wOx7RL1F"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48683 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750825AbaG1SLM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Jul 2014 14:11:12 -0400
Content-Disposition: inline
In-Reply-To: <20140728175739.GA29212@sysresccd>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Michael Welling <mwelling@emacinc.com>, Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Alan Stern <stern@rowland.harvard.edu>, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, heikki.krogerus@linux.intel.com, chris.ruehl@gtsys.com.hk, Roger Quadros <rogerq@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

--3U8TY7m7wOx7RL1F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2014 at 12:57:39PM -0500, Michael Welling wrote:
> On Mon, Jul 28, 2014 at 10:57:18AM -0500, Felipe Balbi wrote:
> > Hi,
> >=20
> > On Mon, Jul 28, 2014 at 10:29:49AM -0500, Michael Welling wrote:
> > > On Mon, Jul 28, 2014 at 11:02:47AM -0400, Alan Stern wrote:
> > > > On Fri, 25 Jul 2014, Michael Welling wrote:
> > > >=20
> > > > > The plot thickens....
> > > > >=20
> > > > > So if I run the above command before anything is plugged into the=
 ports
> > > > > the HUB disconnects.
> > > > >=20
> > > > > root@som3517:~# echo on > /sys/bus/usb/devices/1-1/power/control
> > > > > [   63.068839] usb 1-1: USB disconnect, device number 2
> > > > >=20
> > > > > Here is the output of the usbmon output when running the above co=
mmand:
> > > > > root@som3517:/sys/kernel/debug/usb/usbmon# cat 1t
> > > > > de382e40 3788886573 S Ci:001:00 s a3 00 0000 0001 0004 4 <
> > > > > de382e40 3788890604 C Ci:001:00 0 4 =3D 07050000
> > > > > de382e40 3788892965 S Ci:001:00 s a3 00 0000 0002 0004 4 <
> > > > > de382e40 3788893093 C Ci:001:00 0 4 =3D 00010000
> > > > > de382e40 3788894834 S Ci:001:00 s a3 00 0000 0003 0004 4 <
> > > > > de382e40 3788894958 C Ci:001:00 0 4 =3D 00010000
> > > > > de7d92c0 3788896519 S Ii:001:01 -115 4 <
> > > > > de382e40 3788898778 S Ci:001:00 s a3 00 0000 0001 0004 4 <
> > > > > de382e40 3788900188 C Ci:001:00 0 4 =3D 07050000
> > > > > de382e40 3788902705 S Co:001:00 s 23 01 0002 0001 0000 0
> > > > > de382e40 3788905793 C Co:001:00 0 0
> > > > > de382e40 3788940998 S Ci:001:00 s a3 00 0000 0001 0004 4 <
> > > > > de7d92c0 3788942065 C Ii:001:01 0 1 =3D 02
> > > > > de7d92c0 3788943013 S Ii:001:01 -115 4 <
> > > > > de382e40 3788943145 C Ci:001:00 0 4 =3D 03050400
> > > > > de382e40 3788961031 S Co:001:00 s 23 01 0012 0001 0000 0
> > > > > de382e40 3788961175 C Co:001:00 0 0
> > > > > de382e40 3788961304 S Ci:002:00 s 80 00 0000 0000 0002 2 <
> > > > > de382e40 3788965395 C Ci:002:00 -71 0
> > > > > de249040 3788966954 S Co:001:00 s 23 03 0004 0001 0000 0
> > > > > de249040 3788968362 C Co:001:00 0 0
> > > > > de249040 3789021103 S Ci:001:00 s a3 00 0000 0001 0004 4 <
> > > > > de7d92c0 3789022194 C Ii:001:01 0 1 =3D 02
> > > > > de7d92c0 3789022226 S Ii:001:01 -115 4 <
> > > > > de249040 3789023423 C Ci:001:00 0 4 =3D 01051200
> > > > > de249040 3789025010 S Co:001:00 s 23 03 0004 0001 0000 0
> > > > > de249040 3789026815 C Co:001:00 0 0
> > > > > de249040 3789230980 S Ci:001:00 s a3 00 0000 0001 0004 4 <
> > > > > de249040 3789231111 C Ci:001:00 0 4 =3D 00010300
> > > > > de249040 3789232280 S Co:001:00 s 23 01 0014 0001 0000 0
> > > > > de249040 3789232404 C Co:001:00 0 0
> > > > > de249040 3789233056 S Co:001:00 s 23 01 0001 0001 0000 0
> > > > > de249040 3789235345 C Co:001:00 0 0
> > > > > de249040 3789236820 S Co:001:00 s 23 01 0001 0001 0000 0
> > > > > de249040 3789237201 C Co:001:00 0 0
> > > > > de249040 3789238180 S Co:001:00 s 23 01 0001 0001 0000 0
> > > > > de249040 3789238510 C Co:001:00 0 0
> > > > > de249040 3789240602 S Ci:001:00 s a3 00 0000 0001 0004 4 <
> > > > > de249040 3789241661 C Ci:001:00 0 4 =3D 00010300
> > > > > de249040 3789242264 S Co:001:00 s 23 01 0010 0001 0000 0
> > > > > de249040 3789243921 C Co:001:00 0 0
> > > > > de249040 3789246540 S Co:001:00 s 23 01 0011 0001 0000 0
> > > > > de249040 3789246930 C Co:001:00 0 0
> > > > > de2490c0 3789283096 S Ci:001:00 s a3 00 0000 0001 0004 4 <
> > > > > de2490c0 3789286255 C Ci:001:00 0 4 =3D 00010000
> > > > > de2490c0 3789330975 S Ci:001:00 s a3 00 0000 0001 0004 4 <
> > > > > de2490c0 3789332606 C Ci:001:00 0 4 =3D 00010000
> > > > > de2490c0 3789371015 S Ci:001:00 s a3 00 0000 0001 0004 4 <
> > > > > de2490c0 3789371146 C Ci:001:00 0 4 =3D 00010000
> > > > > de2490c0 3789410975 S Ci:001:00 s a3 00 0000 0001 0004 4 <
> > > > > de2490c0 3789411097 C Ci:001:00 0 4 =3D 00010000
> > > > > de2490c0 3789450972 S Ci:001:00 s a3 00 0000 0001 0004 4 <
> > > > > de2490c0 3789451081 C Ci:001:00 0 4 =3D 00010000
> > > > > de7d92c0 3789452462 C Ii:001:01 -2 0
> > > > >=20
> > > > > Not sure what any of it means.
> > > >=20
> > > > Basically it means what you said above: the hub disconnected.  I ca=
n't=20
> > > > tell why.  You'll have to ask someone who's familiar with the hardw=
are=20
> > > > on that board.
> > >=20
> > > Sadly, there is no one more familar with this specific hardware than =
myself.
> > >=20
> > > I can however ellaborate the hardware setup of the USB subsystem in
> > > case there is someone out there that has used a similar setup.
> > >=20
> > > The board uses the AM3517 SoC from TI. The SoC's USB host port (HSUSB=
1) is
> > > connected to a USB3320 PHY. The PHY is connected to a USB2512 switch =
to
> > > provide two downstream USB ports.
> > >=20
> > > The very same hardware worked with the 2.6.37 kernel that I am trying=
 to
> > > move away from.
> > >=20
> > > Today I am going to try using 3.10 and 3.14 kernels see if they exhib=
it
> > > the same behavior.
> >=20
>=20
> It should be noted that the 3.10 kernel did not even detect the external
> HUB and the 3.14 kernel exhibits the same failure as 3.16.
>=20
> > Do you have off-while-idle enabled ? This could be, as Alan suggested, a
> > problem with remote wakeup. EHCI on TI parts is kinda awkward, if you
> > will, and getting remote wakeup with PM working, is generally a
> > challenge.
>=20
> How would one determine if off-while-idle is enabled? Is this a flag in an
> entry in the devicetree?

there is a pm_debug file on debugfs which you can use. Set autosuspend
delay to UART (it's set to -1 by default, IIRC), then leave the board
idle for a couple minutes, then read /sys/kernel/debug/pm_debug and see
if the OFF() counters are increasing.

Adding linux-omap to Cc. Also Tony, who has a simple script to enable
pm_runtime on UART.

--=20
balbi

--3U8TY7m7wOx7RL1F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT1pIQAAoJEIaOsuA1yqRE238P/0vdaAyWEOuNnee9RjPJZgpr
ltQb5Rk7ob3WcUfdPyv2jvZ8dKAMNSYaXKaGX5EXGm0/g66c5ZAQ0tORh0Dxnnm4
TuS4qF88N3CPRN+wtjlxOxosxz3GmPuuIGsYIddAIDBGPgiIJBBmGLvgGfL4xnO+
+RmzrCnl7UI6IjCCJw2iB1Lq+n+pt2oshBar2LbkpjcQ4oegULFA8srqVHAU+Pq9
Ryvp5aL/sz6VEySNUIAQnNDDb8iXRQYPju4tz5H4PK8rbu58QoCUTZhYMNPZF/0L
+vGAByMNt5p9Or/p4JeP70C9Y8PKYJkP1a6mrxmAuVm33xaVDjDiS7NCWkjXrZbz
QMn3uNm/AYS+flHXfvWGeQS63bcolSvewGjEl2a3vgWOkDgnR6OEb4NKnH8ABXyT
qDLzJtlJ9qHr/pv1f+fe7Ocy9GoPTApFt7jR7v+PNWZyBFrugestNEbYHSlggQ/f
13Cgp/p1g4jfZFstDmP8Sco2hZgRgAG2SlqF1NmuDZJD6xlbv64DH3cbJ73jRvz1
japRRlbJdh+bJsHeyJWRqQ25Mgliu3nG2htGSW19Jknb/g3BRmHDIGcmLyWowwzh
hsXQ1f24ncl69VOdKKv7WN+LkBXwAi2DECXTNIsMfGh6ZSwxPk+94AMU/xH6tGaf
CS0D0RuHHitnzWR0gYh9
=RKzC
-----END PGP SIGNATURE-----

--3U8TY7m7wOx7RL1F--
