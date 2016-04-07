From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 01/20] mfd: Add devm_ apis for mfd_add_devices and
 mfd_release_devices
Date: Thu, 7 Apr 2016 11:44:03 +0100
Message-ID: <20160407104403.GZ3323@x1>
References: <1459856912-17859-1-git-send-email-ldewangan@nvidia.com>
 <1459856912-17859-2-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459856912-17859-2-git-send-email-ldewangan@nvidia.com>
Sender: linux-doc-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>
Cc: corbet@lwn.net, andreas.werner@men.de, tony@atomide.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, patches@opensource.wolfsonmicro.com
List-Id: linux-omap@vger.kernel.org

On Tue, 05 Apr 2016, Laxman Dewangan wrote:

> Add device managed APIs devm_mfd_add_devices() and
> devm_mfd_remove_devices() for the APIs mfd_add_devices()
> and mfd_remove_devices().

Nit: Line wrap after "devm_mfd_remove_devices()" instead.

> This helps in reducing code in error path and sometimes
> removal of .remove callback for driver unbind.

s/for/during/

> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
>  drivers/mfd/mfd-core.c   | 62 ++++++++++++++++++++++++++++++++++++++=
++++++++++
>  include/linux/mfd/core.h |  7 ++++++
>  2 files changed, 69 insertions(+)
>=20
> diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> index 409da01..145712e 100644
> --- a/drivers/mfd/mfd-core.c
> +++ b/drivers/mfd/mfd-core.c
> @@ -334,6 +334,68 @@ void mfd_remove_devices(struct device *parent)
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
> + * This returns the 0 on success otherwise error number in the failu=
re.

"Returns 0 on success or an appropriate negative error number on failur=
e."

> + * The allocated mfd devices will automatically be released when the

s/mfd/MFD/

> + * device is unbound.
> + */
> +int devm_mfd_add_devices(struct device *dev, int id,
> +		    const struct mfd_cell *cells, int n_devs,
> +		    struct resource *mem_base,
> +		    int irq_base, struct irq_domain *domain)
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
> +	if (!ret) {
> +		*ptr =3D dev;
> +		devres_add(dev, ptr);
> +	} else {
> +		devres_free(ptr);
> +	}

Switch these round.  If you encounter a problem, free and return.  If
not, skip the error handling and add the device outside of the if().

> +	return ret;
> +}
> +EXPORT_SYMBOL(devm_mfd_add_devices);
> +
> +static int devm_mfd_devs_match(struct device *dev, void *res, void *=
data)
> +{
> +	struct device **r =3D res;
> +
> +	if (WARN_ON(!r || !*r))
> +		return 0;
> +
> +	return *r =3D=3D data;
> +}
> +
> +/**
> + * devm_mfd_remove_device - Resource managed version of mfd_remove_d=
evices()
> + * @dev: Device for which which resource was allocated.

Did you proof read your own writing?  Pleaes re-word.

> + * Remove all mfd devices added on the device.

s/mfd/MFD/

'D' already means devices, so here you are saying "devices devices".
Please re-word.  Besides, you need to be more specific as to which
"devices on the devices" you are detailing, since this sentence
doesn't really make a great deal of sense.

> + * Normally this function will not need to be called and the resourc=
e
> + * management code will ensure that the resource is freed.

Then what is the purpose of providing it?  Do you have a user?

> + */
> +void devm_mfd_remove_devices(struct device *dev)
> +{
> +	WARN_ON(devres_release(dev, devm_mfd_dev_release,
> +			       devm_mfd_devs_match, dev));
> +}
> +EXPORT_SYMBOL(devm_mfd_remove_devices);
> +
>  int mfd_clone_cell(const char *cell, const char **clones, size_t n_c=
lones)
>  {
>  	struct mfd_cell cell_entry;
> diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
> index bc6f7e0..d658d7f 100644
> --- a/include/linux/mfd/core.h
> +++ b/include/linux/mfd/core.h
> @@ -131,4 +131,11 @@ static inline int mfd_add_hotplug_devices(struct=
 device *parent,
> =20
>  extern void mfd_remove_devices(struct device *parent);
> =20
> +extern int devm_mfd_add_devices(struct device *dev, int id,
> +			   const struct mfd_cell *cells, int n_devs,
> +			   struct resource *mem_base,
> +			   int irq_base, struct irq_domain *irq_domain);
> +
> +extern void devm_mfd_remove_devices(struct device *dev);
> +
>  #endif

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
