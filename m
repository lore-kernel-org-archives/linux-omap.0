From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
Date: Sat, 16 Feb 2013 10:55:28 +0200
Message-ID: <20130216085528.GA19639@arwen.pp.htv.fi>
References: <20130214192719.GB26679@arwen.pp.htv.fi>
 <20130214193911.GD11806@atomide.com>
 <alpine.DEB.2.00.1302141946110.11016@utopia.booyaka.com>
 <20130215101610.GR17852@n2100.arm.linux.org.uk>
 <511E3797.2070802@ti.com>
 <20130215132726.GT17852@n2100.arm.linux.org.uk>
 <511E38C3.7080404@ti.com>
 <20130215163031.GA5724@atomide.com>
 <20130215164235.GA20840@arwen.pp.htv.fi>
 <511F20B1.8010502@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45235 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752444Ab3BPIzs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 16 Feb 2013 03:55:48 -0500
Content-Disposition: inline
In-Reply-To: <511F20B1.8010502@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: balbi@ti.com, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Paul Walmsley <paul@pwsan.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Feb 16, 2013 at 11:31:21AM +0530, Santosh Shilimkar wrote:
> >>The main goal is to avoid duplicating data both in hwmod and DT.
> >>That's pretty much solved as we can have the driver probe populate
> >>the common data for hwmod from DT as Santosh has already demonstrated.
> >>
> >>Then we also want the driver specific idle and reset code to be done
> >>in the drivers rather than in hwmod and glue it together with hwmod
> >>using runtime PM. The biggest issue there is how do we reset and idle
> >>some piece of hardware for PM purposes when there's no driver loaded.
> >
> >right, this will be a tough nut to crack.
> >
> >I guess the only way would be reset all IPs early in the boot process,
> >before even creating the platform-devices. Can we do that ? I mean, from
> >omap_device_build_from_dt() we have access to address space of all
> >devices, through ti,hwmods we can figure out which hwmods are linked to
> >that particular device, so whenever you build a device, you could just
> >call _reset().
> >
> Thats what we do today and it works perfectly. As per Tony's suggestion,
> we need to move the non-probed devices reset and idle setup to late_init
> which is also doable.
>=20
> In that case when probed driver calls runtime_get(), we reset that
> device and setup the idle settings. And remainder of the devices
> are managed in late_init().

what's the point in moving it to late_initcall() ? It makes no
difference, if no driver binds to that device it will stay in reset
anyway. Maybe what we're missing is properly idling (not exactly) all
devices before driver probe kicks in.

> >The only problem is that now omap_device_build_from_dt() is called after
> >we notify that a new device/driver pair has been registered with the
> >platform_bus, right ? So we would still need a way to call _reset() for
> >those which are on DTS but don't have a driver bound to them...
> >
> The only special requirement for reset remains(which today handled by
> hwmod function calls) is for devices which needs specific reset
> sequence. And this one can be handled through a runtime_reset()
> kind of hook.
>=20
> Does that sound reasonable ?

Depends on Rafael. If he says no to the ->runtime_reset() I suggested
earlier, another aproach needs to be found. In any case,
->runtime_reset() is only for devices which actually have a driver, so
it matters little.

The difficult part is handling special reset requirements for devices
without drivers as there'd be no ->runtime_reset() to call.

--=20
balbi

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRH0mAAAoJEIaOsuA1yqREozgP/iTL+wC4Q+DNUHagIblcbFan
Ajr/La0LZ4cP6ZRo+A6LhQsWky0aERkqNfUEglW+ZQc2zOCrGa6gsJyDRV0nNFQP
0DTj1PlIkpE3ZKdjsFKVQ9xMSWhtc9zv43eiFm/VZZM04gBdSuxwMzqktUtN8wkn
gVgHgxtcBLWd0XzC/DydS5IVWO1Rsk7Te0QRYkTmgECvyz39qtrqqrbsVNlrSKFC
rCWo7dFipxBArgxV9+IdgPHnu5Lzp1/OMkJ5y0UTUSb4ZbxLdIIm1MRaaVIgExsc
oHev8ZiUPqCTk7A+QDp/EXaZo6R1Rk71DmElE5AdMdhyxfqT5GOB1i7faVqLMAcs
ipiKI8hF7AoVpUDTZIxzdwh7iQqesGrVudDezSfVdHAH+uU7AjRZ2Yqi3AjZnE6d
k3wtHWUygDgY3xBCILRpLBJYVypruWShnwJbu59jOrNgUtEnmGW8oZbN1Z3dWysY
amTIpDOs6PIZ0I/W0u3FVGAitmaCncR2i80iHGsyGsomdoADwb1ePhDMDcsK9pBh
FVk688BF6Ep5wBYRBzCj4vRJHkFY4/fIQd8MqbA7+mmLV2I5DK9lccA9+i/MWVlk
8GvWp0074NVS8wzMot2AaUdpF5+pa4jADhmVkH/0H0Ba+rGjrDAR2ndldNZXNkc5
onBpp5nGruwEnUiGmcoq
=kGpZ
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
