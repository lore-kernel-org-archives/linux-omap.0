From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH-next 1/4] Revert "ARM: 7655/1: smp_twd: make
 twd_local_timer_of_register() no-op for nosmp"
Date: Thu, 13 Aug 2015 10:47:36 -0500
Message-ID: <20150813154736.GI27560@saruman.tx.rr.com>
References: <1439409416-32673-1-git-send-email-balbi@ti.com>
 <1439409416-32673-2-git-send-email-balbi@ti.com>
 <20150813153707.GF7576@n2100.arm.linux.org.uk>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1900897690205652899=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150813153707.GF7576@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Dirk Behme <dirk.behme@de.bosch.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Shawn Guo <shawn.guo@linaro.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============1900897690205652899==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sl5MdczEF/OU2Miu"
Content-Disposition: inline

--sl5MdczEF/OU2Miu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2015 at 04:37:07PM +0100, Russell King - ARM Linux wrote:
> On Wed, Aug 12, 2015 at 02:56:53PM -0500, Felipe Balbi wrote:
> > This reverts commit 904464b91eca8c665acea033489225af02eeb75a.
> >=20
> > The problem pointed out by commit 904464b91eca ("ARM: 7655/1:
> > smp_twd: make twd_local_timer_of_register() no-op for nosmp")
> > doesn't exist anymore.
> >=20
> > We can safely boot with nosmp and the warning won't show up.
> >=20
> > The other side benefit of this patch is that TWD has a chance
> > to probe on single-core A9 systems such as AM437x which sport
> > TWD.
>=20
> I don't remember all the details from Feb 2013 on why we made that
> change.  If this is proven safe, then I guess it's okay.

Do you want me to upload to your patch system and, perhaps, keep in
linux-next for v4.4 merge window ? (too late for v4.3 I guess).

--=20
balbi

--sl5MdczEF/OU2Miu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVzLwYAAoJEIaOsuA1yqREbroP/17d1BxyqTQB+JcihiF6JzdC
ifTPoCBPIUAddRwTrwQc74HCHd+sDtGWGQ4sxPuTgvs/+Bwq3EVeoSyG8TBAlMvR
mt/W8hwnq1uDZApXFsT39NJDlp745pNFIwm14WpmV2LJ3Gvlzdnzucxg7f+qPGDt
nIS3MH7g+wZwFdecU8/qFnESK8VNZdNJMJk2sbvDc2IPN4b5Gym7Ya8TBvPyZqrN
X7WJ2lsmLocL0sBtxf+QXyIpHgEEcgvrTa5os7h6E/R2nsFfr+vEiQCRZS2T4Wev
K/YkcymiUW9721PTGWy9RYGBYCgRIJAkwVjhkXMeYp3QxLLvGZVaFa79fNQyYb4z
DsLZ7UHNVQ81D1Y8JkQeZxyMrQJyayPnm+/b6ghGVcdc9Z1HqECB4BarHiBpvwOa
5GvVnHdK4ATev5Y+02JkJj6C/ZYAy55Kj+8k5GPKO12Tn64pyzm7fg/Vboxv7Opc
fDALHkvrh6z5n2L11jtvK4FVHnu2U/MimYyzktVo6ZKhg0Ab6OHr5AbOPXYiO6S0
WeuyRWeTX3+LbrIfuC4BkpYzdlwiDZA+vRVuC0WfZ/mBp4nhn8Cto9j+SHOOoPrg
YgmZCn7gAeIEJFnr6dJsoU1bu7P/gKVJnn6TDSxX4IgQt0iTcht4kijHJwBYf8wz
loegtinb9gaCHblw10Vo
=NKKp
-----END PGP SIGNATURE-----

--sl5MdczEF/OU2Miu--


--===============1900897690205652899==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1900897690205652899==--
