From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 17/20] OMAP: hwmod/device: add omap_{device,
 hwmod}_get_mpu_rt_va
Date: Sat, 3 Jul 2010 14:51:06 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5ECEF35@dbde02.ent.ti.com>
References: <20100702152703.6221.33529.stgit@localhost.localdomain>
 <20100702152943.6221.96850.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59283 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751664Ab0GCJVS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Jul 2010 05:21:18 -0400
In-Reply-To: <20100702152943.6221.96850.stgit@localhost.localdomain>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

> -----Original Message-----
> From: Paul Walmsley [mailto:paul@pwsan.com]
> Sent: Friday, July 02, 2010 9:00 PM
> To: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Cc: Shilimkar, Santosh
> Subject: [PATCH 17/20] OMAP: hwmod/device: add omap_{device,
> hwmod}_get_mpu_rt_va
>=20
> Add omap_device_get_mpu_rt_va().  This is intended to be used by
> device drivers (currently, via a struct platform_data function
> pointer) to retrieve their corresponding device's virtual base addres=
s
> that the MPU should use to access the device.  This is needed because
> the omap_hwmod code does its own ioremap(), in order to gain access t=
o
> the module's OCP_SYSCONFIG register.
>=20
> Add omap_hwmod_get_mpu_rt_va().  omap_device_get_mpu_rt_va() calls th=
is
> function to do the real work.
>=20
Thanks Paul for handling this in the hwmod fw !!
This makes ioremap/iounmap usage consistent and HWMOD converted=20
drivers can retrieve the VA directly instead of redoing ioremap.
Add on benefit is drivers need not no about the physical base address a=
nymore since it's already taken care in HWMOD fw

