From: green <greenfreedom10@gmail.com>
Subject: Re: n800 build error in clock24xx.c: 'secure_32k_ck' undeclared
Date: Sat, 18 Apr 2009 23:00:20 -0600
Message-ID: <20090419050020.GC1736@swansys>
References: <873ac7ko2n.fsf@litku.valot.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IDYEmSnFhs3mNXr+"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:9288 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758074AbZDSOpg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 19 Apr 2009 10:45:36 -0400
Received: by qw-out-2122.google.com with SMTP id 5so645155qwd.37
        for <linux-omap@vger.kernel.org>; Sun, 19 Apr 2009 07:45:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <873ac7ko2n.fsf@litku.valot.fi>
Content-Language: en
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


--IDYEmSnFhs3mNXr+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Kalle Valo wrote at 2009-04-17 14:44 -0600:
> I'm trying to compile n800 kernel with latest linux-omap tree. First I
> got strange build error:

Here too, on n810.

> arch/arm/kernel/sys_oabi-compat.c: In function 'sys_oabi_epoll_wait':
> arch/arm/kernel/sys_oabi-compat.c:289: error: implicit declaration of fun=
ction 'kmalloc'
> arch/arm/kernel/sys_oabi-compat.c:289: warning: assignment makes pointer =
=66rom integer without a cast
> arch/arm/kernel/sys_oabi-compat.c:302: error: implicit declaration of fun=
ction 'kfree'
> arch/arm/kernel/sys_oabi-compat.c: In function 'sys_oabi_semtimedop':
> arch/arm/kernel/sys_oabi-compat.c:325: warning: assignment makes pointer =
=66rom integer without a cast

I see nearly the same:

arch/arm/kernel/sys_oabi-compat.c: In function =E2=80=98sys_oabi_epoll_wait=
=E2=80=99:
arch/arm/kernel/sys_oabi-compat.c:288: error: implicit declaration of funct=
ion =E2=80=98kmalloc=E2=80=99
arch/arm/kernel/sys_oabi-compat.c:288: error: =E2=80=98GFP_KERNEL=E2=80=99 =
undeclared (first use in this function)
arch/arm/kernel/sys_oabi-compat.c:288: error: (Each undeclared identifier i=
s reported only once
arch/arm/kernel/sys_oabi-compat.c:288: error: for each function it appears =
in.)
arch/arm/kernel/sys_oabi-compat.c:288: warning: assignment makes pointer fr=
om integer without a cast
arch/arm/kernel/sys_oabi-compat.c:301: error: implicit declaration of funct=
ion =E2=80=98kfree=E2=80=99
arch/arm/kernel/sys_oabi-compat.c: In function =E2=80=98sys_oabi_semtimedop=
=E2=80=99:
arch/arm/kernel/sys_oabi-compat.c:324: error: =E2=80=98GFP_KERNEL=E2=80=99 =
undeclared (first use in this function)
arch/arm/kernel/sys_oabi-compat.c:324: warning: assignment makes pointer fr=
om integer without a cast

--IDYEmSnFhs3mNXr+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknqr+QACgkQ682C+dBP+oSJrQCeOjAVqyVOIikMVdNKKkoBSMmk
/d4AnRh8xAAq4RK6X1hUIj7i2sw8sqZm
=2eC9
-----END PGP SIGNATURE-----

--IDYEmSnFhs3mNXr+--
