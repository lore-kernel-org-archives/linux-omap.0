From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [RFC/PATCH 3/3] omap3-iommu: remote registration
Date: Mon, 18 May 2009 16:59:15 +0300 (EEST)
Message-ID: <20090518.165915.242148841.Hiroshi.DOYU@nokia.com>
References: <20090518121113.GB3067@n2100.arm.linux.org.uk>
	<20090518.163533.28796680.Hiroshi.DOYU@nokia.com>
	<94a0d4530905180652y5c3d045fs99bb2b5bdb52948e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:46459 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752400AbZERN7h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 09:59:37 -0400
In-Reply-To: <94a0d4530905180652y5c3d045fs99bb2b5bdb52948e@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.contreras@gmail.com
Cc: linux@arm.linux.org.uk, linux-omap@vger.kernel.org, h-kanigeri2@ti.com, linux-arm-kernel@lists.arm.linux.org.uk

=46rom: ext Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 3/3] omap3-iommu: remote registration
Date: Mon, 18 May 2009 15:52:59 +0200

> On Mon, May 18, 2009 at 4:35 PM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com=
> wrote:
> > From: ext Russell King - ARM Linux <linux@arm.linux.org.uk>
> > Subject: Re: [RFC/PATCH 3/3] omap3-iommu: remote registration
> > Date: Mon, 18 May 2009 14:11:13 +0200
> >
> >> On Sat, May 16, 2009 at 01:05:50PM +0300, Felipe Contreras wrote:
> >> > This allows devices to be registered only when they are used. Th=
e
> >> > current dsp-bridge driver for example is not using iommu so regi=
stering
> >> > the iommu iva2 device would conflict. By allowing remote registr=
ation
> >> > the dsp-bridge can decide when the iommu iva2 device is register=
ed.
> >>
> >> I don't think that this is a good idea - what happens if two peopl=
e
> >> call omap_iommu_add() for the same IOMMU device independently?
> >>
> >> The real problem here seems to be the TI DSP bridge code, and if t=
hat's
> >> the case why can't we just avoid registering IVA2 if the TI DSP br=
idge
> >> code is enabled. =A0That solves your stated problem without creati=
ng
> >> additional management issues.
> >
> > How about the attached patch? I think this is enough.
>=20
> That wouldn't work when bridgedriver moves to iommu, how about:
>=20
> +#if !defined(CONFIG_MPU_BRIDGE) && !defined(CONFIG_OMAP_DSP_MODULE)
> +#if defined(CONFIG_MPU_BRIDGE_IOMMU)

Just now I read Russell's proposal. This would be better. Agreed.

How about Hari? I think that he's been working on this for a while....
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
