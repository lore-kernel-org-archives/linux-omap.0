From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] omap: pm: Fix overflow when doing powerdomain deps
 lookups.
Date: Wed, 12 Aug 2009 00:32:03 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0908120029530.8886@utopia.booyaka.com>
References: <1249956052-21893-1-git-send-email-mike@android.com>  <87tz0e76vk.fsf@deeprootsystems.com> <8bb80c380908111111m5a0a3417n3fea568cb8ea9124@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="155748971-1429603426-1250058621=:8886"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57821 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbZHLGcD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 02:32:03 -0400
In-Reply-To: <8bb80c380908111111m5a0a3417n3fea568cb8ea9124@mail.gmail.com>
Content-ID: <alpine.DEB.2.00.0908120030480.8886@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Chan <mike@android.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--155748971-1429603426-1250058621=:8886
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <alpine.DEB.2.00.0908120030481.8886@utopia.booyaka.com>

Hi Mike,

On Tue, 11 Aug 2009, Mike Chan wrote:

> On Tue, Aug 11, 2009 at 7:38 AM, Kevin
> Hilman<khilman@deeprootsystems.com> wrote:
> > Mike Chan <mike@android.com> writes:
> >
> >> Signed-off-by: Mike Chan <mike@android.com>
> >> ---
> >> =A0arch/arm/mach-omap2/powerdomain.c | =A0 =A02 +-
> >> =A01 files changed, 1 insertions(+), 1 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/p=
owerdomain.c
> >> index 0334609..6077629 100644
> >> --- a/arch/arm/mach-omap2/powerdomain.c
> >> +++ b/arch/arm/mach-omap2/powerdomain.c
> >> @@ -90,7 +90,7 @@ static struct powerdomain *_pwrdm_deps_lookup(struct=
 powerdomain *pwrdm,
> >> =A0 =A0 =A0 if (!pwrdm || !deps || !omap_chip_is(pwrdm->omap_chip))
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-EINVAL);
> >>
> >> - =A0 =A0 for (pd =3D deps; pd; pd++) {
> >> + =A0 =A0 for (pd =3D deps; pd->pwrdm_name; pd++) {
> >
> > Maybe should be:
> >
> > =A0 =A0 =A0 =A0for (pd =3D deps; pd && pd->pwrdm_name; pd++) {
> >
>=20
> At the end of the list pd is a pointer to a NULL struct, so checking
> if the address =3D=3D NULL doesn't help here. In fact the original code
> will just keep running past the struct to read who knows what in
> memory.
>=20
> This case manifests itself when from clkdms_setup() when enabling auto
> idle for a clock domain and the clockdomain usecount is greater than
> 0. When _clkdm_add_autodeps() tries to add the a dependency that does
> not exist in the powerdomain->wkdep_srcs array the for loop will run
> past the wkdep_srcs array.
>=20
> Currently in linux-omap you won't hit this because the not found case
> is never executed, unless you start modifying powerdomains and their
> wakeup/sleep deps.
>=20
> --Mike

Thanks for the patch, this is correct.  But the patch also should modify:

        if (!pd)
                return ERR_PTR(-ENOENT);

after the loop to be

=09if (!pd->pwrdm_name)
=09=09...

Could you revise this and resend?

thanks


- Paul
--155748971-1429603426-1250058621=:8886--
