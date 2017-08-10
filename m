From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] memory: Convert to using %pOF instead of full_name
Date: Thu, 10 Aug 2017 10:10:52 +0300
Message-ID: <bf4e23a9-ee21-71c6-af13-adf3fe12b5f4@ti.com>
References: <20170718214339.7774-34-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170718214339.7774-34-robh@kernel.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>, arm@kernel.org
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Tony Lindgren <tony@atomide.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

=EF=BB=BF
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Bu=
siness ID: 0615521-4. Kotipaikka/Domicile: Helsinki

On 19/07/17 00:43, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
> Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> Cc: Roger Quadros <rogerq@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-omap@vger.kernel.org
> ---
>  drivers/memory/atmel-ebi.c    | 17 ++++++++---------
>  drivers/memory/jz4780-nemc.c  | 12 ++++++------
>  drivers/memory/mvebu-devbus.c | 12 ++++++------
>  drivers/memory/omap-gpmc.c    | 18 +++++++++---------
>  4 files changed, 29 insertions(+), 30 deletions(-)

for omap-gpmc.c

Acked-by: Roger Quadros <rogerq@ti.com>

>=20
> diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
> index 99e644cda4d1..597282e35c69 100644
> --- a/drivers/memory/atmel-ebi.c
> +++ b/drivers/memory/atmel-ebi.c
> @@ -156,8 +156,8 @@ static int atmel_ebi_xslate_smc_timings(struct atmel_=
ebi_dev *ebid,
>  out:
>  	if (ret) {
>  		dev_err(ebid->ebi->dev,
> -			"missing or invalid timings definition in %s",
> -			np->full_name);
> +			"missing or invalid timings definition in %pOF",
> +			np);
>  		return ret;
>  	}
>=20
> @@ -267,8 +267,8 @@ static int atmel_ebi_xslate_smc_config(struct atmel_e=
bi_dev *ebid,
>  		return -EINVAL;
>=20
>  	if ((ret > 0 && !required) || (!ret && required)) {
> -		dev_err(ebid->ebi->dev, "missing atmel,smc- properties in %s",
> -			np->full_name);
> +		dev_err(ebid->ebi->dev, "missing atmel,smc- properties in %pOF",
> +			np);
>  		return -EINVAL;
>  	}
>=20
> @@ -311,8 +311,7 @@ static int atmel_ebi_dev_setup(struct atmel_ebi *ebi,=
 struct device_node *np,
>=20
>  		if (cs >=3D AT91_MATRIX_EBI_NUM_CS ||
>  		    !(ebi->caps->available_cs & BIT(cs))) {
> -			dev_err(dev, "invalid reg property in %s\n",
> -				np->full_name);
> +			dev_err(dev, "invalid reg property in %pOF\n", np);
>  			return -EINVAL;
>  		}
>=20
> @@ -321,7 +320,7 @@ static int atmel_ebi_dev_setup(struct atmel_ebi *ebi,=
 struct device_node *np,
>  	}
>=20
>  	if (!numcs) {
> -		dev_err(dev, "invalid reg property in %s\n", np->full_name);
> +		dev_err(dev, "invalid reg property in %pOF\n", np);
>  		return -EINVAL;
>  	}
>=20
> @@ -569,8 +568,8 @@ static int atmel_ebi_probe(struct platform_device *pd=
ev)
>=20
>  		ret =3D atmel_ebi_dev_setup(ebi, child, reg_cells);
>  		if (ret) {
> -			dev_err(dev, "failed to configure EBI bus for %s, disabling the devic=
e",
> -				child->full_name);
> +			dev_err(dev, "failed to configure EBI bus for %pOF, disabling the dev=
ice",
> +				child);
>=20
>  			ret =3D atmel_ebi_dev_disable(ebi, child);
>  			if (ret)
> diff --git a/drivers/memory/jz4780-nemc.c b/drivers/memory/jz4780-nemc.c
> index 919d1925acb9..bcf06adefc96 100644
> --- a/drivers/memory/jz4780-nemc.c
> +++ b/drivers/memory/jz4780-nemc.c
> @@ -322,8 +322,8 @@ static int jz4780_nemc_probe(struct platform_device *=
pdev)
>  			bank =3D of_read_number(prop, 1);
>  			if (bank < 1 || bank >=3D JZ4780_NEMC_NUM_BANKS) {
>  				dev_err(nemc->dev,
> -					"%s requests invalid bank %u\n",
> -					child->full_name, bank);
> +					"%pOF requests invalid bank %u\n",
> +					child, bank);
>=20
>  				/* Will continue the outer loop below. */
>  				referenced =3D 0;
> @@ -334,12 +334,12 @@ static int jz4780_nemc_probe(struct platform_device=
 *pdev)
>  		}
>=20
>  		if (!referenced) {
> -			dev_err(nemc->dev, "%s has no addresses\n",
> -				child->full_name);
> +			dev_err(nemc->dev, "%pOF has no addresses\n",
> +				child);
>  			continue;
>  		} else if (nemc->banks_present & referenced) {
> -			dev_err(nemc->dev, "%s conflicts with another node\n",
> -				child->full_name);
> +			dev_err(nemc->dev, "%pOF conflicts with another node\n",
> +				child);
>  			continue;
>  		}
>=20
> diff --git a/drivers/memory/mvebu-devbus.c b/drivers/memory/mvebu-devbus.=
c
> index 24852812fd44..981860879d02 100644
> --- a/drivers/memory/mvebu-devbus.c
> +++ b/drivers/memory/mvebu-devbus.c
> @@ -105,8 +105,8 @@ static int get_timing_param_ps(struct devbus *devbus,
>=20
>  	err =3D of_property_read_u32(node, name, &time_ps);
>  	if (err < 0) {
> -		dev_err(devbus->dev, "%s has no '%s' property\n",
> -			name, node->full_name);
> +		dev_err(devbus->dev, "%pOF has no '%s' property\n",
> +			node, name);
>  		return err;
>  	}
>=20
> @@ -127,8 +127,8 @@ static int devbus_get_timing_params(struct devbus *de=
vbus,
>  	err =3D of_property_read_u32(node, "devbus,bus-width", &r->bus_width);
>  	if (err < 0) {
>  		dev_err(devbus->dev,
> -			"%s has no 'devbus,bus-width' property\n",
> -			node->full_name);
> +			"%pOF has no 'devbus,bus-width' property\n",
> +			node);
>  		return err;
>  	}
>=20
> @@ -180,8 +180,8 @@ static int devbus_get_timing_params(struct devbus *de=
vbus,
>  					   &w->sync_enable);
>  		if (err < 0) {
>  			dev_err(devbus->dev,
> -				"%s has no 'devbus,sync-enable' property\n",
> -				node->full_name);
> +				"%pOF has no 'devbus,sync-enable' property\n",
> +				node);
>  			return err;
>  		}
>  	}
> diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
> index a80e17de906d..f7f393541934 100644
> --- a/drivers/memory/omap-gpmc.c
> +++ b/drivers/memory/omap-gpmc.c
> @@ -960,7 +960,7 @@ static int gpmc_cs_remap(int cs, u32 base)
>  	 * Make sure we ignore any device offsets from the GPMC partition
>  	 * allocated for the chip select and that the new base confirms
>  	 * to the GPMC 16MB minimum granularity.
> -	 */
> +	 */
>  	base &=3D ~(SZ_16M - 1);
>=20
>  	gpmc_cs_get_memconf(cs, &old_base, &size);
> @@ -1930,8 +1930,8 @@ static int gpmc_probe_onenand_child(struct platform=
_device *pdev,
>  	struct omap_onenand_platform_data *gpmc_onenand_data;
>=20
>  	if (of_property_read_u32(child, "reg", &val) < 0) {
> -		dev_err(&pdev->dev, "%s has no 'reg' property\n",
> -			child->full_name);
> +		dev_err(&pdev->dev, "%pOF has no 'reg' property\n",
> +			child);
>  		return -ENODEV;
>  	}
>=20
> @@ -1979,14 +1979,14 @@ static int gpmc_probe_generic_child(struct platfo=
rm_device *pdev,
>  	struct gpmc_device *gpmc =3D platform_get_drvdata(pdev);
>=20
>  	if (of_property_read_u32(child, "reg", &cs) < 0) {
> -		dev_err(&pdev->dev, "%s has no 'reg' property\n",
> -			child->full_name);
> +		dev_err(&pdev->dev, "%pOF has no 'reg' property\n",
> +			child);
>  		return -ENODEV;
>  	}
>=20
>  	if (of_address_to_resource(child, 0, &res) < 0) {
> -		dev_err(&pdev->dev, "%s has malformed 'reg' property\n",
> -			child->full_name);
> +		dev_err(&pdev->dev, "%pOF has malformed 'reg' property\n",
> +			child);
>  		return -ENODEV;
>  	}
>=20
> @@ -2084,8 +2084,8 @@ static int gpmc_probe_generic_child(struct platform=
_device *pdev,
>  		ret =3D of_property_read_u32(child, "bank-width",
>  					   &gpmc_s.device_width);
>  		if (ret < 0) {
> -			dev_err(&pdev->dev, "%s has no 'bank-width' property\n",
> -				child->full_name);
> +			dev_err(&pdev->dev, "%pOF has no 'bank-width' property\n",
> +				child);
>  			goto err;
>  		}
>  	}
> --
> 2.11.0
>=20

--=20
cheers,
-roger
