From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v3 4/5] OMAPDSS: APPLY: Remove display dependency from
 overlay and manager checks
Date: Wed, 09 May 2012 13:15:23 +0300
Message-ID: <1336558523.3962.30.camel@deskari>
References: <1334561027-28569-1-git-send-email-archit@ti.com>
	   <1336471096-21096-1-git-send-email-archit@ti.com>
	   <1336471096-21096-5-git-send-email-archit@ti.com>
	  <1336474223.1821.6.camel@lappyti> <4FA901EC.8020002@ti.com>
	 <1336478139.5761.27.camel@deskari> <4FA912F5.9030604@ti.com>
	 <4FAA3E8E.4000904@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-lhbpGYJqOJIYAsAksbis"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:46353 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753660Ab2EIKP2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 06:15:28 -0400
Received: by lbol5 with SMTP id l5so61013lbo.6
        for <linux-omap@vger.kernel.org>; Wed, 09 May 2012 03:15:25 -0700 (PDT)
In-Reply-To: <4FAA3E8E.4000904@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-lhbpGYJqOJIYAsAksbis
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-05-09 at 15:23 +0530, Archit Taneja wrote:
> On Tuesday 08 May 2012 06:05 PM, Archit Taneja wrote:
> > On Tuesday 08 May 2012 05:25 PM, Tomi Valkeinen wrote:
> >> On Tue, 2012-05-08 at 16:52 +0530, Archit Taneja wrote:
> >>> On Tuesday 08 May 2012 04:20 PM, Tomi Valkeinen wrote:
> >>
> >>>> Checking the validity of all the settings is a bit tricky, but
> >>>> currently
> >>>> I think, as a rule of thumb, we should accept any settings when thin=
gs
> >>>> are disabled. So, until the interface driver sets the timings before
> >>>> enabling the output, all ovl/mgr settings should be allowed. And we
> >>>
> >>> We have 2 ways to go about this, one is to have an initial set of
> >>> 'always valid' values like I have done, the other option is to ignore
> >>> manager timing related checks if the manager is disabled, i.e all
> >>> configs are okay. To implement the second option, I think our functio=
n
> >>> dss_check_settings_low() would get more complicated. We would now hav=
e
> >>> to pass mp->enabled outside of apply, and pass it to dss_mgr_check()
> >>> which would further need to pass this to dss_ovl_check(). Hence I use=
d
> >>> the first approach.
> >>
> >> I'm not sure about that. We already do it for overlay. In ovl.c we hav=
e
> >> dss_ovl_simple_check() and dss_ovl_check(). The simple check sees if t=
he
> >> settings pass basic sanity check. The check sees if all the ovl& mgr
> >> settings are compatible with each other.
> >>
> >> Simple check is done when setting the config, called from
> >> dss_ovl_set_info(). The proper check is done later when the actual
> >> config is about to be taken into use.
> >>
> >> If mp->enabled =3D=3D false, can't we just skip dss_check_settings_low=
()
> >> totally for that manager? We skip the check for ovls the same way.
> >
> > Okay, this would work better I guess. If someone tries to enable the
> > manager without setting the timings, that check should fail, and in my
> > approach, it would have passed, and would have led to bad stuff later.
>=20
> One change in behaviour with the patch series I see is with the=20
> following use case when connected to Pandaboad's DVI interface:
>=20
> - Bootup with 1080p resolution
> - Try to set 640x480 timings with sysfs.
>=20
> The older behaviour was that the timings were taken, and a skewed image=
=20
> was seen(because the overlay size is larger in deimension)
>=20
> The behaviour after this series is that the mgr_set_timings fails with=
=20
> the error:
>=20
> omapdss OVERLAY error: overlay 0 horizontally not inside the display=20
> area (0 + 1920 >=3D 640)
>=20
> I guess this is better in a way, a user of DSS is supposed to reallocate=
=20
> the framebuffer with the desired size and then change the timings.

Yes, I think it's better. I think it's undefined what happens if the
overlay is larger than the output. In theory the DSS HW could lock-up,
or something. So we have to prevent it.

omapdss could change the size of the overlay automatically, but I
dislike things like that. Low level drivers adjusting the configuration
from the user almost always brings problems. So yes, I also think that
the user of DSS is supposed to handle it correctly.

> But with DVI, the problem is that dpi_set_timings already does a ton of=
=20
> stuff before dss_mgr_set_timings() is called, so we change the dividers=
=20
> to get the new clock, and then realise that the overlay can't fit=20
> inside, and we are left nowhere. I guess this is a separate problem and=
=20
> we could tackle it later.

Ah, ok. Yes, I guess we need to roll back the settings in that case. Or,
I wonder, would a check function work, that would take the new timings
and check those but also check if they match the overlays.

Hmm, no, that doesn't solve it totally, as the overlay could be changed
after the check. Again a problem with dss locking, we can't do the
operation atomically...

 Tomi


--=-lhbpGYJqOJIYAsAksbis
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPqkO7AAoJEPo9qoy8lh71zDgP/iFLo1EqBRJsYZFAAIhWPEB/
eqOY+kryKcWeM9JyPVkT+ydZ6hEowI8dgqjsRZh3W0Yo7pL7QXWrpMn0EYJ0wNU7
LP+LztUzqHTGhOLp5tht/n7p3UtEELx+mWiTEf3ceMYbcyQJhIzvTO1btKGYkpQK
Km6udvTyl9LXJrc+7CUP2zF4oc2gDBR/JjX0IQDSo2SqZWdFYH4u8AD0nYYP9tma
Ty1bt3Ej7z2n6f5aIFCmJe866aknMJ1YMx60mdyZd3/qoMa4IWZbHqthUnP2WhLN
BHLB35nPTNuEQj0k+imqM2GlIn2AmEinYHIwLXvncz4ABzkEeSImOr7GE3eACwmH
SmVTHbxKHN1EHyDB9PSops6AJ1UsdSzOOE/39aHJVRfeW/5uvkFhnB4DlcettGgr
kMMbwO8dY4SVPEgalHVPoq9cosCtrCuLW56MyvNb9x8OEiD6yNdWTkyhwt5rjI4E
WtTRpIBUEYL+VMDv1grH1WqyHI1r28UU1aSCv+clZnEyIZYCUmhexxYZx+5ZlCAn
pMWnHmJRFGrxIpQ7qsotiXY40Zu2YvPdykFCsCzgIxAS/vpfkqHIlPlivzlrldt3
SU5sg2/3LCnG6Ms9chS9neqzmAQRbwq89MNL/z1NITptwqV0OmFYgvCFxZAsWGgF
jwXWZdS4EiUdpbxhYMFE
=43jX
-----END PGP SIGNATURE-----

--=-lhbpGYJqOJIYAsAksbis--

