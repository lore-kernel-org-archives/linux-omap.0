From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 4/5] mfd: tps65218: add version check to the PMIC probe
Date: Tue, 28 Jun 2016 12:14:02 +0100
Message-ID: <20160628111402.GA24982@dell>
References: <1466756892-17015-1-git-send-email-j-keerthy@ti.com>
 <1466756892-17015-4-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1466756892-17015-4-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com, broonie@kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, russ.dill@ti.com, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

On Fri, 24 Jun 2016, Keerthy wrote:

> From: Tero Kristo <t-kristo@ti.com>
>=20
> Version information will be needed to handle some error cases under t=
he
> regulator driver, so store the information once during MFD probe.
>=20
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  drivers/mfd/tps65218.c       | 9 +++++++++
>  include/linux/mfd/tps65218.h | 1 +
>  2 files changed, 10 insertions(+)

Acked-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/drivers/mfd/tps65218.c b/drivers/mfd/tps65218.c
> index 80b9dc3..ba610ad 100644
> --- a/drivers/mfd/tps65218.c
> +++ b/drivers/mfd/tps65218.c
> @@ -219,6 +219,7 @@ static int tps65218_probe(struct i2c_client *clie=
nt,
>  	struct tps65218 *tps;
>  	const struct of_device_id *match;
>  	int ret;
> +	unsigned int chipid;
> =20
>  	match =3D of_match_device(of_tps65218_match_table, &client->dev);
>  	if (!match) {
> @@ -250,6 +251,14 @@ static int tps65218_probe(struct i2c_client *cli=
ent,
>  	if (ret < 0)
>  		return ret;
> =20
> +	ret =3D tps65218_reg_read(tps, TPS65218_REG_CHIPID, &chipid);
> +	if (ret) {
> +		dev_err(tps->dev, "Failed to read chipid: %d\n", ret);
> +		return ret;
> +	}
> +
> +	tps->rev =3D chipid & TPS65218_CHIPID_REV_MASK;
> +
>  	ret =3D of_platform_populate(client->dev.of_node, NULL, NULL,
>  				   &client->dev);
>  	if (ret < 0)
> diff --git a/include/linux/mfd/tps65218.h b/include/linux/mfd/tps6521=
8.h
> index 7fdf532..85e464e 100644
> --- a/include/linux/mfd/tps65218.h
> +++ b/include/linux/mfd/tps65218.h
> @@ -267,6 +267,7 @@ struct tps_info {
>  struct tps65218 {
>  	struct device *dev;
>  	unsigned int id;
> +	u8 rev;
> =20
>  	struct mutex tps_lock;		/* lock guarding the data structure */
>  	/* IRQ Data */

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
