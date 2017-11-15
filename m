From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v4 07/16] mtd: onenand: omap2: Account waiting time as
 waiting on IO
Date: Wed, 15 Nov 2017 16:00:04 +0100
Message-ID: <20171115150004.v2i47cjutt3bpaml@earth>
References: <20171111211206.465pgorrjp3eyix6@lenoch>
 <20171111212058.3xkqfw42ik6pre47@lenoch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7809787414503710552=="
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20171111212058.3xkqfw42ik6pre47@lenoch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Tony Lindgren <tony@atomide.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org


--===============7809787414503710552==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yckqe2bnwxotcayv"
Content-Disposition: inline


--yckqe2bnwxotcayv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Nov 11, 2017 at 10:20:58PM +0100, Ladislav Michl wrote:
> Use wait_for_completion_io_timeout, which has an impact on how the
> task is accounted in scheduling stats.
>=20
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> ---

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

>  Changes:
>  -v4: new patch
>=20
>  drivers/mtd/onenand/omap2.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
> index 883993bbe40b..0e7772e16d75 100644
> --- a/drivers/mtd/onenand/omap2.c
> +++ b/drivers/mtd/onenand/omap2.c
> @@ -170,9 +170,8 @@ static int omap2_onenand_wait(struct mtd_info *mtd, i=
nt state)
>  		if (result =3D=3D 0) {
>  			int retry_cnt =3D 0;
>  retry:
> -			result =3D wait_for_completion_timeout(&c->irq_done,
> -						    msecs_to_jiffies(20));
> -			if (result =3D=3D 0) {
> +			if (!wait_for_completion_io_timeout(&c->irq_done,
> +						msecs_to_jiffies(20))) {
>  				/* Timeout after 20ms */
>  				ctrl =3D read_reg(c, ONENAND_REG_CTRL_STATUS);
>  				if (ctrl & ONENAND_CTRL_ONGO &&
> --=20
> 2.11.0
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--yckqe2bnwxotcayv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAloMVnQACgkQ2O7X88g7
+ppsoQ/9FLHI+bVyjzhtu9gBqUZ6yytFlJ+L1BfPFCVFPg14OYZUcWIjO1cbJOhk
sRIAE7EZ/SiqT5PHRpWMF82EMiKA3ZQEUQAajNZk49l8EyqSlZQ61JAiW1okhS33
hy7jtL2/M8P454fGRtsttAx9iNR46iHfiXG6YvjjKMDlqRN/OHAKo1fP11EJb0cK
ijWYZsVm5yq/f9LKehBTSwftROIB6i80PbH8cNpYx0p6Nwecr1PD8xplk1PRulcz
4/iXjXZOtZFV9kbinojL6v+jo1MYb8ssM63yuxaJ9VrpOsbpAVZ2+R1MbvURDFvQ
U5RNI/S7QgGwcXFvnkkYll404T/vTxPUD9JmpZzDpzq536fYto+sZiWzweRXpm5V
rr4v5OwLuApMbgOH4PxNOzAtvZRvv9TQ2IF6yaRu031guTft1t8+xHwesdaS1yd8
WhwKlPyOD828FBiCUbT4Uk4Q059nnUSoKTdarIwuqwqS8T5fPON4mJiJMJPHYu1t
Vz8sroQs3E+ynqeXRCFfD8ricP9iII81Sl8Vw62ELb+zHU23kHOMKiNlxTesw3qI
WmcHfduGpk6urT169kwFEpjlqnAnVVRFww+ucu2YnX6F/WeW0HSHiyg0Q7RRQPLr
ykPEpVO48hoUINBXw2EH6rX/8jgfxsJRBpZDWNn4r8cwCcGTWFc=
=YIsg
-----END PGP SIGNATURE-----

--yckqe2bnwxotcayv--


--===============7809787414503710552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============7809787414503710552==--
