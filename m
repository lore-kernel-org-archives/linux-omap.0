From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH RFC] OMAP: I2C: Fix the mismatch of pm_runtime enable and disable
Date: Wed, 11 Jan 2012 15:59:22 +0200
Message-ID: <CANOLnONdYYybbSP143+TeLxjfdEg1krcZjHwf140Fm5Y8rHogA@mail.gmail.com>
References: <1326288104-10544-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:33268 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756011Ab2AKN7Y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Jan 2012 08:59:24 -0500
In-Reply-To: <1326288104-10544-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, Rajendra Nayak <rnayak@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>

On Wed, Jan 11, 2012 at 3:21 PM, Shubhrajyoti D <shubhrajyoti@ti.com> w=
rote:
> Currently the i2c driver calls the pm_runtime_enable and never
> the disable. This may cause a warning when pm_runtime_enable
> checks for the count match.Attempting to fix the same by calling
> pm_runtime_disable in the error and the remove path.

I remember seeing Felipe doing the reverse to musb here:
http://marc.info/?l=3Dlinux-omap&m=3D132432610700952&w=3D2
so I'm confused here.

>
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
> =C2=A0drivers/i2c/busses/i2c-omap.c | =C2=A0 =C2=A02 ++
> =C2=A01 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-o=
map.c
> index 12d402c..abc7b5b 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1070,6 +1070,7 @@ err_unuse_clocks:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0omap_i2c_write_reg(dev, OMAP_I2C_CON_REG, =
0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pm_runtime_put(dev->dev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iounmap(dev->base);
> + =C2=A0 =C2=A0 =C2=A0 pm_runtime_disable(&pdev->dev);
> =C2=A0err_free_mem:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0platform_set_drvdata(pdev, NULL);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(dev);
> @@ -1085,6 +1086,7 @@ omap_i2c_remove(struct platform_device *pdev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct omap_i2c_dev =C2=A0 =C2=A0 *dev =3D=
 platform_get_drvdata(pdev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct resource =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 *mem;
>
> + =C2=A0 =C2=A0 =C2=A0 pm_runtime_disable(&pdev->dev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0platform_set_drvdata(pdev, NULL);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0free_irq(dev->irq, dev);
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml

--=20
Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
