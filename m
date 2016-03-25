From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] regulator: twl: Enable regulators over the powerbus as
 well
Date: Fri, 25 Mar 2016 17:47:50 +0100
Message-ID: <20160325164750.GA14392@earth>
References: <1458760956-29892-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20160325111757.GC2566@sirena.org.uk>
 <20160325150259.GA9372@earth>
 <20160325155419.GI2566@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160325155419.GI2566@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, tony@atomide.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 25, 2016 at 03:54:19PM +0000, Mark Brown wrote:
> On Fri, Mar 25, 2016 at 04:02:59PM +0100, Sebastian Reichel wrote:
> > On Fri, Mar 25, 2016 at 11:17:57AM +0000, Mark Brown wrote:
> > > On Wed, Mar 23, 2016 at 09:22:36PM +0200, Ivaylo Dimitrov wrote:
>=20
> > > > Assigning a device group to a regulator does not change its state. =
To
> > > > change the state of a regulator a message over the powerbus is requ=
ired.
> > > > Also, the check for the current state of a regulator should not cou=
nt on
> > > > a device group being assigned, but on the current resource state.
>=20
> > > How did this driver ever work then?  It sounds like there must be
> > > something else going on here.
>=20
> > From my understanding of the twl4030 TRM assigning a device group
> > means "<device group> wants this regulator enabled". It does not
> > change the regulator mode (sleep vs normal or in regulator-framework
> > terms: REGULATOR_STATUS_NORMAL vs REGULATOR_STATUS_STANDBY).
>=20
> > It usually works, since the default state is normal. If the system
> > is rebooted from a non-mainline kernel, which left the regulator in
> > sleep/standby, nothing in the kernel switches it to normal.
>=20
> I really can't tell how anyone could get from the changelog to what
> you're saying about modes.  The explanation needs to be *much* clearer.
>=20
> Part of the confusion is that if you're trying to do something to do
> with the mode support that really needs to use the mode APIs, enabling
> or disabling the regulator should not silently change the mode.

I just tried to describe what's going on, so that you can see the
whole picture. I don't agree with the patch and think that the mode
should be switched to normal at probe time. I assumed, that you
would suggest the correct solution if I describe the problem.

-- Sebastian

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJW9WuzAAoJENju1/PIO/qat0sP/3bCDpTPk4uVRG7rkRJU7FJU
PBtPOyvKxXRDEm6b47BKM2OEjb2tYTnrR6ZrJcjscDPKb9fteWnzYvz8VBVRHibt
1z0UFJZwJxxBwCh6L1e0W28KvYIkhW1dxTdzarg2re09vVXWPkyfvlnN5C+hwsK3
faqnH9dt7iSrpfv4UPMpGVzqsA1M/Fds9cHISAOW/Y1i3f/Ui3vVlhZHIuQUxdLY
nFmmnhckPh4G8Re3ZVk5gl/S39iHlL4tdjwHGEcPjk13UhMmh6m8pfPZlH1jijMN
gTbljn70cL4q1WQ6Uh6bjBWIR9TGpbdhg3kW+RVdQt9TYj7KkGSZNND4ewbSFm1I
g3P++H8FhlFfLVO/Rp9Gp0sm/e97cf1TKxswtKH5grOAC69U4zWlQZslW1msn+SS
smSs/P7LcX5jrJrtVF8WfR/YVKCbYDxqg5dp9LTKsK0ulBeWJh0UZ/pU+cbmrjsv
e8xMpVICU9Ww8SOIc3lAqBO8hA5XyhUfCnUxaZRR60xE6pJisNXUebFfNJpuXjWk
SmCtjw+ZMLwq+pRekKNmBJkwpfW2PvfTD2/5v4RXbksVzoNb2QSSU8wkhXRxux2P
HCy6UOv+eRvdRDTVNaQrzVf0/g4Z3FSxUdWiGw147MwVBETZMphvdW//Ujr0TEVG
GRZpV/7uQA33QqkSdmLq
=1u81
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
