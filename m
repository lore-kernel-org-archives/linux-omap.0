From: Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv1 5/6] HSI: Introduce OMAP SSI driver
Date: Wed, 26 Feb 2014 23:49:25 +0100
Message-ID: <20140226224924.GA12143@earth.universe>
References: <1393199401-27197-1-git-send-email-sre@debian.org>
 <1393199401-27197-6-git-send-email-sre@debian.org>
 <20140224155132.GK28555@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140224155132.GK28555-NuALmloUBlrZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Carlos Chinea <cch.devel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?utf-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?= <freemangordon-uiMcrn6V0Vs@public.gmane.org>, Joni Lapilainen <joni.lapilainen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mark,

On Mon, Feb 24, 2014 at 03:51:32PM +0000, Mark Rutland wrote:
> > +       irq =3D platform_get_resource_byname(pd, IORESOURCE_IRQ, "gdd_m=
pu");
> > +       if (!irq) {
> > +               dev_err(&pd->dev, "GDD IRQ resource missing\n");
> > +               err =3D -ENXIO;
> > +               goto out_err;
> > +       }
> > +       omap_ssi->gdd_irq =3D irq->start;
>=20
> You can use platform_get_irq_byname here.

Right. Will be changed in PATCHv2.

> > +static inline int ssi_of_get_available_child_count(const struct device=
_node *np)
> > +{
> > +       struct device_node *child;
> > +       int num =3D 0;
> > +
> > +       for_each_child_of_node(np, child)
> > +               if (of_device_is_available(child))
> > +                       num++;
> > +
> > +       return num;
> > +}
>=20
> You can find of_get_available_child_count in <linux/of.h>.

That did not exist when I started with the DT conversion of the
driver.

> That said, this seems to be trying to count the number of ports,
> which should all be compatible with "ti,omap3-ssi-port", no?
>=20
> So maybe you should count all available child nodes compatible with
> that.

I updated the function to check the compatible string
and use for_each_available_child_of_node(), which has
also been added after I wrote this function.

> > +static int __init ssi_probe(struct platform_device *pd)
> > +{
> > +       struct device_node *np =3D pd->dev.of_node;
> > +       struct hsi_controller *ssi;
> > +       int err;
> > +       int num_ports;
> > +
> > +       if (!np) {
> > +               dev_err(&pd->dev, "missing device tree data\n");
> > +               return -EINVAL;
> > +       }
> > +
> > +       num_ports =3D ssi_of_get_available_child_count(np);
> > +
> > +       ssi =3D hsi_alloc_controller(num_ports, GFP_KERNEL);
> > +       if (!ssi) {
> > +               dev_err(&pd->dev, "No memory for controller\n");
> > +               return -ENOMEM;
> > +       }
> > +
> > +       platform_set_drvdata(pd, ssi);
> > +
> > +       err =3D ssi_add_controller(ssi, pd);
> > +       if (err < 0)
> > +               goto out1;
> > +
> > +       pm_runtime_irq_safe(&pd->dev);
> > +       pm_runtime_enable(&pd->dev);
> > +
> > +       err =3D ssi_hw_init(ssi);
> > +       if (err < 0)
> > +               goto out2;
> > +#ifdef CONFIG_DEBUG_FS
> > +       err =3D ssi_debug_add_ctrl(ssi);
> > +       if (err < 0)
> > +               goto out2;
> > +#endif
> > +
> > +       err =3D of_platform_populate(pd->dev.of_node, NULL, NULL, &pd->=
dev);
>=20
> I'm not keen on doing this because it allows arbitrary devices which are
> not ssi ports to be placed in the ssi host controller node that will be
> probed, which is nonsensical and something I'd like to avoid by
> construction.
>=20
> Is there any reason the ports have to be platform devices at all?

not strictly, but I get system resources via platform_get_resource_byname.

> If so, is there no way we can register them directly and skip any other
> devices?

I set the second parameter (matches) of the of_platform_populate()
call to a table containing the ssi-port compatible value.

> > +static int __exit ssi_remove(struct platform_device *pd)
> > +{
> > +       struct hsi_controller *ssi =3D platform_get_drvdata(pd);
> > +
> > +#ifdef CONFIG_DEBUG_FS
> > +       ssi_debug_remove_ctrl(ssi);
> > +#endif
> > +       ssi_remove_controller(ssi);
> > +       platform_set_drvdata(pd, NULL);
> > +
> > +       pm_runtime_disable(&pd->dev);
> > +
> > +       /* cleanup of of_platform_populate() call */
> > +       device_for_each_child(&pd->dev, NULL, ssi_remove_ports);
>=20
> This would certainly be broken for a non ssi port device.

I never intended to support other subdevices, but this only
unregisters each subdevice, so its probably safe...

> > +static int omap_ssi_port_runtime_suspend(struct device *dev)
> > +{
> > +       struct hsi_port *port =3D dev_get_drvdata(dev);
> > +       struct omap_ssi_port *omap_port =3D hsi_port_drvdata(port);
> > +       struct hsi_controller *ssi =3D to_hsi_controller(port->device.p=
arent);
> > +       struct omap_ssi_controller *omap_ssi =3D hsi_controller_drvdata=
(ssi);
> > +
> > +       dev_dbg(dev, "port runtime suspend!\n");
> > +
> > +       ssi_set_port_mode(omap_port, SSI_MODE_SLEEP);
> > +       if (omap_ssi->get_loss)
> > +               omap_port->loss_count =3D
> > +                               (*omap_ssi->get_loss)(ssi->device.paren=
t);
>=20
> You don't need to do (*struct->func)(args) when invoking a function
> pointer. You can jsut have struct->func(args) as we do elsewhere. This
> can be:
>=20
>   omap_ssi->get_loss(ssi->device.parent)
>=20
> This should be fixed up in the other sites too.

Thanks, fixed everywhere.

-- Sebastian

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTDm90AAoJENju1/PIO/qakjEP/0RIP3Q6tS1dkrokytDsBPjf
cJ4VtbxzzhITCfkt34L2fNw3xQthJfzJTRvJcxEjstO/FTLoOp4soBawPD6iMWJr
D7FtDmEX0+uKvFs/XYPZwP5qjBXvKX5aL2wOv2DMXI+oNs3iTGL8jswvT5SK8q66
Ge1jg9HkB/Z6Cnc3xv0Y9CAbjPjXiO0gsDn/dznEgyxPiGB4xNf89kKWAgwjMKSn
BhRVhJnBXSOC10UyfFD+QsmyZ15OFHl8Nx9HbIn/ap5vF6/YZKVi7IeNCaAXcOCd
XIQZbBBMNeVw7RaKnI2AeRTDp7oKUdmXlqjsm6VDVMJIFsG8ucFdhOPvF7YsfJZ3
42YHq8LT5WyFngrqZqQEM5B3DVxIVrVSwq2nMPZnLHNk6zswaGHpDMwmMam6xqfj
5Bn8aqqw0LV4tYsGjTUxkksAYrnaT9L0MDiH9bKpx23krgdhprk24LaEd4z2zhK9
RZNRgv2RdCsnEhfQmU9VKjg71R2lXi1SM2AjwN7ntR3gkcAlhO2gNK0+d2+1ApO8
XqCfzI+oqvjrnagXJs+mUmOftNquNKKgBfruzVde6z+ocdRWAcH86wk4R2RuwAc5
BtqEx08qk7ZplGfGmi3ivtl104g1bB8zeYdALYssmb0Wlmxl17hfMqRHEdvLSJWL
rLIsDdpY5DZWRn9Lia89
=fPlW
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
