From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [RFC/PATCH 0/3] omap3-iommu: cleanups and remote registration
Date: Mon, 18 May 2009 08:16:27 +0300 (EEST)
Message-ID: <20090518.081627.200381155.Hiroshi.DOYU@nokia.com>
References: <1242468350-23190-1-git-send-email-felipe.contreras@gmail.com>
	<20090516163635.GB25657@n2100.arm.linux.org.uk>
	<94a0d4530905161132j23b109bbj6d62f7ff9fac8c7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:36718 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbZERFRL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 May 2009 01:17:11 -0400
In-Reply-To: <94a0d4530905161132j23b109bbj6d62f7ff9fac8c7f@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux@arm.linux.org.uk, felipe.contreras@gmail.com
Cc: linux-omap@vger.kernel.org, h-kanigeri2@ti.com, linux-arm-kernel@lists.arm.linux.org.uk

=46rom: ext Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 0/3] omap3-iommu: cleanups and remote registrat=
ion
Date: Sat, 16 May 2009 20:32:10 +0200

> On Sat, May 16, 2009 at 7:36 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Sat, May 16, 2009 at 01:05:47PM +0300, Felipe Contreras wrote:
> >> This patch series cleanups up a bit the opap3-iommu device registr=
ation and
> >> then allows registration from other parts of the code.
> >>
> >> Currently the iva2 code (tidspbridge) is not using iommu, therefor=
e it can't be
> >> used as-is with the current omap iommu. By allowing devies to be r=
egistered
> >> externaly (either isp, or iva2) this problem goes away.
> >
> > Hmm, so does this mean that the iommu patchset is going to grow by =
three
> > patches? =A0Hope not.

This series has been posted for a long time and I want to get this in
this time with minor fixes.

> I hope Hiroshi integrates my patches.

I think that the problem of yours is that it's not necesary to allow
device registration around kernel anywhere by "omap_iommu_add()" at
all, but enough only in "omap3-iommu.c". Since eventually
"tidspbridge" will use this iommu framework, no need for this
flexibility. Keeping same kind of device registration in one place is
good thing from SoC perspective. So I want to avoid adding unnecessary
flexibility to the code. I'll follow Russell's call, anyway.

> > Also, please ensure that you address my other comments, some of whi=
ch do
> > seem applicable to your cleanups as well - eg, the __initdata one.
>=20
> Right, I can improve my cleanup patch with your comments, but my fina=
l
> objective was to be able to register iommu devices independently, and
> for that __initdata on the 'devices' array didn't work.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
