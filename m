From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCHv3 2/6] PRCM: Add support for PAD wakeup interrupts
Date: Thu, 23 Jun 2011 15:53:29 +0530
Message-ID: <BANLkTingCPNkpcyfNwy2=M75n6cmVUR6Yg@mail.gmail.com>
References: <1308760934-9757-1-git-send-email-t-kristo@ti.com> <1308760934-9757-3-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57219 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758245Ab1FWKXu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Jun 2011 06:23:50 -0400
Received: by mail-bw0-f46.google.com with SMTP id 15so1402607bwz.19
        for <linux-omap@vger.kernel.org>; Thu, 23 Jun 2011 03:23:49 -0700 (PDT)
In-Reply-To: <1308760934-9757-3-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org

On Wed, Jun 22, 2011 at 10:12 PM, Tero Kristo <t-kristo@ti.com> wrote:
> PRCM interrupt handler will now parse registered pads to see whether =
there
> is an active wakeup event. If this is the case, the corresponding int=
errupt
> will be triggered. This can be used for example with UART driver to r=
egister
> PAD wakeup event for the UART RX pin, and when this happens, UART int=
errupt
> will be triggered.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
> =A0arch/arm/mach-omap2/prcm.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0 50 ++++++=
++++++++++++++++++++++++++
> =A0arch/arm/plat-omap/include/plat/prcm.h | =A0 =A01 +
> =A02 files changed, 51 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
> index 362c59c..cc92064 100644
> --- a/arch/arm/mach-omap2/prcm.c
> +++ b/arch/arm/mach-omap2/prcm.c
> @@ -53,6 +53,15 @@ static struct omap_prcm_irq *omap_prcm_irqs;
> =A0/* Number of entries in omap_prcm_irqs */
> =A0static int omap_prcm_irqs_nr;
>
> +/* PAD handlers list */
> +struct pad_def {
> + =A0 =A0 =A0 u32 pad;
> + =A0 =A0 =A0 unsigned int irq;
> + =A0 =A0 =A0 struct list_head node;
> +};
> +
> +static LIST_HEAD(pad_handler_list);
> +
> =A0/* Pointers to either OMAP3 or OMAP4 specific functions */
> =A0static void (*omap_prcm_mask_event)(unsigned event);
> =A0static void (*omap_prcm_unmask_event)(unsigned event);
> @@ -84,6 +93,25 @@ static struct irq_chip prcm_irq_chip =3D {
> =A0 =A0 =A0 =A0.irq_unmask =A0 =A0 =3D prcm_irq_unmask,
> =A0};
>
> +
> +/*
> + * Handler for PAD irqs, called from PRCM interrupt handler
> + */
> +static void omap_prcm_handle_pad_irqs(void)
> +{
> + =A0 =A0 =A0 struct pad_def *def;
> + =A0 =A0 =A0 u16 val =3D 0;
> + =A0 =A0 =A0 list_for_each_entry(def, &pad_handler_list, node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Read padconf value based on cpu type=
 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cpu_is_omap34xx())
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D omap_ctrl_readw=
(def->pad);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* if pad wakeupevent is active, fire r=
egistered IRQ */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (val & OMAP3_PADCONF_WAKEUPEVENT0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 generic_handle_irq(def-=
>irq);
> + =A0 =A0 =A0 }
> +}
> +
> =A0/*
> =A0* PRCM Interrupt Handler
> =A0*
> @@ -106,6 +134,9 @@ static void prcm_irq_handler(unsigned int irq, st=
ruct irq_desc *desc)
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
> @@ -153,6 +184,25 @@ int omap_prcm_event_to_irq(const char *name)
> =A0}
>
> =A0/*
> + * Register interrupt handler for a given pad. When the PRCM interru=
pt
> + * handler detects wakeupevent on the corresponding pad, the IRQ wil=
l
> + * be triggered.
> + */
> +int omap_prcm_register_pad_irq(u32 pad, unsigned int irq)

I tested this v3 series seems to work fine.

Minor comments.

Can we make the prcm_register interface params with mux_name
or
even omap_hmwod and with hwmod api's check
wake-up event through a mux api as here [1]
rather than passing pad offset.

since I planning to test uart-runtime changes with irq_chaining,
pad offsets are no more available with uart-runtime
and uses hmwod_mux api's.

--
Thanks,
Govindraj.R

[1] https://patchwork.kernel.org/patch/773932/

> +{
> + =A0 =A0 =A0 struct pad_def *def;
> +
> + =A0 =A0 =A0 def =3D kmalloc(sizeof(struct pad_def), GFP_ATOMIC);
> + =A0 =A0 =A0 if (!def)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 def->pad =3D pad;
> + =A0 =A0 =A0 def->irq =3D irq;
> + =A0 =A0 =A0 list_add(&def->node, &pad_handler_list);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/*
> =A0* Prepare the array of PRCM events corresponding to the current So=
C,
> =A0* and set-up the chained interrupt handler mechanism.
> =A0*/
> diff --git a/arch/arm/plat-omap/include/plat/prcm.h b/arch/arm/plat-o=
map/include/plat/prcm.h
> index 5785555..789eb17 100644
> --- a/arch/arm/plat-omap/include/plat/prcm.h
> +++ b/arch/arm/plat-omap/include/plat/prcm.h
> @@ -72,6 +72,7 @@ void omap4_prcm_pending_events(unsigned long *pendi=
ng);
> =A0int omap_prcm_event_to_irq(const char *name);
> =A0int omap_prcm_irq_init(void);
> =A0void omap_prcm_irq_cleanup(void);
> +int omap_prcm_register_pad_irq(u32 pad, unsigned int irq);
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
