From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 03/14] ARM: OMAP2+: gpmc: driver migration helper
Date: Wed, 13 Jun 2012 05:04:58 -0700
Message-ID: <20120613120457.GO12766@atomide.com>
References: <cover.1339419492.git.afzal@ti.com>
 <a121156faf6c758d4e37447ab832f6f825cc5bc8.1339419492.git.afzal@ti.com>
 <4FD6555D.4000508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:34082 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753586Ab2FMMFA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jun 2012 08:05:00 -0400
Content-Disposition: inline
In-Reply-To: <4FD6555D.4000508@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Afzal Mohammed <afzal@ti.com>, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Jon Hunter <jon-hunter@ti.com> [120611 13:34]:
> Hi Afzal,
>=20
> On 06/11/2012 09:26 AM, Afzal Mohammed wrote:
> > A driver is being created out of GPMC code. This is being
> > attempted to acheive by not breaking existing interface,
> > necessitating requirement of GPMC peripherals being able
> > to work with as well as without the help of driver. To not
> > break existing, initcall is required as in old interface
> > GPMC is configured at arch initcall and GPMC should be
> > ready to handle old interface by that time
> >=20
> > Signed-off-by: Afzal Mohammed <afzal@ti.com>
> > ---
> >  arch/arm/mach-omap2/gpmc.c |   19 ++++++++++++++++++-
> >  1 file changed, 18 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.=
c
> > index b471c2f..6dbddb9 100644
> > --- a/arch/arm/mach-omap2/gpmc.c
> > +++ b/arch/arm/mach-omap2/gpmc.c
> > @@ -902,7 +902,7 @@ postcore_initcall(gpmc_init);
> >  __init int omap_gpmc_init(struct gpmc_pdata *pdata)
> >  {
> >  	struct omap_hwmod *oh;
> > -	struct platform_device *pdev;
> > +	static struct platform_device *pdev;
> >  	char *name =3D "omap-gpmc";
> >  	char *oh_name =3D "gpmc";
> > =20
> > @@ -912,6 +912,12 @@ __init int omap_gpmc_init(struct gpmc_pdata *p=
data)
> >  		return -ENODEV;
> >  	}
> > =20
> > +	if (pdev !=3D NULL) {
> > +		clk_put(gpmc_l3_clk);
> > +		omap_device_delete(pdev->archdata.od);
> > +		platform_device_unregister(pdev);
> > +	}
> > +
>=20
> I am not sure if I am missing something, but it appears that pdev wil=
l
> always be NULL here as it is a local uninitialised variable.

This also creates a new warning:

arch/arm/mach-omap2/gpmc.c: In function =E2=80=98gpmc_create_device=E2=80=
=99:
arch/arm/mach-omap2/gpmc.c:1434: warning: =E2=80=98pdev=E2=80=99 may be=
 used uninitialized in this function

> Not sure I see the point in the above function. Why not declare the
> gpmc_device_data struct as static in the file and access it directly
> instead of passing it in omap_gpmc_init(). The postcore_init can then
> call omap_gpmc_init() directly.
>=20
> Shouldn't the post_initcall be added in patch #4, when the driver is
> created?

There should no longer be any need to initialize GPMC early. It should
behave like any other device driver, and also work as a loadable module=
=2E

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
