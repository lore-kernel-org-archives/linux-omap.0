From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 5/5] regulator: map consumer regulator based on device
 tree
Date: Thu, 13 Oct 2011 12:46:07 -0600
Message-ID: <20111013184607.GQ18574@ponder.secretlab.ca>
References: <1318263578-7407-1-git-send-email-rnayak@ti.com>
 <1318263578-7407-6-git-send-email-rnayak@ti.com>
 <20111010173506.GH3607@opensource.wolfsonmicro.com>
 <CACYZBRFmLEY_f1UwJa5U9uj8+NVA-WfUVkiuW1yKrpwnrA_00A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACYZBRFmLEY_f1UwJa5U9uj8+NVA-WfUVkiuW1yKrpwnrA_00A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, lrg@ti.com, b-cousson@ti.com, patches@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 11, 2011 at 12:38:53PM +0530, Nayak, Rajendra wrote:
> >
> >> + =A0 =A0 if (supply) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 struct regulator_dev *r;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 struct device_node *node;
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 /* first do a dt based lookup */
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (dev) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 node =3D of_get_regulato=
r(dev, supply);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (node)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_for=
_each_entry(r, &regulator_list, list)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 if (node =3D=3D r->dev.parent->of_node)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 goto found;
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >>
> >> - =A0 =A0 =A0 =A0 =A0 =A0 if (!found) {
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Failed to =
find supply %s\n",
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 init_dat=
a->supply_regulator);
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto scrub;
> >> - =A0 =A0 =A0 =A0 =A0 =A0 }
> >> + =A0 =A0 =A0 =A0 =A0 =A0 /* next try doing it non-dt way */
> >> + =A0 =A0 =A0 =A0 =A0 =A0 list_for_each_entry(r, &regulator_list, =
list)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (strcmp(rdev_get_name=
(r), supply) =3D=3D 0)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fou=
nd;
> >>
> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Failed to find supply %s\n=
", supply);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto scrub;
> >> +
> >> +found:
> >
> > This is all getting *really* complicated and illegible. =A0I'm not =
sure
> > what the best way to structure is but erroring out early looks usef=
ul.
> >
>=20
> How about this updated patch?
>=20
> From f4c7d2b283740382c272c7971665375067d26dbe Mon Sep 17 00:00:00 200=
1
> From: Rajendra Nayak <rnayak@ti.com>
> Date: Thu, 22 Sep 2011 17:51:10 +0530
> Subject: [PATCH 5/5] regulator: map consumer regulator based on devic=
e tree
>=20
> Device nodes in DT can associate themselves with one or more
> regulators/supply by providing a list of phandles (to regulator nodes=
)
> and corresponding supply names.
>=20
> For Example:
> 	devicenode: node@0x0 {
> 		...
> 		...
> 		vmmc-supply =3D <&regulator1>;
> 		vpll-supply =3D <&regulator1>;
> 	};
>=20
> The driver would then do a regulator_get(dev, "vmmc"); to get
> regulator1 and do a regulator_get(dev, "vpll"); to get
> regulator2.
>=20
> of_get_regulator() extracts the regulator node for a given
> device, based on the supply name.
>=20
> Use it to look up the regulator for a given consumer from device tree=
, during
> a regulator_get(). If not found fallback and lookup through
> the regulator_map_list instead.
>=20
> Also, since the regulator dt nodes can use the same binding to
> associate with a parent regulator/supply, allow the drivers to
> specify a supply_name, which can then be used to lookup dt
> to find the parent phandle.
>=20
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

> ---
>  drivers/regulator/core.c         |   91 ++++++++++++++++++++++++++++=
+++------
>  include/linux/regulator/driver.h |    2 +
>  2 files changed, 78 insertions(+), 15 deletions(-)
>=20
> Index: linux/drivers/regulator/core.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.orig/drivers/regulator/core.c	2011-10-11 11:43:27.944140106=
 +0530
