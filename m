From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 4/4] OMAP3/4: iommu: adapt to runtime pm
Date: Fri, 16 Dec 2011 02:33:08 +0200
Message-ID: <CAMP44s2YFqwFgWeWjMdzDH_00x1NAkFRwgSvp+f8NggcD2eiOw@mail.gmail.com>
References: <1323922709-6986-1-git-send-email-omar.ramirez@ti.com>
	<1323922709-6986-5-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:45385 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756418Ab1LPAdJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Dec 2011 19:33:09 -0500
In-Reply-To: <1323922709-6986-5-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>, Russell King <linux@arm.linux.org.uk>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, iommu@lists.linux-foundation.org, MyungJoo Ham <myungjoo.ham@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Dec 15, 2011 at 6:18 AM, Omar Ramirez Luna <omar.ramirez@ti.com=
> wrote:
> @@ -123,11 +123,10 @@ static int iommu_enable(struct omap_iommu *obj)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!arch_iommu)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV=
;
>
> - =C2=A0 =C2=A0 =C2=A0 clk_enable(obj->clk);
> + =C2=A0 =C2=A0 =C2=A0 pm_runtime_get_sync(obj->dev);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0err =3D arch_iommu->enable(obj);
>
> - =C2=A0 =C2=A0 =C2=A0 clk_disable(obj->clk);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;
> =C2=A0}

Hmm, this is called on omap_iommu_attach, and iommu_disable is not
called until omap_iommu_detach, so this means the device will never
sleep. Why don't you call pm_runtime_put() instead of clk_disable()?

All the rest of the calls to pm_runtime_get/put after this are
basically no-ops, because the count will never go below 1.

You mention some irq issues, but could it be due to some bad clocks in
the hwmod data?

