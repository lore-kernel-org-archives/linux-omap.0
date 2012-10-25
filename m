From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Thu, 25 Oct 2012 13:12:12 +0300
Message-ID: <20121025101212.GD21217@arwen.pp.htv.fi>
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com>
 <alpine.DEB.2.00.1210191645390.10773@utopia.booyaka.com>
 <alpine.DEB.2.00.1210200611150.9865@utopia.booyaka.com>
 <CAORVsuUkU3iTTFcXfYJ=_FntjiTR33Gs4z9OsNEn2Cxq7Ef-qA@mail.gmail.com>
 <CAORVsuWFzH3UmXCaY=iqmYsE72KOecLo40tG9BcTUBirJQ5iLA@mail.gmail.com>
 <alpine.DEB.2.00.1210231918500.27211@utopia.booyaka.com>
 <CAORVsuV9_4oc6+voEM9PkqzkXKHipor5XJqaXfDNxAWLofXcxg@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DrWhICOqskFTAXiy"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41684 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935163Ab2JYKSH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Oct 2012 06:18:07 -0400
Content-Disposition: inline
In-Reply-To: <CAORVsuV9_4oc6+voEM9PkqzkXKHipor5XJqaXfDNxAWLofXcxg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: Paul Walmsley <paul@pwsan.com>, balbi@ti.com, aaro.koskinen@iki.fi, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com

--DrWhICOqskFTAXiy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 23, 2012 at 09:23:03PM +0200, Jean Pihet wrote:
> On Tue, Oct 23, 2012 at 9:19 PM, Paul Walmsley <paul@pwsan.com> wrote:
> > On Mon, 22 Oct 2012, Jean Pihet wrote:
> >
> >> On Mon, Oct 22, 2012 at 6:12 PM, Jean Pihet <jean.pihet@newoldbits.com=
> wrote:
> >>
> >> > Do you have CPU_IDLE enabled?
> >> FYI the issue is not present with CPU_IDLE enabled.
> >
> > Hmm, how can you tell?  I thought you weren't able to reproduce it with
> > CPU_IDLE disabled either?
> I could not reproduce the issue, with and without CPU_IDLE enabled.
> What puzzles me is that the PM QoS code only has influence on the
> states chosen by cpuidle, so the change should not have any impact
> with CPU_IDLE enabled. I reallt need to reproduce the issue.
> Let me try with the same setup as yours (bootloader images,
> omap2pus_defconfig, angstrom roots).

I just sent a patch to fix a bug I found on OMAP4 panda but while
reading this thread again, I think it could be that it's the same bug
which is just easier to reproduce on Paul's setup.

Paul, Aaro, can you see if [1] makes the problem go away ? that would be
another reason to push [1] during this -rc cycle.

[1] http://marc.info/?l=3Dlinux-omap&m=3D135115602407925&w=3D2

--=20
balbi

--DrWhICOqskFTAXiy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQiRB8AAoJEIaOsuA1yqRE4AUP/27YEfRAHAZrXCb1W8NjRuGm
1Z+7Cx8BSs/9nFcfWuW792HonihqmFz9MTqmjaRvny1LbgqisEkRgQNh1Eg8+F0u
O4SoO7IwLGDg/SSKlDs0gK60zrIIe1+dcmtfLUQrkMXRWHMsLTTZ4/hNtWq2jPdf
WbiF8CRX3oaCSYB0Bi6q0ausnXbON4mxoPA38JGWJ+K/QSQK+R2690AxFifKD4rq
zFZeOeFooquGP4Mfe2w33W4tS022BrBwt2lT6js/objuRO3GB+nWo6vR/BcgibPD
bWPcJFRqyO2S9IIpKe/NNfbqYhGXpWPCpZWOSGQZgpQijoeVC0sJf0j/x8DBZRTW
HiVu3kp4png5VUHmJeYEdx4rpQd6QeFEXKVYPjQrgnp60N4P5QA6m44fzyeVvlVx
AYrgzTdkLn6ggjEGUspov0EInhi06MIHd9qJ7yHe8VO+iGzwBrd4VgNJwYviVYp1
jHMWPGx6BB6+FKmuxt0WgblelHKOTXghzk2OWgGH7A6hj/MaCuUp4YSfK7GDksks
L9zQHBc9TtkgOhu4q+rthCyNdiS32JwBWbPRYdita6YFxWRoXwDtdVmn2FcdLsvf
39eD26OTQD5VdgnrPw1QBsfrhwOf6TNlGgTM+kSeyKEP1LUVFxqLF8hfpEGmmasO
w97bYHqfcU25ToKMB97O
=R+++
-----END PGP SIGNATURE-----

--DrWhICOqskFTAXiy--
