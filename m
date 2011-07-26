From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv6 01/11] omap: prcm: switch to a chained IRQ handler
 mechanism
Date: Tue, 26 Jul 2011 13:40:50 +0300
Message-ID: <20110726104049.GC32582@legolas.emea.dhcp.ti.com>
References: <1311611771-15093-1-git-send-email-t-kristo@ti.com>
 <1311611771-15093-2-git-send-email-t-kristo@ti.com>
 <20110725170300.GG18062@legolas.emea.dhcp.ti.com>
 <1311676415.5826.30.camel@sokoban>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KN5l+BnMqAQyZLvT"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:34149 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752129Ab1GZKkx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jul 2011 06:40:53 -0400
Received: by mail-ew0-f53.google.com with SMTP id 8so321529ewy.12
        for <linux-omap@vger.kernel.org>; Tue, 26 Jul 2011 03:40:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1311676415.5826.30.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, linux-omap@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "Mahadeva, Avinash" <avinashhm@ti.com>, "Hilman, Kevin" <khilman@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, "R, Govindraj" <govindraj.raja@ti.com>, Paul Walmsley <paul@pwsan.com>, Thomas Gleixner <tglx@linutronix.de>


--KN5l+BnMqAQyZLvT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 26, 2011 at 01:33:35PM +0300, Tero Kristo wrote:
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
> > > +			generic_handle_irq(irq_setup->base_irq + virtirq);
> > > +
> > > +		chip->irq_unmask(&desc->irq_data);
> >=20
> > can't the IRQ subsystem handle this for you ? I was expecting it would
> > call irq_ack() and irq_unmask() automatically and you wouldn't have to
> > do it yourself. Maybe Thomas can clear this out ? Thomas, should we call
> > ->irq_ack() ->irq_mask ourselves here ?
>=20
> These are needed, as we are using a handle and a level interrupt. If you
> leave out the ack, we will return to the handler immediately as nobody
> else acks it. If you leave out the unmask, we will only ever get 1
> interrupt and no more.

but that's the thing, I guess IRQ subsystem can handle this
automatically. At least from what I remember. That's how I converted the
retu driver, for instance, and I checked that IRQ subsystem calls
->irq_ack() and ->irq_mask/unmask() for me...

Maybe the irq_gc stuff is different, dunno.

> > if you make this a platform_driver, there would be no need for this
> > trickery. You could pass this as driver data. Something like:
> >=20
> >=20
> > struct omap_prcm_irq_setup omap3_prcm_irq_setup =3D {
> > 	.ack		=3D (u32)OMAP3430_PRM_IRQSTATUS_MPU,
> > 	.mask		=3D (u32)OMAP3430_PRM_IRQENABLE_MPU,
> > 	.pending_events	=3D omap3_prm_pending_events,
> > 	.irq		=3D INT_34XX_PRCM_MPU_IRQ,
> > };
> >=20
> > struct const struct platform_device_id prcm_id_table[] __devinitconst =
=3D
> > {
> > 	{
> > 		.name		=3D "omap3-prcm",
> > 		.driver_data	=3D &omap3_prcm_irq_setup,
> > 	},
> > 	{
> > 		.name		=3D "omap4-prcm",
> > 		.driver_data	=3D &omap4_prcm_irq_setup,
> > 	},
> > };
> > MODULE_DEVICE_TABLE(platform, prcm_id_table);
> >=20
> > static struct platform_driver prcm_driver =3D {
> > 	.probe		=3D prcm_probe,
> > 	.remove		=3D __devexit_p(prcm_remove),
> > 	.driver		=3D {
> > 		.name	=3D "prcm",
> > 		.pm	=3D DEV_PM_OPS,
> > 	},
> > 	.id_table	=3D &prcm_id_table,
> > };
> >=20
> > or something similar. Then on probe you can make a copy of irq_setup to
> > your driver's context structure, or only use temporarily to initialize
> > some fields and so on...
> >=20
>=20
> Hmm, this might be useful, however you would still need a way to
> register the driver from somewhere, and you would essentially end up
> with omap_chip version check somewhere. The reason for all this trickery
> is that the omap chip version detection is heavily frowned upon right
> now... it would be much cleaner if there was an accepted way of doing
> this already in place.

wouldn't hwmod be able to handle this for you ? I mean, it's just the
driver name that has to change, rather than exporting a few functions.

--=20
balbi

--KN5l+BnMqAQyZLvT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOLpmxAAoJEAv8Txj19kN1QY4H/0Y9LYaTQp0ZmqXDfIBwL4u/
uZn/4WN5EzsVjkjGzz9Yq6u/MkyA5BvluSCJvCbYNdoZAS4VGXSXWhAw5zDqTXSI
66OcfgK2w1xy5A9ffcUTzoGkupnqbwJljZtl+ml3+eBBrVF669wjmHbprewgLGsw
yWlY2QoXYXyFp8JEDTlKJXPW9tQXSCkh5fRlcp9Fo+HqqXTXKeHn+KfI9Mkicxdx
y21qFr+IZHo0w4Z3K8auBN8/ED8j6qtzZlhnEhlL3E5bacxURxuTxg6pGg2RkMr0
ln9l+wjopIBDVBXQpY19i9rFOrcDueVspAPZkRRakJW60xYQSHEpYjpkLdCpklM=
=qiWQ
-----END PGP SIGNATURE-----

--KN5l+BnMqAQyZLvT--