> While here, rename struct omap_hwmod._rt_va to struct
> omap_hwmod._mpu_rt_va, to reinforce that it refers to the MPU's
> register target virtual address base (as opposed to, for example, the
> L3's).
>=20
> In the future, this belongs as a function in an omap_bus, so it is no=
t
> necessary to call this through a platform_data function pointer.
>=20
> The use-case for this function was originally presented by Santosh
> Shilimkar <santosh.shilimkar@ti.com>.
>=20
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c              |   33
> +++++++++++++++++++++----
>  arch/arm/plat-omap/include/plat/omap_device.h |    2 ++
>  arch/arm/plat-omap/include/plat/omap_hwmod.h  |    7 +++--
>  arch/arm/plat-omap/omap_device.c              |   19 ++++++++++++++
>  4 files changed, 53 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-
> omap2/omap_hwmod.c
> index d9e96fa..b012057 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -1,7 +1,7 @@
>  /*
>   * omap_hwmod implementation for OMAP2/3/4
>   *
> - * Copyright (C) 2009 Nokia Corporation
> + * Copyright (C) 2009-2010 Nokia Corporation
>   *
>   * Paul Walmsley, Beno=EEt Cousson, Kevin Hilman
>   *
> @@ -1066,12 +1066,12 @@ static int _setup(struct omap_hwmod *oh, void
> *data)
>=20
>  u32 omap_hwmod_readl(struct omap_hwmod *oh, u16 reg_offs)
>  {
> -	return __raw_readl(oh->_rt_va + reg_offs);
> +	return __raw_readl(oh->_mpu_rt_va + reg_offs);
>  }
>=20
>  void omap_hwmod_writel(u32 v, struct omap_hwmod *oh, u16 reg_offs)
>  {
> -	__raw_writel(v, oh->_rt_va + reg_offs);
> +	__raw_writel(v, oh->_mpu_rt_va + reg_offs);
>  }
>=20
>  int omap_hwmod_set_slave_idlemode(struct omap_hwmod *oh, u8 idlemode=
)
> @@ -1128,7 +1128,7 @@ int omap_hwmod_register(struct omap_hwmod *oh)
>  	ms_id =3D _find_mpu_port_index(oh);
>  	if (!IS_ERR_VALUE(ms_id)) {
>  		oh->_mpu_port_index =3D ms_id;
> -		oh->_rt_va =3D _find_mpu_rt_base(oh, oh->_mpu_port_index);
> +		oh->_mpu_rt_va =3D _find_mpu_rt_base(oh, oh->_mpu_port_index);
>  	} else {
>  		oh->_int_flags |=3D _HWMOD_NO_MPU_PORT;
>  	}
> @@ -1280,7 +1280,7 @@ int omap_hwmod_unregister(struct omap_hwmod *oh=
)
>  	pr_debug("omap_hwmod: %s: unregistering\n", oh->name);
>=20
>  	mutex_lock(&omap_hwmod_mutex);
> -	iounmap(oh->_rt_va);
> +	iounmap(oh->_mpu_rt_va);
>  	list_del(&oh->node);
>  	mutex_unlock(&omap_hwmod_mutex);
>=20
> @@ -1541,6 +1541,29 @@ struct powerdomain *omap_hwmod_get_pwrdm(struc=
t
> omap_hwmod *oh)
>  }
>=20
>  /**
> + * omap_hwmod_get_mpu_rt_va - return the module's base address (for =
the
> MPU)
> + * @oh: struct omap_hwmod *
> + *
> + * Returns the virtual address corresponding to the beginning of the
> + * module's register target, in the address range that is intended t=
o
> + * be used by the MPU.  Returns the virtual address upon success or =
NULL
> + * upon error.
> + */
> +void __iomem *omap_hwmod_get_mpu_rt_va(struct omap_hwmod *oh)
> +{
> +	if (!oh)
> +		return NULL;
> +
> +	if (oh->_int_flags & _HWMOD_NO_MPU_PORT)
> +		return NULL;
> +
> +	if (oh->_state =3D=3D _HWMOD_STATE_UNKNOWN)
> +		return NULL;
> +
> +	return oh->_mpu_rt_va;
> +}
> +
> +/**
>   * omap_hwmod_add_initiator_dep - add sleepdep from @init_oh to @oh
>   * @oh: struct omap_hwmod *
>   * @init_oh: struct omap_hwmod * (initiator)
> diff --git a/arch/arm/plat-omap/include/plat/omap_device.h
> b/arch/arm/plat-omap/include/plat/omap_device.h
> index 3694b62..25cd9ac 100644
> --- a/arch/arm/plat-omap/include/plat/omap_device.h
> +++ b/arch/arm/plat-omap/include/plat/omap_device.h
> @@ -101,6 +101,8 @@ struct omap_device *omap_device_build_ss(const ch=
ar
> *pdev_name, int pdev_id,
>  int omap_device_register(struct omap_device *od);
>  int omap_early_device_register(struct omap_device *od);
>=20
> +void __iomem *omap_device_get_rt_va(struct omap_device *od);
> +
>  /* OMAP PM interface */
>  int omap_device_align_pm_lat(struct platform_device *pdev,
>  			     u32 new_wakeup_lat_limit);
> diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/=
plat-
> omap/include/plat/omap_hwmod.h
> index aebfacb..a4e508d 100644
> --- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
> +++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
> @@ -1,7 +1,7 @@
>  /*
>   * omap_hwmod macros, structures
>   *
> - * Copyright (C) 2009 Nokia Corporation
> + * Copyright (C) 2009-2010 Nokia Corporation
>   * Paul Walmsley
>   *
>   * Created in collaboration with (alphabetical order): Beno=EEt Cous=
son,
> @@ -419,7 +419,7 @@ struct omap_hwmod_class {
>   * @slaves: ptr to array of OCP ifs that this hwmod can respond on
>   * @dev_attr: arbitrary device attributes that can be passed to the
> driver
>   * @_sysc_cache: internal-use hwmod flags
> - * @_rt_va: cached register target start address (internal use)
> + * @_mpu_rt_va: cached register target start address (internal use)
>   * @_mpu_port_index: cached MPU register target slave ID (internal u=
se)
>   * @msuspendmux_reg_id: CONTROL_MSUSPENDMUX register ID (1-6)
>   * @msuspendmux_shift: CONTROL_MSUSPENDMUX register bit shift
> @@ -460,7 +460,7 @@ struct omap_hwmod {
>  	struct omap_hwmod_ocp_if	**slaves;  /* connect to *_TA */
>  	void				*dev_attr;
>  	u32				_sysc_cache;
> -	void __iomem			*_rt_va;
> +	void __iomem			*_mpu_rt_va;
>  	struct list_head		node;
>  	u16				flags;
>  	u8				_mpu_port_index;
> @@ -507,6 +507,7 @@ int omap_hwmod_count_resources(struct omap_hwmod =
*oh);
>  int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource
> *res);
>=20
>  struct powerdomain *omap_hwmod_get_pwrdm(struct omap_hwmod *oh);
> +void __iomem *omap_hwmod_get_mpu_rt_va(struct omap_hwmod *oh);
>=20
>  int omap_hwmod_add_initiator_dep(struct omap_hwmod *oh,
>  				 struct omap_hwmod *init_oh);
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-
> omap/omap_device.c
> index f9dec0d..dee4629 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -655,6 +655,25 @@ struct powerdomain *omap_device_get_pwrdm(struct
> omap_device *od)
>  	return omap_hwmod_get_pwrdm(od->hwmods[0]);
>  }
>=20
> +/**
> + * omap_device_get_mpu_rt_va - return the MPU's virtual addr for the
> hwmod base
> + * @od: struct omap_device *
> + *
> + * Return the MPU's virtual address for the base of the hwmod, from
> + * the ioremap() that the hwmod code does.  Only valid if there is o=
ne
> + * hwmod associated with this device.  Returns NULL if there are zer=
o
> + * or more than one hwmods associated with this omap_device;
> + * otherwise, passes along the return value from
> + * omap_hwmod_get_mpu_rt_va().
> + */
> +void __iomem *omap_device_get_rt_va(struct omap_device *od)
> +{
> +	if (od->hwmods_cnt !=3D 1)
> +		return NULL;
> +
> +	return omap_hwmod_get_mpu_rt_va(od->hwmods[0]);
> +}
> +
>  /*
>   * Public functions intended for use in omap_device_pm_latency
>   * .activate_func and .deactivate_func function pointers
>=20

Regards,
Santosh
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
