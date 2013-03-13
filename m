From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 1/1] ARM: OMAP: board-4430sdp: Provide regulator to
 pwm-backlight
Date: Wed, 13 Mar 2013 08:09:02 +0100
Message-ID: <20130313070902.GB25940@avionic-0098.mockup.avionic-design.de>
References: <1363053266-515-1-git-send-email-achew@nvidia.com>
 <20130312070104.GB6467@avionic-0098.mockup.avionic-design.de>
 <643E69AA4436674C8F39DCC2C05F7638629CA516BD@HQMAIL03.nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Bn2rw/3z4jIqBvZU"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:64741 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755280Ab3CMHJK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Mar 2013 03:09:10 -0400
Content-Disposition: inline
In-Reply-To: <643E69AA4436674C8F39DCC2C05F7638629CA516BD@HQMAIL03.nvidia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andrew Chew <AChew@nvidia.com>
Cc: "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, Alex Courbot <acourbot@nvidia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--Bn2rw/3z4jIqBvZU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2013 at 12:11:54PM -0700, Andrew Chew wrote:
> > From: Thierry Reding [mailto:thierry.reding@avionic-design.de]
> > Sent: Tuesday, March 12, 2013 12:01 AM
> > To: Andrew Chew
> > Cc: peter.ujfalusi@ti.com; Alex Courbot; linux-omap@vger.kernel.org
> > Subject: Re: [PATCH 1/1] ARM: OMAP: board-4430sdp: Provide regulator to
> > pwm-backlight
> >=20
> > * PGP Signed by an unknown key
> >=20
> > On Mon, Mar 11, 2013 at 06:54:26PM -0700, Andrew Chew wrote:
> > > The pwm-backlight driver now takes a mandatory regulator that is
> > > gotten during driver probe.  Initialize a dummy regulator to satisfy
> > > this requirement.
> > >
> > > Signed-off-by: Andrew Chew <achew@nvidia.com>
> > > ---
> > > This patch, along with many more soon to follow, attempts to satisfy
> > > the new mandatory regulator that pwm-backlight will grab during probe.
> > > The only board in mach-omap2 to use the pwm-backlight appears to be t=
he
> > 4430sdp.
> > >
> > > I thought I'd start small and use this board as an example.
> > >
> > > I tested similar code in my Tegra board, so it should be okay.  Of
> > > course, I don't have a 4430sdp to test with.
> >=20
> > Hi Andrew,
> >=20
> > This looks good, one minor comment below. I think it might make sense to
> > post this patch as part of a series that includes the change to the pwm-
> > backlight driver. This will make things easier on potential testers.
> > You can later extend that series to include all the other users and eve=
ntually
> > the whole series can be merged.
>=20
> Do you mean I should do a single patch series, accumulating other boards
> as I go?

Yes, that way everything needed will be in one patch series and people
can easily apply that to their trees. It will also make things easier if
we decide to merge all of them through one tree in the end.

> And by the way, do I have your reviewed-by for the pwm-backlight regulator
> patch?

I think it looks good, but I'll go over it again in your repost of the
whole series. I don't think you need my Reviewed-by, though, since I
maintain the pwm-backlight driver. =3D)

Thierry

--Bn2rw/3z4jIqBvZU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRQCYOAAoJEN0jrNd/PrOhc+UP/1NYnkDe7hCZFGx2M7kUvOgX
priIkb1i725TuCOqz6Q/45kyS88BRsFXVLTblDQW7IlT9igknPnLff+WtSc+kefg
qZaSkNHJx4cuUoNuyxwhbFBqI7Czi9BRUrsLC++Q/Lm4/qkJC+eVb7LiH6I26lRe
QI/OEchJPjjqMoZ+MX/Td/0VDDMvYuC4uKofN/1WYQtxVaPdT3xmm3l3t9Rj1mc4
29seYAMVE7PblqUqtk+WNczPgWBQhodbpJs6HivQx23ZN5P90NSVpRxWc5/84Oi7
h6MG7ISUywt/1vv9DkK6ftLrxwyyPB+2M5zepsh/qNoLH8FbgEZoRMJr+DcEpwFN
qncvi7UCLyMn5q6ct0YUyl5kfvhCGOLNysZVDuJSs1UEqybsaddZPkrYXoay94Sc
SMO+QtqiTygNLGtRlrLzv0JqrNd/BtNUSuCrqYqinTAwE+zbLucSRXyLPHp34Lr5
8nCCzQ9tE0Nok3JpKiTW6qSJKO/lu/Rrrx0808fHWPX2IAnh+NYiGuVwlS7g4rJD
2QOhDtOvoIaQWJpXJACbYktXiPaXc+H+eG/Fe8CkfyKOO8YHlDRQgmtkD7yX8u/x
CdAHPdb8+U9/cVpAeGt2Z34Fz6us6dXuJhY2ZE+B8UHlqdV5mda2L++ZdfGO2C54
VZr6JlQU942/BSlaapoy
=fG7t
-----END PGP SIGNATURE-----

--Bn2rw/3z4jIqBvZU--
