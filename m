From: Felipe Balbi <balbi@ti.com>
Subject: Re: MUSB regression in linux next at least for pandboard
Date: Wed, 6 Feb 2013 17:29:09 +0200
Message-ID: <20130206152909.GE6773@arwen.pp.htv.fi>
References: <20121004173107.GD3874@atomide.com>
 <20121004175742.GB9702@arwen.pp.htv.fi>
 <20121005013910.GI3874@atomide.com>
 <20121005162717.GL3874@atomide.com>
 <CAFp+6iEQ85EEt2m7f8WSo8y7te62O_R4iia3_xiSMjzLXrAy5g@mail.gmail.com>
 <20130206135126.GA6773@arwen.pp.htv.fi>
 <511270C8.70105@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DO5DiztRLs659m5i"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51987 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756620Ab3BFP3Q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Feb 2013 10:29:16 -0500
Content-Disposition: inline
In-Reply-To: <511270C8.70105@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: balbi@ti.com, Vivek Gautam <gautamvivek1987@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-usb@vger.kernel.org, "ABRAHAM, KISHON VIJAY" <kishon@ti.com>, linux-omap@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>

--DO5DiztRLs659m5i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 06, 2013 at 05:03:36PM +0200, Roger Quadros wrote:
> On 02/06/2013 03:51 PM, Felipe Balbi wrote:
> > Hi,
> >=20
> > On Wed, Feb 06, 2013 at 05:27:52PM +0530, Vivek Gautam wrote:
> >> Hi Tony,
> >>
> >>
> >> On Fri, Oct 5, 2012 at 9:57 PM, Tony Lindgren <tony@atomide.com> wrote:
> >>> * Tony Lindgren <tony@atomide.com> [121004 18:41]:
> >>>>>
> >>>>>> Also on the EHCI port, I've seen issues where unplugging
> >>>>>> the cable hangs kernel with an infinite loop. But that happens
> >>>>>> only occasionally, sorry does not seem to happen right
> >>>>>> now so no output to paste here. Or maybe this issue
> >>>>>> has already been fixed?
> >>>
> >>> Looks like the system eventually recovers from the EHCI issue
> >>> after about fivew minutes or so of spamming the logs. It seems
> >>> the ehci-omap errors are:
> >>>
> >>> [62934.201538] ehci-omap ehci-omap.0: detected XactErr len 0/8 retry =
31
> >>> [62934.201660] ehci-omap ehci-omap.0: devpath 1.3.7 ep0out 3strikes
> >>> [62934.201873] ehci-omap ehci-omap.0: reused qh ea5632c0 schedule
> >>>
> >>> More data below.
> >>>
> >>
> >> Is this issue fixed ?
> >> Actually we too are getting very similar issue with samsung exynos5250=
 hardware.
> >> With latest 'usb-next' kernel and supporting arch patches, when i use
> >> following test scenerio:
> >> Connect a USB 2.0 external hub to USB 2.0 port, and connect mice or
> >> keyboard enumeration and
> >> functionality is fine but once disconnecting the HID we get to see the
> >> error log:
> >> hid-generic 0003:04B3:3025.0002: can't reset device,
> >> s5p-ehci-1.3/input0, status -71
> >>
> >> When i tried to enable CONFIG_USB_DEBUG, get the following log:
> >=20
> > looks like it's not OMAP-specific. Alan any tips ?
> >=20
>=20
> I can't reproduce the problem on Panda, but I can on Beagle with a slight=
ly
> different behaviour.
>=20
> 1) connecting/disconnecting device directly to the beagleboard's USB port=
 works fine.
>=20
> 2) If I connect a USB Hub to the port and connect a device to it after th=
e hub has
> autosuspended, the device is never detected.
> doing lsusb after that triggers the detection and produces a lot of trans=
action errors.
> Beagle log is below, before and after 'lsusb'
>=20
> I suppose this doesn't affect Panda because it has a hub connected immedi=
ately below the
> root hub that never suspends (as ethernet is hardwired to it).

Roger, try changing hub's autosuspend delay to something greater than
30ms and see if it helps. There was a discussion lately about that.

--=20
balbi

--DO5DiztRLs659m5i
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJREnbFAAoJEIaOsuA1yqREp7MQAIEG7bPs9IzOF4igekzkdgrp
g1CTLq6kjtrqncLc7co/azAulYCpxOIsP1QV4F17kRjoIjMg2g+QgOMo4i5QUpZn
3PRBxguXWeZN2ItLHvYftadsF92t0A86NCOxDFFtGL0lvBF/FsSr4ofTMnZvymAk
UDE3H8N7yHbc35UtxQ7r/usNUu6tYoBiKkQY3BZsDQYMeabVZOF0DYmbIfvgjsGl
NnfY9aJuttlo/BUBhqTRGrLZmI1yyw//U1sxxBamZ3rNvq3vihahDBUd54f/KOSv
B2qKuzn8T7vLF4eWEMzqpMoE0fvmLlalbS7QCqHvQKpHVN9Q7ov1MafVMYWr2BqH
k2tHc6yUEpOxFU54P407gPyzfrdei+6JB0BpBUB27co0Uxxp5bJxyDgkZX9fy3AW
YCskwPNwGFGkMy6535T4UieBgPcL+Mt+o6/7/bYwClseIbYramF85A7QmxsZT9YW
7ZppXL2wUE5hl1oRz7lw81aJ9lImS/Cok1lYWQXvDDRqltMYkCqe/nrNz75sYYzk
GTDPin9z9mEQHt6KkOejQ+HlXzhsmIhoFpfxFGWHKy4b3ywoBSjnQr1VvOl3myRz
vbSmB6pRGc0GXZnXBHxqBSGg9ea9sFqkywkQtDpylJph9+ZTz5CWoD5Tk7BzYypT
ZF3lMxJpkWfzdv1isLIN
=uhTl
-----END PGP SIGNATURE-----

--DO5DiztRLs659m5i--
