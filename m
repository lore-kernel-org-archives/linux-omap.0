From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Nokia N900: refcount_t underflow, use after free
Date: Fri, 9 Mar 2018 23:18:34 +0100
Message-ID: <20180309221834.GA15476@amd>
References: <20180308143053.GA17267@amd>
 <20180308165903.GM5799@atomide.com>
 <57c9f17b-fc9d-8506-4b5d-70ac216c9248@ti.com>
 <20180308185046.GA22796@amd>
 <1dfc05fe-1612-f5a5-b5f1-9038b3cecfe5@arm.com>
 <1643b74a-62ba-bea6-71c2-a2dd02430463@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1643b74a-62ba-bea6-71c2-a2dd02430463@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Robin Murphy <robin.murphy@arm.com>, ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, Tony Lindgren <tony@atomide.com>, aaro.koskinen@iki.fi, kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org, martijn@brixit.nl, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, abcloriens@gmail.com, sakari.ailus@linux.intel.com, pali.rohar@gmail.com, clayton@craftyguy.net, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-03-09 16:13:36, Suman Anna wrote:
> On 03/09/2018 06:08 AM, Robin Murphy wrote:
> > On 08/03/18 18:50, Pavel Machek wrote:
> >> Hi!
> >>
> >>>> * Pavel Machek <pavel@ucw.cz> [180308 14:31]:
> >>>>> Hi!
> >>>>>
> >>>>> I'm getting this warning... Has anyone seen/debugged that before?
> >>>>> Unfortunately the backtrace does not seem to be too useful :-(.
> >>>>
> >>>> Adding Suman to Cc, as it points to arm_iommu_release_mapping().
> >>>
> >>> Hmm, we need to find out if the failure paths in isp_probe() are
> >>> mismatched, or if this is coming from some mismatch between the OMAP
> >>> IOMMU driver and the DMA plumbing. AFAIK, the cleanup paths in this
> >>
> >> Well, camera only started to work on N900 pretty recently. Let me add
> >> some debug printks...
> >>
> >> Camera does not work in 4.16.0-rc4-next-20180308-dirty.
> >>
> >> I see this. It looks like problem in isp error paths, indeed:
> >=20
> > Well, there certainly seems to be an obvious bug wherein
> > isp_detach_iommu() just releases the mapping directly without calling
> > arm_iommu_detach_device() to balance the equivalent attach. That can't
> > be helping.
>=20
> Indeed, I have been able to reproduce the same warning using a
> standalone test module, and the missing arm_iommu_detach_device() is
> causing the warning after probe (during failure path) or during
> remove.

Ok do you have an idea how to fix the isp error paths? Untested patch
would be fine... But it seems that you know what needs to be fixed and
I don't.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqjCDoACgkQMOfwapXb+vLhhwCgi7hST8I9ddFqZSa/+CPLAjSQ
T28AoIm71+U3AYWQkJSTu3CzhRO0Zbf3
=XGNC
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
