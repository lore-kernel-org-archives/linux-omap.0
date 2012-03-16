From: "Maximilian Schwerin" <Maximilian.Schwerin@tigris.de>
Subject: AW: [PATCH] OMAP3: OPP: Test for IVA subsystem before attempting to
 add IVA OPP
Date: Fri, 16 Mar 2012 10:26:49 +0100
Message-ID: <5448984682E7954C9BFF27F747A9C6CA56D6A8@dolphin.TIGRIS.local>
References: <8762e6et1u.fsf@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3145147046303034951=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <8762e6et1u.fsf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kevin Hilman <khilman@ti.com>, "Menon, Nishanth" <nm@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Steve Sakoman <steve@sakoman.com>
List-Id: linux-omap@vger.kernel.org

--===============3145147046303034951==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="=-0LlHK+2qETHwrXXD5vNL"

--=-0LlHK+2qETHwrXXD5vNL
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> Von: Kevin Hilman [mailto:khilman@ti.com]=20
>=20
> "Menon, Nishanth" <nm@ti.com> writes:
>=20
> > On Wed, Mar 14, 2012 at 16:15, Kevin Hilman <khilman@ti.com> wrote:
> >> Maximilian Schwerin <mvs@tigris.de> writes:
> >>
> >>> From: Steve Sakoman <steve@sakoman.com>
> >>>
> >>> Don't try to add IVA OPPs for OMAP3 versions not containing an IVA
> >>> subsystem, as this would make omap_init_opp_table fail.
> >>>
> >>> Signed-off-by: Steve Sakoman <steve@sakoman.com>
> >>> Signed-off-by: Maximilian Schwerin <mvs@tigris.de>
> >>
> >> Minor: patch subjects for arch/arm/* core code need to=20
> have the ARM:
> >> prefix also.
> >>
> >> Also, please run scripts/checkpatch.pl on your patch and fix the
> >> warnings.
> >>
> >>> ---
> >>> =A0arch/arm/mach-omap2/opp.c | =A0 =A04 ++++
> >>> =A01 files changed, 4 insertions(+), 0 deletions(-)
> >>>
> >>> diff --git a/arch/arm/mach-omap2/opp.c b/arch/arm/mach-omap2/opp.c
> >>> index 9262a6b..414f2ec 100644
> >>> --- a/arch/arm/mach-omap2/opp.c
> >>> +++ b/arch/arm/mach-omap2/opp.c
> >>> @@ -62,6 +62,10 @@ int __init omap_init_opp_table(struct=20
> omap_opp_def *opp_def,
> >>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
__func__, i);
> >>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> >>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >>> +
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 if ((strcmp(opp_def->hwmod_name,"iva") =
=3D=3D=20
> 0) && !omap3_has_iva())
> >>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> >>> +
> >>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 oh =3D =
omap_hwmod_lookup(opp_def->hwmod_name);
> >>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!oh || !oh->od) {
> >>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warn("%s: no hwmod =
or odev for %s, [%d] "
> >>
> >> Wouldn't the one-liner below do the same thing?
> >>
> >> Actually, your patch makes it less noisy at boot time, avoiding the
> >> pr_warn(), so is probably better.
> >
> > The only issue i have with current patch is that it=20
> focusses to solve
> > a specific device IVA.
> > we could have similar variances if we had SGX/AESS device etc
> > registered in the common
> > table. a generic solution might be preferable - could we reduce the
> > severity of pr_warn to pr_debug and do a continue instead?
>=20
> I agree, that would be a better generic solution.
>=20
> Kevin
>

This is a pragmatic and simple solution for a well understood problem =
with no side effects. Why not fix the problem now and do the generic =
solution later on?=20

I'm not a fulltime kernel dev. I have about two weeks to get my new =
board out to my customer... Every time I set up a new board, I have to =
fix problems using known patches that are sometimes years old. Every =
patch I have to find costs me hours of time I really don't have.=20

Just my two cents (euro cents of course :-), Maximilian

--=-0LlHK+2qETHwrXXD5vNL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAk9jB2QACgkQ6nqkzTWctv4OMwCcC/g2m7jcopL6P5XxxJRqjWUE
xscAn3bx9yAJQU0FVmJfMaKkOwWP/zln
=nuBR
-----END PGP SIGNATURE-----

--=-0LlHK+2qETHwrXXD5vNL--


--===============3145147046303034951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3145147046303034951==--
