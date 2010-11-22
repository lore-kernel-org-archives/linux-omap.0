From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCHv4 11/14] OMAP2+: dmtimer: convert to platform devices
Date: Mon, 22 Nov 2010 14:30:15 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0372E40028@dbde02.ent.ti.com>
References: <1290220778-22244-1-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-2-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-3-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-4-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-5-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-6-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-7-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-8-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-9-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-10-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-11-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-12-git-send-email-tarun.kanti@ti.com>
 <AANLkTi=R6wZ486qMm+9Ktbhb_w0aysq80JfpE8+ujRL0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35347 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751776Ab0KVJAV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 04:00:21 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id oAM90HFw004219
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 03:00:20 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id oAM90HFr019802
	for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 14:30:17 +0530 (IST)
In-Reply-To: <AANLkTi=R6wZ486qMm+9Ktbhb_w0aysq80JfpE8+ujRL0@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>, "Basak, Partha" <p-basak2@ti.com>

> -----Original Message-----
> From: Varadarajan, Charulatha
> Sent: Monday, November 22, 2010 1:55 PM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Gopinath, Thara; Basak, Partha
> Subject: Re: [PATCHv4 11/14] OMAP2+: dmtimer: convert to platform dev=
ices
>=20
> <<snip>>
>=20
> > +/**
> > + * omap_timer_init - top level timer device initialization
> > + *
> > + * uses dedicated hwmod api to parse through hwmod database for
> > + * given class names and then build and register the timer device.
> > + */
> > +static int __init omap2_dmtimer_device_init(void)
> > +{
> > + =A0 =A0 =A0 int ret =3D omap_hwmod_for_each_by_class("timer",
> omap2_timer_init, NULL);
> > +
> > + =A0 =A0 =A0 if (unlikely(ret))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_debug("%s: device registration FAI=
LED\n", __func__);
> > +
> > + =A0 =A0 =A0 return ret;
> > +}
> > +arch_initcall(omap2_dmtimer_device_init);
>=20
> While introducing this, calls to omap_dm_timer_init() should be
> removed. Else, the init
> will happen twice for dmtimer devices
This function is called only when the switch-over takes place.
That is why you still see the omap_dm_timer_init().
So this is more to do with organizing the patch.
I could have introduced this init code as part of platform driver
Swith-over.

--
Tarun

>=20
> > --
> > 1.6.0.4
> >
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
