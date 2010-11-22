From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCHv4 8/14] OMAP: dmtimer: platform driver
Date: Mon, 22 Nov 2010 12:56:27 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0372E3FFB2@dbde02.ent.ti.com>
References: <1290220778-22244-1-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-2-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-3-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-4-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-5-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-6-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-7-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-8-git-send-email-tarun.kanti@ti.com>
 <1290220778-22244-9-git-send-email-tarun.kanti@ti.com>
 <AANLkTinEafdEmcsc9adZWU=rJ79obz2vDybBZ38SS3bC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39545 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751714Ab0KVH0c convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Nov 2010 02:26:32 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id oAM7QTaU023413
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 01:26:31 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id oAM7QSFQ028563
	for <linux-omap@vger.kernel.org>; Mon, 22 Nov 2010 12:56:28 +0530 (IST)
In-Reply-To: <AANLkTinEafdEmcsc9adZWU=rJ79obz2vDybBZ38SS3bC@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Gopinath, Thara" <thara@ti.com>

> -----Original Message-----
> From: Varadarajan, Charulatha [mailto:charu@ti.com]
> Sent: Monday, November 22, 2010 12:43 PM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap@vger.kernel.org; Gopinath, Thara
> Subject: Re: [PATCHv4 8/14] OMAP: dmtimer: platform driver
>=20
> <<snip>>
>=20
> > +static struct platform_driver omap_dmtimer_driver =3D {
> > + =A0 =A0 =A0 .probe =A0=3D omap_dm_timer_probe,
> > + =A0 =A0 =A0 .remove =3D omap_dm_timer_remove,
> > + =A0 =A0 =A0 .driver =3D {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "omap-timer",
>=20
> Comment from Benoit on omap devices name ( see [1] ):
>=20
> "If possible, it will be better to use the "omap_" prefix in order to
> start having some consitency in the omap devices name. "
I can change.
--
Tarun

>=20
> [1] https://patchwork.kernel.org/patch/305082/
>=20
> > + =A0 =A0 =A0 },
> > +};
> > +
>=20
> <<snip>>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
