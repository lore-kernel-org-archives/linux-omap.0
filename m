From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: RE: [PATCH 3/6] omap iommu: omap3 iommu device registration
Date: Fri, 8 May 2009 12:21:07 -0500
Message-ID: <A24693684029E5489D1D202277BE89443DD434A7@dlee02.ent.ti.com>
References: <20090505123905.4583.69865.stgit@oreo.research.nokia.com>
	 <20090505124700.4583.69988.stgit@oreo.research.nokia.com>
	 <94a0d4530905071305i3f604b4am39f4c467e4df65a9@mail.gmail.com>
	 <20090508.071021.123989594.Hiroshi.DOYU@nokia.com>
 <94a0d4530905080032xd0f7bb0ld760a65bf54429f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46310 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751678AbZEHRVh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 May 2009 13:21:37 -0400
In-Reply-To: <94a0d4530905080032xd0f7bb0ld760a65bf54429f2@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "sakari.ailus@maxwell.research.nokia.com" <sakari.ailus@maxwell.research.nokia.com>, "tony@atomide.com" <tony@atomide.com>

Hi,

Just one comment below:

> > Does the following make sense?
> >
> > +#define NR_IOMMU_RES 2
> >
> > ....
> >
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D platform_device_add_resources=
(pdev,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 omap3_iommu_res + =A0i * NR_IOMMU_RES,
> NR_IOMMU_RES);
>=20
> Yeap, also:
>=20
> > +               err =3D platform_device_add_resources(pdev,
> omap3_iommu_res +  i * 2, 2);

IMHO, I don't think it's a good idea to add magical numbers to any code=
 in the kernel. Why is it better to NOT use a define?

Regards,
Sergio
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
