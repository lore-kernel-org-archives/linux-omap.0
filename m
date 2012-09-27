From: Felipe Balbi <balbi@ti.com>
Subject: Re: Which git to clone for testing prior to submitting bugs?
Date: Thu, 27 Sep 2012 21:55:46 +0300
Message-ID: <20120927185545.GA29861@arwen.pp.htv.fi>
References: <50648AA2.2010004@johnea.net>
 <CAOCHtYitbhOMv+YBaYgdTuYZQpZ_VLoP=QKVS=spmqPxEUkATA@mail.gmail.com>
 <5064A173.5000909@johnea.net>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:46162 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751650Ab2I0TAq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Sep 2012 15:00:46 -0400
Received: by bkcjk13 with SMTP id jk13so2364516bkc.19
        for <linux-omap@vger.kernel.org>; Thu, 27 Sep 2012 12:00:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <5064A173.5000909@johnea.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@johnea.net
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Sep 27, 2012 at 11:56:51AM -0700, linux@johnea.net wrote:
> On 09/27/2012 11:25 AM, Robert Nelson wrote:
> >On Thu, Sep 27, 2012 at 12:19 PM,<linux@johnea.net>  wrote:
> >>
> >>Hello,
> >>
> >>In a subsequent distro upgrade to 3.4.4 neither dvi, nor buddy=3Dspidev
> >>function anymore.
> >
> >"buddy=3Dxyz" is not upstream, so which 'tree'/'patchset' are you
> >currently using as a basis for your device?  The authors of that
> >patchset might be able to help out..
> >
>=20
> Thanks Robert,
>=20
> The 3.4.4 kernel is plain vanilla plus:
>=20
> http://rcn-ee.net/deb/sid-armhf/v3.4.4-x1/patch-3.4.4-x1.diff.gz
>=20
> We're running archlinuxarm, and working with devs there to upgrade to
> 3.5.4, in hopes this will address most or all of the issues. That will
> include:
>=20
> http://rcn-ee.net/deb/sid-armhf/v3.5.4-x6/patch-3.5.4-x6.diff.gz
>=20
> We adopted archlinux because it's about as close to a git kernel as
> can be had in a disto packaged format.
>=20
> If we still experience issues, I'm trying to understand what to clone
> to be relevant to this list.
>=20
> Which tree are patches submitted against here?

If you want to try with the public kernel, then try Linus' tree
(http://git.kernel.org/linus) but I'm not sure if we have beagle XM in
mainline yet.

Tony is DM3730 supported in mainline ?

--=20
balbi

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQZKExAAoJEIaOsuA1yqRERvkP/R6boxratNyEbBp+rao3MEaI
euZAMrPxyleiS5DrK8gWIKuKRtJS9Fv8JVdHVHuemrYpNy2nxgJ85heB95GcpcAs
pe3w06n9MRW4u1ryl0Od+5tmvh2i91ggaMW6SqUUid1/n/eN2s/Fb9GcR8tbaFFu
yZFRLTLpMh7OhrEQXhoyCKg4I4+vzlrWcqqum5i0JiRaGu7fGBm7KzUVVsKFnwhV
gkZLnfisYCZJG1CpG8QNg/AWou3O6RKWJ+vpeEkeD3kqCscDj+tTSJydGDAPHf3b
uYBIoMsbC3OTm/zTl9NUQpuXng3xMvpcgrZH6A7sijYjZ88qZkW7piZUlEnVQg5O
/gHI8LwuBRWcqdKbqSHZn6oNu6GWDSqAkKHWiAf8+z2mrFPnqUtoIA/ACwx4xsSZ
zEjDcWl1NS6Hr5teE+v9fxw8zifZX7VpiU4PzT8P2EqF7UZ+PMG8f51ziNdVJNF7
BdgMpY1gfNaBxRGmj8lGlhO8V/blwoLF0RKvfyC1ogc7B5+P6TmgkDBFsKxmzsjN
gzpcjRGKjC+FrGO8d2tjKc6iGHirMaiEkNbRB2L+7zGJZgI3pksctpzA2dJuW/RP
jkaXClHFUsVNzMnC5F+BmZpcnywoZgC7yaWmHfFlIyzzEilZZSa922UHF3XTyi5Z
/DZhlO2vJ00GJt9RaB5V
=Pi3f
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
