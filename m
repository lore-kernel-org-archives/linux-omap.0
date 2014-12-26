From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] arm: omap: reduce zImage size on omap2plus_defconfig
Date: Thu, 25 Dec 2014 22:37:19 -0600
Message-ID: <20141226043719.GA7661@saruman>
References: <1419271535-4057-1-git-send-email-balbi@ti.com>
 <54991A25.2030804@compulab.co.il>
 <20141223161936.GA9147@saruman>
 <549AA94A.8030209@compulab.co.il>
 <20141224154948.GA423@saruman>
 <20141224190401.GN23854@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33474 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750920AbaLZEiL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Dec 2014 23:38:11 -0500
Content-Disposition: inline
In-Reply-To: <20141224190401.GN23854@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Igor Grinberg <grinberg@compulab.co.il>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 24, 2014 at 11:04:01AM -0800, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [141224 07:52]:
> > Hi,
> >=20
> > On Wed, Dec 24, 2014 at 01:53:46PM +0200, Igor Grinberg wrote:
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA1
> > >=20
> > > On 12/23/14 18:19, Felipe Balbi wrote:
> > > > On Tue, Dec 23, 2014 at 09:30:45AM +0200, Igor Grinberg wrote:
> > > >> Hi Felipe,
> > > >>
> > > >> On 12/22/14 20:05, Felipe Balbi wrote:
> > > >>
> > > >> [...]
> > > >>
> > > >>>  CONFIG_SCSI_SCAN_ASYNC=3Dy
> > > >>> -CONFIG_ATA=3Dy
> > > >>> -CONFIG_SATA_AHCI_PLATFORM=3Dy
> > > >>> -CONFIG_MD=3Dy
> > > >>> +CONFIG_ATA=3Dm
> > > >>> +CONFIG_SATA_AHCI_PLATFORM=3Dm
> > > >>
> > > >> Isn't this needed for the rootfs on SATA devices?
> > > >=20
> > > > there's no known boards with rootfs on SATA. Until then, we can red=
uce
> > > > the size.
> > >=20
> > > What makes you say so?
> > > The decision for rootfs on SATA is taken dynamically.
> > > OMAP5 boards (specifically cm-t54) can have rootfs on SATA...
> >=20
> > I'll leave the decision to Tony. Even though they _can_, they really
> > don't and IIRC, OMAP5's SATA has so many silicon errata that it'd be
> > annoying to find that special device which works (e.g it can't negotiate
> > lower speeds with SATA III devices and it won't support SATA I).
> >=20
> > As of today, we don't know of anybody really shipping anything with
> > rootfs on SATA and distros would rather ship initiramfs than a giant
> > zImage anyway.
> >=20
> > Tony, your call.
>=20
> I think we should move omap2plus_defconfig to be mostly modular and
> usable for distros as a base. Most distros prefer to build almost
> everything as loadable modules. And my preference is that we should
> only keep the minimum rootfs for devices and serial support as
> built-in and rely on initramfs for most drivers. And slowly move
> also the remaining built-in drivers to be loadable modules.
>=20
> The reasons for having drivers as loadable modules are many. It
> allows distros to use the same kernel for all the devices without
> bloating the kernel. It makes developing drivers easier as just the
> module needs to be reloaded. And loadable modules protect us from
> cross-framework spaghetti calls in the kernel as the interfaces are=20
> clearly defined.
>=20
> Are there people really using SATA as rootfs right now on omaps?

not that we know :-) The only platforms available today with SATA are
OMAP5432 uEVM and DRA7x EVM, the latter being mostly used by TIers as of
now (at least from mainline point of view).

> If it's only something that will be more widely used in the future,
> then I suggest we make it into a loadable module, and presume
> initramfs and loadable module also for any new devices. The same
> way x86 has been doing with distros for years.

alright, as a module it shall remain.

--=20
balbi

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUnOX/AAoJEIaOsuA1yqREW40P/2P6U/VudVILgfcNSia0ECgD
r+pHS6GkifvQaauBiWkEYZjd2mK6VmKKjV4lwg8cC1wsReq7OG6ZjC0wlnFwt8cB
/GVMcU4D016DgV69vlrTfjEVf2v8h6qKyjw+ynfUcnxnvj4sbUWkfO+Z3HSsC1Cy
Dj5+KfDleZNMJuXsdQNO1mOKdGfDXjt2GeOgdQQGD97P6PTJcdylPhj6vYWW0ick
aMBcWJ52HTBtVP9+u0G7iWu79y3ks6Ci992PNLE/iyCvLDEeXaU8GJpvFAShCwPW
5lgHFtURVlynGosnskkirwlhgFdIcoXVq9FJc9d79036axivB5SVZWubzoEzJIZD
jSCB943hbXbdQ80ahLCOizU66MCCcCmiauXTyKW1n2nRhsv4ExyT/RE84W+OLDfs
6obuvobUO0x4sCDW6RqVUT4O3b0i4/06lZmk0wBmInD55tpKyWi4OhD2AC1OFW+Q
DI1DLViGsE4IQpPipqaQgUfKMvcR5TXWGYzlT5nFBH30ivfRs3h9Cry4LU/9oDMi
LBoxAag4w7j9d3igq1cFZovKQggt+WVu1Amz+nP8YWQkx5uj7w3rHx9blPEdeHoC
3PVhIb4sAE1AnPQfjEcQ6IWdRD0rLNwPkeZ7ONVAIMFB3TBfYKKgRMnRtio8RQNB
oJqwojoRD4JPPCOOXBNE
=6BgP
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
