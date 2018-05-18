From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 4/4] omap4-droid4: Use software debounce for gpio-keys
Date: Fri, 18 May 2018 09:21:09 +0200
Message-ID: <20180518072109.GA31304@amd>
References: <20180517233542.30629-1-tony@atomide.com>
 <20180517233542.30629-5-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0852060653437929967=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180517233542.30629-5-tony@atomide.com>
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
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Marcel Partap <mpartap@gmx.net>, Dave Gerlach <d-gerlach@ti.com>, Keerthy <j-keerthy@ti.com>, Merlijn Wajer <merlijn@wizzup.org>, Sebastian Reichel <sre@kernel.org>, Kalle Valo <kvalo@codeaurora.org>, NeKit <nekit1000@gmail.com>, Eyal Reizer <eyalr@ti.com>, Ash Charles <ash@gumstix.com>, Michael Scott <hashcode0f@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============0852060653437929967==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The default value of 5ms will use GPIO hardware based debounce clocks
> that will keep L4PER from idling consuming about extra 30mW.
>=20
> Use a value of 10ms that is above the hardware debounce maximum of
> 7.95ms forcing software based debouncing.
>=20
> This allows droid4 to enter PER retention during idle as long as UARTs
> are idled and USB modules unloaded or unbound.
>=20
> Note that there seems to be a pending issue with having droid 4 enter core
> retention during idle where GPIO bank 1 needs to be reset late after init
> for some reason to not block core retention. In addition to that, we are
> also missing GPIO related PM runtime calls for omap4 that will be posted
> separately.

Thanks, will take a look.

BTW, did you notice that debouncing is wrong on most of the keyboard?
If you double click a key (most will do, for example "J") it will fail
to recognize second release and instead of expected "jj", you get
autorepeat ("jjjjjjjjjjjjjjjjjjjjjj...").

Ok, I guess main keyboard is not on GPIO...

Best regards,

								Pavel

> @@ -128,6 +128,7 @@
>  			gpios =3D <&gpio5 26 GPIO_ACTIVE_LOW>; /* gpio154 */
>  			linux,code =3D <KEY_VOLUMEDOWN>;
>  			linux,can-disable;
> +			debounce-interval =3D <10>;

I'd say this subtlety is worth a comment.

									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlr+fuUACgkQMOfwapXb+vKM2wCfYZ+SzfyR8jkxdz3LbZYil93D
CMAAoLGjy2ANfK2lE8yTl7t8hDaYC6Sh
=vTXP
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--


--===============0852060653437929967==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0852060653437929967==--
