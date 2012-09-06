From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 15/17] OMAPDSS: remove extra_info completion code
Date: Thu, 06 Sep 2012 17:29:14 +0300
Message-ID: <1346941754.2737.88.camel@deskari>
References: <1346833555-31258-1-git-send-email-tomi.valkeinen@ti.com>
	   <1346833555-31258-16-git-send-email-tomi.valkeinen@ti.com>
	   <50475444.2080509@ti.com> <1346936681.2737.61.camel@deskari>
	  <5048A6AA.50009@ti.com> <1346938926.2737.71.camel@deskari>
	 <5048ACBC.8010502@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-6SrmDivsHfWt22i3f7kR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:57752 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756166Ab2IFO3W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 10:29:22 -0400
Received: by lagy9 with SMTP id y9so1135876lag.19
        for <linux-omap@vger.kernel.org>; Thu, 06 Sep 2012 07:29:18 -0700 (PDT)
In-Reply-To: <5048ACBC.8010502@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-6SrmDivsHfWt22i3f7kR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-09-06 at 19:31 +0530, Archit Taneja wrote:
> On Thursday 06 September 2012 07:12 PM, Tomi Valkeinen wrote:
> > On Thu, 2012-09-06 at 19:05 +0530, Archit Taneja wrote:
> >> On Thursday 06 September 2012 06:34 PM, Tomi Valkeinen wrote:
> >>> On Wed, 2012-09-05 at 19:01 +0530, Archit Taneja wrote:
> >>>> On Wednesday 05 September 2012 01:55 PM, Tomi Valkeinen wrote:
> >>>>> Now that fifo merge has been removed, nobody uses the extra_info re=
lated
> >>>>> completion code, which can be removed.
> >>>>
> >>>> I think this might come into use when we fix the usage of channel ou=
t
> >>>> field. That is, since channel out is an immediate write field, when =
we
> >>>> set a new manager for an overlay, we may need to wait till the overl=
ay
> >>>> disable kicks in, only then we should change channel out.
> >>>>
> >>>> For this, we would need some wait for extra_info, right?
> >>>
> >>> Hmm, yes, I think you are right. Previously the ovl_disable waited un=
til
> >>> the overlay is not used anymore, but now it doesn't.
> >>>
> >>> So I think I need to add wait_pending_extra_info_updates() call to th=
e
> >>> beginning of dss_ovl_set_manager(). Or, should it be in unset_manager=
...
> >>> I think unset is better, then a "free" overlay always disabled also i=
n
> >>> the HW level.
> >>
> >> Yes, I also think it should be in unset_manager. One option could be t=
o
> >> leave the wait_pending_extra_info_updates() in ovl_disable itself, as =
it
> >> was before. But that would force us to use mutexes there, and we'd
> >> rather have overlay enabling and disabling as a non blocking thing.
> >
> > Actually, we do have mutexes there. You are thinking about the prototyp=
e
> > API I have. (I also thought we didn't have mutex there =3D).
>=20
> Ah, I missed looking at that :)
>=20
> >
> > So, in fact, we can have the wait at ovl_disable like it was before. Th=
e
> > prototype API, which cannot block, will not have the wait, but there th=
e
> > caller (i.e. omapdrm) will have to manage the proper wait.
>=20
> I'm more inclined towards waiting in the unset_manager() now, we have a=
=20
> choice between "wait in ovl_disable, ensure the overlay is actually=20
> disabled in hw, and then get out" and "wait only when you know you need=
=20
> to wait (i.e, in unset_manager)". The second choice seems more efficient.
>=20
> This wait would could last for a 1 VSYNC if we do it in ovl_disable. If=
=20
> the next task of the user of DSS is to enable another overlay, this wait=
=20
> would unnecessarily delay the enabling of the second overlay by a VSYNC.=
=20
> We could have done these tasks in the same VSYNC (since we aren't=20
> supporting fifomerge).
>=20
> So, I feel that we should rather wait in unset_manager, where we know an=
=20
> immediate write can mess things up. Maybe, we could delay it set_manager=
=20
> too. But yeah, we won't know whether we are aligned with hw or not.

Good points. Then again, the wait function doesn't wait for the ovl to
be disabled, it waits for all extra_info changes to be done. So we could
be waiting unnecessarily in unset/set_manager. Which makes me think that
we should remove the current wait function and implement a specialized
wait for ovl disable. But that can be looked at later if seen necessary.

Also, it feels safer to ensure the ovl is disabled at ovl_disable call.
However, I was going through the code and I didn't come up with a case
where it would cause problems, except the set_manager part.

So, I guess having the wait in unset_manager is still best overall, we
don't unnecessarily spend time waiting at ovl_disable.

> So even with the prototype API, where omapdrm is responsible for doing=
=20
> the waiting, it should probably wait when switching the manager, rather=
=20
> than when disabling the overlay.

Yep.

 Tomi


--=-6SrmDivsHfWt22i3f7kR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQSLM6AAoJEPo9qoy8lh71WgAP+gJVl6cHte29KR8z2J/JMp6/
OhesrRkngYvinM1cU2INLO6a5AXjga6IlI0butMex7Ebvm4PgR7bf3Pu6Dwy621o
KiGKihaNf5vlISqWvWd0jg3UWdmp9TIWWLdbCpYo5Rm2VHzyxQitV0OXMlnbaGtS
DFxjgMz+CJxtEs42MaZX0ITo22gJO+EmbJ+0iP3IEaWlz46ROw9SIZM4zC10aMo6
w1NF6TrgsQCEY+849pPjskJ4FnkLViKLoPR3BnKPLSQXfobRbdSfkAfRCubbuUyT
kEKCE0sJFW35i0F/kqWaeyQk5M4h9hozqdA/5EoC1vPGGgtuDVX/Co85MMEYJJzc
nLGlLZg4eEfn+PQ/isXlebBEHOksA6Qstm2D4A4fsYvUXTqAKBahxY3MvrW0KWQ8
fRTT7MgccErd2tS2gji1YqhDyaSqMTPydbJwAbSr4h/WnHzu2nRGMwzwOzBkpuvo
OM+MI5qTzDjhUnEy1gCUWUNkgwuYxRafzPOs7GV6pgQ3B3uxp+cboglS3njlL9/H
TYmsJIHWrjH/nxsM/ErWL9saamuhuzuhaVjl/mhaOFKiN/EuIworLOOmcnMUGs48
B8RU3alSvpwqRA16VHzq+we3HL6KonkaGlX81MvEXO0f8n/cTEfzzILF/QZBZFwZ
ms9WSBAEu0pgV5I0jvk2
=91IB
-----END PGP SIGNATURE-----

--=-6SrmDivsHfWt22i3f7kR--

