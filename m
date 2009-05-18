From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [RFC/PATCH 0/3] omap3-iommu: cleanups and remote registration
Date: Mon, 18 May 2009 08:33:41 +0300 (EEST)
Message-ID: <20090518.083341.233686060.Hiroshi.DOYU@nokia.com>
References: <20090516163635.GB25657@n2100.arm.linux.org.uk>
	<94a0d4530905161132j23b109bbj6d62f7ff9fac8c7f@mail.gmail.com>
	<20090518.081627.200381155.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:27846 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706AbZERFdz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 01:33:55 -0400
In-Reply-To: <20090518.081627.200381155.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk, felipe.contreras@gmail.com
Cc: linux-omap@vger.kernel.org, h-kanigeri2@ti.com, linux-arm-kernel@lists.arm.linux.org.uk

=46rom: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [RFC/PATCH 0/3] omap3-iommu: cleanups and remote registrat=
ion
Date: Mon, 18 May 2009 08:16:27 +0300 (EEST)

> From: ext Felipe Contreras <felipe.contreras@gmail.com>
> Subject: Re: [RFC/PATCH 0/3] omap3-iommu: cleanups and remote registr=
ation
> Date: Sat, 16 May 2009 20:32:10 +0200
>=20
> > On Sat, May 16, 2009 at 7:36 PM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> > > On Sat, May 16, 2009 at 01:05:47PM +0300, Felipe Contreras wrote:
> > >> This patch series cleanups up a bit the opap3-iommu device regis=
tration and
> > >> then allows registration from other parts of the code.
> > >>
> > >> Currently the iva2 code (tidspbridge) is not using iommu, theref=
ore it can't be
> > >> used as-is with the current omap iommu. By allowing devies to be=
 registered
> > >> externaly (either isp, or iva2) this problem goes away.
> > >
> > > Hmm, so does this mean that the iommu patchset is going to grow b=
y three
> > > patches? =A0Hope not.
>=20
> This series has been posted for a long time and I want to get this in
> this time with minor fixes.
>=20
> > I hope Hiroshi integrates my patches.
>=20
> I think that the problem of yours is that it's not necesary to allow
> device registration around kernel anywhere by "omap_iommu_add()" at
> all, but enough only in "omap3-iommu.c". Since eventually
> "tidspbridge" will use this iommu framework, no need for this
> flexibility. Keeping same kind of device registration in one place is
> good thing from SoC perspective. So I want to avoid adding unnecessar=
y
> flexibility to the code. I'll follow Russell's call, anyway.

The other thing is about introducing a new structure type, "struct
iommu_device". I don't want to define new structure type just for this
device registration. Since device registration part is kind of
conventional one in kernel, I want to keep things simple/conventional
as much as possible.

>=20
> > > Also, please ensure that you address my other comments, some of w=
hich do
> > > seem applicable to your cleanups as well - eg, the __initdata one=
=2E
> >=20
> > Right, I can improve my cleanup patch with your comments, but my fi=
nal
> > objective was to be able to register iommu devices independently, a=
nd
> > for that __initdata on the 'devices' array didn't work.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
