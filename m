From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH V2 01/20] mfd: Add resource managed apis for
 mfd_add_devices
Date: Mon, 11 Apr 2016 10:15:00 +0100
Message-ID: <20160411091500.GO4592@x1>
References: <1460054594-32325-1-git-send-email-ldewangan@nvidia.com>
 <1460054594-32325-2-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460054594-32325-2-git-send-email-ldewangan@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: corbet@lwn.net, andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: linux-omap@vger.kernel.org

Applied, thanks.

> Add resource managed API devm_mfd_add_devices() for the mfd_add_devic=
es().
>=20
> This helps in reducing code in error path as it is not required
> to call mfd_remove_devices() explicitly to remove all child-devices.
> In some cases, it also helps not to implement .remove() callback
> which get called during driver unbind.
>=20
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
>=20
> ---
> Changes from V1:
> - Reformat the commit message.
> - Run checkpatch with --strict option and fix warning.
> - Remove devm_ for mfd_remove_devices() as this is not used.
> - Consider V1 review comment on error handling.
>=20
>  drivers/mfd/mfd-core.c   | 38 ++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/core.h |  4 ++++
>  2 files changed, 42 insertions(+)
>=20
> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index 409da01..4b4c1d4 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -334,6 +334,44 @@ void mfd_remove_devices(struct device *parent)
>  }
>  EXPORT_SYMBOL(mfd_remove_devices);
> =20
> +static void devm_mfd_dev_release(struct device *dev, void *res)
> +{
> +	mfd_remove_devices(dev);
> +}
> +
> +/**
> + * devm_mfd_add_devices - Resource managed version of mfd_add_device=
s()
> + *
> + * Returns 0 on success or an appropriate negative error number on f=
ailure.
> + * All child-devices of the MFD will automatically be removed when i=
t gets
> + * unbinded.
> + */
> +int devm_mfd_add_devices(struct device *dev, int id,
> +			 const struct mfd_cell *cells, int n_devs,
> +			 struct resource *mem_base,
> +			 int irq_base, struct irq_domain *domain)
> +{
> +	struct device **ptr;
> +	int ret;
> +
> +	ptr =3D devres_alloc(devm_mfd_dev_release, sizeof(*ptr), GFP_KERNEL=
);
> +	if (!ptr)
> +		return -ENOMEM;
> +
> +	ret =3D mfd_add_devices(dev, id, cells, n_devs, mem_base,
> +			      irq_base, domain);
> +	if (ret < 0) {
> +		devres_free(ptr);
> +		return ret;
> +	}
> +
> +	*ptr =3D dev;
> +	devres_add(dev, ptr);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(devm_mfd_add_devices);
> +
>  int mfd_clone_cell(const char *cell, const char **clones, size_t n_c=
lones)
>  {
>  	struct mfd_cell cell_entry;
> diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
> index bc6f7e0..4a0268a 100644
> --- a/include/linux/mfd/core.h
> +++ b/include/linux/mfd/core.h
> @@ -131,4 +131,8 @@ static inline int mfd_add_hotplug_devices(struct =
device *parent,
> =20
>  extern void mfd_remove_devices(struct device *parent);
> =20
> +extern int devm_mfd_add_devices(struct device *dev, int id,
> +				const struct mfd_cell *cells, int n_devs,
> +				struct resource *mem_base,
> +				int irq_base, struct irq_domain *irq_domain);
>  #endif

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
