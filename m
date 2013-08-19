From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH RESEND] i2c: move of helpers into the core
Date: Mon, 19 Aug 2013 15:10:05 -0500
Message-ID: <20130819201005.GM26587@radagast>
References: <1376918361-7014-1-git-send-email-wsa@the-dreams.de>
 <1376935183-11218-1-git-send-email-wsa@the-dreams.de>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0980446090809621484=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1376935183-11218-1-git-send-email-wsa@the-dreams.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: devicetree@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, linux-samsung-soc@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--===============0980446090809621484==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="McpcKDxJRrEJVmOH"
Content-Disposition: inline

--McpcKDxJRrEJVmOH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2013 at 07:59:40PM +0200, Wolfram Sang wrote:
> I2C of helpers used to live in of_i2c.c but experience (from SPI) shows
> that it is much cleaner to have this in the core. This also removes a
> circular dependency between the helpers and the core, and so we can
> finally register child nodes in the core instead of doing this manually
> in each driver. So, fix the drivers and documentation, too.
>=20
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

for i2c-omap.c:

Reviewed-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--McpcKDxJRrEJVmOH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSEnudAAoJEIaOsuA1yqREcNkP/0LKPk4o7wCnJXxOqAyLoeZd
WwCRafc7R0Ls3S5M28xTpxPm+34Ol7FOt8tezKWc1s6G6WCLxEo84glBf4gAWKhf
KaVC35hyoh1tibIeUZR4QfXYKn+UVxu6lMeEwJaC8+yMhuMjq0SLXBHkAUwsLCiN
q3/Unq+bsuNgup5HnIJ6aAOZfbYj047leZF/cnfqup3epSxcZDsU/1lVj+I19rL3
pTYeZ6WECWwhmxHj0rjEf3mgeqCaMwW8XCsRKDoDTOd/sTcvWsAooC53h2ygYe2b
tS9zeeNW9uIlZSmtR1yNBgr59PP1ykf0zp9jGOY0r8u/oP6HG5h/bAjLMN58dXwt
WWLYYJgj3mrXA2EtXoSKQnDNmJl7tLOJu3oxMpQfBbKlrCECgyvxp54xSQpUd+yB
0kT8QEY/wQXCLjlLJWuPWqHkHw+YNCTap//XQYEfPyubucT27Zxa8wz4vhmkjWdH
Cp1VEWD2O5sWpfwdyS7w54GgAOfkNyuF+FWus8zd7PN1hMxNKui2Tw8n4glmC2Ql
LljlBN9YZUvz9ETmJTFuGFGLnX3PZO/zWeF7JkXbEDjYV4tAlKYo0pW8SeTSnY6v
M3I3C6h4TFKDYmctFDbEJnZl8NBmBImV3Zhh+eRohrhimEtscvyoYAiFXtK3tgWN
ojVKmnuVliAHBulFgZbj
=wjr2
-----END PGP SIGNATURE-----

--McpcKDxJRrEJVmOH--


--===============0980446090809621484==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0980446090809621484==--
