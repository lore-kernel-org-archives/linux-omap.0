From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv4 1/9] omap: prcm: switch to a chained IRQ handler
 mechanism
Date: Wed, 29 Jun 2011 19:54:14 +0300
Message-ID: <20110629165413.GI2760@legolas.emea.dhcp.ti.com>
References: <1309338303-2086-1-git-send-email-t-kristo@ti.com>
 <1309338303-2086-2-git-send-email-t-kristo@ti.com>
 <20110629165318.GH2760@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6UEPj0d4ZbbWkD8I"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:38084 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754854Ab1F2QyY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Jun 2011 12:54:24 -0400
Received: by mail-bw0-f47.google.com with SMTP id 20so1471436bwf.20
        for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 09:54:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110629165318.GH2760@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Avinash.H.M" <avinashhm@ti.com>, Kevin Hilman <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, "Govindraj.R" <govindraj.raja@ti.com>


--6UEPj0d4ZbbWkD8I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 29, 2011 at 07:53:19PM +0300, Felipe Balbi wrote:
> On Wed, Jun 29, 2011 at 12:04:55PM +0300, Tero Kristo wrote:
> > diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> > index 96a7624..89cf027 100644
> > --- a/arch/arm/mach-omap2/pm34xx.c
> > +++ b/arch/arm/mach-omap2/pm34xx.c
> > @@ -880,20 +824,35 @@ static int __init omap3_pm_init(void)
> >  	/* XXX prcm_setup_regs needs to be before enabling hw
> >  	 * supervised mode for powerdomains */
> >  	prcm_setup_regs();
> > +	ret =3D omap_prcm_irq_init();
> > +	if (ret) {
> > +		pr_err("omap_prcm_irq_init() failed with %d\n", ret);
> > +		goto err_prcm_irq_init;
> > +	}
> > +
> > +	prcm_wkup_irq =3D omap_prcm_event_to_irq("wkup");
> > +	prcm_io_irq =3D omap_prcm_event_to_irq("io");
> > +
> > +	ret =3D request_irq(prcm_wkup_irq, _prcm_int_handle_wakeup,
> > +			IRQF_NO_SUSPEND | IRQF_DISABLED, "prcm_wkup", NULL);
>=20
> does this _have_ to be all in hardirq context ?
>=20
> > -	ret =3D request_irq(INT_34XX_PRCM_MPU_IRQ,
> > -			  (irq_handler_t)prcm_interrupt_handler,
> > -			  IRQF_DISABLED, "prcm", NULL);
> >  	if (ret) {
> > -		printk(KERN_ERR "request_irq failed to register for 0x%x\n",
> > -		       INT_34XX_PRCM_MPU_IRQ);
> > -		goto err1;
> > +		printk(KERN_ERR "Failed to request prcm_wkup irq\n");
> > +		goto err_prcm_wkup;
> > +	}
> > +
> > +	ret =3D request_irq(prcm_io_irq, _prcm_int_handle_wakeup,
> > +			IRQF_NO_SUSPEND | IRQF_DISABLED, "prcm_io", NULL);
>=20
> same here...
>=20
> > diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
> > index 6be1438..794e451 100644
> > --- a/arch/arm/mach-omap2/prcm.c
> > +++ b/arch/arm/mach-omap2/prcm.c
> > @@ -23,6 +23,8 @@
> >  #include <linux/clk.h>
> >  #include <linux/io.h>
> >  #include <linux/delay.h>
> > +#include <linux/irq.h>
> > +#include <linux/slab.h>
> > =20
> >  #include <mach/system.h>
> >  #include <plat/common.h>
> > @@ -45,6 +47,167 @@ void __iomem *cm2_base;
> > =20
> >  #define MAX_MODULE_ENABLE_WAIT		100000
> > =20
> > +/* Setup for the interrupt handling based on used platform */
> > +static struct omap_prcm_irq_setup *irq_setup;
>=20
> you can set this is irq_chip data, then you can:
>=20
> > +static void prcm_irq_ack(struct irq_data *data)
> > +{
> 	struct omap_prcm_irq_setup	*irq_setup =3D irq_data_get_irq_chip_data(dat=
a)
> 	unsigned int			prcm_irq =3D data->irq - irq_setup->base;
>=20
> 	irq_setup->ack_event(prcm_irq);
> > +}
>=20
> ditto to all other operations.
>=20
> > +static struct irq_chip_generic *prcm_irq_chips[OMAP_PRCM_MAX_NR_PENDIN=
G_REG];
>=20
> can't you allocate this dynamically ???
>=20
> > +/*
> > + * PRCM Interrupt Handler
> > + *
> > + * The PRM_IRQSTATUS_MPU register indicates if there are any pending
> > + * interrupts from the PRCM for the MPU. These bits must be cleared in
> > + * order to clear the PRCM interrupt. The PRCM interrupt handler is
> > + * implemented to simply clear the PRM_IRQSTATUS_MPU in order to clear
> > + * the PRCM interrupt. Please note that bit 0 of the PRM_IRQSTATUS_MPU
> > + * register indicates that a wake-up event is pending for the MPU and
> > + * this bit can only be cleared if the all the wake-up events latched
> > + * in the various PM_WKST_x registers have been cleared. The interrupt
> > + * handler is implemented using a do-while loop so that if a wake-up
> > + * event occurred during the processing of the prcm interrupt handler
> > + * (setting a bit in the corresponding PM_WKST_x register and thus
> > + * preventing us from clearing bit 0 of the PRM_IRQSTATUS_MPU register)
> > + * this would be handled.
> > + */
> > +static void prcm_irq_handler(unsigned int irq, struct irq_desc *desc)
> > +{
> > +	unsigned long pending[OMAP_PRCM_MAX_NR_PENDING_REG];
> > +	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> > +
> > +	/*
> > +	 * Loop until all pending irqs are handled, since
> > +	 * generic_handle_irq(), called by prcm_irq_handle_virtirqs()
> > +	 * can cause new irqs to come
> > +	 */
> > +	while (1) {
> > +		unsigned int virtirq;
> > +
> > +		chip->irq_ack(&desc->irq_data);
> > +
> > +		memset(pending, 0, sizeof(pending));
> > +		irq_setup->pending_events(pending);
> > +
> > +		/* No bit set, then all IRQs are handled */
> > +		if (find_first_bit(pending, OMAP_PRCM_NR_IRQS)
> > +		    >=3D OMAP_PRCM_NR_IRQS) {
> > +			chip->irq_unmask(&desc->irq_data);
> > +			break;
> > +		}
> > +
> > +		/*
> > +		 * Loop on all currently pending irqs so that new irqs
> > +		 * cannot starve previously pending irqs
> > +		 */
> > +		for_each_set_bit(virtirq, pending, OMAP_PRCM_NR_IRQS)
> > +			generic_handle_irq(OMAP_PRCM_IRQ_BASE + virtirq);
>=20
> if you use nested IRQ threads, you could be using
> handle_nested_irq(irq);
>=20
> > +		chip->irq_unmask(&desc->irq_data);
> > +	}
> > +}
> > +
> > +/*
> > + * Given a PRCM event name, returns the corresponding IRQ on which the
> > + * handler should be registered.
> > + */
> > +int omap_prcm_event_to_irq(const char *name)
> > +{
> > +	int i;
> > +
> > +	for (i =3D 0; i < irq_setup->num_irqs; i++)
> > +		if (!strcmp(irq_setup->irqs[i].name, name))
> > +			return OMAP_PRCM_IRQ_BASE + irq_setup->irqs[i].offset;
> > +
> > +	return -ENOENT;
> > +}
> > +
> > +/*
> > + * Prepare the array of PRCM events corresponding to the current SoC,
> > + * and set-up the chained interrupt handler mechanism.
> > + */
> > +int __init omap_prcm_irq_init(void)
> > +{
> > +	int i;
> > +	struct irq_chip_generic *gc;
> > +	struct irq_chip_type *ct;
> > +	u32 mask[2] =3D { 0, 0 };
> > +	int offset;
> > +	int max_irq =3D 0;
> > +
> > +	for (i =3D 0; i < irq_setup->num_irqs; i++)
>=20
> how about using irq_alloc_descs() ?? Then we can make use of Sparse IRQ
> numbers and avoid passing irq_base/irq_end and adding that weird ifdef
> hackery to get NR_IRQS right.
>=20
> > diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-oma=
p/include/plat/irqs.h
> > index 5a25098..23b9680 100644
> > --- a/arch/arm/plat-omap/include/plat/irqs.h
> > +++ b/arch/arm/plat-omap/include/plat/irqs.h
> > @@ -366,7 +366,14 @@
> >  #define OMAP_MAX_GPIO_LINES	192
> >  #define IH_GPIO_BASE		(128 + IH2_BASE)
> >  #define IH_MPUIO_BASE		(OMAP_MAX_GPIO_LINES + IH_GPIO_BASE)
> > -#define OMAP_IRQ_END		(IH_MPUIO_BASE + 16)
> > +#define OMAP_MPUIO_IRQ_END	(IH_MPUIO_BASE + 16)
> > +
> > +/* 64 IRQs for the PRCM (32 are needed on OMAP3, 64 on OMAP4) */
> > +#define OMAP_PRCM_IRQ_BASE      (OMAP_MPUIO_IRQ_END)
> > +#define OMAP_PRCM_NR_IRQS       64
> > +#define OMAP_PRCM_IRQ_END       (OMAP_PRCM_IRQ_BASE + OMAP_PRCM_NR_IRQ=
S)
> > +
> > +#define OMAP_IRQ_END            (OMAP_PRCM_IRQ_END)
>=20
> this is unnecessary with Sparse IRQ numbers and IMHO we should aim for
> that. See the very simple conversion that I sent for the very old retu
> driver [1] and [2] and you'll see that with time, we could get rid of
> NR_IRQS altogether.

