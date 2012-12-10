From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 5/5] OMAPFB: connect ovl managers to all dssdevs
Date: Mon, 10 Dec 2012 12:07:10 +0200
Message-ID: <50C5B44E.3040304@ti.com>
References: <1354881309-17625-1-git-send-email-tomi.valkeinen@ti.com> <1354881309-17625-5-git-send-email-tomi.valkeinen@ti.com> <50C5909E.8030800@ti.com> <50C59745.2080604@ti.com> <50C5B154.9080305@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig09C0660DF63F88C59C7CBD1C"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34817 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752987Ab2LJKHM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Dec 2012 05:07:12 -0500
In-Reply-To: <50C5B154.9080305@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enig09C0660DF63F88C59C7CBD1C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-12-10 11:54, Archit Taneja wrote:
> On Monday 10 December 2012 01:33 PM, Tomi Valkeinen wrote:

>> Another option would be to pass information about mgr-output links fro=
m
>> the board files (or DT data) to the omapdss driver, so that omapdss
>> could setup them at probe time. With this option omapfb/omapdrm doesn'=
t
>> need to care about this, and it doesn't create load order restriction.=

>> But mgr-output links are something that I'd really like to handle insi=
de
>> the drivers, not something that needs to be passed via platform data.
>=20
> This would definitely make things simpler, but if this parameter is put=

> in a panel's DT, it would become omap specific. We could add this info
> to the DT corresponding to omapdss.

Yes, I meant it should be omapdss platform data. Nothing related to panel=
s.

>> Third option, which is the best, but also something I have no idea how=

>> to implement, would be to create the mgr-output links dynamically when=

>> needed. The problem here is, of course, that a mgr could be allocated =
to
>> an output, only to be later found out that that particular mgr is need=
ed
>> for another output.
>>
>> But this is something we could study a bit: can we create such mgr
>> allocation system, that no matter what outputs the board uses, it'll
>> just work.
>=20
> Yes, that would be quite useful. But I think we'll hit situations where=

> it is sort of impossible to prevent the above situation.
>=20
> When an output needs a manager. We could study the current state of the=

> system by splitting managers into 2 sets:
>=20
> A: managers which already have outputs connected to them
> B: managers which don't have an output, but might get connected to one
> in the future.
>=20
> managers in A are lost, and we can't detach them, we would need to at
> least disable/reenable the panel with a new manager connected to the
> output.
>=20
> we need to find one from B such that maximum outputs(or some other
> weightage factor) will still be supported after this new link is made.
>=20
> The system will initially have all managers in B, but eventually
> managers will move to A. We need to move one manager from B to A for
> every mgr-output link.
>=20
> I guess I just described the problem in a more mathematical way, withou=
t
> providing any solution :), but it does look like an optimisation proble=
m.

Well, optimization problem sounds like something that can always be
solved. But in this case the driver may need to predict what outputs
will be used, which is of course impossible.

>> So, for example, on omap4, LCD2 mgr can be used for DPI, DSI2, DSI1, a=
nd
>> RFBI. LCD1 can be used for RFBI and DSI1. If we know that DSI1 and RFB=
I
>> cannot be used at the same time, we're free to give LCD1 to either one=
=2E
>=20
> But they can be used together, can't they? LCD1->DSI1 and LCD2->RFBI.
> Are you creating this constraint by assuming what the board is like? Or=

> is this a constraint of OMAP DSS HW?

I didn't check if they can be used together or not, I was just guessing.
At least on OMAP3 DSI and RFBI shared the same pins, so they could not
be used at the same time.

Perhaps we should implement a mixed approach: the driver presumes
certain things, like "if DSI is used, RFBI is not used", based on the
knowledge of what kind of boards there currently are. This would allow
us to manage the mgr->output connections in the driver for, say, 95% of
the cases. Then we'd also have the platform data parameters for omapdss,
which could be used in the weird cases.

>> And if we know that DPI and DSI2 cannot be used at the same time, we'r=
e
>> also free to give LCD2 to either one. And if that's the case, there ar=
e
>> no conflicts.
>=20
> This is also possible at the same time: TV->DPI and LCD2->DSI2

True. I was just again guessing. On OMAP3 DPI and DSI shared the same pin=
s.

Thinking about this, OMAP4 does have separate pins for DSI, doesn't it?
So my guesses don't hold.

>> I don't know if we can find such allocation for all current omaps, and=
 I
>> know it's slightly risky as the next omap could have limitations even =
if
>> current ones do not.
>=20
> I don't understand the example so well, but I get your point of taking
> advantage of such limitations.
>=20
>>
>>> Also, we would need to do this for omapdrm separately using it's own
>>> encoder/connector entities.
>>
>> Yep. That's also a negative side: both omapfb/omapdrm will need to
>> implement the same stuff, even if neither of them are really intereste=
d
>> in that stuff.
>=20
> Yes. I wonder if crtcs, encoders and connectors already have some sort
> of helpers for this?

Probably nothing that helps us, as this is OMAP HW restriction.

 Tomi



--------------enig09C0660DF63F88C59C7CBD1C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJQxbROAAoJEPo9qoy8lh71SI0P/AqrUfyghmz+RcJRqW9vgtNr
r3a1RWnuVstdchs4XcukxxKTaAmzBb2xPdA5RYiicJJ4DNYgrlTizANTa8fZrdB1
4DzNYMXZvjvSgg/hFwJgbqCpVIPuTtVbW6rvNdDKcH2Uf7k0vTySMZUZI8Vsu10V
wpfRWxZR5DxYoN27itMNn0ZejfymReMklMfrUwlsMvrKb0AMVVFZywRSVc2cc/zn
b5eJ3KyXkOExBr4AGWom1kKOp9nLaf6M0okIEtYNEmBYdDlKqtIF2qdPVlxYCtsk
2bh04ZrCxMUQ4Vr2nKeK/SrjAZluXcSuX9pUWxX+kPkrixPCT+578fdfiqprKZuI
e98yDpx8i7UerCCnHxb+2d4Rao/z7ofudZ8tptvfhM+vo5ZFLo0rPHWYMoaON21k
zrDaX3S+dMNlVNK5uobV9s2ITY3T8nU99PaNbNcF3uqnYAv/HYJJWM2dnD1/y79f
guo2+2+UZjj16m76e6QiW7fJOH5DdaUwWcL8OACz3/Qa/IuaYKV/iT1w+SR8ptxQ
+OJ9AoaU6Dmo1VsrHetqNBGcMoOAs/JBEtnwhKvrdpEa5WkircfXfaTpz2I7LLpJ
9xyDDF0r/bq1dUKXpUaze+diLP7u9zdrG03nbOdVs331it7I3x44MnkowJkJ3JHQ
qYmmHPp6xmSNZCXH8gCF
=rcq7
-----END PGP SIGNATURE-----

--------------enig09C0660DF63F88C59C7CBD1C--
