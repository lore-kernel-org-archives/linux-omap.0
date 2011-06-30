From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCHv4 2/9] PRCM: Add support for PAD wakeup interrupts
Date: Thu, 30 Jun 2011 22:40:22 +0530
Message-ID: <BANLkTi=Ek6qMBj348V+RUMUr7d40JJgj9Q@mail.gmail.com>
References: <1309338303-2086-1-git-send-email-t-kristo@ti.com> <1309338303-2086-3-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34054 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751122Ab1F3RKo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Jun 2011 13:10:44 -0400
Received: by bwd5 with SMTP id 5so1991701bwd.19
        for <linux-omap@vger.kernel.org>; Thu, 30 Jun 2011 10:10:43 -0700 (PDT)
In-Reply-To: <1309338303-2086-3-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org

On Wed, Jun 29, 2011 at 2:34 PM, Tero Kristo <t-kristo@ti.com> wrote:
> PRCM interrupt handler will now parse registered pads to see whether =
there
> is an active wakeup event. If there is a pending wakeup event, the re=
gistered
> ISR will be called.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
> =A0arch/arm/mach-omap2/prcm.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 94 ++++++=
++++++++++++++++++++++++++
> =A0arch/arm/plat-omap/include/plat/prcm.h | =A0 =A05 ++
> =A02 files changed, 99 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
> index 794e451..6b603eb 100644
> --- a/arch/arm/mach-omap2/prcm.c
> +++ b/arch/arm/mach-omap2/prcm.c
> @@ -30,6 +30,7 @@
> =A0#include <plat/common.h>
> =A0#include <plat/prcm.h>
> =A0#include <plat/irqs.h>
> +#include <plat/omap_hwmod.h>
>
> =A0#include "clock.h"
> =A0#include "clock2xxx.h"
> @@ -40,6 +41,7 @@
> =A0#include "prm-regbits-24xx.h"
> =A0#include "prm-regbits-44xx.h"
> =A0#include "control.h"
> +#include "mux.h"
>
> =A0void __iomem *prm_base;
> =A0void __iomem *cm_base;
> @@ -50,6 +52,15 @@ void __iomem *cm2_base;
> =A0/* Setup for the interrupt handling based on used platform */
> =A0static struct omap_prcm_irq_setup *irq_setup;
>
> +/* PAD handlers list */
> +struct pad_def {
> + =A0 =A0 =A0 struct omap_device_pad *pad;
> + =A0 =A0 =A0 unsigned int irq;
> + =A0 =A0 =A0 struct list_head node;
> +};
> +
> +static LIST_HEAD(pad_handler_list);
> +
> =A0static void prcm_irq_ack(struct irq_data *data)
> =A0{
> =A0 =A0 =A0 =A0unsigned int prcm_irq =3D data->irq - OMAP_PRCM_IRQ_BA=
SE;
> @@ -71,6 +82,24 @@ static void prcm_irq_unmask(struct irq_data *data)
> =A0static struct irq_chip_generic *prcm_irq_chips[OMAP_PRCM_MAX_NR_PE=
NDING_REG];
>
> =A0/*
> + * Handler for PAD irqs, called from PRCM interrupt handler
> + */
> +static void omap_prcm_handle_pad_irqs(void)
> +{
> + =A0 =A0 =A0 struct pad_def *def;
> + =A0 =A0 =A0 u16 val =3D 0;
> + =A0 =A0 =A0 list_for_each_entry(def, &pad_handler_list, node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Read padconf value */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D omap_mux_read(def->pad->partiti=
on,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 def->pad->mux->reg_offs=
et);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* If pad wakeupevent is active, call r=
egistered ISR */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (val & OMAP3_PADCONF_WAKEUPEVENT0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 generic_handle_irq(def-=
>irq);
> + =A0 =A0 =A0 }
> +}
> +
> +/*
> =A0* PRCM Interrupt Handler
> =A0*
> =A0* The PRM_IRQSTATUS_MPU register indicates if there are any pendin=
g
> @@ -92,6 +121,9 @@ static void prcm_irq_handler(unsigned int irq, str=
uct irq_desc *desc)
> =A0 =A0 =A0 =A0unsigned long pending[OMAP_PRCM_MAX_NR_PENDING_REG];
> =A0 =A0 =A0 =A0struct irq_chip *chip =3D irq_desc_get_chip(desc);
>
> + =A0 =A0 =A0 /* Handle PAD events first, we don't want to ack them b=
efore parse */
> + =A0 =A0 =A0 omap_prcm_handle_pad_irqs();
> +
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Loop until all pending irqs are handled, since
> =A0 =A0 =A0 =A0 * generic_handle_irq(), called by prcm_irq_handle_vir=
tirqs()
> @@ -139,6 +171,68 @@ int omap_prcm_event_to_irq(const char *name)
> =A0}
>
> =A0/*
> + * Register interrupt handler for a given omap_hwmod_mux. When the P=
RCM
> + * interrupt handler detects wakeupevent on the corresponding pad, t=
he
> + * ISR will be called.
> + */
> +int omap_prcm_register_pad_irqs(struct omap_hwmod_mux_info *mux,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigne=
d int irq)
> +{
> + =A0 =A0 =A0 struct pad_def *def;
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 u16 val;
> +
> + =A0 =A0 =A0 if (!mux)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 for (i =3D 0; i < mux->nr_pads; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!(mux->pads[i].enable & OMAP_PIN_IN=
PUT))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> +

cant be some thing like below considering my pad has entry as [1]

if(!(mux->pads[i].flags & ( OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAK=
EUP))
        continue;


> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 def =3D kmalloc(sizeof(struct pad_def),=
 GFP_ATOMIC);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!def)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 def->pad =3D mux->pads + i;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 def->irq =3D irq;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Enable pad wakeup */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D omap_mux_read(def->pad->partiti=
on,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 def->pad->mux->reg_offs=
et);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val |=3D OMAP_WAKEUP_EN;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_mux_write(def->pad->partition, val=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 def->pad->mux->reg_offs=
et);


I think all direct read write to mux data can be avoided,

just cant we do

mux->pads[i].idle |=3D OMAP_WAKEUP_EN;

considering if if I have a uart pad entry for rx as below,

[1]:

{
	.name   =3D "uart1_rx.uart1_rx",
	.flags  =3D OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
	.enable =3D OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
	.idle =3D OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
},




> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add(&def->node, &pad_handler_list)=
;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/*
> + * Unregister pad irqs associated with a hwmod mux
> + */
> +void omap_prcm_unregister_pad_irqs(struct omap_hwmod_mux_info *mux)
> +{
> + =A0 =A0 =A0 struct pad_def *def;
> + =A0 =A0 =A0 int i;
> + =A0 =A0 =A0 u16 val;
> +
> + =A0 =A0 =A0 list_for_each_entry(def, &pad_handler_list, node)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < mux->nr_pads; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (def->pad =3D=3D mux=
->pads + i) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_de=
l(&def->node);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Disa=
ble pad wakeup */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D=
 omap_mux_read(def->pad->partition,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 def->pad->mux->reg_offset);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val &=3D=
 ~OMAP_WAKEUP_EN;

same here.

mux->pads[i].idle &=3D ~OMAP_WAKEUP_EN;

--
Thanks,
Govindraj.R


> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_mu=
x_write(def->pad->partition, val,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 def->pad->mux->reg_offset);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(d=
ef);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +}
> +
> +/*
> =A0* Prepare the array of PRCM events corresponding to the current So=
C,
> =A0* and set-up the chained interrupt handler mechanism.
> =A0*/
> diff --git a/arch/arm/plat-omap/include/plat/prcm.h b/arch/arm/plat-o=
map/include/plat/prcm.h
> index 205b9b1..7987819 100644
> --- a/arch/arm/plat-omap/include/plat/prcm.h
> +++ b/arch/arm/plat-omap/include/plat/prcm.h
> @@ -66,10 +66,15 @@ struct omap_prcm_irq_setup {
> =A0 =A0 =A0 =A0int irq;
> =A0};
>
> +struct omap_hwmod_mux_info;
> +
> =A0int omap_prcm_event_to_irq(const char *name);
> =A0int omap_prcm_irq_init(void);
> =A0void omap_prcm_irq_setup(struct omap_prcm_irq_setup *setup);
> =A0void omap_prcm_irq_cleanup(void);
> +int omap_prcm_register_pad_irqs(struct omap_hwmod_mux_info *mux,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigne=
d int irq);
> +void omap_prcm_unregister_pad_irqs(struct omap_hwmod_mux_info *mux);
> =A0u32 omap_prcm_get_reset_sources(void);
> =A0int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, u8 idlest,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *name);
> --
> 1.7.4.1
>
>
> Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040=
-6. Kotipaikka: Helsinki
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
