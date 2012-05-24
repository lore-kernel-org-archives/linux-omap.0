From: Rob Clark <rob.clark@linaro.org>
Subject: Re: [PATCH] staging: omapdrm: Fix error paths during dmm init
Date: Thu, 24 May 2012 12:40:50 -0600
Message-ID: <CAF6AEGudrv5Vqp7_Qu=C9JArPx11YZRdZ7NeyffEDEbjBXzJRg@mail.gmail.com>
References: <1337877812-5020-1-git-send-email-andy.gross@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:63294 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756871Ab2EXSkv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 May 2012 14:40:51 -0400
Received: by vcbf11 with SMTP id f11so52851vcb.19
        for <linux-omap@vger.kernel.org>; Thu, 24 May 2012 11:40:50 -0700 (PDT)
In-Reply-To: <1337877812-5020-1-git-send-email-andy.gross@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andy Gross <andy.gross@ti.com>
Cc: dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, greg@kroah.com

On Thu, May 24, 2012 at 10:43 AM, Andy Gross <andy.gross@ti.com> wrote:
> Failures during the dmm probe can cause the kernel to crash. =A0Moved
> the spinlock to a global and moved list initializations immediately
> after the allocation of the dmm private structure.
>
> Signed-off-by: Andy Gross <andy.gross@ti.com>

Reviewed-by: Rob Clark <rob.clark@linaro.org>

