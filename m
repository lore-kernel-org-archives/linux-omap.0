From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 0/2] ARM: DRA7XX/AM43XX build fixes
Date: Mon, 13 Jan 2014 10:24:37 -0600
Message-ID: <20140113162412.GF26950@saruman.home>
References: <1389347850-22435-1-git-send-email-t-kristo@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0855684203809316423=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1389347850-22435-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============0855684203809316423==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6b3yLyRKT1M6kiA0"
Content-Disposition: inline

--6b3yLyRKT1M6kiA0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2014 at 11:57:28AM +0200, Tero Kristo wrote:
> The move of clock code from mach-omap2 to drivers/clk/ti introduces
> a couple of new build errors with AM43XX/DRA7XX only builds. The
> following patches address these issues by modifying the Kconfig + Makefile
> under mach-omap2.
>=20
> Also, it seems DRA7XX only build is not possible at the moment, added
> patch #2 to fix this.

looks like we still need some extra patches since OMAP2-only builds
still fail :-(

Also omap1_defconfig fails miserably :-(

hoping this can still get fixed in time for 3.14 :-s

cheers

--=20
balbi

--6b3yLyRKT1M6kiA0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJS1BNFAAoJEIaOsuA1yqRElesP/3nFuYYfxfMofAwAx6k2LNh5
bcRgMG6FlU+ESFyQ/uUrvKxZDbSG+/H0zDi49TA9PQ0mXd7/Qo6FWwkpu9UF9kDr
IZQjJR4x0Ez3uVS0zUB7IHmRufrR8PKQUf84PyIPFxDtIImvIfnjAW+6e+lr5IC6
a/qvdYsiQ4JCR5SqlRO7mYI79egXX4RgD+25cLh2aE4DcAozFcKYZ8poqXlYBC/2
KwlzmH+dmTW2bQ7UQpI8OQIDNzERbLZxDoYzaG8AqTdKAumZWJZfl5ZiU1XyRq1x
NMcdwiguznCYNa1hKzIyds802WwQ43wXFLeFl5FwQySXw7I5ABQ/Bqx+6+aeqli8
a8ep1X4TI73oa4g9DSfuD5aI27S2Jw+iZ2Mwnpj478pmc/kEtOpVIbZxYKkUVqL3
n9B5RbUuooRKgPliKMeGa+EyFwnm0wZQq5BJbc9reiUmClgeauNinVQ11fw8Eyw8
6Isuc/e29GvzVqEGocsXoxxnT7kWrBf8rAH9fk0j+rI+u7DYgbxlL88hsrCmy1Rn
iSCjbPFvDMJkbP9If08MxEAzOJYJYCezsY7A13/nOWm3EhAmskFnvAeorqI94yzQ
V7evInLlYhgJ0hrarSaG20xc7Q7qg8EshrSbbqYtOe3yvkpUkh7Nh4DAnYSeasMJ
UleM0I+NglaI4fCG5Nj1
=Mnsr
-----END PGP SIGNATURE-----

--6b3yLyRKT1M6kiA0--


--===============0855684203809316423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0855684203809316423==--
