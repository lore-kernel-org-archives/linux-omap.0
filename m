From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: Re: [PATCH v2 1/5] spi/omap: Remove bus_num usage for instance index
Date: Wed, 28 Mar 2012 14:15:32 +0530
Message-ID: <CAC83ZvKXMGfbM=ay_cPim1_PQk5nDRuC3+csOVfLzOVr9Qg6rg@mail.gmail.com>
References: <1332769480-28069-1-git-send-email-shubhrajyoti@ti.com>
	<1332769480-28069-2-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob129.obsmtp.com ([74.125.149.136]:51892 "EHLO
	na3sys009amx259.postini.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752361Ab2C1Ipd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Mar 2012 04:45:33 -0400
Received: by mail-qa0-f44.google.com with SMTP id c14so3756212qad.3
        for <linux-omap@vger.kernel.org>; Wed, 28 Mar 2012 01:45:32 -0700 (PDT)
In-Reply-To: <1332769480-28069-2-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

On Mon, Mar 26, 2012 at 7:14 PM, Shubhrajyoti D <shubhrajyoti@ti.com> w=
rote:
> From: Benoit Cousson <b-cousson@ti.com>
>
> bus_num was used to reference the mcspi controller instance in a fixe=
d array.
> Remove this array and store this information directly inside drvdata =
structure.
>
> bus_num is now just set if the pdev->id is present or with -1 for dyn=
amic
> allocation by SPI core, but the driver does not access it anymore.
>
> Clean some bad comments format, and remove un-needed space.
>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> [Cleanup the OMAP2_MCSPI_MAX_CTRL macro as it is not needed anymore]
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
> =A0drivers/spi/spi-omap2-mcspi.c | =A0 75 ++++++++++++++++++---------=
-------------
> =A01 files changed, 34 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mc=
spi.c
> index bb9274c..7785091 100644
> --- a/drivers/spi/spi-omap2-mcspi.c
> +++ b/drivers/spi/spi-omap2-mcspi.c
> @@ -45,9 +45,6 @@
>
> =A0#define OMAP2_MCSPI_MAX_FREQ =A0 =A0 =A0 =A0 =A0 48000000
>
> -/* OMAP2 has 3 SPI controllers, while OMAP3 has 4 */
> -#define OMAP2_MCSPI_MAX_CTRL =A0 =A0 =A0 =A0 =A0 4
> -
> =A0#define OMAP2_MCSPI_REVISION =A0 =A0 =A0 =A0 =A0 0x00
> =A0#define OMAP2_MCSPI_SYSSTATUS =A0 =A0 =A0 =A0 =A00x14
> =A0#define OMAP2_MCSPI_IRQSTATUS =A0 =A0 =A0 =A0 =A00x18
> @@ -111,6 +108,16 @@ struct omap2_mcspi_dma {
> =A0#define DMA_MIN_BYTES =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0160
>
>
> +/*
> + * Used for context save and restore, structure members to be update=
d whenever
> + * corresponding registers are modified.
> + */
> +struct omap2_mcspi_regs {
> + =A0 =A0 =A0 u32 modulctrl;
> + =A0 =A0 =A0 u32 wakeupenable;
> + =A0 =A0 =A0 struct list_head cs;
> +};
> +
> =A0struct omap2_mcspi {
> =A0 =A0 =A0 =A0struct work_struct =A0 =A0 =A0work;
> =A0 =A0 =A0 =A0/* lock protects queue and registers */
> @@ -122,8 +129,9 @@ struct omap2_mcspi {
> =A0 =A0 =A0 =A0unsigned long =A0 =A0 =A0 =A0 =A0 phys;
> =A0 =A0 =A0 =A0/* SPI1 has 4 channels, while SPI2 has 2 */
> =A0 =A0 =A0 =A0struct omap2_mcspi_dma =A0*dma_channels;
> - =A0 =A0 =A0 struct =A0device =A0 =A0 =A0 =A0 =A0*dev;
> + =A0 =A0 =A0 struct device =A0 =A0 =A0 =A0 =A0 *dev;
> =A0 =A0 =A0 =A0struct workqueue_struct *wq;
> + =A0 =A0 =A0 struct omap2_mcspi_regs ctx;
> =A0};
>
> =A0struct omap2_mcspi_cs {
> @@ -135,17 +143,6 @@ struct omap2_mcspi_cs {
> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chconf0;
> =A0};
>
> -/* used for context save and restore, structure members to be update=
d whenever
> - * corresponding registers are modified.
> - */
> -struct omap2_mcspi_regs {
> - =A0 =A0 =A0 u32 modulctrl;
> - =A0 =A0 =A0 u32 wakeupenable;
> - =A0 =A0 =A0 struct list_head cs;
> -};
> -
> -static struct omap2_mcspi_regs omap2_mcspi_ctx[OMAP2_MCSPI_MAX_CTRL]=
;
> -
> =A0#define MOD_REG_BIT(val, mask, set) do { \
> =A0 =A0 =A0 =A0if (set) \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0val |=3D mask; \
> @@ -236,9 +233,12 @@ static void omap2_mcspi_force_cs(struct spi_devi=
ce *spi, int cs_active)
>
> =A0static void omap2_mcspi_set_master_mode(struct spi_master *master)
> =A0{
> + =A0 =A0 =A0 struct omap2_mcspi =A0 =A0 =A0*mcspi =3D spi_master_get=
_devdata(master);
> + =A0 =A0 =A0 struct omap2_mcspi_regs *ctx =3D &mcspi->ctx;
> =A0 =A0 =A0 =A0u32 l;
>
> - =A0 =A0 =A0 /* setup when switching from (reset default) slave mode
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Setup when switching from (reset default) slave mo=
de
> =A0 =A0 =A0 =A0 * to single-channel master mode
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0l =3D mcspi_read_reg(master, OMAP2_MCSPI_MODULCTRL);
> @@ -247,24 +247,20 @@ static void omap2_mcspi_set_master_mode(struct =
spi_master *master)
> =A0 =A0 =A0 =A0MOD_REG_BIT(l, OMAP2_MCSPI_MODULCTRL_SINGLE, 1);
> =A0 =A0 =A0 =A0mcspi_write_reg(master, OMAP2_MCSPI_MODULCTRL, l);
>
> - =A0 =A0 =A0 omap2_mcspi_ctx[master->bus_num - 1].modulctrl =3D l;
> + =A0 =A0 =A0 ctx->modulctrl =3D l;
> =A0}
>
> =A0static void omap2_mcspi_restore_ctx(struct omap2_mcspi *mcspi)
> =A0{
> - =A0 =A0 =A0 struct spi_master *spi_cntrl;
> - =A0 =A0 =A0 struct omap2_mcspi_cs *cs;
> - =A0 =A0 =A0 spi_cntrl =3D mcspi->master;
> + =A0 =A0 =A0 struct spi_master =A0 =A0 =A0 *spi_cntrl =3D mcspi->mas=
ter;
> + =A0 =A0 =A0 struct omap2_mcspi_regs *ctx =3D &mcspi->ctx;
> + =A0 =A0 =A0 struct omap2_mcspi_cs =A0 *cs;
>
> =A0 =A0 =A0 =A0/* McSPI: context restore */
> - =A0 =A0 =A0 mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_MODULCTRL,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_mcspi_ctx[spi_cnt=
rl->bus_num - 1].modulctrl);
> + =A0 =A0 =A0 mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_MODULCTRL, ctx->=
modulctrl);
> + =A0 =A0 =A0 mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_WAKEUPENABLE, ct=
x->wakeupenable);
>
> - =A0 =A0 =A0 mcspi_write_reg(spi_cntrl, OMAP2_MCSPI_WAKEUPENABLE,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_mcspi_ctx[spi_cnt=
rl->bus_num - 1].wakeupenable);
> -
> - =A0 =A0 =A0 list_for_each_entry(cs, &omap2_mcspi_ctx[spi_cntrl->bus=
_num - 1].cs,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 node)
> + =A0 =A0 =A0 list_for_each_entry(cs, &ctx->cs, node)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__raw_writel(cs->chconf0, cs->base + O=
MAP2_MCSPI_CHCONF0);
> =A0}
> =A0static void omap2_mcspi_disable_clocks(struct omap2_mcspi *mcspi)
> @@ -777,7 +773,8 @@ static int omap2_mcspi_request_dma(struct spi_dev=
ice *spi)
> =A0static int omap2_mcspi_setup(struct spi_device *spi)
> =A0{
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret;
> - =A0 =A0 =A0 struct omap2_mcspi =A0 =A0 =A0*mcspi;
> + =A0 =A0 =A0 struct omap2_mcspi =A0 =A0 =A0*mcspi =3D spi_master_get=
_devdata(spi->master);
> + =A0 =A0 =A0 struct omap2_mcspi_regs *ctx =3D &mcspi->ctx;
> =A0 =A0 =A0 =A0struct omap2_mcspi_dma =A0*mcspi_dma;
> =A0 =A0 =A0 =A0struct omap2_mcspi_cs =A0 *cs =3D spi->controller_stat=
e;
>
> @@ -787,7 +784,6 @@ static int omap2_mcspi_setup(struct spi_device *s=
pi)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 mcspi =3D spi_master_get_devdata(spi->master);
> =A0 =A0 =A0 =A0mcspi_dma =3D &mcspi->dma_channels[spi->chip_select];
>
> =A0 =A0 =A0 =A0if (!cs) {
> @@ -799,8 +795,7 @@ static int omap2_mcspi_setup(struct spi_device *s=
pi)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cs->chconf0 =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spi->controller_state =3D cs;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Link this to context save list */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add_tail(&cs->node,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &omap2_mcspi_ctx[mcspi-=
>master->bus_num - 1].cs);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add_tail(&cs->node, &ctx->cs);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (mcspi_dma->dma_rx_channel =3D=3D -1
> @@ -1053,8 +1048,9 @@ static int omap2_mcspi_transfer(struct spi_devi=
ce *spi, struct spi_message *m)
> =A0static int __init omap2_mcspi_master_setup(struct omap2_mcspi *mcs=
pi)
> =A0{
> =A0 =A0 =A0 =A0struct spi_master =A0 =A0 =A0 *master =3D mcspi->maste=
r;
> + =A0 =A0 =A0 struct omap2_mcspi_regs *ctx =3D &mcspi->ctx;
> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp;
> - =A0 =A0 =A0 int ret =3D 0;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D 0;
>
> =A0 =A0 =A0 =A0ret =3D omap2_mcspi_enable_clocks(mcspi);
> =A0 =A0 =A0 =A0if (ret < 0)
> @@ -1062,7 +1058,7 @@ static int __init omap2_mcspi_master_setup(stru=
ct omap2_mcspi *mcspi)
>
> =A0 =A0 =A0 =A0tmp =3D OMAP2_MCSPI_WAKEUPENABLE_WKEN;
> =A0 =A0 =A0 =A0mcspi_write_reg(master, OMAP2_MCSPI_WAKEUPENABLE, tmp)=
;
> - =A0 =A0 =A0 omap2_mcspi_ctx[master->bus_num - 1].wakeupenable =3D t=
mp;
> + =A0 =A0 =A0 ctx->wakeupenable =3D tmp;
Can't we get rid of tmp now? For example:
ctx->wakeupenable =3D OMAP2_MCSPI_WAKEUPENABLE_WKEN;
mcspi_write_reg(master, OMAP2_MCSPI_WAKEUPENABLE, ctx->wakeupenable);
--
Tarun

>
> =A0 =A0 =A0 =A0omap2_mcspi_set_master_mode(master);
> =A0 =A0 =A0 =A0omap2_mcspi_disable_clocks(mcspi);
> @@ -1109,7 +1105,6 @@ static int __init omap2_mcspi_probe(struct plat=
form_device *pdev)
> =A0 =A0 =A0 =A0struct omap2_mcspi =A0 =A0 =A0*mcspi;
> =A0 =A0 =A0 =A0struct resource =A0 =A0 =A0 =A0 *r;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D=
 0, i;
> - =A0 =A0 =A0 char =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wq_name[20]=
;
> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 regs_offse=
t =3D 0;
> =A0 =A0 =A0 =A0static int =A0 =A0 =A0 =A0 =A0 =A0 =A0bus_num =3D 1;
> =A0 =A0 =A0 =A0struct device_node =A0 =A0 =A0*node =3D pdev->dev.of_n=
ode;
> @@ -1150,8 +1145,7 @@ static int __init omap2_mcspi_probe(struct plat=
form_device *pdev)
> =A0 =A0 =A0 =A0mcspi =3D spi_master_get_devdata(master);
> =A0 =A0 =A0 =A0mcspi->master =3D master;
>
> - =A0 =A0 =A0 sprintf(wq_name, "omap2_mcspi/%d", master->bus_num);
> - =A0 =A0 =A0 mcspi->wq =3D alloc_workqueue(wq_name, WQ_MEM_RECLAIM, =
1);
> + =A0 =A0 =A0 mcspi->wq =3D alloc_workqueue(dev_name(&pdev->dev), WQ_=
MEM_RECLAIM, 1);
> =A0 =A0 =A0 =A0if (mcspi->wq =3D=3D NULL) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D -ENOMEM;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto free_master;
> @@ -1184,7 +1178,7 @@ static int __init omap2_mcspi_probe(struct plat=
form_device *pdev)
>
> =A0 =A0 =A0 =A0spin_lock_init(&mcspi->lock);
> =A0 =A0 =A0 =A0INIT_LIST_HEAD(&mcspi->msg_queue);
> - =A0 =A0 =A0 INIT_LIST_HEAD(&omap2_mcspi_ctx[master->bus_num - 1].cs=
);
> + =A0 =A0 =A0 INIT_LIST_HEAD(&mcspi->ctx.cs);
>
> =A0 =A0 =A0 =A0mcspi->dma_channels =3D kcalloc(master->num_chipselect=
,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sizeof(struct omap2_mc=
spi_dma),
> @@ -1291,13 +1285,12 @@ static int omap2_mcspi_resume(struct device *=
dev)
> =A0{
> =A0 =A0 =A0 =A0struct spi_master =A0 =A0 =A0 *master =3D dev_get_drvd=
ata(dev);
> =A0 =A0 =A0 =A0struct omap2_mcspi =A0 =A0 =A0*mcspi =3D spi_master_ge=
t_devdata(master);
> - =A0 =A0 =A0 struct omap2_mcspi_cs *cs;
> + =A0 =A0 =A0 struct omap2_mcspi_regs *ctx =3D &mcspi->ctx;
> + =A0 =A0 =A0 struct omap2_mcspi_cs =A0 *cs;
>
> =A0 =A0 =A0 =A0omap2_mcspi_enable_clocks(mcspi);
> - =A0 =A0 =A0 list_for_each_entry(cs, &omap2_mcspi_ctx[master->bus_nu=
m - 1].cs,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 node) {
> + =A0 =A0 =A0 list_for_each_entry(cs, &ctx->cs, node) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ((cs->chconf0 & OMAP2_MCSPI_CHCONF_=
=46ORCE) =3D=3D 0) {
> -
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * We need to toggle C=
S state for OMAP take this
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * change in account.
> --
> 1.7.1
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