> ---
> =A0drivers/staging/omapdrm/omap_dmm_priv.h =A0| =A0 =A01 -
> =A0drivers/staging/omapdrm/omap_dmm_tiler.c | =A0 44 ++++++++++++++++=
-------------
> =A02 files changed, 24 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/staging/omapdrm/omap_dmm_priv.h b/drivers/stagin=
g/omapdrm/omap_dmm_priv.h
> index 2f529ab..08b22e9 100644
> --- a/drivers/staging/omapdrm/omap_dmm_priv.h
> +++ b/drivers/staging/omapdrm/omap_dmm_priv.h
> @@ -181,7 +181,6 @@ struct dmm {
>
> =A0 =A0 =A0 =A0/* allocation list and lock */
> =A0 =A0 =A0 =A0struct list_head alloc_head;
> - =A0 =A0 =A0 spinlock_t list_lock;
> =A0};
>
> =A0#endif
> diff --git a/drivers/staging/omapdrm/omap_dmm_tiler.c b/drivers/stagi=
ng/omapdrm/omap_dmm_tiler.c
> index 1ecb6a7..3bc715d 100644
> --- a/drivers/staging/omapdrm/omap_dmm_tiler.c
> +++ b/drivers/staging/omapdrm/omap_dmm_tiler.c
> @@ -40,6 +40,9 @@
> =A0static struct tcm *containers[TILFMT_NFORMATS];
> =A0static struct dmm *omap_dmm;
>
> +/* global spinlock for protecting lists */
> +static DEFINE_SPINLOCK(list_lock);
> +
> =A0/* Geometry table */
> =A0#define GEOM(xshift, yshift, bytes_per_pixel) { \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.x_shft =3D (xshift), \
> @@ -147,13 +150,13 @@ static struct dmm_txn *dmm_txn_init(struct dmm =
*dmm, struct tcm *tcm)
> =A0 =A0 =A0 =A0down(&dmm->engine_sem);
>
> =A0 =A0 =A0 =A0/* grab an idle engine */
> - =A0 =A0 =A0 spin_lock(&dmm->list_lock);
> + =A0 =A0 =A0 spin_lock(&list_lock);
> =A0 =A0 =A0 =A0if (!list_empty(&dmm->idle_head)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0engine =3D list_entry(dmm->idle_head.n=
ext, struct refill_engine,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0idle_node);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0list_del(&engine->idle_node);
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 spin_unlock(&dmm->list_lock);
> + =A0 =A0 =A0 spin_unlock(&list_lock);
>
> =A0 =A0 =A0 =A0BUG_ON(!engine);
>
> @@ -256,9 +259,9 @@ static int dmm_txn_commit(struct dmm_txn *txn, bo=
ol wait)
> =A0 =A0 =A0 =A0}
>
> =A0cleanup:
> - =A0 =A0 =A0 spin_lock(&dmm->list_lock);
> + =A0 =A0 =A0 spin_lock(&list_lock);
> =A0 =A0 =A0 =A0list_add(&engine->idle_node, &dmm->idle_head);
> - =A0 =A0 =A0 spin_unlock(&dmm->list_lock);
> + =A0 =A0 =A0 spin_unlock(&list_lock);
>
> =A0 =A0 =A0 =A0up(&omap_dmm->engine_sem);
> =A0 =A0 =A0 =A0return ret;
> @@ -351,9 +354,9 @@ struct tiler_block *tiler_reserve_2d(enum tiler_f=
mt fmt, uint16_t w,
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* add to allocation list */
> - =A0 =A0 =A0 spin_lock(&omap_dmm->list_lock);
> + =A0 =A0 =A0 spin_lock(&list_lock);
> =A0 =A0 =A0 =A0list_add(&block->alloc_node, &omap_dmm->alloc_head);
> - =A0 =A0 =A0 spin_unlock(&omap_dmm->list_lock);
> + =A0 =A0 =A0 spin_unlock(&list_lock);
>
> =A0 =A0 =A0 =A0return block;
> =A0}
> @@ -374,9 +377,9 @@ struct tiler_block *tiler_reserve_1d(size_t size)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 0;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 spin_lock(&omap_dmm->list_lock);
> + =A0 =A0 =A0 spin_lock(&list_lock);
> =A0 =A0 =A0 =A0list_add(&block->alloc_node, &omap_dmm->alloc_head);
> - =A0 =A0 =A0 spin_unlock(&omap_dmm->list_lock);
> + =A0 =A0 =A0 spin_unlock(&list_lock);
>
> =A0 =A0 =A0 =A0return block;
> =A0}
> @@ -389,9 +392,9 @@ int tiler_release(struct tiler_block *block)
> =A0 =A0 =A0 =A0if (block->area.tcm)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(omap_dmm->dev, "failed to rele=
ase block\n");
>
> - =A0 =A0 =A0 spin_lock(&omap_dmm->list_lock);
> + =A0 =A0 =A0 spin_lock(&list_lock);
> =A0 =A0 =A0 =A0list_del(&block->alloc_node);
> - =A0 =A0 =A0 spin_unlock(&omap_dmm->list_lock);
> + =A0 =A0 =A0 spin_unlock(&list_lock);
>
> =A0 =A0 =A0 =A0kfree(block);
> =A0 =A0 =A0 =A0return ret;
> @@ -479,13 +482,13 @@ static int omap_dmm_remove(struct platform_devi=
ce *dev)
>
> =A0 =A0 =A0 =A0if (omap_dmm) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* free all area regions */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&omap_dmm->list_lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&list_lock);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0list_for_each_entry_safe(block, _block=
, &omap_dmm->alloc_head,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0alloc_node) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0list_del(&block->alloc=
_node);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kfree(block);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&omap_dmm->list_lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&list_lock);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (i =3D 0; i < omap_dmm->num_lut; i=
++)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (omap_dmm->tcm && o=
map_dmm->tcm[i])
> @@ -503,7 +506,7 @@ static int omap_dmm_remove(struct platform_device=
 *dev)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0vfree(omap_dmm->lut);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (omap_dmm->irq !=3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (omap_dmm->irq > 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free_irq(omap_dmm->irq=
, omap_dmm);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0iounmap(omap_dmm->base);
> @@ -527,6 +530,10 @@ static int omap_dmm_probe(struct platform_device=
 *dev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 /* initialize lists */
> + =A0 =A0 =A0 INIT_LIST_HEAD(&omap_dmm->alloc_head);
> + =A0 =A0 =A0 INIT_LIST_HEAD(&omap_dmm->idle_head);
> +
> =A0 =A0 =A0 =A0/* lookup hwmod data - base address and irq */
> =A0 =A0 =A0 =A0mem =3D platform_get_resource(dev, IORESOURCE_MEM, 0);
> =A0 =A0 =A0 =A0if (!mem) {
> @@ -629,7 +636,6 @@ static int omap_dmm_probe(struct platform_device =
*dev)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0sema_init(&omap_dmm->engine_sem, omap_dmm->num_engines=
);
> - =A0 =A0 =A0 INIT_LIST_HEAD(&omap_dmm->idle_head);
> =A0 =A0 =A0 =A0for (i =3D 0; i < omap_dmm->num_engines; i++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_dmm->engines[i].id =3D i;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_dmm->engines[i].dmm =3D omap_dmm;
> @@ -672,9 +678,6 @@ static int omap_dmm_probe(struct platform_device =
*dev)
> =A0 =A0 =A0 =A0containers[TILFMT_32BIT] =3D omap_dmm->tcm[0];
> =A0 =A0 =A0 =A0containers[TILFMT_PAGE] =3D omap_dmm->tcm[0];
>
> - =A0 =A0 =A0 INIT_LIST_HEAD(&omap_dmm->alloc_head);
> - =A0 =A0 =A0 spin_lock_init(&omap_dmm->list_lock);
> -
> =A0 =A0 =A0 =A0area =3D (struct tcm_area) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.is2d =3D true,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.tcm =3D NULL,
> @@ -697,7 +700,8 @@ static int omap_dmm_probe(struct platform_device =
*dev)
> =A0 =A0 =A0 =A0return 0;
>
> =A0fail:
> - =A0 =A0 =A0 omap_dmm_remove(dev);
> + =A0 =A0 =A0 if (omap_dmm_remove(dev))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&dev->dev, "cleanup failed\n");
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> @@ -810,7 +814,7 @@ int tiler_map_show(struct seq_file *s, void *arg)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0map[i] =3D global_map + i * (w_adj + 1=
);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0map[i][w_adj] =3D 0;
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 spin_lock_irqsave(&omap_dmm->list_lock, flags);
> + =A0 =A0 =A0 spin_lock_irqsave(&list_lock, flags);
>
> =A0 =A0 =A0 =A0list_for_each_entry(block, &omap_dmm->alloc_head, allo=
c_node) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (block->fmt !=3D TILFMT_PAGE) {
> @@ -836,7 +840,7 @@ int tiler_map_show(struct seq_file *s, void *arg)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 spin_unlock_irqrestore(&omap_dmm->list_lock, flags);
> + =A0 =A0 =A0 spin_unlock_irqrestore(&list_lock, flags);
>
> =A0 =A0 =A0 =A0if (s) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0seq_printf(s, "BEGIN DMM TILER MAP\n")=
;
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
