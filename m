From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH v4 08/11] pwm: pwm-tiehrpwm: Adding TBCLK gating support.
Date: Thu, 22 Nov 2012 22:05:04 +0100
Message-ID: <20121122210504.GF16716@avionic-0098.adnet.avionic-design.de>
References: <1353503469-18634-1-git-send-email-avinashphilip@ti.com>
 <1353503469-18634-9-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="65ImJOski3p8EhYV"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1353503469-18634-9-git-send-email-avinashphilip@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: "Philip, Avinash" <avinashphilip@ti.com>
Cc: paul@pwsan.com, tony@atomide.com, linux@arm.linux.org.uk, b-cousson@ti.com, hvaibhav@ti.com, anilkumar@ti.com, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, gururaja.hebbar@ti.com, vaibhav.bedia@ti.com
List-Id: linux-omap@vger.kernel.org


--65ImJOski3p8EhYV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 21, 2012 at 06:41:05PM +0530, Philip, Avinash wrote:
> Some platforms (like AM33XX) requires clock gating from control module
> explicitly for TBCLK. Enabling of this clock required for the
> functioning of the time base sub module in EHRPWM module. So adding
> optional TBCLK handling if DT node populated with tbclkgating. This
> helps the driver can coexist for Davinci platforms.
>=20
> Signed-off-by: Philip, Avinash <avinashphilip@ti.com>
> ---
> Changes since v2:
> 	- Remove DT property for tbclkgating
> 	- Use devm_clk_get instead of clk_get
>=20
> Changes since v1:
> 	- Moved TBCLK enable from probe to .pwm_enable & disable from
> 	  remove to .pwm_disable
>=20
> :100644 100644 23fd3c3... 6e90829... M	drivers/pwm/pwm-tiehrpwm.c
>  drivers/pwm/pwm-tiehrpwm.c |   16 ++++++++++++++++
>  1 files changed, 16 insertions(+), 0 deletions(-)

Looks good.

Thierry

--65ImJOski3p8EhYV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQrpOAAAoJEN0jrNd/PrOhxB8QAKBPb7m2rDe17YCp187jyJx/
aYv6cqyoQBvgVL0WjOW4o+iAzoPFmUctoe5PD48VY5UMpzIdjGqLM+7alEQtdeAW
OP4ClHzsleKmzkIhnUMjw/zLDMal3qAYBCQwhTL/z0i/oTd5fnTrY2t+c708vVTN
y1xodUqFevACtAsjspUFZT1o8te1+erpMJhv3tK1amQ4/lfq/rEQ2S1J3gji0Njn
YIvlkSsmJ+/QYgq2JBi2ZrVIJawn0GAyOLt3h93CTIKg5g3mQtv4rANQUs+lK+lN
8qqqpHL9FKQoqa0xUjopgt8SF+DP7UA+xdJ2lNud5RBeLTno1dGYVaayzItKuaca
aSftUvACcNR8CFJ+7Z6Jt3QW3ktLkwcW2woWSRa+YUXtfT3Kje8zR5aOAI4jGR4M
BwjPQ4LMK2OrVCZGXjVKb03kSO5Hbz5UZxvffqPV5m/iLHEpOf4ARE2bpbb/tZ+S
6KKQAUrZ5lqlf0AYAZBx5W45llZ2NQLrJuyH/xsKGXmROXSddfB1bg3rDn8/K8cj
+RHoRT96Tv3hmQ15a7cRWwS6DIIBgPl+aeIzg8BgsrtmOM6jQ3HF9dcHw7aHT9so
wiYpx6vR7q5zyiwqQAyOVgCUdUMwyQlk4zT1BUV3SqnSi9jRXdjgX58xSLAg15aU
/aOR70BXyb5CtIJhOaJ2
=TXBX
-----END PGP SIGNATURE-----

--65ImJOski3p8EhYV--
