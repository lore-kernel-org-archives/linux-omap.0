From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH-v4.2-rc6 2/5] arm: boot: dts: am4372: add ARM timers
 and SCU nodes
Date: Wed, 12 Aug 2015 14:54:01 -0500
Message-ID: <20150812195401.GB20972@saruman.tx.rr.com>
References: <1439242911-715-1-git-send-email-balbi@ti.com>
 <1439242911-715-3-git-send-email-balbi@ti.com>
 <20150812072816.GR4215@atomide.com>
 <20150812145216.GB13884@saruman.tx.rr.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0688799223684909108=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150812145216.GB13884@saruman.tx.rr.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

--===============0688799223684909108==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Content-Disposition: inline

--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 12, 2015 at 09:52:16AM -0500, Felipe Balbi wrote:
> On Wed, Aug 12, 2015 at 12:28:16AM -0700, Tony Lindgren wrote:
> > * Felipe Balbi <balbi@ti.com> [150810 14:44]:
> > > AM437x devices sport SCU, TWD and Global timers,
> > > let's add them to DTS so they have a chance to
> > > probe and be used by Linux.
> >=20
> > Is this one safe to apply already without the Kconfig change?
> >=20
> > Or will it cause multi_v7_defconfig with the timers selected
> > to not boot properly?
>=20
> I'd have to try :-) But it should be safe, just the timers won't be
> chosen for anything :-)

Just booted with only $subject and patch 1/5, it works just fine.

I'll resend the series (now, 4 patches only) and if RMK is fine with
patch 1, then I'll add to his patch system.

--=20
balbi

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVy6RZAAoJEIaOsuA1yqREg7wQAIv9TSNK8IepPY5eD4zQrGeZ
I0WuooA2Jm0S0ETMqN9jsVh/pV26mha3zejIP2foSxW+MmiZJPka7UJ9lpF/e4ok
hepWR7Vu52ZOeNawnyjuuWEY13wegGugkSQQkE/GLU/jCGMUY0CV0vd1iSJu+58j
QVXdNKsuutA6mrBFFePeF18RXCswZe0GB/QgVdtGabC8SFpRjBFJme5n1/3tAxXq
c/iQTN1Ds65DFrWpf5xoHt3ZhTgKE86bgVTutTK5OJs0fLecu0AofDBwqXcL8jaw
bfCu9noJCdHOojp/8buWFbX1yQkS8DYibZPmjEsVplAWHTPMKVHSpRprKBGqy3y0
RRRjTUOcjYerafi1R+DKmoZWdgiYTQO7CaOGGLoT55UTg4OJ9nSSaxG7KT6doNXJ
0kXboIoHdn2YMBARs42+Tp09Bairq0LDoZPRzdbW8IjDQro6YY8O6ZsL7LR93Ulh
OW7RNPkODboJuP5DatSPYDV3lzfvX0Xb8UljVwiQmJ9Vj/9WT0TfdgmLeLXuYiHw
A77fnteoCUt0OjvVvFZ/QGF/Vu01+P1HlBk5bwQs/6TW9dwQa4q/24mc/2A7tW1s
IsoH8G89leIWBdkLKFx1oumG6YrTQcgpdLjvX+tNsdc4DrIzMtH7M/1T/FfF8HpU
JbdeOFwdVVtRXtyrRQ+2
=JaMW
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--


--===============0688799223684909108==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0688799223684909108==--
