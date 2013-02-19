From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
Date: Tue, 19 Feb 2013 18:57:53 +0200
Message-ID: <20130219165753.GD5736@arwen.pp.htv.fi>
References: <1360840554-26901-2-git-send-email-balbi@ti.com>
 <20130214171253.GC7144@atomide.com>
 <20130214175650.GA25891@arwen.pp.htv.fi>
 <20130214181217.GA11806@atomide.com>
 <20130214192719.GB26679@arwen.pp.htv.fi>
 <20130214193911.GD11806@atomide.com>
 <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
 <20130214222247.GE11362@atomide.com>
 <alpine.DEB.2.00.1302191516150.32069@utopia.booyaka.com>
 <20130219163820.GF5724@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NtwzykIc2mflq5ck"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58876 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932600Ab3BSQ57 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Feb 2013 11:57:59 -0500
Content-Disposition: inline
In-Reply-To: <20130219163820.GF5724@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--NtwzykIc2mflq5ck
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 19, 2013 at 08:38:20AM -0800, Tony Lindgren wrote:
> > > * Paul Walmsley <paul@pwsan.com> [130214 12:51]:
> > > > On Thu, 14 Feb 2013, Tony Lindgren wrote:
> > > >=20
> > > > > I don't think so as hwmod should only touch the sysconfig space
> > > > > when no driver has claimed it.
> > > >=20
> > > > hwmod does need to touch the SYSCONFIG register during pm_runtime s=
uspend=20
> > > > and resume operations, and during device enable and disable operati=
ons. =20
> > > > Here's the relevant code:
> > > >=20
> > > > http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.git;a=3D=
blob;f=3Darch/arm/mach-omap2/omap_hwmod.c;h=3D4653efb87a2721ea20a9fe06a30a6=
c204d6d2282;hb=3DHEAD#l2157
> > > >=20
> > > > http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.git;a=3D=
blob;f=3Darch/arm/mach-omap2/omap_hwmod.c;h=3D4653efb87a2721ea20a9fe06a30a6=
c204d6d2282;hb=3DHEAD#l2195
> > >=20
> > > But that's triggered by runtime PM from the device driver, right?
> >=20
> > Yes - for devices with drivers, it will hopefully be called by the=20
> > driver.
> >=20
> > > I think it's fine for hwmod to do that as requested by the device
> > > driver via runtime PM since hwmod is the bus glue making the drivers =
arch
> > > independent.
> > >=20
> > > I think the only piece we're missing for that is for driver to run
> > > something like pm_runtime_init() that initializes the address space
> > > to hwmod.=20
> >=20
> > In the current design, we might be able to do this during the driver's=
=20
> > first call to pm_runtime_get*().  I think that's the first point that w=
e=20
> > can hook into the PM runtime code.
>=20
> Sounds doable and generic for now.

this isn't really a nice way IMHO. You will end up with drivers assuming
that certain details will be initialized whenever it calls
pm_runtime_get() for the first time. Then, for devices such as UART
which, when used as console, will not get pm_domain->runtime_resume()
called because pm_runtime_set_active() has been called right before.

IOW, this will not work for all cases and very soon we will have bug
reports.

> > Once the hwmod code is moved out to be a bus, I'm hoping we can do this=
=20
> > through the driver making a dev->bus->enable_device() call - similar to=
=20
> > the way PCI drivers call pci_enable_device(), but not bus-specific.  Th=
at=20
> > should remove our current dependency on CONFIG_PM_RUNTIME for OMAP devi=
ces=20
> > to work correctly :-(
> >=20
> > > Just to recap what we've discussed earlier, the reasons why we want
> > > reset and idle functions should be in the driver specific header are:
> > >=20
> > > 1. There's often driver specific logic needed in addition to the
> > >    syconfig tinkering in the reset/idle functions.
> >=20
> > It's been a while since I last tabulated this.  But my recollection was=
=20
> > that some kind of IP block-specific reset code is needed for about 7% t=
o=20
> > 10% of the OMAP IP blocks.
>=20
> Yes it's not too many, but the issue there is the driver specific code
> that's duplicated in both places. And sounds like the solution to that
> is to make driver specific reset code a static inline function in the
> driver header as discussed earlier so bus code can call it when there's
> no driver loaded.

this wouldn't work. How would you write a reset for i2c which can be
called for all instances even when there is no driver loaded ? What
would be the arguments to such a call ?

If you have something like:

static inline void omap_i2c_reset(int bus_nr);

you would need to keep track of the bus numbers even when there is no
driver around and if there is a driver, you would have to ask i2c-omap.c
to track all available instances and convert that number to the proper
struct omap_i2c pointer. None of those sound like a good plan IMO.

=46rom a driver perspective, we want all our calls to have our private
structure or a *dev as argument. Those are only avaiable when driver is
around and anything which doesn't take those as argument will force
driver to add extra unnecessary churn.

> > One thing that's unclear to me for the DT case is how we'll bind the=20
> > driver-specific parts of the reset code to the device, particularly in =
the=20
> > case where there's no driver present.  It should be possible to place a=
n=20
> > initcall in the driver-specific header, but that seems like a hack.  An=
y=20
> > thoughts on this?
>=20
> I think we can just initialize the driver-specific reset functions
> in hwmod code and those can just call the driver specific inline functions
> as needed in the driver specific header files.

please don't. This will not work as you expect, we will just add more
special cases to drivers which will be even more complex to maintain.

What you want is a generic reset callback somewhere. For cases where
there is no driver around, then I'm not sure what to do, but doing early
reset sounds like a better plan than late reset, so resetting on
omap_device_build_from_dt() sounds better IMHO, although it concerns me
cases of -EPROBE_DEFER and what that would mean in the long run...

--=20
balbi

--NtwzykIc2mflq5ck
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRI68RAAoJEIaOsuA1yqRE61UQAKF5VegtmY4ZnLnOGvavsgCJ
4XGzZiC6vBVis9j6QeO/0ZuZ8d7qdAkeRxao0bqkx4OJcZvnU6rbYl+q8PrnRg+T
pDrP7WssaRkbSjQJg9JljcGAwPn5MUZBlLDlLEgrvxn6B7xtvV9lk8PryyHQpWDi
1O5vz438PcDPcdGcdSXGWUbm2SCLG+qvrMH/GBAYE3GNaS4DpY9LCsmC2Sn22PjB
ysbC20K/K//U95nAMsm3sB0z0LVCaAmKIL+BxNhkJiLL0B41nXPPg2vW9hM4+nSF
x73e5r3UJDA8u2kzi1OnELskEG0YVq5XMWxLMDCGV7zry4zTP9CcC7QWp7iBzNXH
QS3V+K8eOo0nX35vYiN4hsSoZ5med+VJs6a+JDO7bYVBiUeySiRjDN85tD005/80
Bo0uNILKa56a8oWdKxS9wtZPK4tVq2a8VXJ0ZnIKFPRe326j5IWW0PLwG8x+9vfB
ALkFRSHzvBH3e5UBikYnqId9MaVO23XcTYK7goNrPLcLfKXUx0Z7mCAI8XFYoo/y
HnRel294TGTwaFGimIqb/uHoYUTrHh2bAXHq7/AHLRcPfmaS9l6dzAcy636wceVl
5jUZpVQSVS9tvaSry+MVvtCI3NbIThBLitAdgUnImSgiUbJ39rkrfw/Edc8TnM1E
otXiVEKJAqkPCB5TKS4Q
=M+HU
-----END PGP SIGNATURE-----

--NtwzykIc2mflq5ck--
