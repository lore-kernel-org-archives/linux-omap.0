From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
Date: Tue, 19 Feb 2013 20:34:20 +0200
Message-ID: <20130219183420.GA6851@arwen.pp.htv.fi>
References: <20130214175650.GA25891@arwen.pp.htv.fi>
 <20130214181217.GA11806@atomide.com>
 <20130214192719.GB26679@arwen.pp.htv.fi>
 <20130214193911.GD11806@atomide.com>
 <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
 <20130214222247.GE11362@atomide.com>
 <alpine.DEB.2.00.1302191516150.32069@utopia.booyaka.com>
 <20130219163820.GF5724@atomide.com>
 <20130219165753.GD5736@arwen.pp.htv.fi>
 <20130219174336.GG5724@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36723 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932825Ab3BSSe0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Feb 2013 13:34:26 -0500
Content-Disposition: inline
In-Reply-To: <20130219174336.GG5724@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Paul Walmsley <paul@pwsan.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 19, 2013 at 09:43:36AM -0800, Tony Lindgren wrote:
> > On Tue, Feb 19, 2013 at 08:38:20AM -0800, Tony Lindgren wrote:
> > > > > * Paul Walmsley <paul@pwsan.com> [130214 12:51]:
> > > > > > On Thu, 14 Feb 2013, Tony Lindgren wrote:
> > > > > >=20
> > > > > > > I don't think so as hwmod should only touch the sysconfig spa=
ce
> > > > > > > when no driver has claimed it.
> > > > > >=20
> > > > > > hwmod does need to touch the SYSCONFIG register during pm_runti=
me suspend=20
> > > > > > and resume operations, and during device enable and disable ope=
rations. =20
> > > > > > Here's the relevant code:
> > > > > >=20
> > > > > > http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.git;=
a=3Dblob;f=3Darch/arm/mach-omap2/omap_hwmod.c;h=3D4653efb87a2721ea20a9fe06a=
30a6c204d6d2282;hb=3DHEAD#l2157
> > > > > >=20
> > > > > > http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux.git;=
a=3Dblob;f=3Darch/arm/mach-omap2/omap_hwmod.c;h=3D4653efb87a2721ea20a9fe06a=
30a6c204d6d2282;hb=3DHEAD#l2195
> > > > >=20
> > > > > But that's triggered by runtime PM from the device driver, right?
> > > >=20
> > > > Yes - for devices with drivers, it will hopefully be called by the=
=20
> > > > driver.
> > > >=20
> > > > > I think it's fine for hwmod to do that as requested by the device
> > > > > driver via runtime PM since hwmod is the bus glue making the driv=
ers arch
> > > > > independent.
> > > > >=20
> > > > > I think the only piece we're missing for that is for driver to run
> > > > > something like pm_runtime_init() that initializes the address spa=
ce
> > > > > to hwmod.=20
> > > >=20
> > > > In the current design, we might be able to do this during the drive=
r's=20
> > > > first call to pm_runtime_get*().  I think that's the first point th=
at we=20
> > > > can hook into the PM runtime code.
> > >=20
> > > Sounds doable and generic for now.
> >=20
> > this isn't really a nice way IMHO. You will end up with drivers assuming
> > that certain details will be initialized whenever it calls
> > pm_runtime_get() for the first time. Then, for devices such as UART
> > which, when used as console, will not get pm_domain->runtime_resume()
> > called because pm_runtime_set_active() has been called right before.
> >=20
> > IOW, this will not work for all cases and very soon we will have bug
> > reports.
>=20
> Some generic way to init this from drivers is needed, I'm out of ideas
> here though.

that's fair, but exposing driver-specific details via a static inline in
a header which might or might not be called from hwmod isn't the best
choice IMHO.

the problems this could cause are numerous, specially when you consider
drivers which are shared among multiple architectures (think musb, dwc3,
ehci, ohci, xhci, ahci_platform, etc).

> > > > Once the hwmod code is moved out to be a bus, I'm hoping we can do =
this=20
> > > > through the driver making a dev->bus->enable_device() call - simila=
r to=20
> > > > the way PCI drivers call pci_enable_device(), but not bus-specific.=
  That=20
> > > > should remove our current dependency on CONFIG_PM_RUNTIME for OMAP =
devices=20
> > > > to work correctly :-(
> > > >=20
> > > > > Just to recap what we've discussed earlier, the reasons why we wa=
nt
> > > > > reset and idle functions should be in the driver specific header =
are:
> > > > >=20
> > > > > 1. There's often driver specific logic needed in addition to the
> > > > >    syconfig tinkering in the reset/idle functions.
> > > >=20
> > > > It's been a while since I last tabulated this.  But my recollection=
 was=20
> > > > that some kind of IP block-specific reset code is needed for about =
7% to=20
> > > > 10% of the OMAP IP blocks.
> > >=20
> > > Yes it's not too many, but the issue there is the driver specific code
> > > that's duplicated in both places. And sounds like the solution to that
> > > is to make driver specific reset code a static inline function in the
> > > driver header as discussed earlier so bus code can call it when there=
's
> > > no driver loaded.
> >=20
> > this wouldn't work. How would you write a reset for i2c which can be
> > called for all instances even when there is no driver loaded ? What
> > would be the arguments to such a call ?
> >=20
> > If you have something like:
> >=20
> > static inline void omap_i2c_reset(int bus_nr);
> >=20
> > you would need to keep track of the bus numbers even when there is no
> > driver around and if there is a driver, you would have to ask i2c-omap.c
> > to track all available instances and convert that number to the proper
> > struct omap_i2c pointer. None of those sound like a good plan IMO.
> >=20
> > From a driver perspective, we want all our calls to have our private
> > structure or a *dev as argument. Those are only avaiable when driver is
> > around and anything which doesn't take those as argument will force
> > driver to add extra unnecessary churn.
>=20
> If we cannot find a clean way to reset unclaimed devices without duplicat=
ing
> driver specific code at the bus level, then let's just assume the drivers=
=20
> need to probe to reset them even if the device is not used on a particular
> board.

that wouldn't work either. Whenever you have a product which wants to
optimize memory footprint, will start by disabling unused modules, then
all of your problems are back and we will start to receive bug reports
because of an artificial requirement created by OMAP ;-)

