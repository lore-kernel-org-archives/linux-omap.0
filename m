From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH/RFC] ARM: OMAP: MUSB: disable omap_device auto-suspend
Date: Tue, 31 Jan 2012 09:37:39 +1100
Message-ID: <20120131093739.0d5b57ee@notabene.brown>
References: <1322528190-9274-1-git-send-email-khilman@ti.com>
	<20111207064954.GD32368@legolas.emea.dhcp.ti.com>
	<87k468w4v4.fsf@ti.com>
	<CANOLnOM-V4SFSL7+-ji00fJBu8TC06-pSNWZXA36pqW=4YGFQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/1epC_C7/l=33w+ImABITVlE"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59467 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752619Ab2A3WiR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jan 2012 17:38:17 -0500
In-Reply-To: <CANOLnOM-V4SFSL7+-ji00fJBu8TC06-pSNWZXA36pqW=4YGFQQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Kevin Hilman <khilman@ti.com>, balbi@ti.com, linux-omap@vger.kernel.org

--Sig_/1epC_C7/l=33w+ImABITVlE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 30 Jan 2012 00:57:13 +0200 Grazvydas Ignotas <notasas@gmail.com>
wrote:

> Hello,
>=20
> I've been trying to get suspend working with musb compiled in on 3.2.
> It seems both patches from this thread are needed, Kevin's patch stops
> omap2430_runtime_suspend() from being called at inappropriate time
> (when i2c is suspended [1]) and Felipe's patch brings that call back
> at better time (when i2c is still active). Perhaps they can be applied
> now, as current state crashes for me (see [1])?
>=20
> However there is a new issue with these patches applied, core_pwrdm no
> longer enters low power state, but I think I've found why. After
> omap_device_disable_idle_on_suspend() call, _od_suspend_noirq()
> function in omap_device.c no longer calls omap_device_idle(), which
> means things (clocks?) are not properly stopped before entering
> suspend, preventing core_pwrdm from going down.
>=20
> So I guess the question is, can it be done that
> omap2430_runtime_suspend() could access i2c and omap_device_idle()
> would be called?
>=20
> [1] For some reason I get data abort on i2c register access if it's
> suspended, not i2c timeouts that some people report..

1/ I don't know what your problem might be, but I have suspend working
 quite well with musb compiled in.  CORE goes to RET.

 The code is at git://neil.brown.name/gta04 in the 3.2-gta04 branch.
 There are various additions and hacks in there, I don't know which
 ones might be important.

2/ If you see i2c register access abort, I think that is because the iclk is
  being turned off.  Timeouts are because the interrupt is disabled or
  ignored.

good luck,
NeilBrown



>=20
>=20
> On Wed, Dec 7, 2011 at 9:37 PM, Kevin Hilman <khilman@ti.com> wrote:
> > Felipe Balbi <balbi@ti.com> writes:
> >
> >> Hi,
> >>
> >> On Mon, Nov 28, 2011 at 04:56:30PM -0800, Kevin Hilman wrote:
> >>> The MUSB driver does not currently implment suspend/resume callbacks,
> >>
> >> this is not entirelly true, actually. Such methods are missing for
> >> omap2430 glue layer, not for MUSB itself. And the fact is that it's on=
ly
> >> missing because we failed to use UNIVERSAL_DEV_PM_OPS for declaring
> >> dev_pm_ops structure.
> >
> > I guess that also means that nobody has tested MUSB host suspend/resume
> > with devices attached.
> >
> >> Can you see if this patch helps:
> >
> > Sure.
> >
> > That patch makes sense, and seems necessary, but doesn't fix the proble=
m.
> >
> > The root of the problem is that the PM domain code will call the
> > driver's runtime PM methods late in the suspend if the device is not
> > already runtime suspended.
> >
> > In your patch, you make the driver's suspend/resume methods call the
> > runtime methods, but, the PM core doesn't know that that the device is =
now
> > runtime suspended, so the OMAP PM domain code will still call the
> > driver's runtime PM methods to try and suspend the device.
> >
> > In the case of this glue layer, the runtime PM methods call some PHY
> > code which is trying to use I2C. =C2=A0When this happens late in the su=
spend
> > process, I2C may already be suspended, so you get a bunch of I2C
> > timeouts.
> >
> > Kevin
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
>=20


--Sig_/1epC_C7/l=33w+ImABITVlE
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTycbsznsnt1WYoG5AQKGlA//UPsEJ/v7blbnuqa076HMj0bwn5CdObx3
rztfWK5NPUfNF1JGZfZsdlMkph+I92bQIP8RRp8a0zo3Q8VP28+gX4/4J/CZb/YB
5bSOgErTAjvWfP4nlNodDXQ8a3lIN+nwRIGYAbj3PNmeoqqdiVTpawD4GZscZ5+g
6rEtXYhEDCVXhqFwicK/VBWu0VFbyCIqWE2cTuKhT6OvcZLCw8YoOYPasEYBSvN0
2Ith1uLQBnf9puCrS3mj2qLlPvATE55kpxhsbDGsShtK8Q7pD+NZz81bkNhg5Ycy
emgSOnRFoCY20D621ciMHIF7F5kPLx7raw6MPGO07RwqxCDINtuJAxHA4PqgqgDh
1utr0ZzHvFewg0lY12681BbZ21eP+XzPg/gJ2XwtNTZZOH1M2Ce3/ntpjEJZr02Z
C4aM970IHWblMG8B3Fe7jrDVq7OOwFKuR1Q0jSzTEum8O8Db6g4UBCgnose9FJLS
xF6t9/tgRPpn4wefCYdjiP0vhk6BcHvsLBbUVu204/m0G4tJgAT6BFq0QuDCZA05
TOQgw+8gJGDzyHYtOBDpfxOarY1LpTQMhVSIMdAJZ3JI/iUKDcCBX87MXSblXp5o
V/4539GrDcetUvyPaAU+baGJLGgHLCTXxxjUMGjFGec0XG3YMXgvl4TsVCX3Q+eO
AvNLy+cv1rg=
=Fb8Z
-----END PGP SIGNATURE-----

--Sig_/1epC_C7/l=33w+ImABITVlE--
