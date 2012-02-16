From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH 1/5] gpio/omap: Remove bank->id information and misc cleanup
Date: Thu, 16 Feb 2012 11:23:47 +0530
Message-ID: <CAC83ZvJuHpaBbGoysW7GwOHtqfi72EDhFYja2LE4NyBd+QgFWw@mail.gmail.com>
References: <1329321854-24490-1-git-send-email-b-cousson@ti.com>
	<1329321854-24490-2-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:56884 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752639Ab2BPFxs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Feb 2012 00:53:48 -0500
Received: by mail-qw0-f47.google.com with SMTP id z30so4447269qad.6
        for <linux-omap@vger.kernel.org>; Wed, 15 Feb 2012 21:53:47 -0800 (PST)
In-Reply-To: <1329321854-24490-2-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, devicetree-discuss@lists.ozlabs.org

On Wed, Feb 15, 2012 at 9:34 PM, Benoit Cousson <b-cousson@ti.com> wrot=
e:
> The driver does not need anymore any id to identify the GPIO instance=
=2E
> Remove every occurence of the bank->id inside the driver.
>
> Remove two trailing spaces.
> Add a dev variable for better readability in probe.
> Remove unused variable bank->pbase.
>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Looks fine.
If needed you can add my Acked-by:
--
Tarun

> ---
> =A0drivers/gpio/gpio-omap.c | =A0 23 +++++++++--------------
> =A01 files changed, 9 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index f49bd6f..a0c3e03 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -50,7 +50,6 @@ struct gpio_regs {
>
> =A0struct gpio_bank {
> =A0 =A0 =A0 =A0struct list_head node;
> - =A0 =A0 =A0 unsigned long pbase;
> =A0 =A0 =A0 =A0void __iomem *base;
> =A0 =A0 =A0 =A0u16 irq;
> =A0 =A0 =A0 =A0u16 virtual_irq_start;
> @@ -77,7 +76,6 @@ struct gpio_bank {
> =A0 =A0 =A0 =A0int stride;
> =A0 =A0 =A0 =A0u32 width;
> =A0 =A0 =A0 =A0int context_loss_count;
> - =A0 =A0 =A0 u16 id;
> =A0 =A0 =A0 =A0int power_mode;
> =A0 =A0 =A0 =A0bool workaround_enabled;
>
> @@ -155,7 +153,7 @@ static inline void _gpio_rmw(void __iomem *base, =
u32 reg, u32 mask, bool set)
> =A0{
> =A0 =A0 =A0 =A0int l =3D __raw_readl(base + reg);
>
> - =A0 =A0 =A0 if (set)
> + =A0 =A0 =A0 if (set)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l |=3D mask;
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0l &=3D ~mask;
> @@ -495,7 +493,7 @@ static int _set_gpio_wakeup(struct gpio_bank *ban=
k, int gpio, int enable)
> =A0 =A0 =A0 =A0unsigned long flags;
>
> =A0 =A0 =A0 =A0if (bank->non_wakeup_gpios & gpio_bit) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(bank->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(bank->dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Unable to modify wake=
up on non-wakeup GPIO%d\n", gpio);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
> @@ -1048,37 +1046,36 @@ static void __devinit omap_gpio_chip_init(str=
uct gpio_bank *bank)
>
> =A0static int __devinit omap_gpio_probe(struct platform_device *pdev)
> =A0{
> + =A0 =A0 =A0 struct device *dev =3D &pdev->dev;
> =A0 =A0 =A0 =A0struct omap_gpio_platform_data *pdata;
> =A0 =A0 =A0 =A0struct resource *res;
> =A0 =A0 =A0 =A0struct gpio_bank *bank;
> =A0 =A0 =A0 =A0int ret =3D 0;
>
> - =A0 =A0 =A0 if (!pdev->dev.platform_data) {
> + =A0 =A0 =A0 if (!dev->platform_data) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -EINVAL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_exit;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0bank =3D kzalloc(sizeof(struct gpio_bank), GFP_KERNEL)=
;
> =A0 =A0 =A0 =A0if (!bank) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Memory alloc faile=
d for gpio_bank\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Memory alloc failed\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -ENOMEM;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_exit;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0res =3D platform_get_resource(pdev, IORESOURCE_IRQ, 0)=
;
> =A0 =A0 =A0 =A0if (unlikely(!res)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "GPIO Bank %i Inval=
id IRQ resource\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdev->i=
d);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Invalid IRQ resource\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -ENODEV;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_free;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0bank->irq =3D res->start;
> - =A0 =A0 =A0 bank->id =3D pdev->id;
>
> =A0 =A0 =A0 =A0pdata =3D pdev->dev.platform_data;
> =A0 =A0 =A0 =A0bank->virtual_irq_start =3D pdata->virtual_irq_start;
> - =A0 =A0 =A0 bank->dev =3D &pdev->dev;
> + =A0 =A0 =A0 bank->dev =3D dev;
> =A0 =A0 =A0 =A0bank->dbck_flag =3D pdata->dbck_flag;
> =A0 =A0 =A0 =A0bank->stride =3D pdata->bank_stride;
> =A0 =A0 =A0 =A0bank->width =3D pdata->bank_width;
> @@ -1098,16 +1095,14 @@ static int __devinit omap_gpio_probe(struct p=
latform_device *pdev)
> =A0 =A0 =A0 =A0/* Static mapping, never released */
> =A0 =A0 =A0 =A0res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0)=
;
> =A0 =A0 =A0 =A0if (unlikely(!res)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "GPIO Bank %i Inval=
id mem resource\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdev->i=
d);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Invalid mem resource\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -ENODEV;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_free;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0bank->base =3D ioremap(res->start, resource_size(res))=
;
> =A0 =A0 =A0 =A0if (!bank->base) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Could not ioremap =
gpio bank%i\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdev->i=
d);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Could not ioremap\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -ENOMEM;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_free;
> =A0 =A0 =A0 =A0}
> --
> 1.7.0.4
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