hwmod already has access to all device addresses, so why not reset early
when you build the omap device ?

How about this completely untested patch ? I guess it won't work because
I'm not making sure clocks are enabled for the particular hwmod to be
accessible, but it shows the idea:

diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_d=
evice.c
index e065daa..58de594 100644
--- a/arch/arm/mach-omap2/omap_device.c
+++ b/arch/arm/mach-omap2/omap_device.c
@@ -354,6 +354,13 @@ static int omap_device_build_from_dt(struct platform_d=
evice *pdev)
 			goto odbfd_exit1;
 		}
 		hwmods[i] =3D oh;
+
+		/*
+		 * reset all hwmods early on, but even if it fails to reset
+		 * let it go through, driver might still be able to recover.
+		 */
+		ret =3D omap_hwmod_reset(oh);
+		WARN(ret < 0, "%s failed to reset\n", oh->name);
 	}
=20
 	od =3D omap_device_alloc(pdev, hwmods, oh_cnt, NULL, 0);

> > > > One thing that's unclear to me for the DT case is how we'll bind th=
e=20
> > > > driver-specific parts of the reset code to the device, particularly=
 in the=20
> > > > case where there's no driver present.  It should be possible to pla=
ce an=20
> > > > initcall in the driver-specific header, but that seems like a hack.=
  Any=20
> > > > thoughts on this?
> > >=20
> > > I think we can just initialize the driver-specific reset functions
> > > in hwmod code and those can just call the driver specific inline func=
tions
> > > as needed in the driver specific header files.
> >=20
> > please don't. This will not work as you expect, we will just add more
> > special cases to drivers which will be even more complex to maintain.
> >=20
> > What you want is a generic reset callback somewhere. For cases where
> > there is no driver around, then I'm not sure what to do, but doing early
> > reset sounds like a better plan than late reset, so resetting on
> > omap_device_build_from_dt() sounds better IMHO, although it concerns me
> > cases of -EPROBE_DEFER and what that would mean in the long run...
>=20
> Well this problem too will disappear if we require the drivers to probe
> to reset things properly.

see above, you can't guarantee that, not to mention that this is a too
vague requirement. If a platform doesn't use a driver, why would they
enable it ? And how do you make sure that platform A needs the full
driver but platform B only needs it for a quick reset ? Why would we
allocate memory, IRQ, i/o memory space (ioremap), enable clocks and so
many more resources just for that ? Besides, that would already cause
problems since every DT node with status =3D "disabled" will not probe.

Changing DT data today to status =3D enabled by default won't cut since we
already lost control over DT data. I mean, we don't know which
bootloaders are supporting which DT version and relying on appended DTB
only will not work in the long run since the image will get too large
when you want to support multiplatform.

> Then the hwmod late_init would just be a printk warning about unclaimed
> devices.

is that even necessary ? No other architecture (not even other ARM SoCs)
make such distinction, why would we be different ?

> In any case, we should not reset things early unless requested from driver
> probe. Too many things can go wrong before we have a proper console
> available.

OTOH, initializing from a known state would be much, much better and
would force us to remove *all* bootloader dependencies.

We just need to figure out how to handle console until omap uart is
reset, but I guess 8250 is already taking care of that for us, right ?

--=20
balbi

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRI8WsAAoJEIaOsuA1yqREXZAP/2EHn9/mX1ozxSp1I34t0JNO
Y559yC32Q/FOM+Yd2BfgVJ7ylFX4aYqgzNpIKwhQhgUlO/bl/e9I2RCJsrexxFig
QHIJTxJeRmGL756SqsbvSEGOUQiV5+57lfIcBO+aVMGwzieMnm7UOflH17enrex7
Ukyf7cPHTv7Tap3+SQRp7Lbli6m0LrT1QSuPE1RzWXSqtXkYBT+zsOv9E4Nwc5Su
sOXvlzfyBANfUQLooGZuGma9Yhz3Kq1MQgE6BHCja06XAzEeYwXxAyCW5mmYdn+p
D03uHWY7uouR4tdnxxVa3WjzD9AKgL76BoN6K+fxw/j8AZZEneHkzyRTPWjMXLcI
j3dSuq7MiGCxBIvwA8ivWklbTfUXH7PaBxoH4pww1GuXeCJYFMiU9yDHCIiM1tm+
Wu+5HnJJlr/cO8G8j6Zqpzup9/g/waNYk/hIKMJ/TbHBGSSF2GpLeuT2w00I3+XH
LoSM5ru1WmNLXSm6NvjkWHmGF8SVGlZvxKzul27MrpQH/kdzKhabJyBOJ15i0JHJ
/9aUHZ8ErXT2Xu4q7x1tNiimSAvmU6XO5bID3tKAsE6u27U5guyLD/Jh4kjuhsGI
QlViItb5BTznuz/D+lJgF0RLJC3X/m0svs4iPkev9jDhx1p0okpreoBBKZ8WdAZp
YnKOwB6qdH1waPZQmY+Z
=u0ep
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
