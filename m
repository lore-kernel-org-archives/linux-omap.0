From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH 2/5] gpio/omap: Use devm_ API and add request_mem_region
Date: Thu, 16 Feb 2012 11:11:52 +0530
Message-ID: <CAC83ZvKuOkLKdAVNeoVjRZriouDCGPXPhkZZ+MgcktH+9pYN3w@mail.gmail.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com>
 <1329321854-24490-3-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1329321854-24490-3-git-send-email-b-cousson@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: grant.likely@secretlab.ca, khilman@ti.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Benoit,

On Wed, Feb 15, 2012 at 9:34 PM, Benoit Cousson <b-cousson@ti.com> wrote:
> Replace the regular kzalloc and ioremap with the devm_ equivalent
> to simplify error handling.
>
> Add the missing devm_request_mem_region to reserve the region used
> by the driver.
>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> ---
> =A0drivers/gpio/gpio-omap.c | =A0 35 +++++++++++++++--------------------
> =A01 files changed, 15 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index a0c3e03..c3a9dc8 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -19,7 +19,7 @@
> =A0#include <linux/err.h>
> =A0#include <linux/clk.h>
> =A0#include <linux/io.h>
> -#include <linux/slab.h>
> +#include <linux/device.h>
> =A0#include <linux/pm_runtime.h>
> =A0#include <linux/pm.h>
>
> @@ -1052,23 +1052,19 @@ static int __devinit omap_gpio_probe(struct platf=
orm_device *pdev)
> =A0 =A0 =A0 =A0struct gpio_bank *bank;
> =A0 =A0 =A0 =A0int ret =3D 0;
>
> - =A0 =A0 =A0 if (!dev->platform_data) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_exit;
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (!dev->platform_data)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>
> - =A0 =A0 =A0 bank =3D kzalloc(sizeof(struct gpio_bank), GFP_KERNEL);
> + =A0 =A0 =A0 bank =3D devm_kzalloc(&pdev->dev, sizeof(struct gpio_bank),=
 GFP_KERNEL);
> =A0 =A0 =A0 =A0if (!bank) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "Memory alloc failed\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_exit;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0res =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> =A0 =A0 =A0 =A0if (unlikely(!res)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "Invalid IRQ resource\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
How is the memory allocated to 'bank' getting freed before return -ENODEV?

> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0bank->irq =3D res->start;
> @@ -1096,15 +1092,19 @@ static int __devinit omap_gpio_probe(struct platf=
orm_device *pdev)
> =A0 =A0 =A0 =A0res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> =A0 =A0 =A0 =A0if (unlikely(!res)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "Invalid mem resource\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
And here?

> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (!devm_request_mem_region(dev, res->start, resource_size=
(res),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
pdev->name)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Region already claimed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 bank->base =3D ioremap(res->start, resource_size(res));
> + =A0 =A0 =A0 bank->base =3D devm_ioremap(dev, res->start, resource_size(=
res));
> =A0 =A0 =A0 =A0if (!bank->base) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(dev, "Could not ioremap\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
And here?
--
Tarun
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0platform_set_drvdata(pdev, bank);
> @@ -1125,11 +1125,6 @@ static int __devinit omap_gpio_probe(struct platfo=
rm_device *pdev)
> =A0 =A0 =A0 =A0list_add_tail(&bank->node, &omap_gpio_list);
>
> =A0 =A0 =A0 =A0return ret;
> -
> -err_free:
> - =A0 =A0 =A0 kfree(bank);
> -err_exit:
> - =A0 =A0 =A0 return ret;
> =A0}
>
> =A0#ifdef CONFIG_ARCH_OMAP2PLUS
> --
> 1.7.0.4
>
