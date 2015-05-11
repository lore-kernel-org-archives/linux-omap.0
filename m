From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/2] arm: boot: dts: am4372: add operating points
Date: Mon, 11 May 2015 12:02:23 -0500
Message-ID: <20150511170223.GC22558@saruman.tx.rr.com>
References: <1431115050-23693-1-git-send-email-balbi@ti.com>
 <554D17F3.7090008@ti.com>
 <554D18AB.6060901@ti.com>
 <20150508202439.GA25459@saruman.tx.rr.com>
 <554FF686.5050704@ti.com>
 <20150511151930.GA19183@saruman.tx.rr.com>
 <CAGo_u6oQ_uzO4B4ezC-Vi8_FQZWH49+6fbutdVgP5s0fL3MhrA@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3Gf/FFewwPeBMqCJ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49547 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752486AbbEKREn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 May 2015 13:04:43 -0400
Content-Disposition: inline
In-Reply-To: <CAGo_u6oQ_uzO4B4ezC-Vi8_FQZWH49+6fbutdVgP5s0fL3MhrA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Mark Rutland <mark.rutland@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Viresh Kumar <viresh.kumar@linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

--3Gf/FFewwPeBMqCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

HI,

On Mon, May 11, 2015 at 11:46:13AM -0500, Nishanth Menon wrote:
> On Mon, May 11, 2015 at 10:19 AM, Felipe Balbi <balbi@ti.com> wrote:
> >
> >> in my opinion, doing a temporary hack in upstream kernel is not an
> >> elegant approach. I suggest helping review and approving Viresh's new
> >
> > however this is not a hack, right ? If we get rid of OPP_NITRO and
> > OPP_TURBO, then we will more than likely always be dealing with safe
> > OPPs (yeah, I need to confirm this since it's not on public TRM, so as
> > of now, take this statement with a grain of salt :-), moreover, even
> > though we're trying to change opp bindings, the current situation is
> > still very much accepted and will remain valid even after changing
> > binding :-)
>=20
> yes - if we do have a documented subset of OPPs that are valid for all
> "variants" of AM437x, we could add that in using the legacy bindings,
> but, we will have to do a transition over to the new bindings when
> they are finalized to support all OPPs appropriately.

sounds fair to me.

> > Not to mention that people using AM43xx today might be using it under
> > invalid OPPs and decreasing silicon life; I'd assume that's a very
> > urgent detail to sort out.
>=20
> While I do agree that there is always a debate between fixing things
> in kernel for bootloader issues, but it does not mean that we should
> just postpone fixing the bootloader in this case - since, at this very
> moment, we are already in broken configuration - example sitting on a
> bootloader shell does have the same impact we have at this time.

agreed, I'll cook up a patch for bootloader too.

> Lets try to help Viresh in getting his series sorted out meanwhile -
> maybe others can help as well :(

sure.

--=20
balbi

--3Gf/FFewwPeBMqCJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVUOCfAAoJEIaOsuA1yqRELf8P/0TYavF3GaDUi+K1AJJEmfco
NEyoENn9U5OG88/d4Lo5AdOn/lJJXzLYfjR3xY+UMm8i1oqwO+ZjcChLmGN9HwBh
FYf7SoRIGYSSz1R8FdKSBAn56Fv1Taltjyzyz9+l+iD+/s600gmq5eRfw/ZOg2DP
xrIaWu5coTQTsdIKE3a+z55ouJKkCSYpnmu9i/y1JQHGLNxPx6jmwr/iYgprvX8o
741V8LjdOheJBf3n5W6zFLq6wN9LDQOlObn38DcYPTV1m0zn4+uLdx8sFk/wAPuo
wz+n1bwKTfzxsTs/Q5bL1wjtNXA+YiX5gM86Sl80Be4zpyxhREipo1pmamMkGdVM
jhCMjG6QCCdjuIDedvbnz0KQaj+ndtGRHD41bmLZHwtWPC3rJt3Sh9i9IUsiZM1s
7UZcppDwRB60nK2lFNePQfIBNpaTmgABz21f6m6j+p3yyFXYffMAHwolVElMsyF5
al7Lcpd/LbDLQ/jFINrqMmuwjUwOxxy4f6N1i6YVH4dW8uMRJZa0Mso7XbQGht0L
AALUzASQOMUVnST+qLvvBeBFrxneDwYYggeicJSrIbvoFkLQSZbGJkdlpqqCGEQe
qf5INbqCsyTuJtOzYeEAWG1X64OkBaBm6ewdWWPtbcJmuSvDUttoAtMvSVpJt3l1
thItIN038vivpquDOqUe
=ACQ2
-----END PGP SIGNATURE-----

--3Gf/FFewwPeBMqCJ--
