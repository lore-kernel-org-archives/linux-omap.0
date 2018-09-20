From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC PATCH 2/4] i2c: core: remove level of indentation in
 i2c_transfer
Date: Fri, 21 Sep 2018 00:46:44 +0200
Message-ID: <20180920224644.GA988@kunai>
References: <20180920161423.13990-1-wsa+renesas@sang-engineering.com>
 <20180920161423.13990-3-wsa+renesas@sang-engineering.com>
 <c7ee2547-1b3b-3e43-e933-234516031770@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4422647163755939130=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <c7ee2547-1b3b-3e43-e933-234516031770@axentia.se>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Rosin <peda@axentia.se>
Cc: Tero Kristo <t-kristo@ti.com>, preid@electromag.com.au, Keerthy <j-keerthy@ti.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Grygorii Strashko <grygorii.strashko@ti.com>, linux-i2c@vger.kernel.org, Stefan Lengfeld <contact@stefanchrist.eu>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============4422647163755939130==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 20, 2018 at 07:26:21PM +0200, Peter Rosin wrote:
> On 2018-09-20 18:14, Wolfram Sang wrote:
> > Using the common kernel pattern to bail out at the beginning if some
> > conditions are not met, we can save a level of indentation. No
> > functional change.
> >=20
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> Yes please!

:)


--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlukI1AACgkQFA3kzBSg
KbZQtA/9EZ/aRI1W3Hz9M9y2zvwWMQm1oRZL35cMMMo1plixhlnExxinI5cvgy9l
+aIgdaug5uVq53Qc/gfkrB22GlQHxdyiZ9WOjBHWt4OgIBMxb6cf3NeaLRi4XG6X
DlkHWwKaz6J7UiRzyQuk3qgWlcgnMeNW93FxQmkoWKTxdvq6JyoF7/l0QcNBQby0
FqbZzptmX22Rjxr9acRE88GsmEQv726URKy3XBQLKuv02x1Wk4RCKwxtrcUELhcD
X1MQHqI/05x8JGKHE+BjtFGpQyeg5Myw16lmSK7eKvNyjKQT42HLnBTiayNYkbSY
gtWCb39gzhrrfb7MAT/Bl9TKg/ZmvyXJKdqTMnLBiX+Tqo/ZKRhDgBNUKsW+gQUW
jMyJicsPGHmQsMi+NZQgF4fpvEyE/VT2WFD3r58UIT+3ApwRIoGAnQJzOwjN+KtC
IKf3ezsVeTyTj4vizMaGIKVW9CTbeGpVTmIULabOo1+LXsxDruGPJjlUFuZz7Fdz
mvfYtO0w2iYfQHnPTcX+h8JW2KwVoAdLkVAvF1LekFfYxBwO0AF70wt3xbyBwHZ5
f0EngLB43KvNFxT831JyMfy+oQ8Vzxpanhr6mZHqMHAhW5/NY5a8MI002gvMGgJT
oHmaMgApIdW3lccaJLdsJKGsrhw7IclYRUXDU2ihrUNo7YnWS6E=
=7k+X
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--


--===============4422647163755939130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4422647163755939130==--
