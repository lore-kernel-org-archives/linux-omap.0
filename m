From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [RFC/PATCH 0/3] omap3-iommu: cleanups and remote registration
Date: Mon, 18 May 2009 16:48:49 +0300 (EEST)
Message-ID: <20090518.164849.70215248.Hiroshi.DOYU@nokia.com>
References: <94a0d4530905161132j23b109bbj6d62f7ff9fac8c7f@mail.gmail.com>
	<20090518.081627.200381155.Hiroshi.DOYU@nokia.com>
	<94a0d4530905180448i344328e6hf3a1719b73721d75@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:17611 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbZERNtJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 09:49:09 -0400
In-Reply-To: <94a0d4530905180448i344328e6hf3a1719b73721d75@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.contreras@gmail.com
Cc: linux@arm.linux.org.uk, linux-omap@vger.kernel.org, h-kanigeri2@ti.com, linux-arm-kernel@lists.arm.linux.org.uk

=46rom: ext Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 0/3] omap3-iommu: cleanups and remote registrat=
ion
Date: Mon, 18 May 2009 13:48:09 +0200

> On Mon, May 18, 2009 at 8:16 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com=
> wrote:
> > From: ext Felipe Contreras <felipe.contreras@gmail.com>
> > Subject: Re: [RFC/PATCH 0/3] omap3-iommu: cleanups and remote regis=
tration
> > Date: Sat, 16 May 2009 20:32:10 +0200
> >
> >> On Sat, May 16, 2009 at 7:36 PM, Russell King - ARM Linux
> >> <linux@arm.linux.org.uk> wrote:
> >> > On Sat, May 16, 2009 at 01:05:47PM +0300, Felipe Contreras wrote=
:
> >> >> This patch series cleanups up a bit the opap3-iommu device regi=
stration and
> >> >> then allows registration from other parts of the code.
> >> >>
> >> >> Currently the iva2 code (tidspbridge) is not using iommu, there=
fore it can't be
> >> >> used as-is with the current omap iommu. By allowing devies to b=
e registered
> >> >> externaly (either isp, or iva2) this problem goes away.
> >> >
> >> > Hmm, so does this mean that the iommu patchset is going to grow =
by three
> >> > patches? =A0Hope not.
> >
> > This series has been posted for a long time and I want to get this =
in
> > this time with minor fixes.
> >
> >> I hope Hiroshi integrates my patches.
> >
> > I think that the problem of yours is that it's not necesary to allo=
w
> > device registration around kernel anywhere by "omap_iommu_add()" at
> > all, but enough only in "omap3-iommu.c". Since eventually
> > "tidspbridge" will use this iommu framework, no need for this
> > flexibility. Keeping same kind of device registration in one place =
is
> > good thing from SoC perspective. So I want to avoid adding unnecess=
ary
> > flexibility to the code. I'll follow Russell's call, anyway.
>=20
> The first patch has nothing to do with omap_iommu_add, it's just
> cleanups, and you haven't provided any valid reason to reject them.

Your code doesn't work since the other members of "struct resource"
haven't been initilialized like:

+		memset(res, 0,  sizeof(res));

Please refer to:

http://marc.info/?l=3Dlinux-omap&m=3D124263966231599&w=3D2


> The rest of the patches are *necessary* as of right now. IMHO iommu
> should not be merged in it's current state because it will break
> tidspbridge. Maybe after tidspbridge has been fully converted to use
> iommu.
>=20
> I think there will probably be a conversion period where the
> tidspbridge will use iommu optionally, in that period iommu would nee=
d
> to be patched and add a #ifdef MPU_BRIDGE_IOMMU, that would be ugly.

How about:

http://lists.arm.linux.org.uk/lurker/attach/3@20090518.133533.487a3dd4.=
attach

>=20
> Also you haven't answered my questions: what happens if you disable
> MPU_BRIDGE? What's the point of iommu to register the iva2 iommu
> device?

enough small to ignore.

>=20
> My patches solves all of those issues.
>=20
> --=20
> Felipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
