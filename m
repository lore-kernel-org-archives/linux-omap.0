From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 7/8] ARM: OMAP2+: Allow core oswr for omap4
Date: Sun, 13 Oct 2019 17:08:07 +0200
Message-ID: <20191013150806.GE13278@amd>
References: <20191010001224.41826-1-tony@atomide.com>
 <20191010001224.41826-8-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5302955438175212347=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191010001224.41826-8-tony@atomide.com>
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


--===============5302955438175212347==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vmttodhTwj0NAgWp"
Content-Disposition: inline


--vmttodhTwj0NAgWp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-10-09 17:12:23, Tony Lindgren wrote:
> Commit f74297dd9354 ("ARM: OMAP2+: Make sure LOGICRETSTATE bits are not
> cleared") disabled oswr (open switch retention) for per and core domains
> as various GPIO related issues were noticed if the bootloader had
> configured the bits for LOGICRETSTATE for per and core domains.
>=20
> With the recent gpio-omap fixes, mostly related to commit e6818d29ea15
> ("gpio: gpio-omap: configure edge detection for level IRQs for idle
> wakeup"), things now behave for enabling core oswr for omap4.
>=20
> Cc: Merlijn Wajer <merlijn@wizzup.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

2,7,8 basically modify same lines of code? Should that be done in one
patch?

Best regards,

									Pavel
> =20
> -	/*
> -	 * Bootloader or kexec boot may have LOGICRETSTATE cleared
> -	 * for some domains. This is the case when kexec booting from
> -	 * Android kernels that support off mode for example.
> -	 * Make sure it's set at least for core and per, otherwise
> -	 * we currently will see lost GPIO interrupts for wlcore and
> -	 * smsc911x at least if per hits retention during idle.
> -	 */
> -	if (!strncmp(pwrdm->name, "core", 4)
> -		pwrdm_set_logic_retst(pwrdm, PWRDM_POWER_RET);
> -
> -	if (!strncmp(pwrdm->name, "l4per", 5)
> +	if (!strncmp(pwrdm->name, "core", 4) ||
> +	    !strncmp(pwrdm->name, "l4per", 5))
>  		pwrdm_set_logic_retst(pwrdm, PWRDM_POWER_OFF);
> =20
>  	pwrst =3D kmalloc(sizeof(struct power_state), GFP_ATOMIC);

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vmttodhTwj0NAgWp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl2jPdYACgkQMOfwapXb+vIJzACeMNSoapkU3z/f5DKDV6Y0WjlP
2mUAoJQ12bblkgVJi+y4SH2xOqtXPW2x
=yYl4
-----END PGP SIGNATURE-----

--vmttodhTwj0NAgWp--


--===============5302955438175212347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5302955438175212347==--
