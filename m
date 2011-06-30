From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv4 1/9] omap: prcm: switch to a chained IRQ handler
 mechanism
Date: Thu, 30 Jun 2011 12:11:24 +0300
Message-ID: <20110630091123.GF6057@legolas.emea.dhcp.ti.com>
References: <1309338303-2086-1-git-send-email-t-kristo@ti.com>
 <1309338303-2086-2-git-send-email-t-kristo@ti.com>
 <20110629165318.GH2760@legolas.emea.dhcp.ti.com>
 <1309413099.6148.46.camel@sokoban>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PuGuTyElPB9bOcsM"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:48693 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751596Ab1F3JLa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Jun 2011 05:11:30 -0400
Received: by mail-bw0-f51.google.com with SMTP id 18so1928391bwa.38
        for <linux-omap@vger.kernel.org>; Thu, 30 Jun 2011 02:11:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1309413099.6148.46.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, linux-omap@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Mahadeva, Avinash" <avinashhm@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, "R, Govindraj" <govindraj.raja@ti.com>


--PuGuTyElPB9bOcsM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jun 30, 2011 at 08:51:39AM +0300, Tero Kristo wrote:
> On Wed, 2011-06-29 at 18:53 +0200, Balbi, Felipe wrote:
> > Hi,
> >=20
> > On Wed, Jun 29, 2011 at 12:04:55PM +0300, Tero Kristo wrote:
> > > diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34x=
x.c
> > > index 96a7624..89cf027 100644
> > > --- a/arch/arm/mach-omap2/pm34xx.c
> > > +++ b/arch/arm/mach-omap2/pm34xx.c
> > > @@ -880,20 +824,35 @@ static int __init omap3_pm_init(void)
> > >  	/* XXX prcm_setup_regs needs to be before enabling hw
> > >  	 * supervised mode for powerdomains */
> > >  	prcm_setup_regs();
> > > +	ret =3D omap_prcm_irq_init();
> > > +	if (ret) {
> > > +		pr_err("omap_prcm_irq_init() failed with %d\n", ret);
> > > +		goto err_prcm_irq_init;
> > > +	}
> > > +
> > > +	prcm_wkup_irq =3D omap_prcm_event_to_irq("wkup");
> > > +	prcm_io_irq =3D omap_prcm_event_to_irq("io");
> > > +
> > > +	ret =3D request_irq(prcm_wkup_irq, _prcm_int_handle_wakeup,
> > > +			IRQF_NO_SUSPEND | IRQF_DISABLED, "prcm_wkup", NULL);
> >=20
> > does this _have_ to be all in hardirq context ?
>=20
> Not really, imo this does not need to be done in an interrupt at all.
> The wakeup event ack can be done just before entering next idle, as I
> did in a previous version of this set, but it did not receive that
> positive comments yet. I will probably try to push this idea forward
> once this set is pulled.

I see... BTW, IRQF_DISABLED is a nop now, you don't need it. I missed
that before ;-)

> > > diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
> > > index 6be1438..794e451 100644
> > > --- a/arch/arm/mach-omap2/prcm.c
> > > +++ b/arch/arm/mach-omap2/prcm.c
> > > @@ -23,6 +23,8 @@
> > >  #include <linux/clk.h>
> > >  #include <linux/io.h>
> > >  #include <linux/delay.h>
> > > +#include <linux/irq.h>
> > > +#include <linux/slab.h>
> > > =20
> > >  #include <mach/system.h>
> > >  #include <plat/common.h>
> > > @@ -45,6 +47,167 @@ void __iomem *cm2_base;
> > > =20
> > >  #define MAX_MODULE_ENABLE_WAIT		100000
> > > =20
> > > +/* Setup for the interrupt handling based on used platform */
> > > +static struct omap_prcm_irq_setup *irq_setup;
> >=20
> > you can set this is irq_chip data, then you can:
> >=20
> > > +static void prcm_irq_ack(struct irq_data *data)
> > > +{
> > 	struct omap_prcm_irq_setup	*irq_setup =3D irq_data_get_irq_chip_data(d=
ata)
> > 	unsigned int			prcm_irq =3D data->irq - irq_setup->base;
> >=20
> > 	irq_setup->ack_event(prcm_irq);
> > > +}
> >=20
> > ditto to all other operations.
>=20
> This is related to the dynamic allocation of irq numbers you speak of
> later I think... anyway, I'll take a look at this.

not really, you already set something as data to that function. But I
guess it's the generic irq chip ? Even in that case, you should be able
to access struct omap_prcm_irq_set from struct irq_data.

> > > +static struct irq_chip_generic *prcm_irq_chips[OMAP_PRCM_MAX_NR_PEND=
ING_REG];
> >=20
> > can't you allocate this dynamically ???
>=20
> Well yea, but it is only 1 or 2 pointers. The code for dynamic
> allocation will eat more than 4 bytes easily.

