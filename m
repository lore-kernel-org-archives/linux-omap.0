From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: 4.18.0-rc1-next-20180619 boot failed on beagle board x15
Date: Mon, 6 Aug 2018 09:30:15 +1000
Message-ID: <20180806093015.6099ef5c@canb.auug.org.au>
References: <CA+G9fYuKW_jCFZPqG4tz=QY9ROfHO38KiCp9XTA+KaDOFVtcqQ@mail.gmail.com>
        <20180620102904.GC112168@atomide.com>
        <d5d57b10-facb-d5f7-ad7f-34afae726756@ti.com>
        <CAFY_6qqDcG7+sp7jawhTjuWHizPR75=HUsRJfGPhEPzVE4f5kg@mail.gmail.com>
        <6c15a753-c4a8-ff89-f5c0-0fd19c817c91@ti.com>
        <CAFY_6qq3=+hMLKr0VtCe-witPtV2LTeBSQb3pwqdzysbyiYtMQ@mail.gmail.com>
        <5206d66d-56d0-2edc-8dd0-00eedbaac3db@ti.com>
        <20180702093243.GO112168@atomide.com>
        <CAFY_6qo83Ui6_xRkuTYZUduUJSK2dLKhzd+B_nQ-XW5ciDH-7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/0YK+L5KAgQs0umX0hv0jfjt"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFY_6qo83Ui6_xRkuTYZUduUJSK2dLKhzd+B_nQ-XW5ciDH-7A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Morris <samorris@lexmark.com>, Tejun Heo <tj@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>, Naresh Kamboju <naresh.kamboju@linaro.org>, linux-omap@vger.kernel.org, Linux-Next Mailing List <linux-next@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, ssantosh@kernel.org, Olof Johansson <olof@lixom.net>, Tero Kristo <t-kristo@ti.com>, "Rafael J. Wysocki" <rafael@kernel.org>
List-Id: linux-omap@vger.kernel.org

--Sig_/0YK+L5KAgQs0umX0hv0jfjt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Mon, 2 Jul 2018 09:31:56 -0400 Samuel Morris <samorris@lexmark.com> wrot=
e:
>
> On Mon, Jul 2, 2018 at 5:32 AM, Tony Lindgren <tony@atomide.com> wrote:
> > Hi,
> >
> > * Roger Quadros <rogerq@ti.com> [180621 14:56]: =20
> >> On 21/06/18 17:31, Samuel Morris wrote: =20
> >> > On Thu, Jun 21, 2018 at 3:58 AM, Roger Quadros <rogerq@ti.com> wrote=
: =20
> >> >> +Rafael
> >> >>
> >> >> On 20/06/18 18:30, Samuel Morris wrote: =20
> >> >>> On Wed, Jun 20, 2018 at 8:58 AM, Roger Quadros <rogerq@ti.com> wro=
te: =20
> >> >>>> Tony,
> >> >>>>
> >> >>>> On 20/06/18 13:29, Tony Lindgren wrote: =20
> >> >>>>> Hi,
> >> >>>>>
> >> >>>>> * Naresh Kamboju <naresh.kamboju@linaro.org> [180620 05:55]: =20
> >> >>>>>> Linux next (4.18.0-rc1-next-20180619) boot failed on beagle boa=
rd x15. =20
> >> >>>>>
> >> >>>>> Bisect points to commit aece27a2f01b ("ata: ahci_platform: allow=
 disabling of
> >> >>>>> hotplug to save power").
> >> >>>>>
> >> >>>>> Reverting the patch makes things work again. Any ideas what
> >> >>>>> might be going wrong here? Things clearly idle but then there
> >> >>>>> seems to be some register access with clocks disabled. =20
> >
> > So this issue is still happening as of next-20180702. Can you guys
> > please revert the commit above while working on a better solution? =20
>=20
> That's fine with me. I'm not very familiar with the process here, does
> this require anything on my end? And would that require the
> accompanying patch to be reverted: "ata: ahci: rpm_put port on
> port_stop to match rpm_get in port_start"? There shouldn't be any
> problem leaving that one in, but I just want to know before submitting
> my next patch set.

I am still reverting that commit from linux-next myself.  Has this
issue been fixed some other way, or is it still ongoing?

--=20
Cheers,
Stephen Rothwell

--Sig_/0YK+L5KAgQs0umX0hv0jfjt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltniIcACgkQAVBC80lX
0Gy+uwgAjx18AusCZRh5RpDhTpXN2yvL7JAiPuWJVdZAb/EYFEAB/EP+oaNaKSla
xnFifSNuzIY//X39E3Rim6NMUdWSA9F6CqRGQMhOgFKtXQPzCytDuhVCQ7YYirYw
V5jYFmZLH0ZCgnP2fLX792gjBdIFUi/MYyLv8LVf2nM29dDX0+WqKqfIZn8BopEU
M5HYs5p2aD90gtyQtzWuz1y3zRyLYsBgY4HFdj+4ZAnuCfBFMFmBWCfHuZgqjSd+
ClFk7KI6Pf0hICdxn9yFF7mwgg6d2u/bebaqFhAr8re0RXiBZLEgs32opSpyeUig
0vyso/SsPqx1XvhU/j+6sWyceMeUdQ==
=37UH
-----END PGP SIGNATURE-----

--Sig_/0YK+L5KAgQs0umX0hv0jfjt--
