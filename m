From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH 3/5] omap-serial: Fix the error handling in the
 omap_serial probe
Date: Fri, 20 Jan 2012 14:19:17 +0530
Message-ID: <CAAL8m4xVOiGjOHvf=Uy4m9QbqxO21pFeB2HcC_zGijj-+VF_jw@mail.gmail.com>
References: <1326709360-26020-1-git-send-email-shubhrajyoti@ti.com> <1326709360-26020-4-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1326709360-26020-4-git-send-email-shubhrajyoti@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 16, 2012 at 3:52 PM, Shubhrajyoti D <shubhrajyoti@ti.com> w=
rote:
> The patch does the following
>
> - The pm_runtime_disable is called in the remove not in the error
> =A0case of probe.The patch calls the pm_runtime_disable in the error
> =A0case.
> - The =A0up is not freed in the error path. Fix the memory leak by ca=
lling
> =A0kfree in the error path.
> - Also the iounmap is not called fix the same by calling iounmap in t=
he
> =A0error case of probe and remove .
> - Make the name of the error tags more meaningful.
>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
> =A0drivers/tty/serial/omap-serial.c | =A0 27 +++++++++++++++++-------=
---
> =A01 files changed, 17 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/om=
ap-serial.c
> index 1c24269..8c6f137 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -1369,14 +1369,14 @@ static int serial_omap_probe(struct platform_=
device *pdev)
>
> =A0 =A0 =A0 =A0dma_rx =3D platform_get_resource_byname(pdev, IORESOUR=
CE_DMA, "rx");
> =A0 =A0 =A0 =A0if (!dma_rx) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENXIO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto do_release_region;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0dma_tx =3D platform_get_resource_byname(pdev, IORESOUR=
CE_DMA, "tx");
> =A0 =A0 =A0 =A0if (!dma_tx) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENXIO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto do_release_region;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0up =3D kzalloc(sizeof(*up), GFP_KERNEL);
> @@ -1403,7 +1403,7 @@ static int serial_omap_probe(struct platform_de=
vice *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&pdev->dev, "failed to get ali=
as/pdev id, errno %d\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0up->port.line);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -ENODEV;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_port_line;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0sprintf(up->name, "OMAP UART%d", up->port.line);
> @@ -1412,7 +1412,7 @@ static int serial_omap_probe(struct platform_de=
vice *pdev)
> =A0 =A0 =A0 =A0if (!up->port.membase) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&pdev->dev, "can't ioremap UAR=
T\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -ENOMEM;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_ioremap;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0up->port.flags =3D omap_up_info->flags;
> @@ -1458,16 +1458,22 @@ static int serial_omap_probe(struct platform_=
device *pdev)
>
> =A0 =A0 =A0 =A0ret =3D uart_add_one_port(&serial_omap_reg, &up->port)=
;
> =A0 =A0 =A0 =A0if (ret !=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto do_release_region;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_add_port;
>
> =A0 =A0 =A0 =A0pm_runtime_put(&pdev->dev);
> =A0 =A0 =A0 =A0platform_set_drvdata(pdev, up);
> =A0 =A0 =A0 =A0return 0;
> -err:
> - =A0 =A0 =A0 dev_err(&pdev->dev, "[UART%d]: failure [%s]: %d\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdev->i=
d, __func__, ret);
> +
> +err_add_port:
> + =A0 =A0 =A0 pm_runtime_disable(&pdev->dev);
> + =A0 =A0 =A0 iounmap(up->port.membase);
> +err_ioremap:
> +err_port_line:
> + =A0 =A0 =A0 kfree(up);
> =A0do_release_region:
> =A0 =A0 =A0 =A0release_mem_region(mem->start, resource_size(mem));
> + =A0 =A0 =A0 dev_err(&pdev->dev, "[UART%d]: failure [%s]: %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdev->i=
d, __func__, ret);
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> @@ -1476,6 +1482,7 @@ static int serial_omap_remove(struct platform_d=
evice *dev)
> =A0 =A0 =A0 =A0struct uart_omap_port *up =3D platform_get_drvdata(dev=
);
>
> =A0 =A0 =A0 =A0if (up) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(up->port.membase);

you can build omap-serial as module insmod and rmmod
the module and test this patch.

This can be done on zoom board which uses a non-omap uart
as console.

--
Thanks,
Govindraj.R
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
