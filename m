From: green <greenfreedom10@gmail.com>
Subject: Re: n800 build error in clock24xx.c: 'secure_32k_ck' undeclared
Date: Sun, 19 Apr 2009 19:23:36 -0600
Message-ID: <20090420012336.GE1736@swansys>
References: <873ac7ko2n.fsf@litku.valot.fi> <20090419050020.GC1736@swansys> <87prf8skiq.fsf@litku.valot.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7mxbaLlpDEyR1+x6"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:62158 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753478AbZDTBk4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 19 Apr 2009 21:40:56 -0400
Received: by qw-out-2122.google.com with SMTP id 5so753138qwd.37
        for <linux-omap@vger.kernel.org>; Sun, 19 Apr 2009 18:40:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87prf8skiq.fsf@litku.valot.fi>
Content-Language: en
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


--7mxbaLlpDEyR1+x6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Kalle Valo wrote at 2009-04-19 09:58 -0600:
> green <greenfreedom10@gmail.com> writes:
>=20
> > Kalle Valo wrote at 2009-04-17 14:44 -0600:
> >
> >> arch/arm/kernel/sys_oabi-compat.c: In function 'sys_oabi_epoll_wait':
> >> arch/arm/kernel/sys_oabi-compat.c:289: error: implicit declaration of =
function 'kmalloc'
> >> arch/arm/kernel/sys_oabi-compat.c:289: warning: assignment makes point=
er from integer without a cast
> >> arch/arm/kernel/sys_oabi-compat.c:302: error: implicit declaration of =
function 'kfree'
> >> arch/arm/kernel/sys_oabi-compat.c: In function 'sys_oabi_semtimedop':
> >> arch/arm/kernel/sys_oabi-compat.c:325: warning: assignment makes point=
er from integer without a cast
> >
> > I see nearly the same:
> >
> > arch/arm/kernel/sys_oabi-compat.c: In function =E2=80=98sys_oabi_epoll_=
wait=E2=80=99:
> > arch/arm/kernel/sys_oabi-compat.c:288: error: implicit declaration of f=
unction =E2=80=98kmalloc=E2=80=99
> > arch/arm/kernel/sys_oabi-compat.c:288: error: =E2=80=98GFP_KERNEL=E2=80=
=99 undeclared (first use in this function)
>=20
> I think that's the same error. Most probably my tree was dirty and
> that's the line numbers are different.

I was noticing the 'GFP_KERNEL' undeclared error rather than the line numbe=
rs.

--7mxbaLlpDEyR1+x6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknrzpgACgkQ682C+dBP+oSWyQCgz6vJMfL0DOhVOEANahBJpFL/
QpgAn1DXGHROhve8IRaQqN+7QsWi7ryF
=+kEl
-----END PGP SIGNATURE-----

--7mxbaLlpDEyR1+x6--
