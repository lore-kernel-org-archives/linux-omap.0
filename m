From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 2/7] omap: iommu/iovmm: move to dedicated iommu folder
Date: Thu, 18 Aug 2011 16:53:13 +0300
Message-ID: <CAK=WgbY1qVSZVjk6y=xb152cV0QjeGaQbKc+zMTat8RW5vF5zw@mail.gmail.com>
References: <1313622608-30397-1-git-send-email-ohad@wizery.com>
 <1313622608-30397-3-git-send-email-ohad@wizery.com> <201108181538.18480.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37496 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755057Ab1HRN5C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Aug 2011 09:57:02 -0400
Received: by wwf5 with SMTP id 5so2111840wwf.1
        for <linux-omap@vger.kernel.org>; Thu, 18 Aug 2011 06:57:01 -0700 (PDT)
In-Reply-To: <201108181538.18480.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Joerg Roedel <Joerg.Roedel@amd.com>, iommu@lists.linux-foundation.org

On Thu, Aug 18, 2011 at 4:38 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 18 August 2011, Ohad Ben-Cohen wrote:
>> =A0arch/arm/plat-omap/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | =A0 14 --------------
>> =A0arch/arm/plat-omap/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 =A02 --
>> =A0arch/arm/plat-omap/{ =3D> include/plat}/iopgtable.h =A0| =A0 =A00
>> =A0drivers/iommu/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0| =A0 18 ++++++++++++++++++
>> =A0drivers/iommu/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 | =A0 =A03 +++
>> =A0.../iommu/omap-iommu-debug.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A0 =A02 +-
>> =A0.../iommu.c =3D> drivers/iommu/omap-iommu.c =A0 =A0 =A0 =A0 =A0| =
=A0 =A02 +-
>> =A0.../iovmm.c =3D> drivers/iommu/omap-iovmm.c =A0 =A0 =A0 =A0 =A0| =
=A0 =A02 +-
>> =A0drivers/media/video/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0| =A0 =A02 +-
>
> Do you need the header file to be globally visible?

Yeah; Unfortunately omap3isp is not yet completely decoupled from
omap's iommu, so it needs it.

Once the generic DMA-API will settle in, we will completely decouple
omap3isp and then will be able to move this header file into
drivers/iommu/, and remove omap-iovmm.c.

Thanks,
Ohad.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
