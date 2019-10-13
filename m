From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/8] ARM: OMAP2+: Drop bogus wkup domain oswr setting
Date: Sun, 13 Oct 2019 17:07:44 +0200
Message-ID: <20191013150744.GD13278@amd>
References: <20191010001224.41826-1-tony@atomide.com>
 <20191010001224.41826-3-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7009002446132112942=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191010001224.41826-3-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Merlijn Wajer <merlijn@wizzup.org>, linux-omap@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============7009002446132112942==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="g7w8+K/95kPelPD2"
Content-Disposition: inline


--g7w8+K/95kPelPD2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The wkup domain is always on and does not have logic off setting. This
> got accidentally added by commit f74297dd9354 ("ARM: OMAP2+: Make sure
> LOGICRETSTATE bits are not cleared") but is harmless.
>=20
> Cc: Merlijn Wajer <merlijn@wizzup.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/pm44xx.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
> --- a/arch/arm/mach-omap2/pm44xx.c
> +++ b/arch/arm/mach-omap2/pm44xx.c
> @@ -137,8 +137,7 @@ static int __init pwrdms_setup(struct powerdomain *pw=
rdm, void *unused)
>  	 * smsc911x at least if per hits retention during idle.
>  	 */
>  	if (!strncmp(pwrdm->name, "core", 4) ||
> -	    !strncmp(pwrdm->name, "l4per", 5) ||
> -	    !strncmp(pwrdm->name, "wkup", 4))
> +	    !strncmp(pwrdm->name, "l4per", 5))
>  		pwrdm_set_logic_retst(pwrdm, PWRDM_POWER_RET);

This is rather theoretical, but if the powerdomain is called
"corelation-not-causation", do you still want the if() to trigger?

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--g7w8+K/95kPelPD2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2jPcAACgkQMOfwapXb+vLvaQCfZphVuGB+26TYrQM9wURB4MpE
ujoAoJwodeejH3c14UMdTuuo+wICdQj0
=FiNP
-----END PGP SIGNATURE-----

--g7w8+K/95kPelPD2--


--===============7009002446132112942==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7009002446132112942==--
