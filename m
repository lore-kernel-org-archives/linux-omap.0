From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] usb: dwc3-pci: Ensure system sleep PM ops are defined
 only when used
Date: Fri, 9 Aug 2013 16:26:15 +0300
Message-ID: <20130809132615.GE12041@radagast>
References: <1375804166-3205-1-git-send-email-broonie@kernel.org>
 <CAOMZO5A_M3u4A3j7pFcooZ6jVi5LikERM4CVjL4bB2z5YVeTXQ@mail.gmail.com>
 <20130807093407.GT6427@sirena.org.uk>
 <CAAfg0W5fWdvX7aU8y29op70SFod=xqrr9kpxUUi=NKy71Y89Wg@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6Vw0j8UKbyX0bfpA"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58312 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966041Ab3HIN03 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Aug 2013 09:26:29 -0400
Content-Disposition: inline
In-Reply-To: <CAAfg0W5fWdvX7aU8y29op70SFod=xqrr9kpxUUi=NKy71Y89Wg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Green <andy.green@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linaro-kernel <linaro-kernel@lists.linaro.org>, linux-omap@vger.kernel.org

--6Vw0j8UKbyX0bfpA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2013 at 06:01:00PM +0800, Andy Green wrote:
> On 7 August 2013 17:34, Mark Brown <broonie@kernel.org> wrote:
> > On Tue, Aug 06, 2013 at 10:35:52PM -0300, Fabio Estevam wrote:
> >> On Tue, Aug 6, 2013 at 12:49 PM, Mark Brown <broonie@kernel.org> wrote:
> >> > From: Andy Green <andy.green@linaro.org>
> >> >
> >> > You might have CONFIG_PM, but you might not have CONFIG_SUSPEND, in =
which
> >> > case these are unused.
> >> >
> >> > Signed-off-by: Andy Green <andy.green@linaro.org>
> >> > Signed-off-by: Mark Brown <broonie@linaro.org>
> >
> >> What about doing this instead?
> >
> > Makes sense to me - Andy?
>=20
> Sure, it seems a much more complete solution.

looks good to me too, please send it as a real patch (if you already
have, sorry about that, catching up with my inbox now).

--=20
balbi

--6Vw0j8UKbyX0bfpA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSBO33AAoJEIaOsuA1yqREdLEP/0NTN8hhjVZri80gejJrcgzS
OaeL1lZHa3T1YAWM53n7DSAgrjVshT1YePaKn2LqYtzEmhjQN/cyKpfrScmWk/Jk
IQFYlpmexd7aYSzm3YS6jW/dQxLYYHbljPXwHBp/qIOGKYVIMn3Tf2EjTckSFcHt
/jelk7ME2XI30gbyuHTgNbfjko2gGbT0thfsdHQUftqRzNOc5zb0LRAZ2lmhvQHM
P0TlluQg5tZxvPfhMjxpLe8ykkM/vxWqU1u+gVvv5q4aja2rXGnHydPge3MKf1ki
Ts4c4q2MQNZgOz8VysvahelncczD5vvnnPkMS+lT0JmvRfuAB1s9b1Zlcz1SXCCA
nJqyg1LEfKkWkg/WgatfzRNfxbrTWQ0qJYhtdbw1dZaxCsrQDS5YdTaRkq229WMW
s85EkAaZIlTGSB0nIw7ZbZBbcDsNxT+sfAYQC6gYOuonrf73ZR3Zrx1Sxi35nuuP
30N/hy6dQjPsgx7CDili/NwIluK8i74JhbrOBrV5Tx9DaJbbiH1wOG8In2gw1B9l
f5BpLtU5hENmoncMh/A4s05SS9KVUlofHMpcNN4a5yy7PgqKbzFoqPN+y2E4eqZA
3P1Hax/kiRbyfVt8xhr6PwQS51k/j8WUPPw8LcQ1bSiNEcbKEqtW9621I+LLP4PX
BuSkkzVGEfqP0jqXYv2N
=q+vv
-----END PGP SIGNATURE-----

--6Vw0j8UKbyX0bfpA--
