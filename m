From: "Marathe, Yogesh" <yogesh_marathe@ti.com>
Subject: RE: [PATCH 05/11] omap3: Remove non-existent config option
Date: Mon, 27 Sep 2010 16:32:09 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930233C361B4@dbde02.ent.ti.com>
References: <20100924014938.10325.35279.stgit@baageli.muru.com>
	<20100924015056.10325.95854.stgit@baageli.muru.com>
	<AANLkTik+Qgn5dYd+p_PvEUQFhcwQ2NVxW-fhEdurO6s+@mail.gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB59301F70753CB@dbde02.ent.ti.com>
 <AANLkTinF=iV8p=jmg-YntCpX_BHmavLD3gu2LhhBFRq6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58728 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752712Ab0I0LCg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Sep 2010 07:02:36 -0400
In-Reply-To: <AANLkTinF=iV8p=jmg-YntCpX_BHmavLD3gu2LhhBFRq6@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, "Premi, Sanjeev" <premi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
> Sent: Saturday, September 25, 2010 9:13 PM
> To: Premi, Sanjeev
> Cc: Tony Lindgren; linux-arm-kernel@lists.infradead.org; linux-
> omap@vger.kernel.org; Marathe, Yogesh
> Subject: Re: [PATCH 05/11] omap3: Remove non-existent config option
>=20
> On Fri, Sep 24, 2010 at 6:17 PM, Premi, Sanjeev <premi@ti.com> wrote:
> >> On Fri, Sep 24, 2010 at 4:50 AM, Tony Lindgren
> >> <tony@atomide.com> wrote:
> >> > From: Yogesh Marathe <yogesh_marathe@ti.com>
> >> >
> >> > The definition of "iva2" device in iommu_device
> >> > is wrapped inside CONFIG_MPU_BRIDGE_IOMMU, but
> >> > this option is not defined in KConfig.
> >> >
> >> > This patch removes the wrapper and makes "iva2"
> >> > available as another iommu_device.
> >>
> >> NAK.
> >>
> >> This would break tidspbridge's MMU. This was discussed before:
> >> http://thread.gmane.org/gmane.linux.ports.arm.kernel/58302/focus=3D=
58305
> >>
> >> When tidspbridge has migrated to iommu, then it should define
> >> CONFIG_MPU_BRIDGE_IOMMU.
> >
> > =A0Can you go through earlier discussion on this patch
> > =A0http://marc.info/?l=3Dlinux-omap&m=3D127979007623260&w=3D2
> >
> > =A0I believe these concerns were discussed. I am unable to
> > =A0open the gmane thread (getting 504) - so can't be sure
> > =A0if Hiroshi had referred to same discussion.
>=20
> When you merge iommu support, then either you enable
> CONFIG_MPU_BRIDGE_IOMMU unconditionally, or you apply this patch, but
> this patch alone will only break things.
>=20
> --
> Felipe Contreras

=46elipe,

Any other driver which does not depend on bridge and interested in usin=
g iommu should get the handle when iommu_get("iva2") is called. It is n=
ot happening in original case. I think there should not be restrictions=
 on other drivers to define un-related compile time define if they just=
 want to use iommu driver. I feel the implementation that is breaking d=
ue to removal of this define should be fixed.

Regards,
Yogesh.=20
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
