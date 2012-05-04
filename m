From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 24/25] OMAPDSS: DSI: improve DSI module id handling
Date: Fri, 04 May 2012 12:53:49 +0300
Message-ID: <1336125229.2701.30.camel@deskari>
References: <1336053481-25433-1-git-send-email-tomi.valkeinen@ti.com>
	 <1336053481-25433-25-git-send-email-tomi.valkeinen@ti.com>
	 <4FA39CBB.6010500@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-CYVzmT3yzikhEa5DIU+C"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:38553 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753917Ab2EDJxy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 May 2012 05:53:54 -0400
Received: by lbol5 with SMTP id l5so2410235lbo.34
        for <linux-omap@vger.kernel.org>; Fri, 04 May 2012 02:53:51 -0700 (PDT)
In-Reply-To: <4FA39CBB.6010500@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-CYVzmT3yzikhEa5DIU+C
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2012-05-04 at 14:39 +0530, Archit Taneja wrote:
> On Thursday 03 May 2012 07:28 PM, Tomi Valkeinen wrote:
> > We currently use the id of the dsi platform device (dsidev->id) as the
> > DSI hardware module ID. This works because we assign the ID manually in
> > arch/arm/mach-omap2/display.c at boot time.
> >
> > However, with device tree the platform device IDs are automatically
> > assigned to an arbitrary number, and we can't use it.
>=20
> If this number is arbitrary we would need to change the "dsi_pdev_map"=
=20
> approach of mapping a dsi module and it's corresponding platform device.
> Currently dsi_pdev_map is:
>=20
> static struct platform_device *dsi_pdev_map[MAX_NUM_DSI];
>=20
> So we either need to increase the array size to take larger arbitrary=20
> numbers, or do something else.
>=20
> We would also need to fix the usage of dsi_get_dsidev_from_id(), as=20
> right now we manually pass 0 and 1 to it only, for example:
>=20
> static void dsi1_dump_irqs(struct seq_file *s)
> {
>          struct platform_device *dsidev =3D dsi_get_dsidev_from_id(0);
>=20
>          dsi_dump_dsidev_irqs(dsidev, s);
> }
>=20
> The immediate solution that comes to mind is to maintain 2 id's, one=20
> which is sequential, and the other which the DT has created, and keep an=
=20
> array to map these. But this seems messy!

This is only a problem with device tree, and I solved it so that I pass
a DSI module ID in the device tree data. So, with old pdata way I
initialize dsi->module_id from the pdev->id, but with DT I initialize
dsi->module_id from the DT data.

So basically we remove the use of pdev->id in this patch, and add
dsi->module_id field, which needs to be initialized to 0 or 1, depending
on the corresponding HW module. We just happen to use the pdev->id to
initialize it when using the old pdata method, as we know it tells the
right id. But we could initialize it from any other source.

This allows us to keep the 0 and 1 DSI IDs, and I think we need those
anyway. Some parts of the code could work fine with arbitrary ID, as
long as a pdev can be linked to/from this ID. However, there are things
where we must have the ID, like configuring the clock source settings in
dss_core, where we set a certain bit for DSI module 0, and certain bit
for module 1.

Perhaps even those could be handled without explicit ID of 0 or 1, but
that doesn't sound trivial and I didn't want to start tackling that in
this series.

I wish there was a way to get the module ID from the HW registers
somehow. Then we wouldn't need to pass the ID via SW, which doesn't feel
very correct. At least with DT it's a bit wrong, in my opinion, but best
I could come up with.

 Tomi


--=-CYVzmT3yzikhEa5DIU+C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPo6ctAAoJEPo9qoy8lh71kHMP/16TONDwpF5+YQUKHuVb9CM2
BUSMzB9BMRRZMsP0S43XAffV+IY6vTB83qgNjemwM/8TkMfdm02bXLRjFOarKHvW
xMjSwC/VL7cm73K6Lm5A9T3MZCUKHRitGUnbQurjyTExgg6pjpaAvhcVKW8T9UKh
DWQHxok4IWsP+tSMZf1XunWjt6DdyaYyZD8clnRUcd9fdtHh2Z+z9HXmAEZZGr+9
y4gJtxEQWT9Hu7R4LWh7rgQ+JuA9ORS+rdlq/IW6feMKnpTY7qagh96OTKSg9OcB
oJpmQiemCiuzskoJUJuhkiiaOrmTJayAcjvYqfg4hzOIocSD4QyHQvvp2yOLUozS
J4vP/MikNi9uuWSLdfANjgwuwCX15BIbpielMWev441JTp245z1QEh3qJGaNhPFh
tinX3E1PP05aNhh4ENoK2+pRQW61qO8rBTAzjRVQEFgAL/tb6z9P3vSVv+1Nz3qL
CUkZ+4j0lvhFGQ9jpYzp5fj5FH848IMsiSGtBDETGGD5garWAW0CXiYl7gkTZyzP
kt0k0l3Cu7e5OYvgiT0CUCu3SzNczU7VdNNjhZxWfxkrOgPbCBd/nkDXd8wINqxk
AkJKG8jMW1YQYG1rMqUwKTiOcr05fpC39yN3TfK+OiLZKDr/e5uKZ7Bio10juTBh
RXxmTVJLaqEFHwFmWcPi
=zD/f
-----END PGP SIGNATURE-----

--=-CYVzmT3yzikhEa5DIU+C--

