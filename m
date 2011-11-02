From: MyungJoo Ham <myungjoo.ham@gmail.com>
Subject: Re: [PATCH v3 4/4] OMAP3/4: iommu: adapt to runtime pm
Date: Wed, 2 Nov 2011 19:16:50 +0900
Message-ID: <CAJ0PZbSpxtp1bvbdWxK-hsg=XUbfodgY-7D37rOn=s3yB-Upjw@mail.gmail.com>
References: <1320185752-568-1-git-send-email-omar.ramirez@ti.com>
	<1320185752-568-5-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44592 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055Ab1KBKQv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Nov 2011 06:16:51 -0400
In-Reply-To: <1320185752-568-5-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Russell King <linux@arm.linux.org.uk>, lkml <linux-kernel@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, lo <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>, lm <linux-media@vger.kernel.org>

On Wed, Nov 2, 2011 at 7:15 AM, Omar Ramirez Luna <omar.ramirez@ti.com>=
 wrote:
> Use runtime PM functionality interfaced with hwmod enable/idle
> functions, to replace direct clock operations, reset and sysconfig
> handling.
>
> Tidspbridge uses a macro removed with this patch, for now the value
> is hardcoded to avoid breaking compilation.
>
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> ---
> =A0arch/arm/mach-omap2/iommu2.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 17 --------
> =A0arch/arm/mach-omap2/omap-iommu.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A01 -
> =A0arch/arm/plat-omap/include/plat/iommu.h =A0 =A0 =A0 =A0 =A0 | =A0 =
=A02 -
> =A0arch/arm/plat-omap/include/plat/iommu2.h =A0 =A0 =A0 =A0 =A0| =A0 =
=A02 -
> =A0drivers/iommu/omap-iommu.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 46 ++++++++-------------
> =A0drivers/staging/tidspbridge/core/tiomap3430_pwr.c | =A0 =A02 +-
> =A06 files changed, 19 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
> index bbbf747..3c55be0 100644
> --- a/drivers/iommu/omap-iommu.c
> +++ b/drivers/iommu/omap-iommu.c
> @@ -123,11 +123,11 @@ static int iommu_enable(struct omap_iommu *obj)
> =A0 =A0 =A0 =A0if (!arch_iommu)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>
> - =A0 =A0 =A0 clk_enable(obj->clk);
> + =A0 =A0 =A0 pm_runtime_enable(obj->dev);
> + =A0 =A0 =A0 pm_runtime_get_sync(obj->dev);
>
> =A0 =A0 =A0 =A0err =3D arch_iommu->enable(obj);
>
> - =A0 =A0 =A0 clk_disable(obj->clk);
> =A0 =A0 =A0 =A0return err;
> =A0}
>
> @@ -136,11 +136,10 @@ static void iommu_disable(struct omap_iommu *ob=
j)
> =A0 =A0 =A0 =A0if (!obj)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> - =A0 =A0 =A0 clk_enable(obj->clk);
> -
> =A0 =A0 =A0 =A0arch_iommu->disable(obj);
>
> - =A0 =A0 =A0 clk_disable(obj->clk);
> + =A0 =A0 =A0 pm_runtime_put_sync(obj->dev);
> + =A0 =A0 =A0 pm_runtime_disable(obj->dev);
> =A0}

Hello Omar,


I'm just curious here... Is there any reason to do
pm_runtime_enable/disable at iommu_enable/iommu_disable which are
called by iommu_attach/detach?
I thought that normally, ideal locations of pm_runtime_enable/disable
for such devices are in probe/remove() because it assures that the
device is suspended after the probe.
It seems that the device might be kept on after probe and before the
first iommu_attach if it is default-on.


Thanks,
MyungJoo


--=20
MyungJoo Ham, Ph.D.
Mobile Software Platform Lab, DMC Business, Samsung Electronics
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
