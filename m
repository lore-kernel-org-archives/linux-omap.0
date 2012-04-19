From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/6] OMAPDSS: APPLY: Treat overlay manager timings as
 shadow registers
Date: Thu, 19 Apr 2012 15:00:24 +0300
Message-ID: <1334836824.1911.46.camel@deskari>
References: <1334561027-28569-1-git-send-email-archit@ti.com>
	 <1334836135.1911.40.camel@deskari>  <4F8FFDD5.5030302@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-1xVSv1DvsRFMlKtxJz9U"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:54562 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754899Ab2DSMAc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Apr 2012 08:00:32 -0400
Received: by lbjn8 with SMTP id n8so4084159lbj.34
        for <linux-omap@vger.kernel.org>; Thu, 19 Apr 2012 05:00:27 -0700 (PDT)
In-Reply-To: <4F8FFDD5.5030302@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-1xVSv1DvsRFMlKtxJz9U
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-04-19 at 17:28 +0530, Archit Taneja wrote:
> On Thursday 19 April 2012 05:18 PM, Tomi Valkeinen wrote:
> > On Mon, 2012-04-16 at 12:53 +0530, Archit Taneja wrote:
> >> An overlay manager's timings (the manager size, and blanking parameter=
s if an
> >> LCD manager) are DISPC shadow registers, and they should hence follow =
the
> >> correct programming model.
> >>
> >> This set makes the timings a manager_info parameter. The interface dri=
vers now
> >> set the timings in manager_info instead of directly writing to registe=
rs.
> >>
> >> This change also prevents the need to use display resolution for overl=
ay
> >> checks, hence making some of the APPLY functions less dependent on the=
 display.
> >>
> >> These patches apply over:
> >>
> >> git://gitorious.org/linux-omap-dss2/linux.git dev
> >>
> >> Archit Taneja (6):
> >>    OMAPDSS: DISPC/RFBI: Use dispc_mgr_set_lcd_timings() for setting lc=
d
> >>      size
> >>    OMAPDSS: DISPC: Use a common function to set manager timings
> >>    OMAPDSS: DISPC: Clean up manager timing/size functions
> >>    OMAPDSS: MANAGER: Make DISPC timings a manager_info parameter
> >>    OMAPDSS: MANAGER: Check validity of manager timings
> >>    OMAPDSS: APPLY: Remove display dependency from overlay and manager
> >>      checks
> >
> > The patches 1, 2 and 3 in this series look like independent cleanups.
> > Should I apply those, or do you think there may be changes required?
>=20
> I think you can pull these 3, they were sort of a prerequisite for the=
=20
> apply-manager-timings stuff. I don't think they need to change.
>=20
> I'll post another series for applying the manager timings correctly(i.e,=
=20
> the fixed version of the last 3 patches).

Ok, I applied the first three patches to my dev branch.

 Tomi


--=-1xVSv1DvsRFMlKtxJz9U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPj/5YAAoJEPo9qoy8lh71GowP/iPqMI1kBMdPpYLuVhwiEqQ/
cGQ3RsICkvKdfmXfHJz8osBEExx/QtLebBtFfazlkE64yqdlma6xqpA3XUvyNi+a
9/5cHyAt856pffVGoDEpQglWbKv8MSi/sVQGsH2udexDHNSG5aBs1jbifNYK59xw
MfuAS50hyhbicHRAv2304G8E/I99Mw5RT6wKiaCuKQ/dJoAcnWzprPXXK5x4H5Ks
dNpyv/OGICqYJRHJrB0lmST/+jHc1MZS0l3mlI+HndYLeBCxWuvqnvsa7JC931cy
gisnmck3fColGcLKTfNAvG/eQ/mnTwOfozG16sIf8PUGB2f52VmoFSo20ooeZYP1
NTE6TmNKEdqDZo8oKAwdiZwkS2LcicGpCjUuLbXX5aapPAMCNRuRll6arjwsnz+0
/S09J9uByyUJOYfYvi5asR+VJDGOm273yoyPv6aV1L/b4AkCd9QUpNDg6uiJd/lR
WBEz5WNPl4bhJdCnK13HCnJ85egt3gtIL8djRqC6DHb0lnZqhXR/NXyNlTDSVTrU
ApZfZD/R/vmaCq8grrSd9NnYEAfX+CLCKI90SeZgnSef6dmu1dnHW8ogB5raCtEH
K3fir8cO5FAtA4NB8w6toUySRhwVdmyCm9NbGSQSfoShcz27HxUyrUJqFZnnE8By
4Dr5MGFaQ/pdWDE9VNgn
=uPLB
-----END PGP SIGNATURE-----

--=-1xVSv1DvsRFMlKtxJz9U--

