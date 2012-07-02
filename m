From: NeilBrown <neilb@suse.de>
Subject: Re: [PATCH] gpio/omap: fix invalid context restore of gpio bank-0
Date: Tue, 3 Jul 2012 09:34:04 +1000
Message-ID: <20120703093404.2a9b5aba@notabene.brown>
References: <1340990551-19426-1-git-send-email-jon-hunter@ti.com>
	<87mx3i595b.fsf@ti.com>
	<4FF1E7DE.10409@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/LLY0gEo.a5G.0PGCWaKSzk2"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37009 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751130Ab2GBXeO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Jul 2012 19:34:14 -0400
In-Reply-To: <4FF1E7DE.10409@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Grant Likely <grant.likely@secretlab.ca>, Linus Walleij <linus.walleij@stericsson.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Franky Lin <frankyl@broadcom.com>

--Sig_/LLY0gEo.a5G.0PGCWaKSzk2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Jul 2012 13:26:38 -0500 Jon Hunter <jon-hunter@ti.com> wrote:

>=20
> On 07/02/2012 01:07 PM, Kevin Hilman wrote:
> > + Neil Brown
> >=20
> > Hi Jon,
> >=20
> > Jon Hunter <jon-hunter@ti.com> writes:
> >=20
> >> Currently the gpio _runtime_resume/suspend functions are calling the
> >> get_context_loss_count() platform function if the function is populate=
d for
> >> a gpio bank. This function is used to determine if the gpio bank logic=
 state
> >> needs to be restored due to a power transition. This function will be =
populated
> >> for all banks, but it should only be called for banks that have the
> >> "loses_context" variable set. It is pointless to call this if loses_co=
ntext is
> >> false as we know the context will never be lost and will not need rest=
oring.
> >>
> >> For all OMAP2+ devices gpio bank-0 is in an always-on power domain and=
 so will
> >> never lose context. We found that the get_context_loss_count() was bei=
ng called
> >> for bank-0 during the probe and returning 1 instead of 0 indicating th=
at the
> >> context had been lost. This was causing the context restore function t=
o be
> >> called at probe time for this bank and because the context had never b=
een saved,
> >> was restoring an invalid state. This ultimately resulted in a crash [1=
].
> >>
> >> There are multiple bugs here that need to be addressed ...
> >>
> >> 1. Why the always-on power domain returns a context loss count of 1? T=
his needs
> >>    to be fixed in the power domain code. However, the gpio driver shou=
ld not
> >>    assume the loss count is 0 to begin with.
> >> 2. The omap gpio driver should never be calling get_context_loss_count=
 for a
> >>    gpio bank in a always-on domain. This is pointless and adds unnecce=
ssary
> >>    overhead.
> >> 3. The OMAP gpio driver assumes that the initial power domain context =
loss count
> >>    will be 0 at the time the gpio driver is probed. However, it could =
be
> >>    possible that this is not the case and an invalid context restore c=
ould be
> >>    performed during the probe. To avoid this otherwise only populated =
the
> >=20
> > The 'To avoid this...' sentence here doesn't read well.  Looks like you
> > need to:
> >=20
> > s/otherwise//
>=20
> Yes, I meant to have dropped "otherwise" here. Thanks!
>=20
> > s/populated/populate/
>=20
> Yes that too! I must have re-worded and screwed it up royally :-(
>=20
> > ?
> >=20
> >>    get_context_loss_count() function pointer after the initial call to
> >>    pm_runtime_get() has occurred. This will ensure that the first
> >>    pm_runtime_put() initialised the loss count correctly.
> >>
> >> This patch addresses issues 2 and 3 above.
> >> [1] http://marc.info/?l=3Dlinux-omap&m=3D134065775323775&w=3D2
> >>
> >> Cc: Grant Likely <grant.likely@secretlab.ca>
> >> Cc: Linus Walleij <linus.walleij@stericsson.com>
> >> Cc: Kevin Hilman <khilman@ti.com>
> >> Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> >> Cc: Franky Lin <frankyl@broadcom.com>
> >>
> >> Reported-by: Franky Lin <frankyl@broadcom.com>
> >> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> >=20
> > Thanks for digging inot this bug Jon.  The same bug was brought up by
> > Neil Brown (Cc'd) in a different thread.
> >=20
> > Neil, it looks to me that this fix will address the problems you were
> > seeing as well.  Care to test, and respond with your ack/tested-by if it
> > works for you?  Thanks.
>=20
> Neil let me know your thoughts and if you are ok, I can clean-up the
> changelog and re-send.

Yes, works for me and looks sensible.

 Tested-by: NeilBrown <neilb@suse.de>

Thanks,
NeilBrown

--Sig_/LLY0gEo.a5G.0PGCWaKSzk2
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBT/Iv7Dnsnt1WYoG5AQL9eA//fY1O+QsbjnPvhUWFmBgW2GmTGCiR75tm
+5lzpFt6IOON9eHwTQ0pM6NEvu2UZkalq9jXSOjDc/58T1Fu/84fOT05/NeMle6z
5NeqcJTDZwCym5/CN3av8fFkcJk7acbD4d8WMCpz77QZ6hnai9jrr7VYhaBYBxkD
nC98gwPxS84UPtHvyH87Gg3XIoZRpraZl0e+ImtXAUSKRLRQt5yrC4EWn5brRcEw
7l3ibEsXBwr6AQ/z13fWNDHxfP7X/xk+DY3zWJ4anZH22Ko8O3MlZQUI3qZ8eew7
tqb8Urbu02mpoFRk4EG5QdqeAGGNkjlbL9U4SsjdEixgdU+3D6y21vh2INFKZ/b4
nt84Lqup/bOvqWREY7CnB09Zm/MfJ6XtzWL+7w5zCRPm8dHAisroOFdZ5+qFpHLr
CnhDyRcLddFOg6Zi64TA7HkovNumFiDgZzEkdwB9KQu94B+Q0rxXmtzsBEPFiXdw
i73eT7VrS0lKXg1BrbVpx9dezbhWiRYdVAvOtySrdQYWNLjTk7kGEvgLcX9XbyJy
s1uS3Eg8KvsY+FmN9sCUftUrGR5fxqC855rLECPei1XYAs8qqOBSPym7jQqGNqe4
ueGUO/gR27F7Zd2CQAWBL9QrFYjiHDxAaq0DHyPMe8sZw69nQFJjG3ZVX6ZZlwIL
1HvGVN0UaQ8=
=91KR
-----END PGP SIGNATURE-----

--Sig_/LLY0gEo.a5G.0PGCWaKSzk2--