fair enough...

> > > +/*
> > > + * PRCM Interrupt Handler
> > > + *
> > > + * The PRM_IRQSTATUS_MPU register indicates if there are any pending
> > > + * interrupts from the PRCM for the MPU. These bits must be cleared =
in
> > > + * order to clear the PRCM interrupt. The PRCM interrupt handler is
> > > + * implemented to simply clear the PRM_IRQSTATUS_MPU in order to cle=
ar
> > > + * the PRCM interrupt. Please note that bit 0 of the PRM_IRQSTATUS_M=
PU
> > > + * register indicates that a wake-up event is pending for the MPU and
> > > + * this bit can only be cleared if the all the wake-up events latched
> > > + * in the various PM_WKST_x registers have been cleared. The interru=
pt
> > > + * handler is implemented using a do-while loop so that if a wake-up
> > > + * event occurred during the processing of the prcm interrupt handler
> > > + * (setting a bit in the corresponding PM_WKST_x register and thus
> > > + * preventing us from clearing bit 0 of the PRM_IRQSTATUS_MPU regist=
er)
> > > + * this would be handled.
> > > + */
> > > +static void prcm_irq_handler(unsigned int irq, struct irq_desc *desc)
> > > +{
> > > +	unsigned long pending[OMAP_PRCM_MAX_NR_PENDING_REG];
> > > +	struct irq_chip *chip =3D irq_desc_get_chip(desc);
> > > +
> > > +	/*
> > > +	 * Loop until all pending irqs are handled, since
> > > +	 * generic_handle_irq(), called by prcm_irq_handle_virtirqs()
> > > +	 * can cause new irqs to come
> > > +	 */
> > > +	while (1) {
> > > +		unsigned int virtirq;
> > > +
> > > +		chip->irq_ack(&desc->irq_data);
> > > +
> > > +		memset(pending, 0, sizeof(pending));
> > > +		irq_setup->pending_events(pending);
> > > +
> > > +		/* No bit set, then all IRQs are handled */
> > > +		if (find_first_bit(pending, OMAP_PRCM_NR_IRQS)
> > > +		    >=3D OMAP_PRCM_NR_IRQS) {
> > > +			chip->irq_unmask(&desc->irq_data);
> > > +			break;
> > > +		}
> > > +
> > > +		/*
> > > +		 * Loop on all currently pending irqs so that new irqs
> > > +		 * cannot starve previously pending irqs
> > > +		 */
> > > +		for_each_set_bit(virtirq, pending, OMAP_PRCM_NR_IRQS)
> > > +			generic_handle_irq(OMAP_PRCM_IRQ_BASE + virtirq);
> >=20
> > if you use nested IRQ threads, you could be using
> > handle_nested_irq(irq);
>=20
> 1st level PRCM interrupt can't be a thread I think. I don't think

technically they can, now if it's fair to do that, I doubt. But I tend
to agree with tglx when he says top half should only check if the IRQ
comes from this device, then we spend very little time on hardirq
context and since IRQ threads are the next big thing after hardirqs,
there shouldn't be too much delay... hopefully

> chained interrupt handlers even support that, and even if they did,

no, chained can't fire another threads, but if they are already a
thread, the chained handler should run on the same thread, at least
that's how I understood the implementation.

> there might be reasons where in some cases we want to execute some of
> the PRCM events as hard irqs.

I don't see the point, after you know which interrupts you must handle,
there shouldn't be many things preventing you from doing the handling
itself in a thread. The IRQ line is even re-enabled so no delays should
be experienced.

--=20
balbi

--PuGuTyElPB9bOcsM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJODD27AAoJEAv8Txj19kN1XpcH/3qe/vUAfspvY0C8XYdTWHAQ
0N/HR6fR9IYAReR7/TX8c6C0oCm+6bMd9XvUglhQbE+PjsaSUUgOjh7SpvN1RPr/
N+Gyy8fM1iOxkEu+1Wgoz/Utc3kI1r9HmfRkSwX5oO5P+AjrGi3DYgu5+DhmPhhs
dhTcMbDADqacDE6u2dOaCkTzco9+J6gqHGSxOirV4ovsX3B4rWjLKMBOvMKBF2Fl
wxqd7bmg8qAeMnNPb2ISH6MlUAVh1b9YcMQOKKwqVot129RTLb2yL5nBDKl4orpi
iuT5MUrlexpFa2q2NemHwGg/POigpiCJx/dKVGRvBe4V3YbPTPwfiRL+f44lgKo=
=Zm8k
-----END PGP SIGNATURE-----

--PuGuTyElPB9bOcsM--
