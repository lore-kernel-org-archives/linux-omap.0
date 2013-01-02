From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 3/7] pwm: pwm-tiehrpwm: Update the clock handling of
 pwm-tiehrpwm driver
Date: Wed, 2 Jan 2013 14:38:43 +0100
Message-ID: <20130102133843.GA4414@avionic-0098.adnet.avionic-design.de>
References: <1357133094-30806-1-git-send-email-avinashphilip@ti.com>
 <1357133094-30806-4-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6671017753979430883=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1357133094-30806-4-git-send-email-avinashphilip@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Philip Avinash <avinashphilip@ti.com>
Cc: paul@pwsan.com, linux@arm.linux.org.uk, b-cousson@ti.com, tony@atomide.com, nsekhar@ti.com, linux-kernel@vger.kernel.org, hvaibhav@ti.com, gururaja.hebbar@ti.com, vaibhav.bedia@ti.com, anilkumar@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org


--===============6671017753979430883==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 02, 2013 at 06:54:50PM +0530, Philip Avinash wrote:
> The clock framework has changed and it's now better to invoke
> clock_prepare_enable() and clk_disable_unprepare() rather than the
> legacy clk_enable() and clk_disable() calls. This patch converts the
> pwm-tiehrpwm driver to the new framework.
>=20
> Signed-off-by: Philip Avinash <avinashphilip@ti.com>
> Cc: Thierry Reding <thierry.reding@avionic-design.de>
> ---
> In 3.8-rc1, common clock frame work support added to AM335x.
>=20
>  drivers/pwm/pwm-tiehrpwm.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
> index 72a6dd4..af6f162 100644
> --- a/drivers/pwm/pwm-tiehrpwm.c
> +++ b/drivers/pwm/pwm-tiehrpwm.c
> @@ -341,7 +341,7 @@ static int ehrpwm_pwm_enable(struct pwm_chip *chip, s=
truct pwm_device *pwm)
>  	configure_polarity(pc, pwm->hwpwm);
> =20
>  	/* Enable TBCLK before enabling PWM device */
> -	clk_enable(pc->tbclk);
> +	clk_prepare_enable(pc->tbclk);

I apparently didn't catch this before, but maybe it would be useful to
check the return value here to make sure we only proceed if the clock
can actually be enabled.

Thierry

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQ5DhjAAoJEN0jrNd/PrOhdu8P/12xU5M0R2PV1JLRaFyFOR6i
Y1SioRt3GENO+iJdEJGW74PcFBRyzjPxgcGpeaJ6p8ko0YpkT/Q0/HwNeqQ9ZKrb
aWmRXy+zlX6kGbxHp208fd4tGu3rwYyC49YUNVybNdtzVwU2KWB6yp0Ij463RYIS
/nBZaO/dNOHUzX1JJrBz8qQM/5br0ttztHLy4TH9jkN12yhMxVbk87t6jUikFnzs
+Y+xN1FJ8srHGKH63Ndw+BvKLLIgTdXirFW0QUoET9mYc3OGzhlu/oYyDocFzmQk
ldekPqJbuwinyzlAGYIjrSutknkx/zAfcjVF7Gnlyauktg39wZTGAVkIllmXhOKG
yIOJn0TSn1qWDMLvSkt9yfJ3+1y0CMMmn62xREExB7JTqpPwjEsIGCiXf4pVKB0e
Ojh7oDS1qpBX1qGeYB4W/MF0jyOWNtkWgghAqmQrwCdSxwAs0lxnDz1291EAtT6w
7AwPVdUcbhM4FNlAjn0fnl9HW4zmpIFhVRWotJLyR8gxhRDzUBu+sNdgfDy2pO5/
5JZOgTDwTuQntq49WtvyMdSyDIKqJTvIAeEikvgLhdD/OJKUtTAxKbKsfAbC/XMa
CeiDrodNomB0bjUCInUZSBpQ3QuVYPmx3gmIzEdmoNSOHlp4cLFlEXqiQxwH7gH6
Kzmal9AsBItpsF78d1vI
=dpiy
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--


--===============6671017753979430883==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============6671017753979430883==--