[1] http://marc.info/?l=3Dlinux-omap&m=3D130934802215308&w=3D2
[2] http://marc.info/?l=3Dlinux-omap&m=3D130934804515353&w=3D2

--=20
balbi

--6UEPj0d4ZbbWkD8I
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOC1i1AAoJEAv8Txj19kN1AA8IAIifWbkOcZrKj0N6fnSBRlf/
3PwZCiJvHrblBwi5t6fuLfMep0PoSVPK4a4bOmQu4+tz3tjMv1NHcE3mP1xZ2hom
Ea3pkKB6tlc/Rp25+lcCCN3+Q3kWYiG0k8i12K/BVdqRpQDvrqFkcEE1RnS3O1dF
2ilVLL5ualiR3ecG27uqlI8ymGUX+3isv525/EiL/FqzXuNHPXc0QfvZ9UdwpCv6
Ufzp8fCfpS49BEY9kz1xLBlhCzBDTSpF+3Ieohb8WMdK4ve/rdqgATOu3bZNmKx6
veklA3ss1f3Yi9ucsnT+1x1gP8yTcDA+PYBR2tCrR7NXQaKsC/46gsk58jcTJmI=
=VEwS
-----END PGP SIGNATURE-----

--6UEPj0d4ZbbWkD8I--