> +++ linux/drivers/regulator/core.c	2011-10-11 12:25:53.540418748 +053=
0
> @@ -25,9 +25,11 @@
>  #include <linux/mutex.h>
>  #include <linux/suspend.h>
>  #include <linux/delay.h>
> +#include <linux/of.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/regulator/driver.h>
>  #include <linux/regulator/machine.h>
> +#include <linux/regulator/of_regulator.h>
>=20
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/regulator.h>
> @@ -131,6 +133,33 @@
>  	return NULL;
>  }
>=20
> +/**
> + * of_get_regulator - get a regulator device node based on supply na=
me
> + * @dev: Device pointer for the consumer (of regulator) device
> + * @supply: regulator supply name
> + *
> + * Extract the regulator device node corresponding to the supply nam=
e.
> + * retruns the device node corresponding to the regulator if found, =
else
> + * returns NULL.
> + */
> +static struct device_node *of_get_regulator(struct device *dev, cons=
t
> char *supply)
> +{
> +	struct device_node *regnode =3D NULL;
> +	char prop_name[32]; /* 32 is max size of property name */
> +
> +	dev_dbg(dev, "Looking up %s-supply from device tree\n", supply);
> +
> +	snprintf(prop_name, 32, "%s-supply", supply);
> +	regnode =3D of_parse_phandle(dev->of_node, prop_name, 0);
> +
> +	if (!regnode) {
> +		pr_warn("%s: %s property in node %s references invalid phandle",
> +			__func__, prop_name, dev->of_node->full_name);
> +		return NULL;
> +	}
> +	return regnode;
> +}
> +
>  /* Platform voltage constraint check */
>  static int regulator_check_voltage(struct regulator_dev *rdev,
>  				   int *min_uV, int *max_uV)
> @@ -1147,6 +1176,28 @@
>  	return rdev->desc->ops->enable_time(rdev);
>  }
>=20
> +static struct regulator_dev *regulator_dev_lookup(struct device *dev=
,
> +							 const char *supply)
> +{
> +	struct regulator_dev *r;
> +	struct device_node *node;
> +
> +	/* first do a dt based lookup */
> +	if (dev && dev->of_node)
> +		node =3D of_get_regulator(dev, supply);
> +		if (node)
> +			list_for_each_entry(r, &regulator_list, list)
> +				if (node =3D=3D r->dev.parent->of_node)
> +					return r;
> +
> +	/* if not found, try doing it non-dt way */
> +	list_for_each_entry(r, &regulator_list, list)
> +		if (strcmp(rdev_get_name(r), supply) =3D=3D 0)
> +			return r;
> +
> +	return NULL;
> +}
> +
>  /* Internal regulator request function */
>  static struct regulator *_regulator_get(struct device *dev, const ch=
ar *id,
>  					int exclusive)
> @@ -1155,6 +1206,7 @@
>  	struct regulator_map *map;
>  	struct regulator *regulator =3D ERR_PTR(-ENODEV);
>  	const char *devname =3D NULL;
> +	struct device_node *node;
>  	int ret;
>=20
>  	if (id =3D=3D NULL) {
> @@ -1167,6 +1219,10 @@
>=20
>  	mutex_lock(&regulator_list_mutex);
>=20
> +	rdev =3D regulator_dev_lookup(dev, id);
> +	if (rdev)
> +		goto found;
> +
>  	list_for_each_entry(map, &regulator_map_list, list) {
>  		/* If the mapping has a device set up it must match */
>  		if (map->dev_name &&
> @@ -2579,6 +2635,7 @@
>  	static atomic_t regulator_no =3D ATOMIC_INIT(0);
>  	struct regulator_dev *rdev;
>  	int ret, i;
> +	const char *supply;
>=20
>  	if (regulator_desc =3D=3D NULL)
>  		return ERR_PTR(-EINVAL);
> @@ -2653,21 +2710,18 @@
>  	if (ret < 0)
>  		goto scrub;
>=20
> -	if (init_data->supply_regulator) {
> +	if (init_data->supply_regulator)
> +		supply =3D init_data->supply_regulator;
> +	else if (regulator_desc->supply_name);
> +		supply =3D regulator_desc->supply_name;
> +
> +	if (supply) {
>  		struct regulator_dev *r;
> -		int found =3D 0;
>=20
> -		list_for_each_entry(r, &regulator_list, list) {
> -			if (strcmp(rdev_get_name(r),
> -				   init_data->supply_regulator) =3D=3D 0) {
> -				found =3D 1;
> -				break;
> -			}
> -		}
> +		r =3D regulator_dev_lookup(dev, supply);
>=20
> -		if (!found) {
> -			dev_err(dev, "Failed to find supply %s\n",
> -				init_data->supply_regulator);
> +		if (!r) {
> +			dev_err(dev, "Failed to find supply %s\n", supply);
>  			ret =3D -ENODEV;
>  			goto scrub;
>  		}
> Index: linux/include/linux/regulator/driver.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.orig/include/linux/regulator/driver.h	2011-10-11
> 11:43:27.936139476 +0530
> +++ linux/include/linux/regulator/driver.h	2011-10-11 11:43:43.485351=
850 +0530
> @@ -153,6 +153,7 @@
>   * this type.
>   *
>   * @name: Identifying name for the regulator.
> + * @supply_name: Identifying the regulator supply
>   * @id: Numerical identifier for the regulator.
>   * @n_voltages: Number of selectors available for ops.list_voltage()=
=2E
>   * @ops: Regulator operations table.
> @@ -162,6 +163,7 @@
>   */
>  struct regulator_desc {
>  	const char *name;
> +	const char *supply_name;
>  	int id;
>  	unsigned n_voltages;
>  	struct regulator_ops *ops;
