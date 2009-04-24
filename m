From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: RE: Problems while designing TPS65023 regulator driver
Date: Fri, 24 Apr 2009 11:35:19 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03051F84D1@dbde02.ent.ti.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02FAA91D06@dbde02.ent.ti.com>
	 <20090404000531.GE8840@atomide.com>
	 <5d5443650904230630v454c2c7ft526b020731278010@mail.gmail.com>
	 <200904231517.11338.david-b@pacbell.net>
 <5d5443650904232301wb01150eu33e65074cf6223e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50025 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754473AbZDXGFi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Apr 2009 02:05:38 -0400
In-Reply-To: <5d5443650904232301wb01150eu33e65074cf6223e8@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: Mark Brown <broonie@sirena.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>

Trilok,

Since the new regulator_register API was not there in l-o, I have not=20
submitted my patch for TPS65023. But since now it is available, I will=20
submit my patch soon.

Thanks and Regards,
Anuj Aggarwal
=20
Platform Support Products
Texas Instruments Incorporated
PSP Products RSS Feed
> -----Original Message-----
> From: Trilok Soni [mailto:soni.trilok@gmail.com]
> Sent: Friday, April 24, 2009 11:32 AM
> To: David Brownell
> Cc: Aggarwal, Anuj; Mark Brown; linux-omap@vger.kernel.org; Tony Lind=
gren
> Subject: Re: Problems while designing TPS65023 regulator driver
>=20
> Hi David,
>=20
> On Fri, Apr 24, 2009 at 3:47 AM, David Brownell <david-b@pacbell.net>
> wrote:
> > On Thursday 23 April 2009, Trilok Soni wrote:
> >> Any updates on tps65023 regulator driver? Could you please submit =
the
> >> WIP patches to the list?
> >
> > FWIW, here's the last version I saw ... it includes a
> > build hack for the regulator_register() call. =A0I haven't
> > build-tested it since that API change went to mainline.
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > From: Manikandan Pillai <mani.pillai@ti.com>
> > Subject: regulator: add support for TPS6235x
> >
> > The patch has been fixed for comments given by David Brownell
> > and Mark Brown for adding TPS6235x support on OMAP3 EVM.
> > Comments fixed include
> > moving Makefile changes to this patch
> > dev_err used
> > removed the extra configuration option from Kconfig
>=20
> Thanks but I was requesting tps 6 5 0 2 3 not tps 6 2 3 5 x  :).
>=20
> --
> ---Trilok Soni
> http://triloksoni.wordpress.com
> http://www.linkedin.com/in/triloksoni

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
