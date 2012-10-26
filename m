From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 1/3] usb: dwc3: Add the suspend/resume functionality
Date: Fri, 26 Oct 2012 11:13:16 +0300
Message-ID: <20121026081316.GB23501@arwen.pp.htv.fi>
References: <20121018150009.GT5378@xanatos>
 <Pine.LNX.4.44L0.1210181244080.1495-100000@iolanthe.rowland.org>
 <20121018172936.GB7823@arwen.pp.htv.fi>
 <CAD025ySWpF-_o4K030Sib2NsZXA3Qcw0MN8qpTZhPn4OR170EQ@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34157 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932142Ab2JZITI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Oct 2012 04:19:08 -0400
Content-Disposition: inline
In-Reply-To: <CAD025ySWpF-_o4K030Sib2NsZXA3Qcw0MN8qpTZhPn4OR170EQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikas Sajjan <vikas.sajjan@linaro.org>
Cc: balbi@ti.com, Alan Stern <stern@rowland.harvard.edu>, Sarah Sharp <sarah.a.sharp@linux.intel.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, gregkh@linuxfoundation.org, joshi@samsung.com, kishon@ti.com, Abhilash Kesavan <a.kesavan@samsung.com>, Doug Anderson <dianders@chromium.org>

--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 26, 2012 at 10:34:22AM +0530, Vikas Sajjan wrote:
> Hi Felipe,
>=20
> On 18 October 2012 22:59, Felipe Balbi <balbi@ti.com> wrote:
> > Hi,
> >
> > On Thu, Oct 18, 2012 at 12:44:50PM -0400, Alan Stern wrote:
> >> On Thu, 18 Oct 2012, Sarah Sharp wrote:
> >>
> >> > For system suspend while the DW3 hardware is in host mode, doesn't t=
he
> >> > USB core prevent drivers from submitting URBs just before the
> >> > PCI/platform suspend is called?  Alan?
> >>
> >> Sure it does.
> >
> > ok great, so my concerns is limited to the gadget side ;-) I still want
> > to see both sides tested, though.
> >
> > (sorry guys, but with DWC3 now passing full USB3 certification, I want
> > to be very careful with patches I accept, specially related to PM ;-)
> >
> > --
> > balbi
>=20
> Will test both HOST and GADGET mode as per your suggestion and update you.

cool, thanks. Hope we can still make it to v3.8. I guess we have about 2
weeks (maybe 3) to get code to Greg so it soaks in linux-next long
enough before the merge window opens.

--=20
balbi

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQikYcAAoJEIaOsuA1yqRE3pMP/1DgH9JvIUfO3sfZrjihML0w
0iG7elkjuy/8FfVUaEvGhuDNTzZGtxVAuHW3UUXQKCCqudfvTL5afjGx0HkIuTMZ
Hpdhn3XQsszkDX+iT40pKmUyHtFMPPOSvFjyvEMr+2T7PVtRUP6pELrUuKdrNtM4
OMihLKoi4kM0txa4XR9LWHjTbg3Fa4WD/As/gBjh0TmPvVTZ49d1hNWl3Z5ukYG/
9JjHNPw+ryxPyzSFjUIxzDm3/ATOh7jGxPUmQvIhmf0YD08bqmapV5OxJtgKRz+T
0qVlRCU5E+GGQoswxKcTchvX1VsF1h3djTPqJ3hzPh09pP2eYn3j8BkhqRS4Senq
8OpxPcr2ZKtYqlfklYAxcA0NzzjtbSr/1FGnJ3dhQfuykRQdGtxatmZj73tGqSX2
S+rmt3fjjmMqdRoSxrvPSDUOgeRYUPKIsfSfTP3tn+9lmwd6MvkooQqHagukPepX
V6iroNYb5VUSyYGekkwM83tD9zrXlse+AphOcCkGrNpO+ZGiTelXHcgZ3r7Nr89C
HVd4hKOwKWUDSyJ5MGVGuTjN6WrzhwZQ3noeCWKieBnQTnw0v3iJDxoEQMyl8P3/
8i6K2f2VQP5D4/g9Xr1Z6saTYtkKG0QsvfVTGOmU/IZVs3PAWbyhgmyXOnJcTO+N
eri1a4V7rRnljRH8Tb3V
=ZSnG
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--
