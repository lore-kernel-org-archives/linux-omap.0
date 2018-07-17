From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: 4.18.0-rc1-next-20180619 boot failed on beagle board x15
Date: Tue, 17 Jul 2018 18:00:28 +1000
Message-ID: <20180717180028.0ba098f6@canb.auug.org.au>
References: <CA+G9fYuKW_jCFZPqG4tz=QY9ROfHO38KiCp9XTA+KaDOFVtcqQ@mail.gmail.com>
        <20180620102904.GC112168@atomide.com>
        <d5d57b10-facb-d5f7-ad7f-34afae726756@ti.com>
        <CAFY_6qqDcG7+sp7jawhTjuWHizPR75=HUsRJfGPhEPzVE4f5kg@mail.gmail.com>
        <6c15a753-c4a8-ff89-f5c0-0fd19c817c91@ti.com>
        <CAFY_6qq3=+hMLKr0VtCe-witPtV2LTeBSQb3pwqdzysbyiYtMQ@mail.gmail.com>
        <5206d66d-56d0-2edc-8dd0-00eedbaac3db@ti.com>
        <20180702093243.GO112168@atomide.com>
        <CAFY_6qo83Ui6_xRkuTYZUduUJSK2dLKhzd+B_nQ-XW5ciDH-7A@mail.gmail.com>
        <20180717060808.GW99251@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/Hm7invgqnGXP7kvcNCVH6+o"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180717060808.GW99251@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Tejun Heo <tj@kernel.org>, Roger Quadros <rogerq@ti.com>, Naresh Kamboju <naresh.kamboju@linaro.org>, linux-omap@vger.kernel.org, Linux-Next Mailing List <linux-next@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, ssantosh@kernel.org, Olof Johansson <olof@lixom.net>, Tero Kristo <t-kristo@ti.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Samuel Morris <samorris@lexmark.com>
List-Id: linux-omap@vger.kernel.org

--Sig_/Hm7invgqnGXP7kvcNCVH6+o
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Mon, 16 Jul 2018 23:08:08 -0700 Tony Lindgren <tony@atomide.com> wrote:
>
> The following regression is still pending in next, see below.
>=20
> * Samuel Morris <samorris@lexmark.com> [180702 13:35]:
> > On Mon, Jul 2, 2018 at 5:32 AM, Tony Lindgren <tony@atomide.com> wrote:=
 =20
> > > Hi,
> > >
> > > * Roger Quadros <rogerq@ti.com> [180621 14:56]: =20
> > >> On 21/06/18 17:31, Samuel Morris wrote: =20
> > >> > On Thu, Jun 21, 2018 at 3:58 AM, Roger Quadros <rogerq@ti.com> wro=
te: =20
> > >> >> +Rafael
> > >> >>
> > >> >> On 20/06/18 18:30, Samuel Morris wrote: =20
> > >> >>> On Wed, Jun 20, 2018 at 8:58 AM, Roger Quadros <rogerq@ti.com> w=
rote: =20
> > >> >>>> Tony,
> > >> >>>>
> > >> >>>> On 20/06/18 13:29, Tony Lindgren wrote: =20
> > >> >>>>> Hi,
> > >> >>>>>
> > >> >>>>> * Naresh Kamboju <naresh.kamboju@linaro.org> [180620 05:55]: =
=20
> > >> >>>>>> Linux next (4.18.0-rc1-next-20180619) boot failed on beagle b=
oard x15. =20
> > >> >>>>>
> > >> >>>>> Bisect points to commit aece27a2f01b ("ata: ahci_platform: all=
ow disabling of
> > >> >>>>> hotplug to save power").
> > >> >>>>>
> > >> >>>>> Reverting the patch makes things work again. Any ideas what
> > >> >>>>> might be going wrong here? Things clearly idle but then there
> > >> >>>>> seems to be some register access with clocks disabled. =20
> > >
> > > So this issue is still happening as of next-20180702. Can you guys
> > > please revert the commit above while working on a better solution? =20
> >=20
> > That's fine with me. I'm not very familiar with the process here, does
> > this require anything on my end? And would that require the
> > accompanying patch to be reverted: "ata: ahci: rpm_put port on
> > port_stop to match rpm_get in port_start"? There shouldn't be any
> > problem leaving that one in, but I just want to know before submitting
> > my next patch set. =20
>=20
> Well usually the maintainer just reverts the regression causing
> patch in the related branch and that's it.
>=20
> Stephen, can you please revert in next until we hear back from
> Tejun?

OK, I have reverted that commit from today.  Please let me know when the
problem is fixed in the libata tree ...

--=20
Cheers,
Stephen Rothwell

--Sig_/Hm7invgqnGXP7kvcNCVH6+o
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAltNohwACgkQAVBC80lX
0GzfBQf9Hef9gp4izYBLjKnFS8pOE8SylX5vLn+IxcljOyakrzwV1SLupQVI3+ZL
bmL+xrbu5eY07Bt2xTjw/rkSfU38xxctWOFZiDXVGs1+N5n93LnTpDxbu567HyOK
3Kolafh0l6FcjSYUEuyENFeFqbMhPYRIFuCwwtjxPPcTzMH/BNinxfCAELvJO2E8
LZZ9kKiG0KWl4QkG7LdS8KYBsn9OmKQ8UGS7K7MHdxMKID+I8HVJdG52Cq+aVdgg
8ntbHhRQChOHQRSLdkOKP6a7Ng9fe5sff9yDwkeBuw59l51i1N5RRzrc1pkWOmlo
oVt5Y2BcaGIFor/0vKAj1Q3bJEJA/w==
=HbdJ
-----END PGP SIGNATURE-----

--Sig_/Hm7invgqnGXP7kvcNCVH6+o--