> @@ -136,11 +135,9 @@ static void iommu_disable(struct omap_iommu *obj=
)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!obj)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>
> - =C2=A0 =C2=A0 =C2=A0 clk_enable(obj->clk);
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0arch_iommu->disable(obj);
>
> - =C2=A0 =C2=A0 =C2=A0 clk_disable(obj->clk);
> + =C2=A0 =C2=A0 =C2=A0 pm_runtime_put(obj->dev);
> =C2=A0}
>
> =C2=A0/*
> @@ -263,7 +260,7 @@ static int load_iotlb_entry(struct omap_iommu *ob=
j, struct iotlb_entry *e)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!obj || !obj->nr_tlb_entries || !e)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL=
;
>
> - =C2=A0 =C2=A0 =C2=A0 clk_enable(obj->clk);
> + =C2=A0 =C2=A0 =C2=A0 pm_runtime_get_sync(obj->dev);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iotlb_lock_get(obj, &l);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (l.base =3D=3D obj->nr_tlb_entries) {
> @@ -293,7 +290,7 @@ static int load_iotlb_entry(struct omap_iommu *ob=
j, struct iotlb_entry *e)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0cr =3D iotlb_alloc_cr(obj, e);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(cr)) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clk_disable(obj->c=
lk);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pm_runtime_put(obj=
->dev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR=
(cr);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> @@ -307,7 +304,7 @@ static int load_iotlb_entry(struct omap_iommu *ob=
j, struct iotlb_entry *e)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0l.vict =3D l.b=
ase;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iotlb_lock_set(obj, &l);
> =C2=A0out:
> - =C2=A0 =C2=A0 =C2=A0 clk_disable(obj->clk);
> + =C2=A0 =C2=A0 =C2=A0 pm_runtime_put(obj->dev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;
> =C2=A0}
>
> @@ -337,7 +334,7 @@ static void flush_iotlb_page(struct omap_iommu *o=
bj, u32 da)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct cr_regs cr;
>
> - =C2=A0 =C2=A0 =C2=A0 clk_enable(obj->clk);
> + =C2=A0 =C2=A0 =C2=A0 pm_runtime_get_sync(obj->dev);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for_each_iotlb_cr(obj, obj->nr_tlb_entries=
, i, cr) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 start;
> @@ -356,7 +353,7 @@ static void flush_iotlb_page(struct omap_iommu *o=
bj, u32 da)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0iommu_write_reg(obj, 1, MMU_FLUSH_ENTRY);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
> - =C2=A0 =C2=A0 =C2=A0 clk_disable(obj->clk);
> + =C2=A0 =C2=A0 =C2=A0 pm_runtime_put(obj->dev);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (i =3D=3D obj->nr_tlb_entries)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_dbg(obj->d=
ev, "%s: no page for %08x\n", __func__, da);
> @@ -370,7 +367,7 @@ static void flush_iotlb_all(struct omap_iommu *ob=
j)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct iotlb_lock l;
>
> - =C2=A0 =C2=A0 =C2=A0 clk_enable(obj->clk);
> + =C2=A0 =C2=A0 =C2=A0 pm_runtime_get_sync(obj->dev);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0l.base =3D 0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0l.vict =3D 0;
> @@ -378,7 +375,7 @@ static void flush_iotlb_all(struct omap_iommu *ob=
j)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iommu_write_reg(obj, 1, MMU_GFLUSH);
>
> - =C2=A0 =C2=A0 =C2=A0 clk_disable(obj->clk);
> + =C2=A0 =C2=A0 =C2=A0 pm_runtime_put(obj->dev);
> =C2=A0}
>
> =C2=A0#if defined(CONFIG_OMAP_IOMMU_DEBUG) || defined(CONFIG_OMAP_IOM=
MU_DEBUG_MODULE)
> @@ -388,11 +385,11 @@ ssize_t omap_iommu_dump_ctx(struct omap_iommu *=
obj, char *buf, ssize_t bytes)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!obj || !buf)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL=
;
>
> - =C2=A0 =C2=A0 =C2=A0 clk_enable(obj->clk);
> + =C2=A0 =C2=A0 =C2=A0 pm_runtime_get_sync(obj->dev);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0bytes =3D arch_iommu->dump_ctx(obj, buf, b=
ytes);
>
> - =C2=A0 =C2=A0 =C2=A0 clk_disable(obj->clk);
> + =C2=A0 =C2=A0 =C2=A0 pm_runtime_put(obj->dev);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return bytes;
> =C2=A0}
> @@ -406,7 +403,7 @@ __dump_tlb_entries(struct omap_iommu *obj, struct=
 cr_regs *crs, int num)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct cr_regs tmp;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct cr_regs *p =3D crs;
>
> - =C2=A0 =C2=A0 =C2=A0 clk_enable(obj->clk);
> + =C2=A0 =C2=A0 =C2=A0 pm_runtime_get_sync(obj->dev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iotlb_lock_get(obj, &saved);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for_each_iotlb_cr(obj, num, i, tmp) {
> @@ -416,7 +413,7 @@ __dump_tlb_entries(struct omap_iommu *obj, struct=
 cr_regs *crs, int num)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iotlb_lock_set(obj, &saved);
> - =C2=A0 =C2=A0 =C2=A0 clk_disable(obj->clk);
> + =C2=A0 =C2=A0 =C2=A0 pm_runtime_put(obj->dev);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return =C2=A0p - crs;
> =C2=A0}
> @@ -780,9 +777,7 @@ static irqreturn_t iommu_fault_handler(int irq, v=
oid *data)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!obj->refcount)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_NON=
E;
>
> - =C2=A0 =C2=A0 =C2=A0 clk_enable(obj->clk);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0errs =3D iommu_report_fault(obj, &da);
> - =C2=A0 =C2=A0 =C2=A0 clk_disable(obj->clk);

Why?

> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (errs =3D=3D 0)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return IRQ_HAN=
DLED;
>
> @@ -920,10 +915,6 @@ static int __devinit omap_iommu_probe(struct pla=
tform_device *pdev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!obj)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENOMEM=
;
>
> - =C2=A0 =C2=A0 =C2=A0 obj->clk =3D clk_get(&pdev->dev, pdata->clk_na=
me);
> - =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(obj->clk))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_clk;
> -
> =C2=A0 =C2=A0 =C2=A0 =C2=A0obj->nr_tlb_entries =3D pdata->nr_tlb_entr=
ies;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0obj->name =3D pdata->name;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0obj->dev =3D &pdev->dev;
> @@ -966,6 +957,8 @@ static int __devinit omap_iommu_probe(struct plat=
form_device *pdev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_irq;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0platform_set_drvdata(pdev, obj);
>
> + =C2=A0 =C2=A0 =C2=A0 pm_runtime_enable(obj->dev);
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info(&pdev->dev, "%s registered\n", ob=
j->name);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;
>
> @@ -974,8 +967,6 @@ err_irq:
> =C2=A0err_ioremap:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0release_mem_region(res->start, resource_si=
ze(res));
> =C2=A0err_mem:
> - =C2=A0 =C2=A0 =C2=A0 clk_put(obj->clk);
> -err_clk:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(obj);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return err;
> =C2=A0}
> @@ -996,7 +987,8 @@ static int __devexit omap_iommu_remove(struct pla=
tform_device *pdev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0release_mem_region(res->start, resource_si=
ze(res));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0iounmap(obj->regbase);
>
> - =C2=A0 =C2=A0 =C2=A0 clk_put(obj->clk);
> + =C2=A0 =C2=A0 =C2=A0 pm_runtime_disable(obj->dev);

I'm not sure if this is needed; you want to resume the driver? AFAICS
kfree will take care of that _without_ resuming.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info(&pdev->dev, "%s removed\n", obj->=
name);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0kfree(obj);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;

Cheers.

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
