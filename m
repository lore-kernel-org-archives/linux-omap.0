From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v5 8/12] OMAP2+: dmtimer: convert to platform devices
Date: Tue, 7 Dec 2010 11:20:47 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03736F5098@dbde02.ent.ti.com>
References: <1291679059-13419-1-git-send-email-tarun.kanti@ti.com>
 <1291679059-13419-9-git-send-email-tarun.kanti@ti.com>
 <AANLkTim4Kq2xA-RZ21HuX0Du2umzyJuGs4=mCufEuNc6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44006 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753963Ab0LGFuz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 00:50:55 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id oB75oq4R023202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 6 Dec 2010 23:50:54 -0600
In-Reply-To: <AANLkTim4Kq2xA-RZ21HuX0Du2umzyJuGs4=mCufEuNc6@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>

> -----Original Message-----
> From: Varadarajan, Charulatha
> Sent: Tuesday, December 07, 2010 11:16 AM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Gopinath, Thara
> Subject: Re: [PATCH v5 8/12] OMAP2+: dmtimer: convert to platform dev=
ices
>=20
> Tarun,
>=20
> On Tue, Dec 7, 2010 at 05:14, Tarun Kanti DebBarma <tarun.kanti@ti.co=
m>
> wrote:
> > Add routines to converts dmtimers to platform devices. The device d=
ata
> > is obtained from hwmod database of respective platform and is regis=
tered
> > to device model after successful binding to driver. It also provide=
s
> > provision to access timers during early boot when pm_runtime framew=
ork
> > is not completely up and running.
> >
> > Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > Signed-off-by: Thara Gopinath <thara@ti.com>
> > Reviewed-by: Cousson, Benoit <b-cousson@ti.com>
> > Reviewed-by: Varadarajan, Charulatha <charu@ti.com>
> > ---
> > =A0arch/arm/mach-omap2/Makefile =A0| =A0 =A02 +-
> > =A0arch/arm/mach-omap2/dmtimer.c | =A0174
> +++++++++++++++++++++++++++++++++++++++++
> > =A02 files changed, 175 insertions(+), 1 deletions(-)
> > =A0create mode 100644 arch/arm/mach-omap2/dmtimer.c
> >
>=20
> <<snip>>
>=20
> > +/**
> > + * omap_timer_init - build and register timer device with an
> > + * associated timer hwmod
> > + * @oh: =A0 =A0 =A0 =A0timer hwmod pointer to be used to build tim=
er device
> > + * @user: =A0 =A0 =A0parameter that can be passed from calling hwm=
od API
> > + *
> > + * Called by omap_hwmod_for_each_by_class to register each of the =
timer
> > + * devices present in the system. The number of timer devices is k=
nown
> > + * by parsing through the hwmod database for a given class name. A=
t the
> > + * end of function call memory is allocated for timer device and i=
t is
> > + * registered to the framework ready to be proved by the driver.
> > + */
> > +static int __init omap_timer_init(struct omap_hwmod *oh, void *use=
r)
> > +{
> > + =A0 =A0 =A0 int id;
> > + =A0 =A0 =A0 int ret =3D 0;
> > + =A0 =A0 =A0 char *name =3D "omap_timer";
> > + =A0 =A0 =A0 struct dmtimer_platform_data *pdata;
> > + =A0 =A0 =A0 struct omap_device *od;
> > +
> > + =A0 =A0 =A0 pr_debug("%s: %s\n", __func__, oh->name);
> > +
> > + =A0 =A0 =A0 pdata =3D kzalloc(sizeof(*pdata), GFP_KERNEL);
> > + =A0 =A0 =A0 if (!pdata) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: No memory for [%s]\n", __=
func__, oh->name);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 if (user)
>=20
> Check for the value of "user".
Ok.

>=20
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->is_early_init =3D 1;
> > + =A0 =A0 =A0 else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->is_early_init =3D 0;
> > +
> > + =A0 =A0 =A0 /* hook clock set/get functions */
> > + =A0 =A0 =A0 pdata->set_timer_src =3D omap2_dm_timer_set_src;
> > +
>=20
> <<snip>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
