From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/6] mmc: host: omap_hsmmc: trivial cleanups
Date: Thu, 15 Mar 2012 16:00:49 +0200
Message-ID: <20120315140048.GO28447@arwen.pp.htv.fi>
References: <1331716714-31912-1-git-send-email-balbi@ti.com>
 <CANrkHUYGDYiCrXp56fwgoXvOin_YPAnyQPhDiFWizZ2X0WM-Sw@mail.gmail.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="keoAwTxaagou87Dg"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:40086 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761918Ab2COOBB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Mar 2012 10:01:01 -0400
Received: by lahc1 with SMTP id c1so2606714lah.12
        for <linux-omap@vger.kernel.org>; Thu, 15 Mar 2012 07:00:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CANrkHUYGDYiCrXp56fwgoXvOin_YPAnyQPhDiFWizZ2X0WM-Sw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Jean Delvare (PC drivers, core)" <khali@linux-fr.org>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, "Wolfram Sang (embedded platforms)" <w.sang@pengutronix.de>, cjb@laptop.org


--keoAwTxaagou87Dg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 15, 2012 at 07:20:22PM +0530, T Krishnamoorthy, Balaji wrote:
> On Wed, Mar 14, 2012 at 2:48 PM, Felipe Balbi <balbi@ti.com> wrote:
> > a bunch of non-functional cleanups to the omap_hsmmc
> > driver.
> >
> > It basically decreases indentation level, drop unneded
> > dereferences and drop unneded accesses to the platform_device
> > structure.
> >
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> > =A0drivers/mmc/host/omap_hsmmc.c | =A0147 ++++++++++++++++++++---------=
------------
> > =A01 file changed, 70 insertions(+), 77 deletions(-)
> >
> > diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmm=
c.c
> > index fd0c661..11fef49 100644
> > --- a/drivers/mmc/host/omap_hsmmc.c
> > +++ b/drivers/mmc/host/omap_hsmmc.c
> > @@ -2104,30 +2104,28 @@ static int omap_hsmmc_remove(struct platform_de=
vice *pdev)
> > =A0 =A0 =A0 =A0struct omap_hsmmc_host *host =3D platform_get_drvdata(pd=
ev);
> > =A0 =A0 =A0 =A0struct resource *res;
> >
> > - =A0 =A0 =A0 if (host) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_get_sync(host->dev);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_remove_host(host->mmc);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->use_reg)
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_hsmmc_reg_put(host);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->pdata->cleanup)
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->pdata->cleanup(&pde=
v->dev);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(host->irq, host);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc_slot(host).card_detect_irq)
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(mmc_slot(host).c=
ard_detect_irq, host);
> > -
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_put_sync(host->dev);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_disable(host->dev);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_put(host->fclk);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->got_dbclk) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(host->dbclk);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_put(host->dbclk);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> Hi,
>=20
> Checking for host NULL is added in suspend/resume, however it is missing =
in
> .remove, is it intentional ?

you mean:

if (!host)
	return 0;

???

That's intentional. We know platform_set_drvdata() is called on probe,
and we can only reach .remove if .probe was called first. So we can make
the assumption that dev->p->driver_data will always be valid on .remove.
If it isn't, it's a bug on driver core which we want to catch ASAP, so
it deserves to oops.

--=20
balbi

--keoAwTxaagou87Dg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPYfYQAAoJEIaOsuA1yqREirQP/RaMzA0/fGK8nd05G26/XX5H
wLR6i3LRteHrTidleD7SevadQThHT2tkUo3hBZOG9a+opV9+ktQZWBWEABTuH6k5
TNy1QXgo5Ek1tH0vEh1yuH+ho+187r/LAgNY65MBPWhpdukFpZs6+X5THlN+csZ7
Ha1t7LjZIr2clAHEJoiItXNTkttgKj+TTnx97cgbHe2hxlWx2/N2wv+ZFHQsiLJZ
sEXrQ3GVW7emwVo/ZDnyS+zyJ79jm635nY+Jum3+VN7Wiw/E2i86TGv9I8L4+Hzg
1sJkHlQIq/nVNRLjXHwQw2sxf307zy6iho6COcwM0bnAfGz7k+CwufkhMDGkq5zu
77w6latOCiHzJ8etHpzOkBYqmSFZp9IGfNMlevr8Qj1CnKdKYLFG6Zv9liLMs8If
DIVKDEtjDweX5bIrsz4srt00ifowUVh+d/sn/RkjHqy8zi46E3VUZ3tVuwJ7jNmQ
OJDyDFo+7lX2o/1VjbhUABrSHVZi6TRBNKmq5pkuM8BtEDiUrbkYYOvBYrrYkpTd
UIGugq+l4O+LDvz1gQ/BVEfooukzcv5aN2oAyaodaKz46qRqhM5nlbrJtoxovTQ6
x00c3uHCBR3U3FX2j/hnGfCNLLc8KdoDGJ9YVD7Mh1xh/PGRMWQmO6ZaI7hnDwiv
aLLcZ0aakAiXo8DzvnfG
=qYOc
-----END PGP SIGNATURE-----

--keoAwTxaagou87Dg--
