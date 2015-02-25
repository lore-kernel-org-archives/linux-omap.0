From: Felipe Balbi <balbi@ti.com>
Subject: build warning on v4.0-rc1
Date: Wed, 25 Feb 2015 11:51:43 -0600
Message-ID: <20150225175143.GE11136@saruman.tx.rr.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dFWYt1i2NyOo1oI9"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

--dFWYt1i2NyOo1oI9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Al,

commit 3b994d98a815d934ab6a77a380882865982c14f9 (get rid of the second
argument of acct_kill()) added a new build warning when building
kernel/acct.c. Warning can be seen below. Revert of that commit is
non-trivial, so I haven't tried to check if reverting it fixes the
warning.

One one to silent the warning would be to cast return of cmpxchg to void
on the call inside acct_pin_kill(), but maybe there's a better way?

In file included from ./arch/arm/include/asm/atomic.h:19:0,
                 from include/linux/atomic.h:4,
                 from include/linux/debug_locks.h:5,
                 from include/linux/lockdep.h:23,
                 from include/linux/spinlock_types.h:18,
                 from include/linux/spinlock.h:81,
                 from include/linux/mmzone.h:7,
                 from include/linux/gfp.h:5,
                 from include/linux/mm.h:9,
                 from kernel/acct.c:46:
kernel/acct.c: In function =E2=80=98acct_kill=E2=80=99:
=2E/arch/arm/include/asm/cmpxchg.h:205:3: warning: value computed is not us=
ed [-Wunused-value]
  ((__typeof__(*(ptr)))__cmpxchg_mb((ptr),   \
   ^
kernel/acct.c:181:3: note: in expansion of macro =E2=80=98cmpxchg=E2=80=99
   cmpxchg(&ns->bacct, acct, NULL);
   ^

cheers

--=20
balbi

--dFWYt1i2NyOo1oI9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU7guvAAoJEIaOsuA1yqREBdsP+wdDfCZvN7XJu05cWVyhXRew
j69KcJ0y224VVAzZEKUpzVyNSE7aBabJz/OxJAYB4c620XZ1MnkXkOxuHgNqlCjq
d8XV8MCwtIjabW7YefYotzsIBtXHVnZ3F1jybNTQiS2a2Jl1P2R8jsABizbMbRhE
mn0q0U/kS4fqBab4XlcK6SLR3JxT919Vgz5af8XFsJtXqgORaCDzr07SNNTM2db4
q1e6aoTphrg011G2lvxFW7sznWh/bs+MpOhsFxR8R/1q0+fFiNcxWjtd+x0lzKQA
49u4cpYcUn30PmLJmny1IttKkhMIeI1pJ7+tMSrXB6NiesliSzrxJJ20A4FQIP6v
XRJX9WivDnJC3pcVtl6GcMDNEN3B23l4H4V9i4E3voRlEzdgWi1ABNEmy9Puh2pa
h43h2FSF9ygqBm33H91XR9KEdcjXNmICdNszBQNg0v07XuNfCIrkmFy+iAiLNJ18
peLL4/prYGizriXkNm41ySBpR+4qoKCaVMzMmnqJYCoc4T4XAKOi74HcV6oHGLz1
5PaKQcrGScp6jEkvWVg8b03svQ4dmLU0+OMFJpedd/yBjl/JI7/YAEnBOZ8dRiRq
otkEg+dZjkpr7Nc0dL+HnJ2fct8NTLbxXqqtATzqb0EFZztndVmmU+p9aB8T9VIW
b2vhn5ct3b9cCW54AXLN
=co00
-----END PGP SIGNATURE-----

--dFWYt1i2NyOo1oI9--
