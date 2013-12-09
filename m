From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 01/15] mfd: menelaus: Drop __exit section annotation
Date: Mon, 9 Dec 2013 10:14:22 -0600
Message-ID: <20131209161422.GC24047@saruman.home>
References: <1386042188-12246-1-git-send-email-balbi@ti.com>
 <20131203095136.GF11828@lee--X1>
 <20131208190739.GA18977@saruman.home>
 <20131209093748.GA12675@lee--X1>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5151653786516143614=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131209093748.GA12675@lee--X1>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lee Jones <lee.jones@linaro.org>
Cc: sameo@linux.intel.com, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============5151653786516143614==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ghzN8eJ9Qlbqn3iT"
Content-Disposition: inline

--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 09, 2013 at 09:37:48AM +0000, Lee Jones wrote:
> > > The code looks mostly fine, but the implementation of the commit logs
> > > seems lazy. Please submit a v3 using coherent sentences with full
> > > explanations and correct punctuation.
> >=20
> > example ?
>=20
> All of your commit messages.
>=20
> > that macro just helps removing some extra
>=20
>   ^- Sentences start with an uppercase character.
>=20
> > line of code and hides ffs() calls.
> >=20
> > while at that, also fix a variable shadowing
>=20
>   ^- Sentences start with an uppercase character.
>=20
> > bug where 'int irq' was being redeclared inside
> > inner loop while it was also argument to interrupt
> > handler.
>=20
>   < ---------------   50 chars   ----------------- >
>=20
> Please use the full 72 char (or there abouts) width of the buffer.

I don't see any mention of punctuation problems, however. Also, you're
not complaining about the content at all, which tells me those sentences
aren't as incoherent as you claimed before. But fair enough, I'll fix
those up and add Aaro's Tested-by

--=20
balbi

--ghzN8eJ9Qlbqn3iT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJSpexeAAoJEIaOsuA1yqRE3/IP/2PkBF7vCs18wGZHDeFgfDOI
nGF+ykmHeVeMXhpb/8BcD4Oob+X3sBsZ60+WZ6cUizAt40Dzq02548JtydFMjBnb
arb7qVmiYYvGEAHXP9nhm88q/+lBlB0Fu0i3i0pDhIHuxy4FieQmSidR/quDd5xW
1LwHeAtMFhk89TnPwuDZtEGUxN0Qb/f8ojbjl3yIC5JFVhJEdwRl+orRCa8vUBUI
1cvSWl/kAyKoazEkZ2Z9r9Qq/ge8FDEEyND672ng4Sq/t3sl6ck3minMplQ5+bUk
laEHFZ5+X3K600wwxu4cFKX5Rf2MdUp8hgFrcahgRxGR4uOP4ILoWmBiBn4DSv2x
J+Y0Yy0HEJh+OSGhCTYXaTLZmcpjVJXcgiK1lE8SXiYkj3Hy57YR4lF9d6HuKOUw
KoxDngPIDTe4GTf/oruTzGcJbx7BNngU76E7ttJaBYgIXiG+nzkHKtLhKnh6mapG
vZEY8hA6pIO1VKsFhv1fFbFZjag0sQ9LdRxWUdARb7QC5GpgHU/L6sYFpSVjzb+7
HoNC2Rv6HzQFYVuIvjqJimkOOZ0vQV9txxciuUjBTqeaIrrHUMY6Ut5Wmcba5gze
YUzDZ97lBPf/MNDmn5C07+APELLFJQCz5dg5n3YqESKe8yQgZYYT2idwsvHXrCJR
7yiPXEl70roKe+heWZtB
=3+qF
-----END PGP SIGNATURE-----

--ghzN8eJ9Qlbqn3iT--


--===============5151653786516143614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5151653786516143614==--
