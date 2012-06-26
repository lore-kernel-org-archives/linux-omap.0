From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: Check if RPM enabled before trying to change
 state
Date: Tue, 26 Jun 2012 21:44:03 +0300
Message-ID: <1340736243.24530.98.camel@deskari>
References: <1340438771-25587-1-git-send-email-jaswinder.singh@linaro.org>
	 <1340605221.12683.30.camel@lappyti>
	 <CAJe_Zhf-H0dLtFsFAcryDy3av60RjmWmP+d3GSaxq8dNZKiXWw@mail.gmail.com>
	 <1340616643.3395.19.camel@deskari>
	 <CAJe_ZhftuNggxH+269-ZJbWJo5nSzSjo1dDCTQGMbsjPWoUpyg@mail.gmail.com>
	 <1340628094.3395.63.camel@deskari>
	 <CAJe_ZhetdEwrgDEfV9rLHU1_fmb3O+954hCKcoENBgQ6Bi6BXQ@mail.gmail.com>
	 <1340632161.3395.100.camel@deskari>
	 <CAJe_ZheHoCikVzy6zJoKHuL8_oQ0ZnPASUUWimvbPRr+AZ4zWg@mail.gmail.com>
	 <1340695166.2093.22.camel@lappyti>
	 <CAJe_Zhev3V85K1jhj+W+d+0kv132MZ=-7rChhCLgtWO7WN4u1w@mail.gmail.com>
	 <1340701660.24530.17.camel@deskari>
	 <CAJe_Zhd-LA67yO-H_7pacB_T8_z6=Zf47QuoHSJcsXDZ9S+byw@mail.gmail.com>
	 <1340712213.24530.21.camel@deskari>
	 <CAJe_ZhcxVAUuuMDZ8p1LVae4N2aZb_vFs_nRLfb7atJ2j6j=Sg@mail.gmail.com>
	 <1340723296.24530.68.camel@deskari>
	 <CAJe_ZheMN_sqaANSMepmhDDp2a2sQAVPYD1-owBWpwwbxqAtHQ@mail.gmail.com>
	 <1340723514.24530.70.camel@deskari>
	 <CAJe_ZheXSquxOtOD9iPyQjZ-jxWKzVGZHYkjM=wC37qgMZeJug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-c+LvscmYQ4c3fzCBHAct"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:49952 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757370Ab2FZSoI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jun 2012 14:44:08 -0400
Received: by lbbgj3 with SMTP id gj3so509392lbb.11
        for <linux-omap@vger.kernel.org>; Tue, 26 Jun 2012 11:44:05 -0700 (PDT)
In-Reply-To: <CAJe_ZheXSquxOtOD9iPyQjZ-jxWKzVGZHYkjM=wC37qgMZeJug@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jassi Brar <jaswinder.singh@linaro.org>
Cc: mythripk@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, andy.green@linaro.org, n-dechesne@ti.com


--=-c+LvscmYQ4c3fzCBHAct
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-06-26 at 22:31 +0530, Jassi Brar wrote:

> While I think your patch is simpler and achieve the same, I also think
> your fears about this patch are unfounded.

Perhaps. But I do get a bad feeling from your patch, and I don't like
when that happens =3D). What I fear with changes like you made is that
they'll hide problems that should be fixed in other ways.

And I think that was the case here also. I think we should not call
dispc_runtime_get() during suspend. If pm_runtime_get returns -EACCES,
we do have a possible problem, and we should not silently ignore it.

> A quick snack for thought...
> >
> > But if pm_runtime_get_sync() returns an error, it means the HW has not
> > been resumed successfully, and is not operational,
> >
> Not always. The HW could be in RPM_ACTIVE state while PM on it could
> be disabled, if the returned error is -EACCESS.   And
> pm_runtime_enabled() only catches a potential -EACCESS.

True. But the HW could also be in disabled state. And that would lead to
a crash when accessing the registers.

It is not a fatal error if pm_runtime_get returns -EACCES, but we sure
shouldn't ignore it (or avoid it with pm_runtime_enabled()), but handle
it. In some rare cases it could be ok to get -EACCES, but that's a
special case, not standard.

> BTW, I just tested your patch and it worked for me as well. But as
> suspected, it doesn't help the stack spew of CONFIG_PM_RUNTIME:=3Dn
>=20
> So I understand, I only need to resend the other three patches ?

Yes, please.

 Tomi


--=-c+LvscmYQ4c3fzCBHAct
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJP6gLzAAoJEPo9qoy8lh71x/8P/jrVqlYbYqXG07dYKIym0ewl
1IsDeFikGGTc3C47bpvSSs23HJspBqTWmXCO20WBXIY+14SNnh5nkQ4dM4Wlwt4P
lrbvcaJbTHub8ctNsH80ubKYK1b+WVvcYeZejo1k352cJfGLG26/Nx0CcJtOvjgz
PrLwH0kbqyOQq9wB3/nL4t0k2Uyhh8AOZDKhiXanw95esXTgeaiTnHkrAArRUq6o
Cr/zK5DWjzOMx5sOC//z3DJZgY3rnV72XOlOQegEq3X1rez/Dp21fe4qIm9BcWg4
kGpej6wW2E5sN1H7wKAWJXGV4RVABwywixPnX026pX05BYWkHzV+18ysmSCocGyM
NarJwgh1iOGEUyVdLf/MLD1FS62/RTdos9ghoLLNQ0d084kHHwXTg2xdV+COtZsz
j0M5RsHMlyt0e0+MxdLGyLDGB0w8w/8qB4Otqf6GJ5UFBNAkKdUYPke51Wxac8Az
Taq3aclq35lDmiXMkRqJ+cbSw27PL0xEaEqDQNA06MfK2JS6o/fNLWzPez4igTh5
vJQwF135yync5U2ISwF0ZU6dS+dD/ZXokur+1HnLr7KZ91OvAyhPK8BZ/1SJ81R7
XJS5PYtdwG1oY4sd+JbG0oqtHuc2Ncrkic9BQRvGL4FHuror0r5ktE4GNVuQYrpg
FOz6bd3hTAwKC0neZqbH
=2Nqo
-----END PGP SIGNATURE-----

--=-c+LvscmYQ4c3fzCBHAct--

