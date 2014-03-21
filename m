From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC] possible removal of omap-serial
Date: Thu, 20 Mar 2014 21:52:38 -0500
Message-ID: <20140321025238.GA31610@saruman.home>
References: <20140320235210.GB26964@saruman.home>
 <20140321001228.GA18131@kroah.com>
 <20140321013557.GB29691@saruman.home>
 <20140321013729.GC29691@saruman.home>
 <20140321023646.GB17404@kroah.com>
 <CAOCHtYhwuAJy-=LJV=eFwzwqzDDPv5RngQ2dVJDOPhYT+J_Mvw@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37777 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759912AbaCUCyv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Mar 2014 22:54:51 -0400
Content-Disposition: inline
In-Reply-To: <CAOCHtYhwuAJy-=LJV=eFwzwqzDDPv5RngQ2dVJDOPhYT+J_Mvw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Robert Nelson <robertcnelson@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>

--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2014 at 09:45:42PM -0500, Robert Nelson wrote:
> On Thu, Mar 20, 2014 at 9:36 PM, Greg KH <gregkh@linuxfoundation.org> wro=
te:
> > On Thu, Mar 20, 2014 at 08:37:29PM -0500, Felipe Balbi wrote:
> >> On Thu, Mar 20, 2014 at 08:35:57PM -0500, Felipe Balbi wrote:
> >> > Hi,
> >> >
> >> > On Thu, Mar 20, 2014 at 05:12:28PM -0700, Greg KH wrote:
> >> > > On Thu, Mar 20, 2014 at 06:52:10PM -0500, Felipe Balbi wrote:
> >> > > > Hi folks,
> >> > > >
> >> > > > I've been toying with the idea of removing
> >> > > > drivers/tty/serial/omap-serial.c since that's, to put it bluntly=
, an
> >> > > > ungly copy of 8250 driver.
> >> > > >
> >> > > > The original concern was wrt suspend/resume but I think it'd be =
a far
> >> > > > better approach to implement runtime PM in 8250 and write a rath=
er small
> >> > > > 8250-omap.c glue (much like 8250-acorn.c or 8250-dw.c) just to g=
et the
> >> > > > OMAP-specific details out of the way.
> >> > > >
> >> > > > The question I have is: omap-serial.c calls the serial devnodes =
ttyO\d,
> >> > > > instead of ttyS\d so removing omap-serial.c would have a direct =
impact
> >> > > > in userland. I wonder if it's an acceptable "regression" conside=
ring
> >> > > > we'd be able to reuse 8250 gaining proper Flow Control support, =
proper
> >> > > > DMA support, years and years of bug-fixes, etc.
> >> > >
> >> > > Breaking device node names is a contentious issue for serial ports=
, I
> >> > > don't think you can do that :(
> >> >
> >> > would an upstream udev rule creating a symbolic link from ttyO to tt=
yS
> >> > be enough ?
> >> >
> >> > I didn't test this yet but I guess this is enough (?)
> >> >
> >> > KERNEL=3D=3D"ttyO[0-9]", GROUP=3D"dialout", SYMLINK+=3D"ttyS"
> >>
> >> or actually it should be to other way around, ttyS would be the real
> >> device:
> >>
> >> KERNEL=3D=3D"ttyS[0-9]", GROUP=3D"dialout", SYMLINK+=3D"ttyO"
> >
> > As udev rules don't ship with the kernel, this might be tough to do :(
> >
> > Might be easier to make the 8250 driver handle different "names" like
> > Alan said.

I'll see if I find a way to avoid that or at least see if we find any
other way of creating a symlink... In any case, just switching back to
8250, even if just maintaining ttyO name, is already a big benefit.

> On the support side, I'm not looking forward to this for beagle/panda
> users.  We've already converted them once from ttySx -> ttyOx back in
> 2.6.33/2.6.34? days.  That was an irc/email/u-boot/kernel nightmare...

that's exactly why we're talking about ways to maintain backwards
compatibility here. But I'm more interested in finding a way to switch
over to ttyS and have a symlink to ttyO, that way a simple debootstrap
(or any other ARM distro minimal rootfs) would work out of the box,
without any changes, just like in "normal" systems.

--=20
balbi

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTK6l2AAoJEIaOsuA1yqREtBsQALFZOVDZxjvzRRD2frBIO8oS
trNtQfIxcfO/l6XEcaRRkNTqdRC9JwCpHdu1ZZqCQLasVrtK8ospgOsjYsxpaB3R
oaSHyGJJcTOj6mgvnFznytEM9p+mp6y0MIQTRkXILB+qhEYif6pzWiZ7RjVofwOw
oSdmG2uupGbNwwXrrUVpz4D1eFUC5aOwMQaPmga/E8ECKkQDkDhGsq+XLCFU1eI9
RmZGmdVBpGFT6m8Hh1t8sCMFw/b0jUCkzFjIFas459tJUQDbnVaZs+j4vihNqWx4
egvhRt0tHHWyv8dtg1pMMxI5ly+3a8c20Yt5hpA8Cz7TmPtCeF4SdKq1C0cUwjQ+
rwVtQc4zYzRtSW7/W6o4SPMfKfSkyiscgS/3KKosWRJQOn+2C2l4ZK+8bfV3qE36
LYy6LSU4sL0/1uPpj3Y5d0NYRbABpW+Rrl+bx2WZAV/G5wJIwrDxORlrVi7i7LM9
JPfHc9S6HffnWX+6EURCpbMNxgUT8Xa/ndT6YjPhwQDC/KxogWKdkKpzOEGQNUek
gqYRCXv9VgLbcrcT83ayvf2fCiYdYmy8XKl79PcZI4Y+c2+E87fHopCCVnnyeiZz
k7f1SytgKCFTRMnKUehQkmyYL1MyzWwLTSe5qB1m9kwyBAU/hv/C1RYVpx1q+xCu
w2CkYFFByTndR8Om9KFs
=dffn
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
